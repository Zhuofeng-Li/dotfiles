#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CURSOR_DIR="$HOME/Library/Application Support/Cursor/User"

echo "==> Linking Cursor settings..."
mkdir -p "$CURSOR_DIR"
rm -f "$CURSOR_DIR/settings.json" "$CURSOR_DIR/keybindings.json"
ln -sf "$SCRIPT_DIR/settings.json" "$CURSOR_DIR/settings.json"
ln -sf "$SCRIPT_DIR/keybindings.json" "$CURSOR_DIR/keybindings.json"
echo "  settings.json -> $CURSOR_DIR/settings.json"
echo "  keybindings.json -> $CURSOR_DIR/keybindings.json"

echo "==> Installing Cursor extensions..."
if ! command -v cursor &>/dev/null; then
  echo "  Cursor CLI not found, skipping extensions." >&2
else
  while IFS= read -r ext; do
    [[ -z "$ext" ]] && continue
    echo "  Installing $ext"
    cursor --install-extension "$ext" --force 2>/dev/null || true
  done < "$SCRIPT_DIR/extensions.txt"
fi

echo "Done."
