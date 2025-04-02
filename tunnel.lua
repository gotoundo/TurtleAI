local tunnelDepth = 16*4 --chunk is 16 deep
local tunnelLoops = 4*4 --chunk is 4 loops wide

turtle.dig()
turtle.forward()

local function localDigAll()
    turtle.dig()
    turtle.digUp()
    turtle.digDown()
end

local function digTunnel(depth)
    for i=1,depth do
        localDigAll()

        turtle.turnLeft()
        turtle.dig()

        turtle.turnRight()
        turtle.turnRight()
        turtle.dig()

        turtle.turnLeft()
        turtle.forward()
    end
end

local function carveRightTurn()
    turtle.turnLeft()
    turtle.dig()
    turtle.turnRight()
    localDigAll()
    turtle.turnRight()
    digTunnel(3)
    localDigAll()
    turtle.turnRight()
end

local function carveLeftTurn()
    turtle.turnRight()
    turtle.dig()
    turtle.turnLeft()
    localDigAll()
    turtle.turnLeft()
    digTunnel(3)
    localDigAll()
    turtle.turnLeft()
end

local function storeItemsBehind()
    turtle.turnLeft()
    turtle.turnLeft()
    turtle.dig()
    turtle.select(1) --chest slot
    turtle.place() --place chest
    for i=2,16 do --store in chest
        turtle.select(i)
        turtle.drop()
    end
    turtle.turnRight()
    turtle.turnRight()
end

for i=1,tunnelLoops do
    storeItemsBehind()
    digTunnel(tunnelDepth)
    carveRightTurn()
    digTunnel(tunnelDepth)
    carveLeftTurn()
end