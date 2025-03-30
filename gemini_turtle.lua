-- Turtle Gemini Shell
-- A program that uses Gemini AI to interpret natural language commands into turtle actions
-- Based on the original gemini_chat.lua implementation

local MODEL = "models/gemini-1.5-flash"
local VERSION = "1.0.4"

-- Debug mode (set to true for more logging)
local DEBUG = true

-- Helper function for debug logging
local function debugLog(message)
  if DEBUG then
    term.setTextColor(colors.orange)
    print("[DEBUG] " .. tostring(message))
    term.setTextColor(colors.white)
  end
end

-- Helper function to escape special characters in JSON strings
local function jsonEscape(str)
  if str then
    str = string.gsub(str, '\\', '\\\\')
    str = string.gsub(str, '"', '\\"')
    str = string.gsub(str, '\n', '\\n')
    str = string.gsub(str, '\r', '\\r')
    str = string.gsub(str, '\t', '\\t')
  end
  return str
end

-- Helper function to unescape JSON strings
local function jsonUnescape(str)
  if str then
    str = string.gsub(str, '\\n', '\n')
    str = string.gsub(str, '\\r', '\r')
    str = string.gsub(str, '\\t', '\t')
    str = string.gsub(str, '\\"', '"')
    str = string.gsub(str, '\\\\', '\\')
  end
  return str
end

