-- TurtleAI Server
-- This program runs on the turtle and executes code received from the client

-- Configuration 
local DEFAULT_CHANNEL = 65      -- Default channel to listen on
local SERVER_NAME = "TurtleAI" -- Name of this server
local PASSWORD = nil            -- Set to string for password protection

-- Get the modem
local modem = nil
for _, side in pairs({"left", "right", "top", "bottom", "front", "back"}) do
  if peripheral.isPresent(side) and peripheral.getType(side) == "modem" then
    modem = peripheral.wrap(side)
    if modem.isWireless() then
      print("Found wireless modem on " .. side)
      break
    end
    modem = nil
  end
end

if not modem then
  print("No wireless modem found! Please attach one.")
  return
end

-- Check if simple_mining.lua exists on the turtle
local function checkSimpleMiningExists()
  return fs.exists("simple_mining.lua")
end

-- Run the simple_mining program with given dimensions
local function runSimpleMining(width, height, depth)
  if not checkSimpleMiningExists() then
    return false, "simple_mining.lua not found on this turtle"
  end
  
  -- Use shell.run to execute the program with arguments
  return pcall(function() 
    shell.run("simple_mining", tostring(width), tostring(height), tostring(depth))
  end)
end

-- Function to safely execute Lua code from string (with limitations)
local function safeExecute(codeString)
  local success, result = pcall(function()
    -- Create a safe environment with limited functions
    local env = {
      turtle = turtle,
      print = print,
      tonumber = tonumber,
      tostring = tostring,
      math = math,
      string = string,
      table = table,
      pairs = pairs,
      ipairs = ipairs,
      next = next,
      type = type,
      select = select,
      unpack = unpack,
      pcall = pcall,
      sleep = sleep,
      os = {
        pullEvent = os.pullEvent,
        time = os.time,
        clock = os.clock,
        startTimer = os.startTimer
      },
      runSimpleMining = runSimpleMining,
      checkSimpleMiningExists = checkSimpleMiningExists,
      shell = {
        run = shell.run
      },
      fs = {
        exists = fs.exists
      }
    }
    
    -- Set metatable to allow read-only access to _G
    setmetatable(env, {
      __index = function(_, key)
        -- Don't allow access to potentially unsafe functions
        if _G[key] ~= nil and 
           key ~= "load" and 
           key ~= "loadstring" and 
           key ~= "dofile" and 
           key ~= "loadfile" then
          return _G[key]
        end
        return nil
      end
    })
    
    -- Compile the function with our safe environment
    local func, err = load(codeString, "turtleCommand", "t", env)
    if not func then
      return false, "Compilation error: " .. (err or "unknown error")
    end
    
    -- Execute the function
    return func()
  end)
  
  if not success then
    return false, "Execution error: " .. tostring(result)
  end
  
  return true, result
end

-- Open the channel
local channel = DEFAULT_CHANNEL
if arg and arg[1] and tonumber(arg[1]) then
  channel = tonumber(arg[1])
end

-- Set up server
print("Starting TurtleAI server on channel " .. channel)
print("Simple Mining available: " .. tostring(checkSimpleMiningExists()))
modem.open(channel)

-- Collect turtle status
local function getTurtleStatus()
  local status = {}
  
  -- Fuel info
  status.fuelLevel = turtle.getFuelLevel()
  
  -- Inventory info
  status.inventory = {}
  status.selectedSlot = turtle.getSelectedSlot()
  status.itemCount = 0
  status.slotsUsed = 0
  
  for i = 1, 16 do
    local count = turtle.getItemCount(i)
    if count > 0 then
      status.slotsUsed = status.slotsUsed + 1
      status.itemCount = status.itemCount + count
      
      local detail = turtle.getItemDetail(i)
      status.inventory[i] = {
        count = count,
        name = detail and detail.name or "Unknown"
      }
    end
  end
  
  -- Programs
  status.hasSimpleMining = checkSimpleMiningExists()
  
  return status
end

-- Capture print output
local function captureOutput(func)
  local oldPrint = print
  local output = {}
  
  -- Override print function
  _G.print = function(...)
    local args = {...}
    local text = ""
    for i, v in ipairs(args) do
      text = text .. tostring(v)
      if i < #args then
        text = text .. "\t"
      end
    end
    table.insert(output, text)
    oldPrint(...)
  end
  
  -- Call the function
  local results = {pcall(func)}
  
  -- Restore print
  _G.print = oldPrint
  
  -- Return results and captured output
  return {
    success = results[1],
    results = {table.unpack(results, 2)},
    output = output
  }
end

-- Authentication function
local function authenticate(password)
  if not PASSWORD then return true end
  return password == PASSWORD
end

-- Main server loop
local authenticated = {}
print("Server ready. Press Ctrl+T to terminate.")

while true do
  local event, side, senderChannel, replyChannel, message, distance = os.pullEvent("modem_message")
  
  if type(message) == "table" and message.command then
    local clientID = message.clientID or "unknown"
    
    -- Process the message
    if message.command == "connect" then
      -- Handle connection requests
      local authRequired = PASSWORD ~= nil
      local welcome = {
        serverName = SERVER_NAME,
        authRequired = authRequired,
        success = true,
        status = getTurtleStatus()
      }
      authenticated[clientID] = not authRequired
      modem.transmit(replyChannel, channel, welcome)
      print("Connection from " .. clientID .. " (auth: " .. tostring(not authRequired) .. ")")
      
    elseif message.command == "auth" then
      -- Handle authentication
      local authSuccess = authenticate(message.password)
      authenticated[clientID] = authSuccess
      modem.transmit(replyChannel, channel, {
        success = authSuccess,
        message = authSuccess and "Authentication successful" or "Authentication failed"
      })
      print(clientID .. " authentication: " .. tostring(authSuccess))
      
    elseif message.command == "status" then
      -- Return turtle status
      if authenticated[clientID] then
        modem.transmit(replyChannel, channel, {
          success = true,
          status = getTurtleStatus()
        })
      else
        modem.transmit(replyChannel, channel, {
          success = false,
          message = "Not authenticated"
        })
      end
      
    elseif message.command == "exec" then
      -- Execute code only if authenticated
      if authenticated[clientID] then
        local code = message.code
        print("Executing code from " .. clientID)
        
        -- Capture output and execute code
        local captured = captureOutput(function()
          return safeExecute(code)
        end)
        
        modem.transmit(replyChannel, channel, {
          success = captured.success,
          results = captured.results,
          output = captured.output,
          status = getTurtleStatus() -- Include updated status
        })
      else
        modem.transmit(replyChannel, channel, {
          success = false,
          message = "Not authenticated"
        })
      end
      
    elseif message.command == "ping" then
      -- Respond to ping
      modem.transmit(replyChannel, channel, {
        success = true,
        message = "pong",
        serverName = SERVER_NAME,
        hasSimpleMining = checkSimpleMiningExists()
      })
    end
  end
end