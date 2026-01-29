--[[
Gemini Image Generator for ComputerCraft
Pure Lua implementation - no external servers!

Uses Gemini Imagen API to generate images and displays them on CC monitors
Includes PNG decoder, base64 decoder, and CC 16-color converter
--]]

local VERSION = "1.0.0"

-- Load PNG decoder (merged pngLua library)
local PngImage
if fs.exists("lib/png.lua") then
  local pngModule = loadfile("lib/png.lua")
  PngImage = pngModule()
else
  error("lib/png.lua not found! Please ensure PNG decoder is installed.")
end

-- Load base64 decoder
local base64
if fs.exists("lib/base64.lua") then
  local b64Module = loadfile("lib/base64.lua")
  base64 = b64Module()
else
  error("lib/base64.lua not found! Please ensure base64 decoder is installed.")
end

-- ComputerCraft 16-color palette (RGB values)
local CC_PALETTE = {
  {240, 240, 240}, -- 0: white
  {242, 178, 51},  -- 1: orange
  {229, 127, 216}, -- 2: magenta
  {153, 178, 242}, -- 3: lightBlue
  {222, 222, 108}, -- 4: yellow
  {127, 204, 25},  -- 5: lime
  {242, 178, 204}, -- 6: pink
  {76, 76, 76},    -- 7: gray
  {153, 153, 153}, -- 8: lightGray
  {76, 153, 178},  -- 9: cyan
  {178, 102, 229}, -- 10: purple
  {51, 102, 204},  -- 11: blue
  {127, 102, 76},  -- 12: brown
  {87, 166, 78},   -- 13: green
  {204, 76, 76},   -- 14: red
  {25, 25, 25}     -- 15: black
}

-- Settings
settings.define("gemini.api_key", {
  description = "Gemini API key for image generation",
  default = "",
  type = "string"
})
settings.load()

-- Find monitor or use terminal
local function findMonitor()
  local monitors = {peripheral.find("monitor")}
  if #monitors == 0 then
    return term.current()
  end
  return monitors[1]
end

-- Convert RGB to closest CC color index (0-15)
local function closestCCColor(r, g, b)
  local minDist = math.huge
  local closest = 0

  for idx, rgb in ipairs(CC_PALETTE) do
    local pr, pg, pb = rgb[1], rgb[2], rgb[3]
    local dist = (r - pr) * (r - pr) + (g - pg) * (g - pg) + (b - pb) * (b - pb)

    if dist < minDist then
      minDist = dist
      closest = idx - 1  -- 0-indexed
    end
  end

  return closest
end

-- Display image on monitor
local function drawImage(mon, pixelData)
  mon.clear()
  mon.setCursorPos(1, 1)

  local width = pixelData.width
  local height = pixelData.height
  local pixels = pixelData.pixels

  for y = 1, height do
    for x = 1, width do
      local colorIndex = pixels[y][x]
      local ccColor = 2 ^ colorIndex  -- Convert index to CC color

      mon.setCursorPos(x, y)
      mon.setBackgroundColor(ccColor)
      mon.write(" ")
    end
  end

  mon.setBackgroundColor(colors.black)
  mon.setTextColor(colors.white)
end

-- Convert PNG image data to CC pixel array
local function pngToCCPixels(pngImage)
  print("Converting to CC colors...")

  local width = pngImage.width
  local height = pngImage.height
  local pixels = {}

  for y = 1, height do
    pixels[y] = {}
    for x = 1, width do
      local pixel = pngImage:get_pixel(x, y)
      local r, g, b, a = pixel:getColor()

      -- Convert RGB to closest CC color
      local ccIndex = closestCCColor(r, g, b)
      pixels[y][x] = ccIndex
    end

    -- Progress indicator
    if y % 10 == 0 then
      print("  " .. y .. " / " .. height .. " rows converted")
    end
  end

  return {
    width = width,
    height = height,
    pixels = pixels
  }
end

