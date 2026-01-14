# Quick Start Guide

## Installation

1. **Install dependencies:**
```bash
pip install -r requirements.txt
```

Or use the quickstart script:
```bash
python quickstart.py
```

## Basic Usage

### Interactive Mode
Launch the interactive console:
```bash
python console_art.py
```

Then enter prompts when asked!

### Single Generation
Generate one image from command line:
```bash
python console_art.py --prompt "a beautiful sunset over mountains"
```

### With Options
```bash
python console_art.py --prompt "cyberpunk city at night" --width 120 --style blocks --color
```

## Test Without ComfyUI

Test the ASCII converter with a test image:
```bash
python test_ascii.py
```

Or convert any existing image:
```bash
python image_to_ascii.py path/to/image.jpg --width 100 --style detailed
```

## How It Works

1. **Starts ComfyUI** - Automatically launches your local ComfyUI server
2. **Generates Image** - Sends your prompt to ComfyUI for AI generation
3. **Converts to ASCII** - Transforms the image into beautiful terminal art
4. **Displays** - Shows the result right in your console!

## Tips

- Use `--width` to control ASCII art size (default: 100 chars)
- Try `--style blocks` for better detail
- Add `--color` for colorful output (requires ANSI color support)
- Increase `--contrast` if output looks washed out
- Save output with `--output art.txt`

## Troubleshooting

**"ComfyUI not found"**
- Edit `config.json` and set the correct path
- Or use `--comfy-path /path/to/ComfyUI`

**Server won't start**
- Make sure ComfyUI is properly installed
- Check that you have models downloaded
- Try starting ComfyUI manually first to verify it works

**Unicode/encoding errors**
- Use `--style simple` or `--style detailed` (pure ASCII)
- Avoid `blocks` and `braille` styles on older terminals

## Examples

```bash
# Fantasy
python console_art.py --prompt "magical forest with glowing mushrooms"

# Portrait
python console_art.py --prompt "portrait of a wise wizard" --image-height 768

# Sci-fi with color
python console_art.py --prompt "futuristic spaceship" --color --width 80

# Save to file
python console_art.py --prompt "cute robot" --output robot.txt
```

## Configuration

Edit `config.json` to set defaults:
- ComfyUI installation path
- Default image dimensions
- ASCII art preferences
- Model selections

Enjoy creating AI art in your terminal! 🎨
