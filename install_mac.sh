#!/bin/bash
set -e

# Zork I macOS Installer

INSTALL_DIR="$HOME/zork"
REPO_URL="https://github.com/jake9696/zork.git"

echo "Welcome to the Zork I Installer for macOS."

# 1. Check for dependencies
if ! command -v git >/dev/null 2>&1; then
    echo "Error: git is not installed."
    echo "Please install Xcode Command Line Tools by running: xcode-select --install"
    exit 1
fi

if ! command -v gcc >/dev/null 2>&1; then
    echo "Error: gcc (clang) is not installed."
    echo "Please install Xcode Command Line Tools by running: xcode-select --install"
    exit 1
fi

# 2. Clone or Update
if [ -d "$INSTALL_DIR" ]; then
    echo "Found existing installation at $INSTALL_DIR. Updating..."
    cd "$INSTALL_DIR"
    git pull
else
    echo "Cloning Zork into $INSTALL_DIR..."
    git clone "$REPO_URL" "$INSTALL_DIR"
    cd "$INSTALL_DIR"
fi

# 3. Build
echo "Building the game..."
chmod +x build.sh
./build.sh

# 4. Success Message
echo ""
echo "========================================"
echo "      Zork I Installed Successfully!    "
echo "========================================"
echo ""
echo "To play, run the following command:"
echo ""
echo "    $INSTALL_DIR/zork"
echo ""
echo "Have fun!"
