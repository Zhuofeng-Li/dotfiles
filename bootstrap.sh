#!/bin/bash
set -e

DOTFILES_DIR="$HOME/Library/Mobile Documents/com~apple~CloudDocs/karabiner"

echo "==> Installing Xcode Command Line Tools..."
xcode-select --install 2>/dev/null || true

echo "==> Installing Homebrew..."
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
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
rm -rf ~/.config/karabiner
ln -sf "$DOTFILES_DIR" ~/.config/karabiner

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