-- Function to parse JSON (CC doesn't have built-in JSON parsing)
local function parseJSON(json)
  -- Basic JSON parser (handles the response format we need)
  local result = {}
  
  -- Look for patterns in the JSON response
  local content = json:match('"text"%s*:%s*"(.-[^\\])"')
  
  if content then
    -- Unescape the JSON string
    result.text = jsonUnescape(content)
  else
    -- Try a simpler pattern as fallback
    content = json:match('"text"%s*:%s*"(.-)"')
    if content then
      result.text = jsonUnescape(content)
    end
  end
  
  return result
end

-- Helper function to trim whitespace from a string (since there's no built-in trim method)
local function trim(s)
  if type(s) ~= "string" then
    return ""
  end
  return s:match("^%s*(.-)%s*$")
end

-- Setup settings for the API key (reuse from simple_mining setting if available)
settings.define("gemini.api_key", {
  description = "Your Gemini API key from Google AI Studio",
  default = "",
  type = "string"
})

-- Conversation history management
local conversationHistory = {}

-- Add a message to history
local function addToHistory(role, message)
  table.insert(conversationHistory, {role = role, text = message})
end

-- Build the conversation context for the API request
local function buildRequestBody()
  local contents = {}
  
  for _, message in ipairs(conversationHistory) do
    local roleStr = message.role == "user" and "user" or "model"
    table.insert(contents, '{"role":"' .. roleStr .. '","parts":[{"text":"' .. jsonEscape(message.text) .. '"}]}')
  end
  
  local requestBody = '{"contents":[' .. table.concat(contents, ",") .. ']}'
  return requestBody
end

-- Function to send a request to Gemini API
local function generateContent(prompt)
  local apiKey = settings.get("gemini.api_key")
  
  if not apiKey or apiKey == "" then
    -- Try to get it from simple_mining settings if available
    apiKey = settings.get("3dminer.gemini.api_key") or settings.get("gemini.api_key")
    
    if not apiKey or apiKey == "" then
      return "Error: API key not set. Use 'setkey' to set it."
    else
      settings.set("gemini.api_key", apiKey)
      settings.save()
    end
  end
  
  -- Add the current prompt to history
  addToHistory("user", prompt)
  
  local url = "https://generativelanguage.googleapis.com/v1beta/" .. MODEL .. ":generateContent?key=" .. apiKey
  
  -- Prepare the request body with conversation history
  local requestBody = buildRequestBody()
  
  debugLog("Sending request to Gemini API")
  
  -- Make the HTTP request
  local response = http.post(
    url,
    requestBody,
    {["Content-Type"] = "application/json"}
  )
  
  if response then
    local responseText = response.readAll()
    response.close()
    
    -- Parse the JSON response
    local result = parseJSON(responseText)
    
    if result.text then
      -- Add the response to history
      addToHistory("model", result.text)
      return result.text
    else
      -- Debug information for failed parsing
      local debugInfo = "Error: Could not parse response."
      if #responseText > 200 then
        debugInfo = debugInfo .. " Raw (first 200 chars): " .. responseText:sub(1, 200) .. "..."
      else
        debugInfo = debugInfo .. " Raw: " .. responseText
      end
      return debugInfo
    end
  else
    return "Error: Could not connect to Gemini API"
  end
end

-- Clear conversation history
local function clearHistory()
  conversationHistory = {}
  return "Conversation history cleared. Starting fresh!"
end

-- Turtle execution context
local turtleExecutionContext = {
  lastCommand = "",
  isInterpreting = false,
  executeTimer = nil,
  maxCommandsPerTick = 1,
  commandsExecuted = 0,
  commandQueue = {},
  inProgress = false
}

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

-- Initialize the AI with turtle-specific context
local function initializeAI()
  local hasMiningProgram = checkSimpleMiningExists()
  local miningInfo = ""
  
  if hasMiningProgram then
    miningInfo = [[
This turtle has the "simple_mining.lua" program installed. You can use it to mine rectangular areas with these commands:
- "mine a [width] x [height] x [depth] area" - This will use simple_mining.lua to mine the specified dimensions
- "dig a [width] x [height] x [depth] hole" - Same as above, alternative phrasing

The simple_mining program will:
1. Mine in a 3D snake pattern for efficiency
2. Return to deposit items when inventory is full
3. Continue from where it left off
4. Handle fuel management
5. Return to original position when done
    ]]
  end

  local systemPrompt = [[You are TurtleGPT, an AI assistant specialized in controlling ComputerCraft turtles in Minecraft.
Your purpose is to interpret natural language commands into Lua code that controls the turtle.
The turtle is a programmable robot that can move, dig, place blocks, and interact with the world.

For safety, you should:
1. Always confirm DESTRUCTIVE operations before executing them
2. Never directly execute code with 'load' or other unsafe methods
3. Keep commands reasonably sized for better control

Key turtle functions include:
- Movement: turtle.forward(), turtle.back(), turtle.up(), turtle.down(), turtle.turnLeft(), turtle.turnRight()
- Digging: turtle.dig(), turtle.digUp(), turtle.digDown()
- Placing: turtle.place(), turtle.placeUp(), turtle.placeDown()
- Inventory: turtle.select(slot), turtle.getItemCount(slot), turtle.getItemDetail(slot)
- Item Transfer: turtle.drop(), turtle.dropUp(), turtle.dropDown(), turtle.suck(), turtle.suckUp(), turtle.suckDown()
- Inspection: turtle.detect(), turtle.detectUp(), turtle.detectDown(), turtle.inspect(), turtle.inspectUp(), turtle.inspectDown()
- Fuel: turtle.getFuelLevel(), turtle.refuel(count)
- Combat: turtle.attack(), turtle.attackUp(), turtle.attackDown()

]] .. miningInfo .. [[

When interpreting commands, please:
1. Provide ONLY executable Lua code in code blocks (no explanations in the code)
2. AFTER the code, you can briefly explain what the code does
3. For complex tasks, break them down into simpler steps
4. Always handle errors and edge cases when possible

For mining commands like "mine a 5x5x5 area", check if they match the pattern for the simple_mining program. If they do, generate code that calls the function runSimpleMining(width, height, depth) instead of creating a custom mining algorithm.

Example command: "Move forward 5 blocks then turn right"
Example response: 
```lua
for i = 1, 5 do
  if not turtle.forward() then
    print("Path blocked at step " .. i)
    break
  end
end
turtle.turnRight()
```
This will move the turtle forward 5 blocks, stopping if it encounters an obstacle, then turn right.

Example command: "Mine a 3x4x5 area"
Example response (if simple_mining.lua exists):
```lua
local success, err = runSimpleMining(3, 4, 5)
if not success then
  print("Error running mining program: " .. tostring(err))
end
```
This will use the simple_mining program to excavate a 3x4x5 area using its efficient algorithm.
]]

  addToHistory("user", systemPrompt)
  
  local initialResponse = "I'm TurtleGPT, your turtle control assistant. I'll help you control your ComputerCraft turtle using natural language commands. What would you like your turtle to do?"
  addToHistory("model", initialResponse)
  
  return initialResponse
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

-- Process and execute a queue of code commands
local function processCommandQueue()
  if #turtleExecutionContext.commandQueue == 0 then
    turtleExecutionContext.inProgress = false
    return
  end
  
  turtleExecutionContext.inProgress = true
  
  -- Execute the first command in the queue
  local cmd = table.remove(turtleExecutionContext.commandQueue, 1)
  
  -- Execute the command
  term.setTextColor(colors.lightBlue)
  print("Executing command...")
  term.setTextColor(colors.white)
  
  local success, result = safeExecute(cmd)
  
  if not success then
    term.setTextColor(colors.red)
    print("Error: " .. tostring(result))
    term.setTextColor(colors.white)
    
    -- Clear the queue on error
    turtleExecutionContext.commandQueue = {}
    turtleExecutionContext.inProgress = false
    return
  end
  
  -- Schedule the next command with a slight delay
  if #turtleExecutionContext.commandQueue > 0 then
    os.sleep(0.5) -- Wait half a second between commands
    processCommandQueue()
  else
    turtleExecutionContext.inProgress = false
    print("Command execution completed.")
  end
end

-- Extract code blocks from Gemini response
local function extractCodeBlocks(response)
  debugLog("Extracting code blocks from response")
  
  -- Return empty table if response is not a string
  if type(response) ~= "string" then
    debugLog("Error: Response is not a string")
    return {}
  end
  
  local codeBlocks = {}
  
  -- Look for code blocks in markdown format (```lua ... ```)
  for codeBlock in response:gmatch("```lua(.-)```") do
    debugLog("Found lua code block: " .. codeBlock:sub(1, 30) .. (codeBlock:len() > 30 and "..." or ""))
    local cleanedBlock = codeBlock:gsub("^%s+", ""):gsub("%s+$", "")
    table.insert(codeBlocks, cleanedBlock)
  end
  
  -- If no code blocks found with lua tag, try generic code blocks
  if #codeBlocks == 0 then
    debugLog("No lua code blocks found, looking for generic code blocks")
    for codeBlock in response:gmatch("```(.-)```") do
      debugLog("Found generic code block: " .. codeBlock:sub(1, 30) .. (codeBlock:len() > 30 and "..." or ""))
      local cleanedBlock = codeBlock:gsub("^%s+", ""):gsub("%s+$", "")
      table.insert(codeBlocks, cleanedBlock)
    end
  end
  
  debugLog("Extracted " .. tostring(#codeBlocks) .. " code blocks")
  return codeBlocks
end

-- Handle a turtle command
local function handleTurtleCommand(userInput)
  -- Check for direct mining command pattern
  local width, height, depth = userInput:match("mine%s+a%s+(%d+)%s*x%s*(%d+)%s*x%s*(%d+)")
  if not width then
    -- Try alternative phrasings
    width, height, depth = userInput:match("dig%s+a%s+(%d+)%s*x%s*(%d+)%s*x%s*(%d+)")
  end
  
  -- If we matched a direct mining command, handle it directly
  if width and height and depth then
    width, height, depth = tonumber(width), tonumber(height), tonumber(depth)
    
    if checkSimpleMiningExists() then
      debugLog("Direct mining command detected: " .. width .. "x" .. height .. "x" .. depth)
      
      print("Mining command detected. Running simple_mining.lua with dimensions:")
      print("Width: " .. width .. ", Height: " .. height .. ", Depth: " .. depth)
      
      write("Execute mining operation? (y/n): ")
      local input = read()
      
      if input:lower() == "y" then
        local success, err = runSimpleMining(width, height, depth)
        if not success then
          term.setTextColor(colors.red)
          print("Error running mining program: " .. tostring(err))
          term.setTextColor(colors.white)
        end
      else
        print("Mining operation cancelled.")
      end
      
      return
    end
  end
  
  -- For non-direct mining commands, use the AI
  term.setTextColor(colors.cyan)
  print("Interpreting command...")
  term.setTextColor(colors.white)
  
  debugLog("Sending command: " .. userInput)
  local response = generateContent(userInput)
  
  if not response or type(response) ~= "string" then
    term.setTextColor(colors.red)
    print("Error: Invalid response from Gemini AI")
    debugLog("Response type: " .. type(response))
    term.setTextColor(colors.white)
    return
  end
  
  -- Extract code blocks from the response
  local codeBlocks = extractCodeBlocks(response)
  
  if #codeBlocks == 0 then
    term.setTextColor(colors.red)
    print("No executable code found in the response.")
    term.setTextColor(colors.lightGray)
    print(response)
    term.setTextColor(colors.white)
    return
  end
  
  -- Display the full response
  term.setTextColor(colors.lightGray)
  print(response)
  term.setTextColor(colors.white)
  
  -- Add the code to the command queue
  debugLog("Adding " .. tostring(#codeBlocks) .. " blocks to queue")
  turtleExecutionContext.commandQueue = {}  -- Clear previous queue
  
  for i, codeBlock in ipairs(codeBlocks) do
    debugLog("Adding block " .. i .. " to queue")
    table.insert(turtleExecutionContext.commandQueue, codeBlock)
  end
  
  -- Ask for confirmation before executing
  write("Execute this code? (y/n): ")
  local input = read()
  
  if input:lower() == "y" then
    if not turtleExecutionContext.inProgress then
      processCommandQueue()
    else
      print("Already executing commands. Please wait.")
    end
  else
    turtleExecutionContext.commandQueue = {}
    print("Execution cancelled.")
  end
end

-- Save API key
local function saveApiKey()
  term.setTextColor(colors.cyan)
  write("Enter your Gemini API key: ")
  term.setTextColor(colors.white)
  
  -- Hide input while typing the API key
  local key = read("*")
  if key and key ~= "" then
    settings.set("gemini.api_key", key)
    settings.save()
    print("API key saved!")
  else
    print("API key not changed")
  end
end

-- Show help information
local function showHelp()
  term.setTextColor(colors.yellow)
  print("=== Turtle Gemini Shell Help ===")
  term.setTextColor(colors.white)
  print("Type natural language commands to control your turtle.")
  print("For example: 'move forward 3 blocks and turn right'")
  print("")
  
  if checkSimpleMiningExists() then
    print("Direct Mining Commands:")
    print("- mine a 5x5x5 area")
    print("- dig a 3x2x10 hole")
    print("These will use the simple_mining.lua program directly.")
    print("")
  end
  
  print("Special commands:")
  print("- exit: Exit the program")
  print("- help: Show this help message")
  print("- clear: Clear conversation history")
  print("- setkey: Set your Gemini API key")
  print("- status: Show turtle status (fuel, position, etc.)")
  print("- debug: Toggle debug mode")
  print("")
  print("Press Enter with no text to start a new command.")
end

-- Show turtle status
local function showTurtleStatus()
  term.setTextColor(colors.yellow)
  print("=== Turtle Status ===")
  term.setTextColor(colors.white)
  
  local fuelLevel = turtle.getFuelLevel()
  local fuelStr = fuelLevel
  
  if fuelLevel == "unlimited" then
    fuelStr = "Unlimited"
  else
    fuelStr = tostring(fuelLevel)
  end
  
  print("Fuel Level: " .. fuelStr)
  
  -- Try to get selected slot and item details
  local selectedSlot = turtle.getSelectedSlot()
  print("Selected Slot: " .. selectedSlot)
  
  local itemDetail = turtle.getItemDetail()
  if itemDetail then
    print("Current Item: " .. itemDetail.name .. " (Count: " .. itemDetail.count .. ")")
  else
    print("Current Item: None")
  end
  
  print("")
  print("Inventory Summary:")
  
  local totalItems = 0
  local slotsUsed = 0
  
  for i = 1, 16 do
    local count = turtle.getItemCount(i)
    if count > 0 then
      slotsUsed = slotsUsed + 1
      totalItems = totalItems + count
      
      local detail = turtle.getItemDetail(i)
      local name = detail and detail.name or "Unknown"
      
      if i == selectedSlot then
        term.setTextColor(colors.yellow)
      end
      
      print("  Slot " .. i .. ": " .. name .. " x" .. count)
      term.setTextColor(colors.white)
    end
  end
  
  print("")
  print("Total: " .. totalItems .. " items in " .. slotsUsed .. " slots")
  
  -- Check for installed programs
  print("")
  print("Installed Special Programs:")
  if checkSimpleMiningExists() then
    print("- simple_mining.lua (3D Mining)")
  else
    print("No special programs installed.")
  end
end

-- Toggle debug mode
local function toggleDebug()
  DEBUG = not DEBUG
  print("Debug mode: " .. (DEBUG and "ON" or "OFF"))
end

-- Main program
local function main()
  term.clear()
  term.setCursorPos(1, 1)
  
  term.setTextColor(colors.yellow)
  print("=== Turtle Gemini Shell v" .. VERSION .. " ===")
  term.setTextColor(colors.white)
  print("Control your turtle with natural language")
  print("Type 'help' for available commands")
  print("")
  
  -- Check for API key
  local apiKey = settings.get("gemini.api_key")
  if not apiKey or apiKey == "" then
    -- Try to get from simple_mining settings
    apiKey = settings.get("3dminer.gemini.api_key")
    
    if apiKey and apiKey ~= "" then
      settings.set("gemini.api_key", apiKey)
      settings.save()
      print("Found and imported API key from 3dminer settings.")
    else
      print("API key not set! Type 'setkey' to set it.")
      print("You can get an API key from Google AI Studio")
    end
  end
  
  -- Initialize the AI
  print("Initializing AI assistant...")
  local initMsg = initializeAI()
  
  term.setTextColor(colors.lightGray)
  print(initMsg)
  term.setTextColor(colors.white)
  print("")
  
  -- Main command loop
  while true do
    if turtleExecutionContext.inProgress then
      print("Command execution in progress. Press Enter to start a new command.")
    end
    
    term.setTextColor(colors.yellow)
    write("> ")
    term.setTextColor(colors.white)
    
    local input = read()
    
    if input:lower() == "exit" then
      break
    elseif input:lower() == "help" then
      showHelp()
    elseif input:lower() == "setkey" then
      saveApiKey()
    elseif input:lower() == "clear" then
      print(clearHistory())
      print("Reinitializing assistant...")
      local initMsg = initializeAI()
      term.setTextColor(colors.lightGray)
      print(initMsg)
      term.setTextColor(colors.white)
    elseif input:lower() == "status" then
      showTurtleStatus()
    elseif input:lower() == "debug" then
      toggleDebug()
    elseif trim(input) ~= "" then
      handleTurtleCommand(input)
    end
    
    print("")
  end
  
  print("Exiting Turtle Gemini Shell. Goodbye!")
end

-- Run the program with error handling
local function runWithErrorHandling()
  local success, err = pcall(main)
  if not success then
    term.setTextColor(colors.red)
    print("Program crashed with error:")
    print(err)
    term.setTextColor(colors.white)
    print("Press any key to exit...")
    os.pullEvent("key")
  end
end

-- Start the program with error handling
runWithErrorHandling()