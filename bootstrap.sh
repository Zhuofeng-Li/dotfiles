#!/bin/bash
set -e

DOTFILES_DIR="$HOME/dotfiles"
GITHUB_REPO="https://github.com/Zhuofeng-Li/dotfiles.git"

echo "==> Installing Xcode Command Line Tools..."
xcode-select --install 2>/dev/null || true

echo "==> Installing Homebrew..."
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "==> Cloning dotfiles from GitHub..."
if [ -d "$DOTFILES_DIR" ]; then
  git -C "$DOTFILES_DIR" pull
else
  git clone "$GITHUB_REPO" "$DOTFILES_DIR"
fi

echo "==> Installing packages from Brewfile..."
brew bundle install --file="$DOTFILES_DIR/Brewfile" --no-lock

echo "==> Setting up fish shell..."
FISH_PATH="$(which fish)"
if ! grep -q "$FISH_PATH" /etc/shells; then
  echo "$FISH_PATH" | sudo tee -a /etc/shells
fi
chsh -s "$FISH_PATH"
mkdir -p ~/.config/fish
cp "$DOTFILES_DIR/fish/config.fish" ~/.config/fish/config.fish

echo "==> Setting up Karabiner config..."
mkdir -p ~/.config
rm -rf ~/.config/karabiner
ln -sf "$DOTFILES_DIR/karabiner" ~/.config/karabiner

echo "==> Setting up Cursor config..."
CURSOR_DIR="$HOME/Library/Application Support/Cursor/User"
mkdir -p "$CURSOR_DIR"
rm -f "$CURSOR_DIR/settings.json" "$CURSOR_DIR/keybindings.json"
ln -sf "$DOTFILES_DIR/cursor/settings.json" "$CURSOR_DIR/settings.json"
ln -sf "$DOTFILES_DIR/cursor/keybindings.json" "$CURSOR_DIR/keybindings.json"

echo "==> Installing Cursor extensions..."
if command -v cursor &>/dev/null; then
  while IFS= read -r ext; do
    [[ -z "$ext" ]] && continue
    cursor --install-extension "$ext" --force 2>/dev/null || true
  done < "$DOTFILES_DIR/cursor/extensions.txt"
else
  echo "  Cursor CLI not found, skipping extensions (install manually from cursor/extensions.txt)"
fi

echo "==> Restoring app settings with mackup..."
cp "$DOTFILES_DIR/mackup.cfg" ~/.mackup.cfg
mackup restore

echo ""
echo "Done! Log out and back in for shell change to take effect."
echo "Apps requiring manual install:"
echo "  - 幕布: mubu.com"
echo "  - Mathpix Snipping Tool"
echo "  - Input Source Pro"
echo "  - WPS Office"
echo "  - BaiduNetdisk"
