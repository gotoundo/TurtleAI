-- Turtle Companion System Installer
-- Automatically downloads and sets up the companion system
-- Usage: wget run https://raw.githubusercontent.com/[user]/TurtleAI/dev/companion/install.lua

local GITHUB_BASE = "https://raw.githubusercontent.com/gotoundo/TurtleAI/dev/companion/"
local FILES = {
    player_beacon = "player_beacon.lua",
    dog_turtle = "dog_turtle.lua"
}

-- Color support
local function setColor(color)
    if term.isColor() then
        term.setTextColor(color)
    end
end

local function printHeader()
    setColor(colors.yellow)
    print("================================")
    print("  Turtle Companion Installer")
    print("================================")
    setColor(colors.white)
    print("")
end

local function printSuccess(msg)
    setColor(colors.green)
    print("[OK] " .. msg)
    setColor(colors.white)
end

local function printError(msg)
    setColor(colors.red)
    print("[ERROR] " .. msg)
    setColor(colors.white)
end

local function printInfo(msg)
    setColor(colors.lightBlue)
    print("[INFO] " .. msg)
    setColor(colors.white)
end

-- Download a file from GitHub
local function downloadFile(url, filename)
    printInfo("Downloading " .. filename .. "...")

    local response = http.get(url)
    if not response then
        printError("Failed to download " .. filename)
        return false
    end

    local content = response.readAll()
    response.close()

    local file = fs.open(filename, "w")
    file.write(content)
    file.close()

    printSuccess("Downloaded " .. filename)
    return true
end

-- Check if modem is available
local function checkModem()
    local modem = peripheral.find("modem")
    if modem then
        printSuccess("Wireless modem detected")
        return true
    else
        printError("No wireless modem found!")
        print("    Please equip a wireless modem and try again")
        return false
    end
end

-- Detect device type
local function detectDevice()
    if turtle then
        return "turtle"
    elseif pocket then
        return "pocket"
    else
        return "computer"
    end
end

-- Main installation
local function main()
    printHeader()

    -- Detect device type
    local deviceType = detectDevice()
    printInfo("Detected device: " .. deviceType)
    print("")

    -- Check for modem
    if not checkModem() then
        return
    end
    print("")

    -- Show menu
    print("What would you like to install?")
    print("")
    print("1. Player Beacon (for pocket computer)")
    print("2. Dog Turtle (for turtle)")
    print("3. Both programs")
    print("4. Cancel")
    print("")
    write("Enter choice (1-4): ")

    local choice = read()
    print("")

    if choice == "4" then
        print("Installation cancelled")
        return
    end

    local installBeacon = (choice == "1" or choice == "3")
    local installDog = (choice == "2" or choice == "3")

    -- Validate choice based on device
    if deviceType == "pocket" and installDog then
        printError("Cannot install dog_turtle on pocket computer!")
        print("    Please select option 1 for pocket computers")
        return
    end

    if deviceType == "turtle" and installBeacon then
        print("Warning: player_beacon is designed for pocket computers")
        write("Continue anyway? (y/n): ")
        if read() ~= "y" then
            return
        end
        print("")
    end

    -- Download files
    local success = true

    if installBeacon then
        if not downloadFile(GITHUB_BASE .. FILES.player_beacon, FILES.player_beacon) then
            success = false
        end
    end

    if installDog then
        if not downloadFile(GITHUB_BASE .. FILES.dog_turtle, FILES.dog_turtle) then
            success = false
        end
    end

    print("")

    if success then
        printSuccess("Installation complete!")
        print("")

        -- Show usage instructions
        setColor(colors.yellow)
        print("Usage Instructions:")
        setColor(colors.white)

        if installBeacon then
            print("")
            print("Player Beacon (run on pocket computer):")
            setColor(colors.lightGray)
            print("  " .. FILES.player_beacon .. " [your_name]")
            setColor(colors.white)
            print("  Example: " .. FILES.player_beacon .. " steve")
        end

        if installDog then
            print("")
            print("Dog Turtle (run on turtle):")
            setColor(colors.lightGray)
            print("  " .. FILES.dog_turtle .. " [player_name] [distance]")
            setColor(colors.white)
            print("  Example: " .. FILES.dog_turtle .. " steve 3")
        end

        print("")
        printInfo("GPS network required for operation!")
        print("See: tweaked.cc/guide/gps_setup.html")

    else
        printError("Installation failed!")
        print("Please check your internet connection and try again")
    end
end

-- Run installer
main()
