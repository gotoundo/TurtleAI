-- Define the URL and headers
local url = "http://localhost:11434/api/generate"
local headers = {
    ["Content-Type"] = "application/json",
}
local model = "qwen2.5" --"llama3.2"

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

-- Function to convert a Lua table to a JSON string
local function tableToJSON(t)
    local json = "{"
    for k, v in pairs(t) do
        if type(k) == "string" then
            json = json .. string.format('"%s":"%s",', k, v)
        end
    end
    return json:sub(1, -2) .. "}"
end

-- Function to convert Lua headers table to a JSON string
local function headersToJSON(headers)
    local headerJson = "{"
    for k, v in pairs(headers) do
        if type(k) == "string" then
            headerJson = headerJson .. string.format('"%s":"%s",', k, v)
        end
    end
    return headerJson:sub(1, -2) .. "}"
end

local function simpleOllamaRequest(fullContext)
    -- Define the payload as a Lua table
    local payload = {
        model = model,
        prompt = fullContext
    }

    -- Convert the payload to JSON
    local jsonPayload = tableToJSON(payload)

    local response, status = http.post(url, jsonPayload, headers)

    if not response then
        print("Request failed with status:", status)
    else
        -- Extract and combine response text
        local fullText = ""
        local responseStr = response.readAll()
        
        -- Process each line of the response (each is a JSON object)
        for line in responseStr:gmatch("[^\r\n]+") do
            -- Check if the line contains a "response" field
            local responseText = line:match('"response":"([^"]*)"')
            if responseText then
                fullText = fullText .. responseText
            end
        end
        
        return fullText
    end
end

conversation_log = ""

print("You are chatting with " .. model .. ". Type exit to exit.")

local running = true
while running do
    term.setTextColor(colors.yellow)
    write("> ")
    local userInput = io.read("*l")  -- Read a line of input from the user
    term.setTextColor(colors.white)

    -- Check if the user wants to continue or not (e.g., enter 'exit' to break the loop)
    if userInput == "exit" then
        print("Smell ya later!")
        print("(.`____(.`")
        running = false
        return
    end

    local turn_template = string.format([[%s                      <user> %s </user> <assistant> ]], conversation_log, jsonEscape(userInput))
    
    local response = simpleOllamaRequest(turn_template)
    
    term.setTextColor(colors.green)
    write(model .. ": ")
    term.setTextColor(colors.white)
    print(jsonUnescape(response))
    
    conversation_log = conversation_log .. turn_template .. jsonEscape(response)
end

