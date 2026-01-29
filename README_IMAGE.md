# Gemini Image Generator for ComputerCraft

Generate AI images directly in Minecraft using pure Lua - no external servers required!

## Overview

This system uses **Gemini 2.5 Flash Image** to generate images and displays them on ComputerCraft monitors. Everything runs in pure Lua with no external Python servers or dependencies outside of ComputerCraft.

**Key Features:**
- 🎨 Pure Lua implementation (no external servers!)
- 🖼️ Full PNG decoder in Lua (9551-Dev/pngLua)
- 🎯 Base64 decoder included
- 🌈 Automatic conversion to CC's 16-color palette
- ⚡ Uses Gemini 2.5 Flash Image ($0.039/image)
- 📐 10 aspect ratios supported

## How It Works

```
User enters prompt
    ↓
Gemini 2.5 Flash Image generates 1024px PNG
    ↓
Base64 encoded response received via HTTP
    ↓
Base64 decoded to PNG bytes (Lua)
    ↓
PNG decoded to RGB pixels (Lua, 30-120 sec)
    ↓
RGB converted to CC 16-color palette (Euclidean distance)
    ↓
Displayed on monitor pixel-by-pixel
```

## Installation

### Step 1: Download Files

In ComputerCraft:

```lua
-- Download main program
wget https://raw.githubusercontent.com/gotoundo/TurtleAI/dev/gemini_image.lua gemini_image.lua

-- Create lib folder
mkdir lib

-- Download PNG decoder
wget https://raw.githubusercontent.com/9551-Dev/pngLua/master/png.lua lib/png.lua

-- Download base64 decoder
wget https://raw.githubusercontent.com/gotoundo/TurtleAI/dev/lib/base64.lua lib/base64.lua
```

### Step 2: Configure HTTP Access

Ensure your `config/computercraft-common.toml` allows HTTPS:

```toml
[[http.rules]]
    host = "*"
    action = "allow"

# Or specifically:
[[http.rules]]
    host = "generativelanguage.googleapis.com"
    action = "allow"
```

### Step 3: Set API Key

```lua
gemini_image setkey
```

Enter your Gemini API key when prompted. Get one at: https://aistudio.google.com/apikey

## Usage

### Interactive Mode

```lua
gemini_image
```

Then enter your prompt when asked.

### Command Line Mode

```lua
-- Default (1:1 aspect ratio)
gemini_image "a cute robot in a garden"

-- With aspect ratio
gemini_image "pixel art landscape" 16:9
gemini_image "portrait of a wizard" 3:4
gemini_image "cinematic space scene" 21:9
```

### Available Aspect Ratios

- `1:1` - Square (default)
- `2:3`, `3:2` - Photo formats
- `3:4`, `4:3` - Classic formats
- `4:5`, `5:4` - Social media
- `9:16`, `16:9` - Widescreen/mobile
- `21:9` - Ultra-wide cinematic

### Commands

```lua
gemini_image help      -- Show help
gemini_image setkey    -- Set/change API key
```

## Performance

### Decode Times (Approximate)

| Size | PNG Decode Time |
|------|----------------|
| 1024x1024 (1:1) | 90-120 seconds |
| 1024x576 (16:9) | 60-90 seconds |
| 1024x1366 (3:4) | 90-120 seconds |

**Note:** PNG decoding is the slow part. The Lua PNG decoder processes ~10-15 pixels/second. This is normal for pure Lua DEFLATE decompression.

### Tips for Faster Results

1. **Use wider aspect ratios** - Fewer total pixels (e.g., 21:9)
2. **Be patient** - Grab a coffee during decode
3. **Generated images are cached** - Display is instant after first decode

## Technical Details

### Architecture

**Libraries Used:**
- **9551-Dev/pngLua** - PNG decoder for CC: Tweaked
- **Custom base64.lua** - Base64 decoder
- **Built-in bit32** - Bitwise operations (CC: Tweaked)

**Color Conversion:**
- Uses Euclidean distance in RGB space
- Finds closest match from CC's 16-color palette
- Preserves as much detail as possible

**PNG Decoding:**
- Full DEFLATE decompression in pure Lua
- Supports all PNG color types
- Handles filtering and interlacing

### API Details

**Endpoint:**
```
POST https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-image:generateContent
```

