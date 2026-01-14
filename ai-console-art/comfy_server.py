"""
ComfyUI Server Manager
Starts, stops, and monitors ComfyUI server
"""

import subprocess
import requests
import time
import os
import sys
from pathlib import Path
from typing import Optional
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


class ComfyServer:
    """Manage ComfyUI server lifecycle"""

    def __init__(self, comfy_path: Optional[str] = None, port: int = 8188):
        """
        Initialize server manager

        Args:
            comfy_path: Path to ComfyUI installation (auto-detect if None)
            port: Port number for server (default: 8188)
        """
        self.port = port
        self.base_url = f"http://127.0.0.1:{port}"
        self.process: Optional[subprocess.Popen] = None

        # Find ComfyUI installation
        if comfy_path:
            self.comfy_path = Path(comfy_path)
        else:
            self.comfy_path = self._find_comfy_installation()

        if not self.comfy_path or not self.comfy_path.exists():
            raise ValueError(f"ComfyUI not found at {self.comfy_path}")

        self.main_py = self.comfy_path / "main.py"
        if not self.main_py.exists():
            raise ValueError(f"main.py not found at {self.main_py}")

        logger.info(f"ComfyUI found at: {self.comfy_path}")

    def _find_comfy_installation(self) -> Optional[Path]:
        """
        Auto-detect ComfyUI installation

        Returns:
            Path to ComfyUI or None if not found
        """
        # Check common locations
        common_paths = [
            Path.home() / "Documents" / "GitHub" / "ComfyUI",
            Path.home() / "ComfyUI",
            Path("C:/ComfyUI"),
            Path("./ComfyUI"),
            Path("../ComfyUI"),
        ]

        for path in common_paths:
            if path.exists() and (path / "main.py").exists():
                return path

        return None

    def is_running(self) -> bool:
        """
        Check if ComfyUI server is responding

        Returns:
            True if server is running and responding
        """
        try:
            response = requests.get(f"{self.base_url}/system_stats", timeout=2)
            return response.status_code == 200
        except requests.exceptions.RequestException:
            return False

    def start(self, wait_timeout: int = 60) -> bool:
        """
        Start ComfyUI server

        Args:
            wait_timeout: Maximum seconds to wait for server to start

        Returns:
            True if server started successfully
        """
        if self.is_running():
            logger.info("ComfyUI server already running")
            return True

        logger.info("Starting ComfyUI server...")

        # Start server process
        try:
            self.process = subprocess.Popen(
                [sys.executable, str(self.main_py), "--port", str(self.port)],
                cwd=str(self.comfy_path),
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True,
                bufsize=1
            )
        except Exception as e:
            logger.error(f"Failed to start server: {e}")
            return False

        # Wait for server to be ready
        start_time = time.time()
        while time.time() - start_time < wait_timeout:
            if self.is_running():
                logger.info(f"ComfyUI server started successfully on port {self.port}")
                return True

            # Check if process died
            if self.process.poll() is not None:
                stderr = self.process.stderr.read() if self.process.stderr else ""
                logger.error(f"Server process terminated unexpectedly: {stderr}")
                return False

            time.sleep(1)
            logger.info("Waiting for server to start...")

        logger.error(f"Server failed to start within {wait_timeout} seconds")
        return False

    def stop(self):
        """Stop ComfyUI server"""
        if self.process:
            logger.info("Stopping ComfyUI server...")
            self.process.terminate()
            try:
                self.process.wait(timeout=10)
            except subprocess.TimeoutExpired:
                logger.warning("Server didn't stop gracefully, killing...")
                self.process.kill()
            self.process = None
            logger.info("Server stopped")

    def get_status(self) -> dict:
        """
        Get server status information

        Returns:
            Dictionary with status info
        """
        if not self.is_running():
            return {"running": False}

        try:
            response = requests.get(f"{self.base_url}/system_stats", timeout=5)
            stats = response.json()
            return {
                "running": True,
                "stats": stats
            }
        except Exception as e:
            return {"running": False, "error": str(e)}

    def __enter__(self):
        """Context manager entry"""
        self.start()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        """Context manager exit"""
        self.stop()


def main():
    """CLI for server management"""
    import argparse

    parser = argparse.ArgumentParser(description='Manage ComfyUI server')
    parser.add_argument('command', choices=['start', 'stop', 'status'],
                       help='Command to execute')
    parser.add_argument('--path', help='Path to ComfyUI installation')
    parser.add_argument('--port', type=int, default=8188,
                       help='Port number (default: 8188)')

    args = parser.parse_args()

    try:
        server = ComfyServer(comfy_path=args.path, port=args.port)

        if args.command == 'start':
            if server.start():
                print(f"Server started on http://127.0.0.1:{args.port}")
            else:
                print("Failed to start server", file=sys.stderr)
                sys.exit(1)

        elif args.command == 'stop':
            server.stop()

        elif args.command == 'status':
            status = server.get_status()
            if status['running']:
                print("Server is running")
                if 'stats' in status:
                    print(f"Stats: {status['stats']}")
            else:
                print("Server is not running")

    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == '__main__':
    main()
