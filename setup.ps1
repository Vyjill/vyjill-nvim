# setup.ps1 - Bootstrap native dependencies for Neovim on Windows
$ErrorActionPreference = "Stop"

Write-Host "Installing native Neovim dependencies via winget..." -ForegroundColor Cyan

$packages = @(
    "Neovim.Neovim",
    "Git.Git",
    "BurntSushi.ripgrep.MSVC",
    "sharkdp.fd",
    "zig.zig",
    "tree-sitter.tree-sitter-cli",
    "JesseDuffield.lazygit",
    "OpenJS.NodeJS.LTS",
    "Python.Python.3.12"
)

foreach ($pkg in $packages) {
    Write-Host "Checking / Installing $pkg..." -ForegroundColor Yellow
    winget install --id $pkg -e --silent --accept-package-agreements --accept-source-agreements
}

Write-Host "`nAll native dependencies installed!" -ForegroundColor Green
Write-Host "Next steps:" -ForegroundColor Cyan
Write-Host "  1. Close and reopen PowerShell to refresh your PATH."
Write-Host "  2. Install a Nerd Font (e.g. JetBrainsMono Nerd Font) and set it in Windows Terminal."
Write-Host "  3. Run 'nvim' — Lazy and Mason will automatically install all plugins, LSPs, and formatters."
