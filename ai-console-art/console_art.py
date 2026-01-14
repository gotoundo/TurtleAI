"""
AI Console Art Generator
Main application for generating and displaying AI art in the terminal
"""

import argparse
import sys
import os
from pathlib import Path
from typing import Optional
import logging

from rich.console import Console
from rich.panel import Panel
from rich.progress import Progress, SpinnerColumn, TextColumn
from rich.prompt import Prompt, Confirm
from rich import print as rprint

from comfy_server import ComfyServer
from comfy_client import ComfyClient
from image_to_ascii import ImageToAscii

logging.basicConfig(level=logging.WARNING)
logger = logging.getLogger(__name__)

console = Console()


class ConsoleArtGenerator:
    """Main application class"""

    def __init__(self, server: ComfyServer, client: ComfyClient,
                 ascii_converter: ImageToAscii):
        """
        Initialize generator

        Args:
            server: ComfyUI server manager
            client: ComfyUI API client
            ascii_converter: Image to ASCII converter
        """
        self.server = server
        self.client = client
        self.converter = ascii_converter

    def generate_and_display(self, prompt: str, negative_prompt: str = "",
                            width: int = 512, height: int = 512,
                            steps: int = 20, cfg: float = 7.0,
                            contrast: float = 1.0, color: bool = False,
                            output_file: Optional[str] = None) -> bool:
        """
        Generate an image and display it as ASCII art

        Args:
            prompt: Text prompt for image generation
            negative_prompt: Negative prompt
            width: Image width
            height: Image height
            steps: Sampling steps
            cfg: CFG scale
            contrast: ASCII contrast adjustment
            color: Use colored output
            output_file: Optional file to save ASCII art

        Returns:
            True if successful
        """
        try:
            # Create workflow
            console.print("[cyan]Creating workflow...[/cyan]")
            workflow = self.client.create_simple_txt2img_workflow(
                prompt=prompt,
                negative_prompt=negative_prompt,
                width=width,
                height=height,
                steps=steps,
                cfg=cfg
            )

            # Generate image with progress indication
            console.print(f"[cyan]Generating image:[/cyan] {prompt}")

            with Progress(
                SpinnerColumn(),
                TextColumn("[progress.description]{task.description}"),
                console=console
            ) as progress:
                task = progress.add_task("Generating...", total=None)

                images = self.client.generate_image(workflow, timeout=300)

                progress.update(task, description="[green]Complete!")

            if not images:
                console.print("[red]No images generated[/red]")
                return False

            # Convert to ASCII
            console.print("[cyan]Converting to ASCII art...[/cyan]")
            ascii_art = self.converter.convert(images[0], contrast=contrast,
                                              color=color)

            # Display
            console.print("\n")
            console.print(Panel(
                ascii_art,
                title=f"[bold cyan]Prompt:[/bold cyan] {prompt[:60]}...",
                border_style="cyan"
            ))

            # Save if requested
            if output_file:
                with open(output_file, 'w', encoding='utf-8') as f:
                    f.write(ascii_art)
                console.print(f"[green]ASCII art saved to:[/green] {output_file}")

            return True

        except Exception as e:
            console.print(f"[red]Error:[/red] {e}")
            logger.exception("Generation failed")
            return False

    def interactive_mode(self):
        """Run in interactive mode"""
        console.print(Panel.fit(
            "[bold cyan]AI Console Art Generator[/bold cyan]\n"
            "Generate AI art and display it in your terminal!",
            border_style="cyan"
        ))

        while True:
            console.print("\n")
            prompt = Prompt.ask("[cyan]Enter prompt[/cyan] (or 'quit' to exit)")

            if prompt.lower() in ['quit', 'exit', 'q']:
                console.print("[yellow]Goodbye![/yellow]")
                break

            if not prompt.strip():
                continue

            # Optional advanced settings
            advanced = Confirm.ask("Configure advanced settings?", default=False)

            if advanced:
                negative = Prompt.ask("Negative prompt", default="")
                width = int(Prompt.ask("Image width", default="512"))
                height = int(Prompt.ask("Image height", default="512"))
                steps = int(Prompt.ask("Steps", default="20"))
                cfg = float(Prompt.ask("CFG scale", default="7.0"))
                contrast = float(Prompt.ask("ASCII contrast", default="1.0"))
                color = Confirm.ask("Use color?", default=False)
            else:
                negative = ""
                width = 512
                height = 512
                steps = 20
                cfg = 7.0
                contrast = 1.0
                color = False

            # Generate and display
            self.generate_and_display(
                prompt=prompt,
                negative_prompt=negative,
                width=width,
                height=height,
                steps=steps,
                cfg=cfg,
                contrast=contrast,
                color=color
            )