**Headers:**
```
Content-Type: application/json
x-goog-api-key: YOUR_API_KEY
```

**Request:**
```json
{
  "contents": [{
    "parts": [{"text": "your prompt"}]
  }],
  "generationConfig": {
    "responseModalities": ["IMAGE"],
    "imageConfig": {
      "aspectRatio": "1:1"
    }
  }
}
```

**Response:**
```json
{
  "candidates": [{
    "content": {
      "parts": [{
        "inline_data": {
          "data": "base64_encoded_png...",
          "mime_type": "image/png"
        }
      }]
    }
  }]
}
```

### File Structure

```
TurtleAI/
├── gemini_image.lua       # Main program (~350 lines)
├── lib/
│   ├── png.lua           # PNG decoder (~785 lines, from 9551-Dev)
│   └── base64.lua        # Base64 decoder (~70 lines)
└── README_IMAGE.md       # This file
```

## Limitations

1. **Decode Time:** 30-120 seconds for 1024px images (pure Lua DEFLATE is slow)
2. **16 Colors:** CC's palette limits color accuracy
3. **Resolution:** Monitor size limits display (164x81 max)
4. **Memory:** Large images may cause OOM on older CC versions
5. **No Animation:** Static images only
6. **SynthID Watermark:** All images include invisible watermark

## Cost

**Gemini 2.5 Flash Image Pricing:**
- $30.00 per 1 million output tokens
- Each image = 1290 tokens
- **Cost per image: $0.039** (~2.5 cents)

Much cheaper than Imagen 4.0!

## Troubleshooting

### "lib/png.lua not found"

Make sure you downloaded the PNG decoder to the `lib/` folder:

```lua
mkdir lib
wget https://raw.githubusercontent.com/9551-Dev/pngLua/master/png.lua lib/png.lua
```

### "Could not connect to Gemini API"

1. Check HTTP is enabled in CC config
2. Verify API key is correct (`gemini_image setkey`)
3. Check network connectivity
4. Ensure HTTPS is allowed

### "Failed to decode PNG"

This is rare but can happen if:
- Image is corrupted
- Out of memory
- Unsupported PNG format

Try again with a simpler prompt.

### "Decode takes forever"

This is normal! Pure Lua PNG decoding is slow:
- 1024x1024 image = ~100,000 pixels
- Processing rate = ~10-15 pixels/second
- Expected time = 90-120 seconds

Be patient and let it complete.

### Display looks wrong

- CC only has 16 colors - some details will be lost
- Try prompts that work well with limited palette
- "pixel art", "simple shapes", "bold colors" work best

## Best Practices

### Prompt Tips

**Good prompts:**
- "pixel art robot on white background"
- "simple geometric landscape with few colors"
- "bold minimalist poster design"
- "flat design illustration of a cat"

**Avoid:**
- Complex gradients
- Realistic photos (too many colors)
- Very detailed scenes
- Subtle color variations

### Example Prompts

```lua
-- Works well with 16 colors
gemini_image "pixel art castle in minecraft style"
gemini_image "simple cartoon robot character"
gemini_image "geometric abstract art with primary colors"
gemini_image "flat design icon of a computer"

-- Cinematic shots
gemini_image "wide angle view of a space station" 21:9
gemini_image "dramatic sunset landscape" 16:9

-- Portraits
gemini_image "pixel art character portrait" 3:4
gemini_image "simple logo design on white background" 1:1
```

## Credits

- **pngLua:** 9551-Dev (based on DelusionalLogic/pngLua)
- **Original DEFLATE:** David Manura (2008-2011)
- **Gemini API:** Google
- **Base64 implementation:** lua-users wiki
- **Integration:** TurtleAI project

## License

- `gemini_image.lua`: MIT (TurtleAI project)
- `lib/png.lua`: MIT (David Manura, 9551-Dev)
- `lib/base64.lua`: MIT

## See Also

- [Main TurtleAI README](README.md)
- [CC Chat Documentation](CLAUDE.md)
- [Gemini 2.5 Flash Image Docs](https://ai.google.dev/gemini-api/docs/image-generation)
- [9551-Dev/pngLua](https://github.com/9551-Dev/pngLua)

---

**Remember:** This is Minecraft! Be patient during PNG decoding and have fun generating AI art in-game!
