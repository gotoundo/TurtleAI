-- Dog Turtle Follower Program
-- Makes a turtle follow a player like a loyal dog
-- Usage: dog_turtle [player_name] [follow_distance]

local args = {...}
local targetPlayer = args[1] or "player"
local followDistance = tonumber(args[2]) or 3  -- Stay 3 blocks away

-- Protocol for dog following
local PROTOCOL = "dog_follow"

-- Configuration
local UPDATE_TIMEOUT = 5  -- Max seconds between position updates
local POSITION_TOLERANCE = 1  -- Movement tolerance in blocks

-- Find and open modem
local modem = peripheral.find("modem")
if not modem then
    error("No modem found! Please equip a wireless modem.", 0)
end

rednet.open(peripheral.getName(modem))
print("Dog Turtle Active")
print("Following: " .. targetPlayer)
print("Follow distance: " .. followDistance .. " blocks")
print("Press Ctrl+T to stop")
print("")

-- State
local playerPos = nil
local lastUpdate = 0
local turtlePos = nil

-- Helper function to get turtle's position
local function getPosition()
    local x, y, z = gps.locate(2, false)
    if x and y and z then
        return {x = math.floor(x), y = math.floor(y), z = math.floor(z)}
    end
    return nil
end

-- Calculate distance between two positions
local function distance(pos1, pos2)
    local dx = pos1.x - pos2.x
    local dy = pos1.y - pos2.y
    local dz = pos1.z - pos2.z
    return math.sqrt(dx*dx + dy*dy + dz*dz)
end

-- Get direction to face target
local function getFacingDirection()
    local pos1 = getPosition()
    if not pos1 then return nil end

    turtle.forward()
    local pos2 = getPosition()
    turtle.back()

    if not pos2 then return nil end

    if pos2.x > pos1.x then return 0, "east"   -- +X
    elseif pos2.x < pos1.x then return 2, "west"   -- -X
    elseif pos2.z > pos1.z then return 1, "south"  -- +Z
    elseif pos2.z < pos1.z then return 3, "north"  -- -Z
    end
    return nil
end

-- Turn to face a specific direction (0=east, 1=south, 2=west, 3=north)
local function turnToFace(targetDir)
    local currentDir = getFacingDirection()
    if not currentDir then return false end

    local turnAmount = (targetDir - currentDir) % 4

    if turnAmount == 1 then
        turtle.turnRight()
    elseif turnAmount == 2 then
        turtle.turnRight()
        turtle.turnRight()
    elseif turnAmount == 3 then
        turtle.turnLeft()
    end

    return true
end

-- Navigate toward target position
local function moveToward(target)
    turtlePos = getPosition()
    if not turtlePos then
        print("Cannot get turtle position!")
        return false
    end

    local dist = distance(turtlePos, target)

    -- Check if we're close enough
    if dist <= followDistance then
        return true  -- Already at follow distance
    end

    -- Calculate direction to move
    local dx = target.x - turtlePos.x
    local dy = target.y - turtlePos.y
    local dz = target.z - turtlePos.z

    -- Move horizontally first
    if math.abs(dx) > POSITION_TOLERANCE then
        -- Move in X direction
        local targetDir = dx > 0 and 0 or 2  -- 0=east (+X), 2=west (-X)
        turnToFace(targetDir)

        if not turtle.forward() then
            -- Obstacle ahead, try to dig or go around
            if turtle.detect() then
                turtle.dig()
                sleep(0.5)
                turtle.forward()
            else
                -- Try going up
                turtle.up()
            end
        end
    elseif math.abs(dz) > POSITION_TOLERANCE then
        -- Move in Z direction
        local targetDir = dz > 0 and 1 or 3  -- 1=south (+Z), 3=north (-Z)
        turnToFace(targetDir)

        if not turtle.forward() then
            -- Obstacle ahead
            if turtle.detect() then
                turtle.dig()
                sleep(0.5)
                turtle.forward()
            else
                turtle.up()
            end
        end
    elseif math.abs(dy) > POSITION_TOLERANCE then
        -- Move in Y direction
        if dy > 0 then
            if not turtle.up() then
                if turtle.detectUp() then
                    turtle.digUp()
                    sleep(0.5)
                    turtle.up()
                end
            end
        else
            if not turtle.down() then
                if turtle.detectDown() then
                    turtle.digDown()
                    sleep(0.5)
                    turtle.down()
                end
            end
        end
    end

    return false
end

-- Refuel if needed
local function ensureFuel()
    local fuelLevel = turtle.getFuelLevel()
    if fuelLevel == "unlimited" then return true end

    if fuelLevel < 10 then
        print("Low fuel! (" .. fuelLevel .. ") Trying to refuel...")
        for slot = 1, 16 do
            turtle.select(slot)
            if turtle.refuel(0) then  -- Check if item is fuel
                turtle.refuel(1)
                print("Refueled from slot " .. slot)
                return true
            end
        end
        print("No fuel available!")
        return false
    end
    return true
end

-- Display status
local function displayStatus()
    term.setCursorPos(1, 6)
    term.clearLine()

    if playerPos then
        print("Player at: " .. playerPos.x .. ", " .. playerPos.y .. ", " .. playerPos.z)
    else
        print("Player position: Unknown")
    end

    term.clearLine()
    if turtlePos then
        print("Turtle at: " .. turtlePos.x .. ", " .. turtlePos.y .. ", " .. turtlePos.z)
    else
        print("Turtle position: Unknown")
    end

    term.clearLine()
    if playerPos and turtlePos then
        local dist = distance(turtlePos, playerPos)
        print("Distance: " .. string.format("%.1f", dist) .. " blocks")
    end

    term.clearLine()
    local fuel = turtle.getFuelLevel()
    if fuel == "unlimited" then
        print("Fuel: Unlimited")
    else
        print("Fuel: " .. fuel)
    end
end

-- Main loop
print("Waiting for GPS lock...")
while not getPosition() do
    sleep(1)
end
print("GPS acquired!")
print("")

while true do
    -- Listen for player position updates
    local senderId, message, protocol = rednet.receive(PROTOCOL, 0.5)

    if senderId and message and message.name == targetPlayer then
        -- Update player position
        playerPos = {
            x = message.x,
            y = message.y,
            z = message.z
        }
        lastUpdate = os.epoch("utc")

        -- Ensure we have fuel
        if ensureFuel() then
            -- Move toward player
            moveToward(playerPos)
        end
    else
        -- Check if we've lost contact with player
        local timeSinceUpdate = (os.epoch("utc") - lastUpdate) / 1000
        if timeSinceUpdate > UPDATE_TIMEOUT and playerPos then
            print("Lost contact with player...")
            playerPos = nil
        end
    end

    -- Update display
    displayStatus()

    sleep(0.1)
end
