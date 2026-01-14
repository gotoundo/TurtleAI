-- AI Art Display for ComputerCraft
-- Generates and displays AI art on monitors
-- Usage: art_display [server_url]

local args = {...}
local SERVER_URL = args[1] or "http://localhost:8080"

-- Find monitor
local function findMonitor()
    local monitors = {peripheral.find("monitor")}
    if #monitors == 0 then
        return term.current()  -- Use terminal if no monitor
    end
    return monitors[1]
end

-- Draw image on monitor
local function drawImage(mon, imageData)
    mon.clear()
    mon.setCursorPos(1, 1)

    local width = imageData.width
    local height = imageData.height
    local pixels = imageData.pixels

    print("Drawing " .. width .. "x" .. height .. " image...")

    -- Draw each pixel
    for y = 1, height do
        for x = 1, width do
            local colorIndex = pixels[y][x]
            -- Convert 0-15 to CC color (2^colorIndex)
            local ccColor = 2 ^ colorIndex

            -- Set pixel color
            mon.setCursorPos(x, y)
            mon.setBackgroundColor(ccColor)
            mon.write(" ")
        end
    end

    -- Reset colors
    mon.setBackgroundColor(colors.black)
    mon.setTextColor(colors.white)
end

-- Generate art from prompt
local function generateArt(prompt, width, height, steps)
    print("Generating: " .. prompt)
    print("Please wait...")

    -- Build request
    local requestData = textutils.serializeJSON({
        prompt = prompt,
        width = width or 512,
        height = height or 512,
        steps = steps or 15,
        cc_width = 164,
        cc_height = 81
    })

    -- Send HTTP request
    local response = http.post(
        SERVER_URL .. "/generate",
        requestData,
        {["Content-Type"] = "application/json"}
    )

    if not response then
        error("Failed to connect to server at " .. SERVER_URL)
    end

    -- Parse response
    local responseText = response.readAll()
    response.close()

    local result = textutils.unserializeJSON(responseText)

    if not result or not result.success then
        error("Generation failed: " .. (result and result.error or "Unknown error"))
    end

    return result.data
end

-- Main UI
local function mainUI()
    local mon = findMonitor()

    if mon ~= term.current() then
        print("Using monitor: " .. peripheral.getName(mon))
    else
        print("No monitor found, using terminal")
    end

    print("")
    print("=" .. string.rep("=", 47))
    print(" AI Art Display for ComputerCraft")
    print("=" .. string.rep("=", 47))
    print("")
    print("Server: " .. SERVER_URL)
    print("")

    -- Test server connection
    write("Testing server connection... ")
    local testResponse = http.get(SERVER_URL .. "/health")
    if not testResponse then
        print("FAILED")
        print("")
        print("Error: Cannot connect to bridge server")
        print("Make sure the Python bridge server is running:")
        print("  python bridge_server.py")
        return
    end
    testResponse.close()
    print("OK")
    print("")

    while true do
        -- Get prompt
        write("Enter prompt (or 'quit'): ")
        local prompt = read()

        if prompt:lower() == "quit" or prompt:lower() == "exit" then
            print("Goodbye!")
            break
        end

        if prompt:len() == 0 then
            print("Prompt cannot be empty")
        else
            -- Optional settings
            write("Image size (512/768/1024) [512]: ")
            local sizeInput = read()
            local size = tonumber(sizeInput) or 512

            write("Steps (10-30) [15]: ")
            local stepsInput = read()
            local steps = tonumber(stepsInput) or 15

            print("")
            print("Generating...")

            -- Generate and display
            local success, result = pcall(function()
                return generateArt(prompt, size, size, steps)
            end)

            if success then
                print("Converting to display format...")
                drawImage(mon, result)
                print("")
                print("Done! Displayed on monitor")
                print("")
            else
                print("Error: " .. tostring(result))
                print("")
            end
        end
    end
end

-- Quick mode (single generation)
local function quickMode(prompt)
    local mon = findMonitor()

    print("Quick mode: " .. prompt)
    print("Generating...")

    local success, result = pcall(function()
        return generateArt(prompt, 512, 512, 15)
    end)

    if success then
        print("Drawing...")
        drawImage(mon, result)
        print("Done!")
    else
        print("Error: " .. tostring(result))
    end
end

-- Entry point
if args[2] then
    -- Quick mode with prompt
    quickMode(args[2])
else
    -- Interactive mode
    mainUI()
end
