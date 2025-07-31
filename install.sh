#!/bin/bash

# GitHub Monitor Installation Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="$HOME/.local/bin"

echo "Installing GitHub Monitor scripts..."

# Create target directory if it doesn't exist
mkdir -p "$TARGET_DIR"

# Create symlinks
ln -sf "$SCRIPT_DIR/gh-monitor" "$TARGET_DIR/gh-monitor"
ln -sf "$SCRIPT_DIR/gh-monitor-my-jobs" "$TARGET_DIR/gh-monitor-my-jobs"

echo "✅ Symlinks created:"
echo "  $TARGET_DIR/gh-monitor -> $SCRIPT_DIR/gh-monitor"
echo "  $TARGET_DIR/gh-monitor-my-jobs -> $SCRIPT_DIR/gh-monitor-my-jobs"

# Make scripts executable
chmod +x "$SCRIPT_DIR/gh-monitor"
chmod +x "$SCRIPT_DIR/gh-monitor-my-jobs"

echo "✅ Scripts made executable"
echo "🎉 Installation complete!"

# Check if ~/.local/bin is in PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    echo ""
    echo "⚠️  Warning: $HOME/.local/bin is not in your PATH"
    echo "   Add to your shell profile: export PATH=\"\$HOME/.local/bin:\$PATH\""
fi