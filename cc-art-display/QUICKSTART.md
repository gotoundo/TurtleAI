# Quick Start Guide - CC Art Display

Display AI-generated art on ComputerCraft monitors!

## Setup (One-Time)

### 1. Start ComfyUI Manually

First, start your ComfyUI server manually (in its own terminal):

```bash
cd C:\Users\trogd\Documents\GitHub\ComfyUI
python main.py
```

Wait for it to fully load (you'll see "To see the GUI go to: http://127.0.0.1:8188")

### 2. Start the Bridge Server

In a NEW terminal:

```bash
cd C:\Users\trogd\Documents\GitHub\TurtleAI\cc-art-display
pip install Flask
python bridge_server.py --no-start-comfy
```

You should see:
```
CC Art Bridge Server starting on http://0.0.0.0:8080
Ready to receive requests from ComputerCraft!
```

### 3. Configure ComputerCraft HTTP

Edit `config/computercraft-common.toml` in your Minecraft folder:

```toml
[[http.rules]]
    host = "127.0.0.1"
    action = "allow"
```

Save and restart Minecraft if needed.

### 4. Run in ComputerCraft

In Minecraft, on a ComputerCraft computer:

```lua
-- Copy art_display.lua to your computer
-- Then run:
art_display
```

Or if you're on a different computer than the server:
```lua
art_display http://YOUR_IP:8080
```

## Usage

1. **Enter a prompt** when asked
2. **Wait** for generation (15-60 seconds)
3. **See the art** displayed on your monitor!

## Example Prompts

Good prompts for CC's limited colors:
- "pixel art landscape"
- "simple robot"
- "colorful abstract shapes"
- "minimalist sunset"
- "geometric pattern"

## Troubleshooting

**"Failed to connect"**
- Make sure both ComfyUI and bridge_server.py are running
- Check your IP address
- Verify HTTP rules in CC config

**"Generation failed"**
- Check bridge_server.py terminal for errors
- Try a simpler prompt
- Make sure ComfyUI has models loaded

**Can't see the art**
- Connect a monitor to your computer
- Make it bigger (combine multiple monitors)
- The program auto-detects monitors

## Tips

- **Use monitors** for better display (terminal is tiny!)
- **Combine monitors** for larger canvas (3x3, 4x2, etc.)
- **Simple subjects** look better with only 16 colors
- **Lower steps** (10-15) = faster generation

Enjoy making AI art in Minecraft! 🎨
