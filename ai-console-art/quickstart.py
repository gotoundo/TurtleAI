#!/usr/bin/env python3
"""
Quick start script for AI Console Art Generator
Sets up environment and runs the application
"""

import subprocess
import sys
from pathlib import Path


def check_python_version():
    """Ensure Python version is adequate"""
    if sys.version_info < (3, 8):
        print("Error: Python 3.8 or higher is required")
        sys.exit(1)


def install_dependencies():
    """Install required packages"""
    print("Installing dependencies...")
    requirements_file = Path(__file__).parent / "requirements.txt"

    try:
        subprocess.check_call([
            sys.executable, "-m", "pip", "install", "-r", str(requirements_file)
        ])
        print("Dependencies installed successfully!")
        return True
    except subprocess.CalledProcessError:
        print("Error: Failed to install dependencies")
        return False


def main():
    """Main entry point"""
    print("=" * 60)
    print("AI Console Art Generator - Quick Start")
    print("=" * 60)
    print()

    # Check Python version
    check_python_version()

    # Check if dependencies are installed
    try:
        import PIL
        import requests
        import rich
        deps_installed = True
    except ImportError:
        deps_installed = False

    if not deps_installed:
        print("Dependencies not found. Installing...")
        if not install_dependencies():
            sys.exit(1)

    print()
    print("Starting AI Console Art Generator...")
    print()

    # Run the main application
    main_script = Path(__file__).parent / "console_art.py"
    subprocess.call([sys.executable, str(main_script)] + sys.argv[1:])


if __name__ == '__main__':
    main()
