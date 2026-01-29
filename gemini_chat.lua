-- Gemini Chat for ComputerCraft with Local Documentation
-- Refactored to be smaller while maintaining full RAG functionality
local VERSION = "1.7.0"
local MODEL = "models/gemini-2.5-flash"  -- Default model
local DEBUG, DOCS_LOADED = false, false

-- Available models
local MODELS = {
  ["2.5"] = "models/gemini-2.5-flash",
  ["3"] = "models/gemini-3-flash-preview",
  ["lite"] = "models/gemini-2.5-flash-lite",
  ["gemma"] = "models/gemma-3-27b"
}

-- Simplified JSON helpers
local function jsonEscape(str)
  return str and str:gsub('\\', '\\\\'):gsub('"', '\\"'):gsub('\n', '\\n')
                  :gsub('\r', '\\r'):gsub('\t', '\\t') or ""
end

local function jsonUnescape(str)
  return str and str:gsub('\\n', '\n'):gsub('\\r', '\r'):gsub('\\t', '\t')
               :gsub('\\"', '"'):gsub('\\\\', '\\') or ""
end

-- Parse JSON response
local function parseJSON(json)
  local success, decoded = pcall(textutils.unserialiseJSON, json)
  if success and decoded and decoded.candidates and decoded.candidates[1] then
    local parts = decoded.candidates[1].content and decoded.candidates[1].content.parts
    if parts and parts[1] and parts[1].text then
      return {text = parts[1].text}
    end
  end
  -- Fallback to regex if proper parsing fails
  local content = json:match('"text"%s*:%s*"(.-[^\\])"') or json:match('"text"%s*:%s*"(.-)"')
  return content and {text = jsonUnescape(content)} or {}
end

-- Setup settings
settings.define("gemini.api_key", {description = "Gemini API key", default = "", type = "string"})
settings.define("docs.path", {description = "Documentation folder", default = "/cc_docs/", type = "string"})
settings.load()

-- Conversation management
local conversationHistory = {}
local function addToHistory(role, message)
  table.insert(conversationHistory, {role = role, text = message})
end

-- Documentation storage
local docs, docIndex = {}, {}
local function trim(s) return s:match("^%s*(.-)%s*$") end

