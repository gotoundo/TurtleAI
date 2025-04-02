local tunnelDepth = 16*1 --chunk is 16 deep
local tunnelLoops = 4*1 --chunk is 4 loops wide

turtle.dig()
turtle.forward()

local function digForward()
    while turtle.dig() do print("Dig!") end --continuously dig through falling sand/gravel
end

local function digLeft()
    turtle.turnLeft()
    digForward()
    turtle.turnRight()
end

local function digRight()
    turtle.turnRight()
    digForward()
    turtle.turnLeft()
end

local function digUpDownForward()
    digForward()
    turtle.digUp()
    turtle.digDown()
end

local function digTunnel(depth)
    for i=1,depth do
        digUpDownForward()
        digLeft()
        digRight()
        turtle.forward()
    end
end

local function carveRightTurn()
    digLeft() --clear out corner
    digUpDownForward()
    turtle.turnRight()
    digTunnel(3)
    digLeft() --clear out corner
    digUpDownForward()
    turtle.turnRight()
end

local function carveLeftTurn()
    digRight() --clear out corner
    digUpDownForward()
    turtle.turnLeft()
    digTunnel(3)
    digRight() --clear out corner
    digUpDownForward()
    turtle.turnLeft()
end

local function storeItemsBehind()
    turtle.turnLeft()
    turtle.turnLeft()
    digForward()
    turtle.select(1) --chest slot
    turtle.place() --place chest
    for i=2,16 do --store in chest
        turtle.select(i)
        turtle.refuel(64)
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

--return home
storeItemsBehind()
carveRightTurn()
digTunnel(1)
carveRightTurn()
digTunnel(tunnelLoops * 4)
carveRightTurn()