-- Call Gemini 2.5 Flash Image API
local function generateImage(prompt, aspectRatio)
  local apiKey = settings.get("gemini.api_key")
  if not apiKey or apiKey == "" then
    return nil, "API key not set. Use 'setkey' to configure."
  end

  aspectRatio = aspectRatio or "1:1"
  print("Generating image (this may take a moment)...")

  -- Gemini 2.5 Flash Image endpoint
  local url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-image:generateContent"

  -- Build request
  local requestBody = textutils.serializeJSON({
    contents = {{
      parts = {{text = prompt}}
    }},
    generationConfig = {
      responseModalities = {"IMAGE"},
      imageConfig = {
        aspectRatio = aspectRatio
      }
    }
  })

  -- Send request with API key in header
  local headers = {
    ["Content-Type"] = "application/json",
    ["x-goog-api-key"] = apiKey
  }

  local response = http.post(url, requestBody, headers)

  if not response then
    return nil, "Could not connect to Gemini API. Check network and API key."
  end

  local responseText = response.readAll()
  response.close()

  -- Parse JSON response
  local result = textutils.unserialiseJSON(responseText)
  if not result then
    return nil, "Failed to parse API response"
  end

  -- Extract base64 image from response
  -- Response format: { candidates: [{ content: { parts: [{ inline_data: { data: "base64..." } }] } }] }
  if not (result.candidates and result.candidates[1]) then
    -- Try to extract error message
    local errorMsg = result.error and result.error.message or "Unknown error"
    return nil, "API Error: " .. errorMsg
  end

  local parts = result.candidates[1].content and result.candidates[1].content.parts
  if not parts then
    return nil, "API Error: No content in response"
  end

  -- Find the image part (inline_data)
  local base64Image
  for _, part in ipairs(parts) do
    if part.inline_data and part.inline_data.data then
      base64Image = part.inline_data.data
      break
    end
  end

  if not base64Image then
    return nil, "API Error: No image data in response"
  end

  return base64Image
end

-- Main function
local function main(prompt, aspectRatio)
  print("Gemini Image Generator v" .. VERSION)
  print("Using Gemini 2.5 Flash Image")
  print()

  -- Get API key if not set
  local apiKey = settings.get("gemini.api_key")
  if not apiKey or apiKey == "" then
    print("API key not set.")
    print("Please enter your Gemini API key:")
    local key = read("*")
    settings.set("gemini.api_key", key)
    settings.save()
    apiKey = key
  end

  -- Get prompt if not provided
  if not prompt then
    print("Enter image prompt:")
    prompt = read()
  end

  -- Validate aspect ratio
  aspectRatio = aspectRatio or "1:1"
  local validRatios = {"1:1", "2:3", "3:2", "3:4", "4:3", "4:5", "5:4", "9:16", "16:9", "21:9"}
  local isValid = false
  for _, ratio in ipairs(validRatios) do
    if ratio == aspectRatio then
      isValid = true
      break
    end
  end

  if not isValid then
    print("Warning: Invalid aspect ratio '" .. aspectRatio .. "', using 1:1")
    aspectRatio = "1:1"
  end

  print("Aspect ratio: " .. aspectRatio)
  print()

  -- Generate image
  local base64Image, err = generateImage(prompt, aspectRatio)
  if not base64Image then
    print("Error: " .. err)
    return
  end

  print("Image generated! Size: " .. #base64Image .. " chars (base64)")
  print()

  -- Decode base64
  print("Decoding base64...")
  local pngData = base64.decode(base64Image)
  print("Decoded to " .. #pngData .. " bytes")
  print()

  -- Decode PNG (this is the slow part!)
  print("Decoding PNG...")
  print("This may take 30-120 seconds for 1024px images...")
  print("Please be patient!")
  print()

  local pngImage = PngImage({input = pngData})

  if not pngImage then
    print("Error: Failed to decode PNG")
    return
  end

  print("PNG decoded! Size: " .. pngImage.width .. "x" .. pngImage.height)
  print()

  -- Convert to CC colors
  local ccPixels = pngToCCPixels(pngImage)

  -- Find monitor
  local mon = findMonitor()
  print("Displaying on " .. (peripheral.getName(mon) or "terminal"))
  print()

  -- Draw image
  drawImage(mon, ccPixels)

  print()
  print("Done! Image displayed.")
  print("Note: Image has SynthID watermark")
end

-- Command line interface
local args = {...}

if #args == 0 then
  -- Interactive mode
  main()
elseif args[1] == "setkey" then
  print("Enter your Gemini API key:")
  local key = read("*")
  settings.set("gemini.api_key", key)
  settings.save()
  print("API key saved!")
elseif args[1] == "help" then
  print("Gemini Image Generator v" .. VERSION)
  print("Using Gemini 2.5 Flash Image")
  print()
  print("Usage:")
  print("  gemini_image                    - Interactive mode")
  print("  gemini_image <prompt>           - Generate with prompt (1:1 ratio)")
  print("  gemini_image <prompt> <ratio>   - Generate with aspect ratio")
  print("  gemini_image setkey             - Set API key")
  print("  gemini_image help               - Show this help")
  print()
  print("Aspect Ratios:")
  print("  1:1, 2:3, 3:2, 3:4, 4:3, 4:5, 5:4, 9:16, 16:9, 21:9")
  print()
  print("Examples:")
  print("  gemini_image \"a cute robot in a garden\"")
  print("  gemini_image \"pixel art landscape\" 16:9")
  print("  gemini_image \"portrait of a wizard\" 3:4")
  print()
  print("Note: Generated images are 1024px base resolution")
  print("PNG decoding takes 30-120 seconds - please be patient!")
  print("Cost: $0.039 per image (1290 tokens)")
else
  -- Command line mode
  local prompt = args[1]
  local aspectRatio = args[2]
  main(prompt, aspectRatio)
end
