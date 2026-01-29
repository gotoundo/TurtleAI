--[[
Base64 Decoder for Lua
Based on lua-users wiki implementation
Licensed under MIT
--]]

local base64 = {}

-- Base64 encoding table
local b64chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

-- Create decode lookup table
local function makeDecodeTable()
    local decode = {}
    for i = 1, #b64chars do
        decode[b64chars:sub(i, i)] = i - 1
    end
    decode['='] = 0  -- Padding character
    return decode
end

local b64decode = makeDecodeTable()

-- Decode base64 string to binary string
function base64.decode(data)
    -- Remove whitespace
    data = data:gsub('%s+', '')

    -- Ensure length is multiple of 4
    local padding = #data % 4
    if padding > 0 then
        data = data .. string.rep('=', 4 - padding)
    end

    local result = {}
    local pos = 1

    for i = 1, #data, 4 do
        local a = b64decode[data:sub(i, i)]
        local b = b64decode[data:sub(i+1, i+1)]
        local c = b64decode[data:sub(i+2, i+2)]
        local d = b64decode[data:sub(i+3, i+3)]

        if not (a and b and c and d) then
            error("Invalid base64 character at position " .. i)
        end

        -- Decode 4 base64 chars into 3 bytes
        local byte1 = (a * 4) + math.floor(b / 16)
        local byte2 = ((b % 16) * 16) + math.floor(c / 4)
        local byte3 = ((c % 4) * 64) + d

        result[pos] = string.char(byte1)
        pos = pos + 1

        if data:sub(i+2, i+2) ~= '=' then
            result[pos] = string.char(byte2)
            pos = pos + 1
        end

        if data:sub(i+3, i+3) ~= '=' then
            result[pos] = string.char(byte3)
            pos = pos + 1
        end
    end

    return table.concat(result)
end

return base64