-- Unified API call function for both task and conversation modes
local function callGemini(prompt, withHistory, docContext, maxTokens)
  local apiKey = settings.get("gemini.api_key")
  if not apiKey or apiKey == "" then
    return nil, "API key not set. Use 'setkey' to set it."
  end

  local url = "https://generativelanguage.googleapis.com/v1beta/" .. MODEL .. ":generateContent?key=" .. apiKey
  local requestBody

  if withHistory then
    addToHistory("user", prompt)
    local messages = {}
    for i, msg in ipairs(conversationHistory) do
      if msg.role == "user" and i == #conversationHistory then
        local enhancedText = msg.text
        if docContext and docContext ~= "" then
          enhancedText = enhancedText .. "\n\n" .. docContext .. "\n\nPlease provide a clear, concise answer (2-3 sentences max)."
        else
          enhancedText = enhancedText .. "\n\nPlease provide a clear, concise answer (2-3 sentences max)."
        end
        table.insert(messages, '{"role":"user","parts":[{"text":"' .. jsonEscape(enhancedText) .. '"}]}')
      else
        table.insert(messages, '{"role":"' .. msg.role .. '","parts":[{"text":"' .. jsonEscape(msg.text) .. '"}]}')
      end
    end
    requestBody = '{"contents":[' .. table.concat(messages, ",") .. ']'
    if DEBUG then print("[DEBUG] Sending request with " .. #conversationHistory .. " messages in history") end
  else
    requestBody = '{"contents":[{"role":"user","parts":[{"text":"' .. jsonEscape(prompt) .. '"}]}]'
    if DEBUG then print("[DEBUG] Sending single request") end
  end

  if maxTokens then
    requestBody = requestBody .. ',"generationConfig":{"maxOutputTokens":' .. maxTokens .. '}'
  end
  requestBody = requestBody .. '}'

  local response = http.post(url, requestBody, {["Content-Type"] = "application/json"})

  if not response then
    if withHistory then table.remove(conversationHistory) end
    if DEBUG then
      print("[DEBUG] Connection failed - check network, API key, or model name")
    end
    return nil, "Could not connect to Gemini API - check network and API key"
  end

  local responseText = response.readAll()
  response.close()

  if DEBUG then
    print("[DEBUG] Received response (" .. #responseText .. " chars)")
  end

  local result = parseJSON(responseText)
  if not result.text then
    if withHistory then table.remove(conversationHistory) end

    -- Try to extract error message from response
    local errorMsg = responseText:match('"message"%s*:%s*"([^"]+)"')
    if errorMsg then
      if DEBUG then print("[DEBUG] Server error: " .. errorMsg) end
      return nil, "API Error: " .. errorMsg
    end

    if DEBUG then
      print("[DEBUG] Failed to parse response:")
      print(responseText:sub(1, 500))
    end

    return nil, "Failed to parse response - enable debug mode for details"
  end

  if DEBUG then print("[DEBUG] Response parsed successfully") end
  if withHistory then addToHistory("model", result.text) end
  return result.text
end

-- Load documentation
local function loadDocs()
  if DOCS_LOADED and #docIndex > 0 then
    return true, "Documentation already loaded (" .. #docIndex .. " sections)"
  end

  local docsPath = settings.get("docs.path")
  local indexPath = fs.combine(docsPath, "category_index.json")

  if not fs.exists(indexPath) then
    if DEBUG then print("[DEBUG] Category index not found at: " .. indexPath) end
    return false, "Category index not found at " .. indexPath
  end

  local file = fs.open(indexPath, "r")
  local indexContent = file.readAll()
  file.close()

  -- Parse categories
  local categories = {}
  for category, combined_file, file_count in indexContent:gmatch('"([^"]+)"%s*:%s*{%s*"combined_file"%s*:%s*"([^"]+)"%s*,%s*"file_count"%s*:%s*(%d+)') do
    categories[category] = {combined_file = combined_file, file_count = tonumber(file_count)}
  end

  if not next(categories) then
    if DEBUG then print("[DEBUG] Failed to parse categories from index") end
    return false, "Failed to parse categories from index"
  end

  local count, docId = 0, 0

  for category, data in pairs(categories) do
    local filePath = fs.combine(docsPath, data.combined_file)

    if fs.exists(filePath) then
      local docFile = fs.open(filePath, "r")
      local content = docFile.readAll()
      docFile.close()

      docs[category] = {}

      local currentPath, sectionContent = nil, ""

      for line in content:gmatch("[^\r\n]+") do
        local pathMatch = line:match("^##%s+Source%s+File:%s+`([^`]+)`")

        if pathMatch then
          -- Save previous section if exists
          if currentPath and #sectionContent > 0 then
            docId = docId + 1
            local name = currentPath:match("^%w+/(.-)%.md$") or currentPath:match("^(.-)%.md$") or currentPath
            name = name:gsub("_", " ")
            local docCat = currentPath:match("^(%w+)/") or "general"

            table.insert(docs[category], {
              path = currentPath, name = trim(name),
              category = docCat, content = trim(sectionContent)
            })

            table.insert(docIndex, {
              path = currentPath, name = trim(name),
              category = docCat, id = docId
            })

            count = count + 1
          end

          currentPath = pathMatch
          sectionContent = ""
        elseif currentPath then
          sectionContent = sectionContent .. line .. "\n"
        end
      end

      -- Process last section
      if currentPath and #sectionContent > 0 then
        docId = docId + 1
        local name = currentPath:match("^%w+/(.-)%.md$") or currentPath:match("^(.-)%.md$") or currentPath
        name = name:gsub("_", " ")
        local docCat = currentPath:match("^(%w+)/") or "general"

        table.insert(docs[category], {
          path = currentPath, name = trim(name),
          category = docCat, content = trim(sectionContent)
        })

        table.insert(docIndex, {
          path = currentPath, name = trim(name),
          category = docCat, id = docId
        })

        count = count + 1
      end
    end
  end

  DOCS_LOADED = (count > 0)
  if DEBUG then print("[DEBUG] Loaded " .. count .. " documentation sections") end
  return true, count .. " documentation sections loaded"
end

-- Get documentation content by path
local function getDocContent(path)
  for _, catDocs in pairs(docs) do
    for _, doc in ipairs(catDocs) do
      if doc.path == path then return doc.content end
    end
  end
  return nil
end

-- Generate documentation list for AI
local function createDocListJSON()
  local items = {}
  for _, doc in ipairs(docIndex) do
    table.insert(items, '{"id":' .. doc.id .. ',"name":"' .. jsonEscape(doc.name) .. 
                '","category":"' .. jsonEscape(doc.category) .. '"}')
  end
  return "[" .. table.concat(items, ",") .. "]"
end

-- Stage 1: Select relevant documents
local function selectDocs(query)
  if #docIndex == 0 then
    return {}, "No documentation loaded. Use 'reload' to reload."
  end

  local selectionPrompt = [[
You are a documentation retrieval system for ComputerCraft (CC: Tweaked).
Select up to 3 most relevant documentation entries to answer this question:
"]] .. query .. [["

Available documentation:
]] .. createDocListJSON() .. [[

Return ONLY a JSON array of document IDs, like:
[1, 15, 42]

Do not include explanations - ONLY a JSON array of numbers.
]]

  local response, error = callGemini(selectionPrompt, false)
  if not response then
    return {}, error or "Document selection failed"
  end

  -- Extract and process document IDs
  local selectedDocs = {}
  local idsArray = response:match("%[%s*[%d%s,]+%s*%]")

  -- Extract IDs either from JSON array or as individual numbers
  local selectedIds = {}
  if idsArray then
    for id in idsArray:gmatch("%d+") do
      table.insert(selectedIds, tonumber(id))
    end
  else
    for id in response:gmatch("%d+") do
      table.insert(selectedIds, tonumber(id))
      if #selectedIds >= 3 then break end
    end
  end

  -- Map IDs to documents
  for _, id in ipairs(selectedIds) do
    for _, doc in ipairs(docIndex) do
      if doc.id == id then
        if DEBUG then print("[DEBUG] Selected: " .. doc.name) end
        table.insert(selectedDocs, doc)
        break
      end
    end
  end

  return selectedDocs, #selectedDocs .. " documents selected"
end

-- Command handlers
local function clearHistory()
  conversationHistory = {}
  return "Conversation history cleared. Starting fresh!"
end

local function saveConversation(filename)
  if not filename or filename == "" then
    filename = "gemini_chat_" .. os.date("%Y%m%d_%H%M%S") .. ".txt"
  elseif not filename:match("%.txt$") then 
    filename = filename .. ".txt" 
  end
  
  local file = fs.open(filename, "w")
  if not file then return "Error: Could not create file " .. filename end
  
  file.writeLine("=== Gemini Chat Conversation with Documentation ===")
  file.writeLine("Date: " .. os.date("%Y-%m-%d %H:%M:%S"))
  file.writeLine("")
  
  for i, message in ipairs(conversationHistory) do
    file.writeLine((message.role == "user" and "You: " or "Gemini: ") .. message.text)
    if i % 2 == 0 then file.writeLine("") end
  end
  
  file.close()
  return "Conversation saved to " .. filename
end

-- Full RAG pipeline
local function answerWithRAG(query)
  -- Stage 1: Select docs
  local selectedDocs, message = selectDocs(query)

  -- Build context from selected docs
  local docContext = ""
  local docNames = {}

  if #selectedDocs > 0 then
    docContext = "Relevant ComputerCraft Documentation:\n\n"
    for _, doc in ipairs(selectedDocs) do
      local content = getDocContent(doc.path)
      if content then
        docContext = docContext .. "--- " .. doc.name .. " (" .. doc.category .. ") ---\n"
        docContext = docContext .. content .. "\n\n"
        table.insert(docNames, doc.name)
      end
    end
    if DEBUG then print("[DEBUG] Using " .. #selectedDocs .. " docs (" .. #docContext .. " chars context)") end
  end

  -- Call Gemini with conversation history and document context
  local answer, error = callGemini(query, true, docContext, 1000)
  if not answer then
    return "Error: " .. (error or "Failed to get response"), "Error occurred"
  end

  return answer, (#docNames > 0) and "Using: " .. table.concat(docNames, ", ") or "No documentation used"
end

-- Main chat loop
local function main()
  term.clear()
  term.setCursorPos(1, 1)

  print("=== CC Chat v" .. VERSION .. " ===")
  print("Type 'help' for commands")
  print("-------------------------------------------------")

  -- Load docs silently on startup
  loadDocs()
  
  while true do
    term.setTextColor(colors.yellow)
    write("You: ")
    term.setTextColor(colors.white)
    
    local input = read()
    local command = input:match("^%s*(%S+)") or ""
    command = command:lower()
    
    -- Handle commands
    if command == "exit" then
      break
    elseif command == "help" then
      print("\nAvailable Commands:")
      print("  help     - Show this help message")
      print("  info     - Show system information")
      print("  model    - Switch model (2.5 or 3)")
      print("  setkey   - Set your Gemini API key")
      print("  clear    - Clear conversation history")
      print("  save     - Save conversation to file")
      print("  listdocs - List loaded documentation")
      print("  reload   - Reload documentation")
      print("  update   - Update to latest version")
      print("  debug    - Toggle debug mode")
      print("  exit     - Exit the program")
    elseif command == "info" then
      print("\nSystem Information:")
      print("Version: " .. VERSION)
      print("Model: " .. MODEL)

      if not settings.get("gemini.api_key") or settings.get("gemini.api_key") == "" then
        print("API Key: Not set")
      else
        local key = settings.get("gemini.api_key")
        print("API Key: " .. key:sub(1, 8) .. "..." .. key:sub(-4))
      end

      if #docIndex > 0 then
        print("Documentation: " .. #docIndex .. " sections loaded")
      else
        print("Documentation: Not loaded")
      end

      print("Debug Mode: " .. (DEBUG and "Enabled" or "Disabled"))
    elseif command == "model" then
      local arg = input:match("^model%s+(.+)$")
      if arg then
        local newModel = MODELS[arg]
        if newModel then
          MODEL = newModel
          print("Switched to model: " .. MODEL)
        else
          print("Unknown model. Available: 2.5, 3, gemma")
        end
      else
        print("\nAvailable models:")
        print("  2.5   - Gemini 2.5 Flash (default)")
        print("  3     - Gemini 3.0 Flash")
        print("  lite  - Gemini 2.5 Flash Lite")
        print("  gemma - Gemma 3 27b")
        print("\nUsage: model <version>")
        print("Current: " .. MODEL)
      end
    elseif command == "setkey" then
      term.setTextColor(colors.cyan)
      write("Enter your Gemini API key: ")
      term.setTextColor(colors.white)
      local key = read("*")
      if key and key ~= "" then
        settings.set("gemini.api_key", key)
        settings.save()
        print("\nAPI key saved!")
      else
        print("\nAPI key not changed.")
      end
    elseif command == "debug" then
      DEBUG = not DEBUG
      print("Debug mode " .. (DEBUG and "enabled" or "disabled"))
    elseif command == "reload" then
      print("Reloading documentation...")
      docs, docIndex = {}, {}
      DOCS_LOADED = false
      local success, message = loadDocs()
      print(message)
    elseif command == "update" then
      print("Downloading latest version from GitHub...")
      local url = "https://raw.githubusercontent.com/gotoundo/TurtleAI/dev/gemini_chat.lua"
      local tempFile = "gemini_chat_new.lua"

      local response = http.get(url)
      if not response then
        print("Error: Could not connect to GitHub")
      else
        local content = response.readAll()
        response.close()

        -- Check if we got valid content
        if content and #content > 100 then
          local file = fs.open(tempFile, "w")
          file.write(content)
          file.close()

          -- Get current program name
          local programName = shell.getRunningProgram()

          -- Delete old and rename new
          fs.delete(programName)
          fs.move(tempFile, programName)

          print("Update successful! Restarting...")
          sleep(1)
          shell.run(programName)
          return -- Exit current instance
        else
          print("Error: Downloaded file appears invalid")
          if fs.exists(tempFile) then fs.delete(tempFile) end
        end
      end
    elseif command == "clear" then
      term.setTextColor(colors.cyan)
      print("Gemini:")
      term.setTextColor(colors.white)
      print(clearHistory())
    elseif command:match("^save") then
      term.setTextColor(colors.cyan)
      print("Gemini:")
      term.setTextColor(colors.white)
      print(saveConversation(input:match("^save%s+(.+)$")))
    elseif command == "listdocs" then
      if #docIndex == 0 then
        print("No documents loaded. Use 'reload' to reload documents.")
      else
        print("Loaded " .. #docIndex .. " documents:")
        for i = 1, math.min(10, #docIndex) do
          print(docIndex[i].id .. ": " .. docIndex[i].name .. " (" .. docIndex[i].category .. ")")
        end
        if #docIndex > 10 then print("...and " .. (#docIndex - 10) .. " more") end
      end
    elseif input ~= "" then -- Ignore empty input
      local response, message = answerWithRAG(input)

      term.setTextColor(colors.cyan)
      print("Gemini:")
      term.setTextColor(colors.white)
      print(response)
    end
    print("")
  end
  
  print("Goodbye!")
end

-- Run the program
main()