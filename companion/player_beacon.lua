-- Player Beacon Program
-- Run this on a pocket computer to broadcast your position
-- Usage: player_beacon [name]

local args = {...}
local playerName = args[1] or "player"

-- Find and open modem
local modem = peripheral.find("modem")
if not modem then
    error("No modem found! Please equip a wireless modem.", 0)
end

rednet.open(peripheral.getName(modem))
print("Modem opened on " .. peripheral.getName(modem))

-- Protocol for dog following
local PROTOCOL = "dog_follow"

print("Player Beacon Active")
print("Name: " .. playerName)
print("Press Ctrl+T to stop")
print("")

local updateInterval = 0.5  -- Send position every 0.5 seconds
local lastX, lastY, lastZ

while true do
    -- Get current GPS position
    local x, y, z = gps.locate(2, false)

    if x and y and z then
        -- Only broadcast if position changed (optimization)
        if x ~= lastX or y ~= lastY or z ~= lastZ then
            local message = {
                name = playerName,
                x = math.floor(x),
                y = math.floor(y),
                z = math.floor(z),
                timestamp = os.epoch("utc")
            }

            rednet.broadcast(message, PROTOCOL)

            -- Update display
            term.setCursorPos(1, 5)
            term.clearLine()
            print("Position: " .. x .. ", " .. y .. ", " .. z .. "  ")

            lastX, lastY, lastZ = x, y, z
        end
    else
        term.setCursorPos(1, 5)
        term.clearLine()
        print("GPS unavailable - waiting...  ")
    end

    sleep(updateInterval)
end
