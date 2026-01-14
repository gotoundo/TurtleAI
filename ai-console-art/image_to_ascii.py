"""
Image to ASCII/ANSI Art Converter
Converts images to various ASCII art styles for terminal display
"""

from PIL import Image
import numpy as np
from typing import Tuple, Optional
import sys


class ImageToAscii:
    """Convert images to ASCII/ANSI art"""

    # ASCII character sets ordered by brightness
    ASCII_CHARS = {
        'simple': ' .:-=+*#%@',
        'detailed': ' .\'`^",:;Il!i><~+_-?][}{1)(|/tfjrxnuvczXYUJCLQ0OZmwqpdbkhao*#MW&8%B@$',
        'blocks': ' ░▒▓█',
        'braille': ' ⠁⠂⠃⠄⠅⠆⠇⠈⠉⠊⠋⠌⠍⠎⠏⠐⠑⠒⠓⠔⠕⠖⠗⠘⠙⠚⠛⠜⠝⠞⠟⠠⠡⠢⠣⠤⠥⠦⠧⠨⠩⠪⠫⠬⠭⠮⠯⠰⠱⠲⠳⠴⠵⠶⠷⠸⠹⠺⠻⠼⠽⠾⠿',
    }

    def __init__(self, style: str = 'detailed', width: int = 80):
        """
        Initialize converter

        Args:
            style: Character set to use ('simple', 'detailed', 'blocks', 'braille')
            width: Target width in characters
        """
        self.style = style
        self.width = width
        self.chars = self.ASCII_CHARS.get(style, self.ASCII_CHARS['detailed'])

    def resize_image(self, image: Image.Image, new_width: int) -> Image.Image:
        """
        Resize image maintaining aspect ratio

        Args:
            image: PIL Image object
            new_width: Target width in characters

        Returns:
            Resized PIL Image
        """
        width, height = image.size
        aspect_ratio = height / width

        # Adjust for character aspect ratio (characters are taller than wide)
        char_aspect_ratio = 0.55 if self.style != 'braille' else 0.4
        new_height = int(aspect_ratio * new_width * char_aspect_ratio)

        return image.resize((new_width, new_height), Image.Resampling.LANCZOS)

    def pixels_to_ascii(self, image: Image.Image, contrast: float = 1.0) -> str:
        """
        Convert image pixels to ASCII characters

        Args:
            image: PIL Image object
            contrast: Contrast multiplier (1.0 = normal)

        Returns:
            String of ASCII art with newlines
        """
        # Convert to grayscale
        image = image.convert('L')

        # Get pixel data
        pixels = np.array(image)

        # Apply contrast adjustment
        if contrast != 1.0:
            pixels = np.clip(128 + (pixels - 128) * contrast, 0, 255)

        # Normalize to char range
        normalized = pixels / 255.0
        char_indices = (normalized * (len(self.chars) - 1)).astype(int)

        # Build ASCII string
        ascii_str = ''
        for row in char_indices:
            ascii_str += ''.join(self.chars[idx] for idx in row) + '\n'

        return ascii_str

    def pixels_to_color_blocks(self, image: Image.Image) -> str:
        """
        Convert image to colored ANSI blocks

        Args:
            image: PIL Image object

        Returns:
            String with ANSI color codes
        """
        # Convert to RGB
        image = image.convert('RGB')
        pixels = np.array(image)

        ascii_str = ''
        for row in pixels:
            for pixel in row:
                r, g, b = pixel
                # Use ANSI 24-bit color (truecolor)
                ascii_str += f'\033[48;2;{r};{g};{b}m '
            ascii_str += '\033[0m\n'  # Reset color at end of line

        return ascii_str

    def convert(self, image: Image.Image, contrast: float = 1.0,
                color: bool = False) -> str:
        """
        Convert image to ASCII art

        Args:
            image: PIL Image object
            contrast: Contrast adjustment (1.0 = normal)
            color: Use colored output (ANSI colors)

        Returns:
            ASCII art string
        """
        # Resize image to target width
        image = self.resize_image(image, self.width)

        if color:
            return self.pixels_to_color_blocks(image)
        else:
            return self.pixels_to_ascii(image, contrast)

    def convert_file(self, image_path: str, contrast: float = 1.0,
                     color: bool = False) -> str:
        """
        Convert image file to ASCII art

        Args:
            image_path: Path to image file
            contrast: Contrast adjustment
            color: Use colored output

        Returns:
            ASCII art string
        """
        with Image.open(image_path) as img:
            return self.convert(img, contrast, color)


def main():
    """CLI for testing image conversion"""
    import argparse

    parser = argparse.ArgumentParser(description='Convert images to ASCII art')
    parser.add_argument('image', help='Path to image file')
    parser.add_argument('-w', '--width', type=int, default=80,
                       help='Width in characters (default: 80)')
    parser.add_argument('-s', '--style', choices=['simple', 'detailed', 'blocks', 'braille'],
                       default='detailed', help='ASCII character style')
    parser.add_argument('-c', '--contrast', type=float, default=1.0,
                       help='Contrast multiplier (default: 1.0)')
    parser.add_argument('--color', action='store_true',
                       help='Use colored output')
    parser.add_argument('-o', '--output', help='Output file (default: stdout)')

    args = parser.parse_args()

    # Create converter
    converter = ImageToAscii(style=args.style, width=args.width)

    # Convert image
    try:
        ascii_art = converter.convert_file(args.image, contrast=args.contrast,
                                          color=args.color)

        # Output
        if args.output:
            with open(args.output, 'w', encoding='utf-8') as f:
                f.write(ascii_art)
            print(f'ASCII art saved to {args.output}')
        else:
            print(ascii_art)

    except Exception as e:
        print(f'Error: {e}', file=sys.stderr)
        sys.exit(1)


if __name__ == '__main__':
    main()
