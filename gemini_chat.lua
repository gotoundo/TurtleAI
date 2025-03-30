-- Gemini Chat for ComputerCraft with Local Documentation
-- Refactored to be smaller while maintaining full RAG functionality
local MODEL, VERSION = "models/gemini-2.0-flash", "1.4.0"
local DEBUG, DOCS_LOADED = false, false

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
  if DEBUG then print("Added to history: " .. role .. " - " .. message:sub(1, 30) .. "...") end
end

-- Documentation storage
local docs, docIndex = {}, {}
local function trim(s) return s:match("^%s*(.-)%s*$") end

-- Unified API call function for both task and conversation modes
local function callGemini(prompt, withHistory, docContext, maxTokens)
  local apiKey = settings.get("gemini.api_key")
  if not apiKey or apiKey == "" then return nil, "API key not set. Use 'setkey' to set it." end
  
  local url = "https://generativelanguage.googleapis.com/v1beta/" .. MODEL .. ":generateContent?key=" .. apiKey
  local requestBody
  
  if withHistory then
    addToHistory("user", prompt)
    local messages = {}
    for i, msg in ipairs(conversationHistory) do
      if msg.role == "user" and i == #conversationHistory then
        local enhancedText = msg.text
        if docContext and docContext ~= "" then
          enhancedText = enhancedText .. "\n\n" .. docContext .. "\n\nPlease provide a single-sentence answer that fits on a small computer screen."
        else
          enhancedText = enhancedText .. "\n\nPlease provide a single-sentence answer that fits on a small computer screen."
        end
        table.insert(messages, '{"role":"user","parts":[{"text":"' .. jsonEscape(enhancedText) .. '"}]}')
      else
        table.insert(messages, '{"role":"' .. msg.role .. '","parts":[{"text":"' .. jsonEscape(msg.text) .. '"}]}')
      end
    end
    requestBody = '{"contents":[' .. table.concat(messages, ",") .. ']'
  else
    requestBody = '{"contents":[{"role":"user","parts":[{"text":"' .. jsonEscape(prompt) .. '"}]}]'
  end
  
  if maxTokens then requestBody = requestBody .. ',"generationConfig":{"maxOutputTokens":' .. maxTokens .. '}' end
  requestBody = requestBody .. '}'
  
  if DEBUG then print("Request: " .. requestBody:sub(1, 100) .. "...") end
  
  local response = http.post(url, requestBody, {["Content-Type"] = "application/json"})
  if not response then
    if withHistory then table.remove(conversationHistory) end
    return nil, "Could not connect to Gemini API"
  end
  
  local responseText = response.readAll()
  response.close()
  
  local result = parseJSON(responseText)
  if not result.text then
    if withHistory then table.remove(conversationHistory) end
    if DEBUG then print("Raw response: " .. responseText:sub(1, 200)) end
    return nil, "Failed to parse response"
  end
  
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
  
  if not fs.exists(indexPath) then return false, "Category index not found" end
  
  local file = fs.open(indexPath, "r")
  local indexContent = file.readAll()
  file.close()
  
  -- Parse categories
  local categories = {}
  for category, combined_file, file_count in indexContent:gmatch('"([^"]+)"%s*:%s*{%s*"combined_file"%s*:%s*"([^"]+)"%s*,%s*"file_count"%s*:%s*(%d+)') do
    categories[category] = {combined_file = combined_file, file_count = tonumber(file_count)}
    if DEBUG then print("Found category: " .. category .. " with file: " .. combined_file) end
  end
  
  if not next(categories) then return false, "Failed to parse categories from index" end
  
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
  if #docIndex == 0 then return {}, "No documentation loaded. Use 'reload' to reload." end
  
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
  if not response then return {}, error or "Document selection failed" end
  
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
    if DEBUG then print("Failed to parse doc IDs from: " .. response) end
    for id in response:gmatch("%d+") do
      table.insert(selectedIds, tonumber(id))
      if #selectedIds >= 3 then break end
    end
  end
  
  -- Map IDs to documents
  for _, id in ipairs(selectedIds) do
    for _, doc in ipairs(docIndex) do
      if doc.id == id then
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
  end
  
  -- Call Gemini with conversation history and document context
  local answer, error = callGemini(query, true, docContext, 200)
  if not answer then
    return "Error: " .. (error or "Failed to get response"), "Error occurred"
  end
  
  return answer, (#docNames > 0) and "Using: " .. table.concat(docNames, ", ") or "No documentation used"
end

-- Main chat loop
local function main()
  term.clear()
  term.setCursorPos(1, 1)
  
  print("=== Gemini Chat v" .. VERSION .. " with Documentation ===")
  print("Commands: exit, setkey, clear, save, listdocs, debug, reload")
  print("-------------------------------------------------")
  
  if not settings.get("gemini.api_key") or settings.get("gemini.api_key") == "" then
    print("API key not set! Type 'setkey' to set it.")
  end
  
  -- Load docs on startup
  local success, message = loadDocs()
  if success then print("Documentation loaded: " .. #docIndex .. " sections.") 
  else print("Documentation failed to load.") end
  
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
      term.setTextColor(colors.cyan)
      print("Thinking with documentation...")
      term.setTextColor(colors.white)
      
      local response, message = answerWithRAG(input)
      
      term.setTextColor(colors.lightGray)
      print("(" .. message .. ")")
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