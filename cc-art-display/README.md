# ComputerCraft AI Art Display

Display AI-generated art on ComputerCraft monitors in Minecraft!

## Overview

This system bridges ComfyUI with ComputerCraft, allowing you to generate AI art and display it on in-game monitors.

## Components

1. **bridge_server.py** - Python server that handles ComfyUI generation and image conversion
2. **art_display.lua** - ComputerCraft program that requests and displays art

## Setup

### Step 1: Install Python Dependencies

```bash
pip install -r requirements.txt
```

### Step 2: Start the Bridge Server

On your real computer, run:
```bash
python bridge_server.py
```

The server will:
- Auto-start your ComfyUI installation
- Listen on port 8080 for ComputerCraft requests
- Convert images to ComputerCraft's 16-color format

### Step 3: Upload Lua Program to ComputerCraft

In Minecraft, on your ComputerCraft computer:

```lua
-- Download the program
wget https://raw.githubusercontent.com/gotoundo/TurtleAI/dev/cc-art-display/art_display.lua art_display.lua

-- Or paste it manually using edit
edit art_display.lua
```

### Step 4: Configure HTTP Access

Make sure your ComputerCraft config allows local HTTP access:

In `config/computercraft-common.toml`:
```toml
[[http.rules]]
    host = "127.0.0.1"
    action = "allow"

[[http.rules]]
    host = "localhost"
    action = "allow"
```

Or add your computer's IP address.

## Usage

### Interactive Mode

On your ComputerCraft computer:
```lua
art_display
```

Then enter prompts when asked!

### Quick Mode

Generate a single image:
```lua
art_display http://YOUR_IP:8080 "a cute robot in a garden"
```

Replace `YOUR_IP` with your computer's IP address (e.g., `192.168.1.100`)

### Find Your IP Address

On Windows:
```bash
ipconfig
```
Look for "IPv4 Address"

On Linux/Mac:
```bash
ifconfig
```

## How It Works

1. **You type a prompt** in ComputerCraft
2. **Lua program sends HTTP request** to the Python bridge server
3. **Bridge server generates image** using your local ComfyUI
4. **Image is converted** to ComputerCraft's 16-color palette
5. **Lua program displays** the art on your monitor!

## Tips

### Using Monitors

- Connect one or more monitors to your computer
- The program automatically detects and uses monitors
- Larger monitors = more detailed art!
- Combine monitors (3x3, 4x2, etc.) for bigger displays

### Best Results

- Use descriptive prompts
- Lower step count (10-15) for faster generation
- Smaller images (512x512) work better on CC's limited palette
- Simple subjects look better than complex scenes

### Troubleshooting

**"Failed to connect to server"**
- Make sure bridge_server.py is running
- Check your IP address is correct
- Verify HTTP access is enabled in CC config

**"Generation failed"**
- Check that ComfyUI has models downloaded
- Try simpler prompts
- Check bridge_server.py terminal for errors

**Colors look wrong**
- This is normal! CC only has 16 colors
- The converter picks the closest matching colors
- Try adjusting your prompt for better results

## Example Prompts

```
a pixel art landscape
simple geometric shapes
minimalist robot design
colorful abstract art
a sunset with few colors
```

Simpler subjects with fewer colors tend to look better on ComputerCraft's limited palette!

## Architecture

```
┌─────────────────┐
│  ComputerCraft  │
│   (Minecraft)   │
│                 │
│  art_display.lua│
└────────┬────────┘
         │ HTTP
         │ Request
         ▼
┌─────────────────┐
│ Bridge Server   │
│ (Python/Flask)  │
│                 │
│ bridge_server.py│
└────────┬────────┘
         │ API
         │ Call
         ▼
┌─────────────────┐
│    ComfyUI      │
│  (Image Gen)    │
└─────────────────┘
```

## License

MIT License
