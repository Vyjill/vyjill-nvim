#!/usr/bin/env bash
# setup.sh - Bootstrap native dependencies for Neovim on Ubuntu / WSL
set -euo pipefail

echo "=== 1. Adding Neovim Stable PPA and updating apt ==="
sudo apt-get update
sudo apt-get install -y software-properties-common curl git unzip tar gzip build-essential
sudo add-apt-repository -y ppa:neovim-ppa/stable
sudo apt-get update

echo "=== 2. Installing Neovim, Telescope tools, Node.js, and Python ==="
sudo apt-get install -y \
  neovim \
  ripgrep \
  fd-find \
  nodejs \
  npm \
  python3 \
  python3-pip \
  python3-venv

# Link fdfind to fd if not already linked (Ubuntu packages fd as fdfind)
mkdir -p ~/.local/bin
if command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1; then
  ln -sf "$(command -v fdfind)" ~/.local/bin/fd
fi

echo "=== 3. Installing latest Lazygit binary ==="
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf /tmp/lazygit.tar.gz -C /tmp lazygit
sudo install /tmp/lazygit -D -t /usr/local/bin/
rm -f /tmp/lazygit /tmp/lazygit.tar.gz

echo "=== 4. Installing latest tree-sitter-cli binary ==="
TS_VERSION=$(curl -s "https://api.github.com/repos/tree-sitter/tree-sitter/releases/latest" | grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo /tmp/tree-sitter.gz "https://github.com/tree-sitter/tree-sitter/releases/download/v${TS_VERSION}/tree-sitter-linux-x64.gz"
gunzip -f /tmp/tree-sitter.gz
chmod +x /tmp/tree-sitter
sudo mv /tmp/tree-sitter /usr/local/bin/tree-sitter

echo ""
echo "All native dependencies installed!"
echo "Next steps:"
echo "  1. Ensure ~/.local/bin is in your PATH (add 'export PATH=\"\$HOME/.local/bin:\$PATH\"' to ~/.bashrc if needed)."
echo "  2. Run 'nvim' — Lazy and Mason will automatically install all plugins, LSPs, and formatters."
