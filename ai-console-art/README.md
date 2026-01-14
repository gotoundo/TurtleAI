# AI Console Art Generator

Generate AI art with ComfyUI and display it directly in your terminal as ASCII/ANSI art.

## Features

- 🎨 Generate images using your local ComfyUI installation
- 🖥️ Display AI-generated images as beautiful ASCII/ANSI art in the terminal
- 🚀 Automatic ComfyUI server management
- 🎯 Simple text-to-image interface
- 🌈 Colorized output support
- 📦 Multiple rendering styles (ASCII, block characters, braille)

## Requirements

- Python 3.8+
- ComfyUI installation (found automatically)
- Required Python packages (see requirements.txt)

## Installation

```bash
# Install dependencies
pip install -r requirements.txt
```

## Usage

### Quick Start

```bash
# Start the interactive console art generator
python console_art.py
```

### Command Line Usage

```bash
# Generate and display a single image
python console_art.py --prompt "a beautiful sunset over mountains"

# Specify output size
python console_art.py --prompt "cute cat" --width 80 --height 40

# Use different rendering styles
python console_art.py --prompt "cyberpunk city" --style blocks

# Save ASCII art to file
python console_art.py --prompt "space station" --output art.txt
```

### Available Styles

- `ascii` - Classic ASCII characters (default)
- `blocks` - Unicode block characters (higher detail)
- `braille` - Braille patterns (highest detail)
- `color` - ANSI colored blocks

## Project Structure

```
ai-console-art/
├── console_art.py          # Main application
├── comfy_client.py         # ComfyUI API client
├── image_to_ascii.py       # Image to ASCII/ANSI converter
├── comfy_server.py         # ComfyUI server manager
├── workflows/              # ComfyUI workflow templates
│   └── basic_txt2img.json
├── requirements.txt        # Python dependencies
└── README.md              # This file
```

## How It Works

1. **Server Management**: Automatically starts ComfyUI server if not running
2. **Prompt Submission**: Sends your text prompt to ComfyUI via API
3. **Image Generation**: ComfyUI generates the image using your models
4. **Conversion**: Converts the generated image to ASCII/ANSI art
5. **Display**: Renders the art in your terminal

## Configuration

Edit `config.json` to customize:
- ComfyUI installation path
- Default image dimensions
- Model preferences
- Color schemes
- ASCII character sets

## Examples

```bash
# Fantasy art
python console_art.py --prompt "magical forest with glowing mushrooms"

# Portrait
python console_art.py --prompt "portrait of a wise wizard" --style color

# Sci-fi
python console_art.py --prompt "futuristic spaceship cockpit" --width 120
```

## Tips

- Use wider terminals for better detail
- The `blocks` style works best for most images
- `color` style requires a terminal that supports ANSI colors
- Adjust `--contrast` for better visibility

## Troubleshooting

**"ComfyUI not found"**
- Set the path in config.json or use `--comfy-path` flag

**"Server failed to start"**
- Check if ComfyUI dependencies are installed
- Verify models are available in ComfyUI

**"Image looks bad"**
- Increase terminal size
- Try different `--style` options
- Adjust `--contrast` parameter

## License

MIT License
