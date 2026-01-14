#!/usr/bin/env python3
"""
Test ASCII converter without ComfyUI
Uses a sample image to demonstrate ASCII art conversion
"""

import sys
from pathlib import Path
from PIL import Image, ImageDraw, ImageFont
from image_to_ascii import ImageToAscii


def create_test_image(text: str = "TEST") -> Image.Image:
    """
    Create a simple test image

    Args:
        text: Text to display in image

    Returns:
        PIL Image
    """
    # Create gradient image
    width, height = 400, 300
    image = Image.new('RGB', (width, height), color='white')
    draw = ImageDraw.Draw(image)

    # Draw gradient background
    for y in range(height):
        color_value = int(255 * (1 - y / height))
        draw.rectangle([(0, y), (width, y + 1)],
                      fill=(color_value, color_value // 2, 255 - color_value))

    # Draw text
    try:
        # Try to use a nice font
        font = ImageFont.truetype("arial.ttf", 60)
    except:
        # Fallback to default font
        font = ImageFont.load_default()

    # Center text
    bbox = draw.textbbox((0, 0), text, font=font)
    text_width = bbox[2] - bbox[0]
    text_height = bbox[3] - bbox[1]
    x = (width - text_width) // 2
    y = (height - text_height) // 2

    draw.text((x, y), text, fill='white', font=font)

    return image


def main():
    """Test ASCII conversion"""
    print("AI Console Art - ASCII Converter Test")
    print("=" * 60)
    print()

    # Create test image
    print("Creating test image...")
    image = create_test_image("AI ART")

    # Test different styles
    styles = ['simple', 'detailed', 'blocks']

    for style in styles:
        print(f"\n{'=' * 60}")
        print(f"Style: {style}")
        print('=' * 60)

        converter = ImageToAscii(style=style, width=80)
        ascii_art = converter.convert(image, contrast=1.2)
        print(ascii_art)

    # Test color output
    print(f"\n{'=' * 60}")
    print("Style: color")
    print('=' * 60)

    converter = ImageToAscii(style='blocks', width=40)
    ascii_art = converter.convert(image, color=True)
    print(ascii_art)

    print("\n" + "=" * 60)
    print("Test complete!")
    print("\nYou can now test with real images:")
    print(f"  python image_to_ascii.py <image_file>")
    print("\nOr start generating AI art:")
    print("  python console_art.py")


if __name__ == '__main__':
    main()
