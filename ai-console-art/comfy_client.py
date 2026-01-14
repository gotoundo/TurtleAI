"""
ComfyUI API Client
Submits workflows and retrieves generated images
"""

import requests
import json
import time
import io
import uuid
import websocket
from PIL import Image
from typing import Dict, Any, Optional
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class ComfyClient:
    """Client for ComfyUI API"""

    def __init__(self, server_url: str = "http://127.0.0.1:8188"):
        """
        Initialize client

        Args:
            server_url: URL of ComfyUI server
        """
        self.server_url = server_url
        self.client_id = str(uuid.uuid4())

    def queue_prompt(self, workflow: Dict[str, Any]) -> str:
        """
        Queue a workflow for execution

        Args:
            workflow: ComfyUI workflow dictionary

        Returns:
            Prompt ID

        Raises:
            Exception if queueing fails
        """
        payload = {
            "prompt": workflow,
            "client_id": self.client_id
        }

        response = requests.post(
            f"{self.server_url}/prompt",
            json=payload
        )

        if response.status_code != 200:
            raise Exception(f"Failed to queue prompt: {response.text}")

        result = response.json()
        prompt_id = result["prompt_id"]
        logger.info(f"Queued prompt: {prompt_id}")
        return prompt_id

    def get_history(self, prompt_id: str) -> Optional[Dict]:
        """
        Get execution history for a prompt

        Args:
            prompt_id: Prompt ID

        Returns:
            History dictionary or None if not found
        """
        response = requests.get(f"{self.server_url}/history/{prompt_id}")

        if response.status_code != 200:
            return None

        history = response.json()
        return history.get(prompt_id)

    def get_image(self, filename: str, subfolder: str = "", folder_type: str = "output") -> Image.Image:
        """
        Download an image from ComfyUI

        Args:
            filename: Image filename
            subfolder: Subfolder in output directory
            folder_type: Type of folder ("output", "input", "temp")

        Returns:
            PIL Image object
        """
        url = f"{self.server_url}/view"
        params = {
            "filename": filename,
            "subfolder": subfolder,
            "type": folder_type
        }

        response = requests.get(url, params=params)

        if response.status_code != 200:
            raise Exception(f"Failed to download image: {response.text}")

        return Image.open(io.BytesIO(response.content))

    def wait_for_completion(self, prompt_id: str, timeout: int = 300,
                           poll_interval: float = 1.0) -> Dict:
        """
        Wait for a prompt to complete execution

        Args:
            prompt_id: Prompt ID to wait for
            timeout: Maximum seconds to wait
            poll_interval: Seconds between status checks

        Returns:
            History dictionary with results

        Raises:
            TimeoutError if execution takes too long
            Exception if execution fails
        """
        start_time = time.time()

        while time.time() - start_time < timeout:
            history = self.get_history(prompt_id)

            if history is not None:
                # Check if execution completed
                status = history.get("status", {})

                if status.get("completed", False):
                    logger.info(f"Prompt {prompt_id} completed")
                    return history

                if "error" in status:
                    raise Exception(f"Execution failed: {status['error']}")

            time.sleep(poll_interval)
            logger.info(f"Waiting for completion... ({int(time.time() - start_time)}s)")

        raise TimeoutError(f"Prompt {prompt_id} did not complete within {timeout}s")

    def get_output_images(self, history: Dict) -> list[Image.Image]:
        """
        Extract output images from execution history

        Args:
            history: Execution history dictionary

        Returns:
            List of PIL Images
        """
        images = []
        outputs = history.get("outputs", {})

        for node_id, node_output in outputs.items():
            if "images" in node_output:
                for img_info in node_output["images"]:
                    filename = img_info["filename"]
                    subfolder = img_info.get("subfolder", "")
                    folder_type = img_info.get("type", "output")

                    image = self.get_image(filename, subfolder, folder_type)
                    images.append(image)

        return images

    def generate_image(self, workflow: Dict[str, Any], timeout: int = 300) -> list[Image.Image]:
        """
        Generate images from a workflow (convenience method)

        Args:
            workflow: ComfyUI workflow dictionary
            timeout: Maximum seconds to wait for completion

        Returns:
            List of generated PIL Images
        """
        # Queue the workflow
        prompt_id = self.queue_prompt(workflow)

        # Wait for completion
        history = self.wait_for_completion(prompt_id, timeout)

        # Get output images
        images = self.get_output_images(history)

        logger.info(f"Generated {len(images)} image(s)")
        return images

    def create_simple_txt2img_workflow(self, prompt: str, negative_prompt: str = "",
                                      width: int = 512, height: int = 512,
                                      steps: int = 20, cfg: float = 7.0,
                                      seed: int = -1) -> Dict[str, Any]:
        """
        Create a simple text-to-image workflow

        Args:
            prompt: Positive prompt text
            negative_prompt: Negative prompt text
            width: Image width
            height: Image height
            steps: Number of sampling steps
            cfg: CFG scale
            seed: Random seed (-1 for random)

        Returns:
            Workflow dictionary
        """
        if seed == -1:
            seed = int(time.time() * 1000) % (2**32)

        # Basic SDXL workflow structure
        workflow = {
            "3": {
                "inputs": {
                    "seed": seed,
                    "steps": steps,
                    "cfg": cfg,
                    "sampler_name": "euler",
                    "scheduler": "normal",
                    "denoise": 1,
                    "model": ["4", 0],
                    "positive": ["6", 0],
                    "negative": ["7", 0],
                    "latent_image": ["5", 0]
                },
                "class_type": "KSampler"
            },
            "4": {
                "inputs": {
                    "ckpt_name": "sd_xl_base_1.0.safetensors"
                },
                "class_type": "CheckpointLoaderSimple"
            },
            "5": {
                "inputs": {
                    "width": width,
                    "height": height,
                    "batch_size": 1
                },
                "class_type": "EmptyLatentImage"
            },
            "6": {
                "inputs": {
                    "text": prompt,
                    "clip": ["4", 1]
                },
                "class_type": "CLIPTextEncode"
            },
            "7": {
                "inputs": {
                    "text": negative_prompt,
                    "clip": ["4", 1]
                },
                "class_type": "CLIPTextEncode"
            },
            "8": {
                "inputs": {
                    "samples": ["3", 0],
                    "vae": ["4", 2]
                },
                "class_type": "VAEDecode"
            },
            "9": {
                "inputs": {
                    "filename_prefix": "ComfyUI",
                    "images": ["8", 0]
                },
                "class_type": "SaveImage"
            }
        }

        return workflow


def main():
    """CLI for testing client"""
    import argparse

    parser = argparse.ArgumentParser(description='Test ComfyUI client')
    parser.add_argument('--prompt', default="a beautiful landscape",
                       help='Text prompt')
    parser.add_argument('--server', default="http://127.0.0.1:8188",
                       help='Server URL')
    parser.add_argument('--output', default='test_output.png',
                       help='Output filename')

    args = parser.parse_args()

    try:
        client = ComfyClient(server_url=args.server)

        print(f"Generating image for: {args.prompt}")

        # Create simple workflow
        workflow = client.create_simple_txt2img_workflow(
            prompt=args.prompt,
            width=512,
            height=512
        )

        # Generate image
        images = client.generate_image(workflow)

        if images:
            images[0].save(args.output)
            print(f"Image saved to: {args.output}")
        else:
            print("No images generated", file=sys.stderr)

    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        import traceback
        traceback.print_exc()


if __name__ == '__main__':
    main()
