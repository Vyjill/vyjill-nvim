#!/bin/bash
set -e

# Install win32yank (Neovim clipboard fix for WSL)
if ! command -v win32yank.exe &> /dev/null; then
    echo "Installing win32yank for fast Neovim clipboard..."
    curl -sLo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip
    unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
    chmod +x /tmp/win32yank.exe
    sudo mv /tmp/win32yank.exe /usr/local/bin/
    rm /tmp/win32yank.zip
else
    echo "win32yank is already installed."
fi

