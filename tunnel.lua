local tunnelDepth = 16*0.25 --chunk is 16 deep
local tunnelLoops = 4*0.5 --chunk is 4 loops wide

turtle.dig()
turtle.forward()

local function digForward()
    while turtle.dig() do write("Dig! ") end --continuously dig through falling sand/gravel
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
    print("Starting tunnel loop ",i," of ",tunnelLoops)
    storeItemsBehind()
    digTunnel(tunnelDepth)
    carveRightTurn()
    digTunnel(tunnelDepth)
    carveLeftTurn()
end

--return home
print("Returning home...")
turtle.turnRight()
turtle.turnRight()
storeItemsBehind()
digTunnel(2)
turtle.turnRight()
digTunnel(tunnelLoops * 4)
carveRightTurn()