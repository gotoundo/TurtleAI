"""
ComputerCraft Art Bridge Server
Bridges between ComfyUI and ComputerCraft monitors
"""

import sys
import os
import json
import io
from pathlib import Path
from flask import Flask, request, jsonify
from PIL import Image
import logging

# Add parent directory to path to import comfy modules
sys.path.append(str(Path(__file__).parent.parent / "ai-console-art"))

from comfy_server import ComfyServer
from comfy_client import ComfyClient

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

app = Flask(__name__)

# ComputerCraft color palette (16 colors)
CC_COLORS = {
    0: (240, 240, 240),  # white
    1: (242, 178, 51),   # orange
    2: (229, 127, 216),  # magenta
    3: (153, 178, 242),  # lightBlue
    4: (222, 222, 108),  # yellow
    5: (127, 204, 25),   # lime
    6: (242, 178, 204),  # pink
    7: (76, 76, 76),     # gray
    8: (153, 153, 153),  # lightGray
    9: (76, 153, 178),   # cyan
    10: (178, 102, 229), # purple
    11: (51, 102, 204),  # blue
    12: (127, 102, 76),  # brown
    13: (87, 166, 78),   # green
    14: (204, 76, 76),   # red
    15: (25, 25, 25),    # black
}


class ImageToCCConverter:
    """Convert images to ComputerCraft format"""

    def __init__(self):
        self.cc_palette = list(CC_COLORS.values())

    def closest_cc_color(self, rgb):
        """Find closest CC color to RGB value"""
        r, g, b = rgb
        min_dist = float('inf')
        closest = 0

        for idx, (pr, pg, pb) in enumerate(self.cc_palette):
            dist = (r - pr) ** 2 + (g - pg) ** 2 + (b - pb) ** 2
            if dist < min_dist:
                min_dist = dist
                closest = idx

        return closest

    def convert_to_cc_format(self, image: Image.Image, max_width=164, max_height=81):
        """
        Convert PIL image to CC monitor format

        Args:
            image: PIL Image
            max_width: Maximum width (CC monitor limit)
            max_height: Maximum height (CC monitor limit)

        Returns:
            Dict with width, height, and pixel data
        """
        # Resize to fit CC monitor
        img_width, img_height = image.size
        aspect_ratio = img_height / img_width

        if img_width > max_width or img_height > max_height:
            if img_width / max_width > img_height / max_height:
                new_width = max_width
                new_height = int(max_width * aspect_ratio)
            else:
                new_height = max_height
                new_width = int(max_height / aspect_ratio)

            image = image.resize((new_width, new_height), Image.Resampling.LANCZOS)

        # Convert to RGB
        image = image.convert('RGB')
        width, height = image.size
        pixels = image.load()

        # Convert each pixel to CC color index
        cc_pixels = []
        for y in range(height):
            row = []
            for x in range(width):
                rgb = pixels[x, y]
                cc_color = self.closest_cc_color(rgb)
                row.append(cc_color)
            cc_pixels.append(row)

        return {
            'width': width,
            'height': height,
            'pixels': cc_pixels
        }


# Global instances
comfy_server = None
comfy_client = None
cc_converter = ImageToCCConverter()


@app.route('/health', methods=['GET'])
def health():
    """Health check endpoint"""
    return jsonify({'status': 'ok'})


@app.route('/generate', methods=['POST'])
def generate_art():
    """
    Generate AI art and return in CC format

    Request body:
    {
        "prompt": "text prompt",
        "width": 512,
        "height": 512,
        "steps": 20
    }

    Returns CC-formatted image data
    """
    try:
        data = request.json
        prompt = data.get('prompt', 'a beautiful landscape')
        width = data.get('width', 512)
        height = data.get('height', 512)
        steps = data.get('steps', 15)
        cc_width = data.get('cc_width', 164)
        cc_height = data.get('cc_height', 81)

        logger.info(f"Generating: {prompt}")

        # Create workflow
        workflow = comfy_client.create_simple_txt2img_workflow(
            prompt=prompt,
            width=width,
            height=height,
            steps=steps
        )

        # Generate image
        images = comfy_client.generate_image(workflow, timeout=300)

        if not images:
            return jsonify({'error': 'No images generated'}), 500

        # Convert to CC format
        cc_data = cc_converter.convert_to_cc_format(
            images[0],
            max_width=cc_width,
            max_height=cc_height
        )

        logger.info(f"Converted to {cc_data['width']}x{cc_data['height']} CC image")

        return jsonify({
            'success': True,
            'data': cc_data,
            'prompt': prompt
        })

    except Exception as e:
        logger.exception("Generation failed")
        return jsonify({'error': str(e)}), 500


def main():
    """Start the bridge server"""
    import argparse

    parser = argparse.ArgumentParser(description='CC Art Bridge Server')
    parser.add_argument('--port', type=int, default=8080,
                       help='Server port (default: 8080)')
    parser.add_argument('--comfy-path', help='Path to ComfyUI')
    parser.add_argument('--comfy-port', type=int, default=8188,
                       help='ComfyUI port (default: 8188)')
    parser.add_argument('--no-start-comfy', action='store_true',
                       help='Use existing ComfyUI server (don\'t start new one)')

    args = parser.parse_args()

    global comfy_server, comfy_client

    # Start or connect to ComfyUI server
    if not args.no_start_comfy:
        print("Initializing ComfyUI server...")
        comfy_server = ComfyServer(comfy_path=args.comfy_path, port=args.comfy_port)

        if not comfy_server.is_running():
            print("Starting ComfyUI server...")
            if not comfy_server.start(wait_timeout=120):
                print("Failed to start ComfyUI server")
                return 1
    else:
        print("Using existing ComfyUI server...")
        comfy_server = None

    # Initialize client
    comfy_client = ComfyClient(server_url=f"http://127.0.0.1:{args.comfy_port}")

    print(f"\nCC Art Bridge Server starting on http://0.0.0.0:{args.port}")
    print(f"ComfyUI server: http://127.0.0.1:{args.comfy_port}")
    print("\nReady to receive requests from ComputerCraft!")
    print("=" * 60)

    app.run(host='0.0.0.0', port=args.port, debug=False)


if __name__ == '__main__':
    main()
