#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v cursor &>/dev/null; then
  echo "Error: Cursor CLI not found. Make sure Cursor is installed." >&2
  exit 1
fi

echo "==> Installing Cursor extensions..."
while IFS= read -r ext; do
  [[ -z "$ext" ]] && continue
  echo "  Installing $ext"
  cursor --install-extension "$ext" --force 2>/dev/null || true
done < "$SCRIPT_DIR/extensions.txt"

echo "Done."