def main():
    """Main entry point"""
    parser = argparse.ArgumentParser(
        description='Generate AI art and display it in the terminal'
    )

    # Generation options
    parser.add_argument('--prompt', help='Text prompt for image generation')
    parser.add_argument('--negative', default='',
                       help='Negative prompt')
    parser.add_argument('--image-width', type=int, default=512,
                       help='Generated image width (default: 512)')
    parser.add_argument('--image-height', type=int, default=512,
                       help='Generated image height (default: 512)')
    parser.add_argument('--steps', type=int, default=20,
                       help='Sampling steps (default: 20)')
    parser.add_argument('--cfg', type=float, default=7.0,
                       help='CFG scale (default: 7.0)')

    # ASCII conversion options
    parser.add_argument('--width', type=int, default=100,
                       help='ASCII art width in characters (default: 100)')
    parser.add_argument('--style', choices=['simple', 'detailed', 'blocks', 'braille'],
                       default='detailed',
                       help='ASCII character style (default: detailed)')
    parser.add_argument('--contrast', type=float, default=1.0,
                       help='ASCII contrast multiplier (default: 1.0)')
    parser.add_argument('--color', action='store_true',
                       help='Use colored output (ANSI colors)')

    # Server options
    parser.add_argument('--comfy-path', help='Path to ComfyUI installation')
    parser.add_argument('--port', type=int, default=8188,
                       help='ComfyUI server port (default: 8188)')
    parser.add_argument('--no-start-server', action='store_true',
                       help='Don\'t start server (assume already running)')

    # Output options
    parser.add_argument('--output', help='Save ASCII art to file')

    args = parser.parse_args()

    try:
        # Initialize server
        if not args.no_start_server:
            console.print("[cyan]Initializing ComfyUI server...[/cyan]")
            server = ComfyServer(comfy_path=args.comfy_path, port=args.port)

            if not server.is_running():
                console.print("[cyan]Starting ComfyUI server...[/cyan]")
                if not server.start(wait_timeout=120):
                    console.print("[red]Failed to start ComfyUI server[/red]")
                    return 1
        else:
            console.print("[cyan]Using existing ComfyUI server[/cyan]")
            server = None

        # Initialize client
        client = ComfyClient(server_url=f"http://127.0.0.1:{args.port}")

        # Initialize ASCII converter
        converter = ImageToAscii(style=args.style, width=args.width)

        # Create generator
        generator = ConsoleArtGenerator(server, client, converter)

        # Run in appropriate mode
        if args.prompt:
            # Single generation mode
            success = generator.generate_and_display(
                prompt=args.prompt,
                negative_prompt=args.negative,
                width=args.image_width,
                height=args.image_height,
                steps=args.steps,
                cfg=args.cfg,
                contrast=args.contrast,
                color=args.color,
                output_file=args.output
            )
            return 0 if success else 1
        else:
            # Interactive mode
            generator.interactive_mode()
            return 0

    except KeyboardInterrupt:
        console.print("\n[yellow]Interrupted by user[/yellow]")
        return 130

    except Exception as e:
        console.print(f"[red]Error:[/red] {e}")
        logger.exception("Application error")
        return 1

    finally:
        # Cleanup
        if server and not args.no_start_server:
            console.print("[cyan]Shutting down server...[/cyan]")
            server.stop()


if __name__ == '__main__':
    sys.exit(main())
