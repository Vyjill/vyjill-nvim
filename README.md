# Neovim config

Personal cross-platform Neovim setup (Linux, WSL, Windows) built on [lazy.nvim](https://github.com/folke/lazy.nvim).

## Install

```sh
git clone ssh://git@gitea.aipice.local:2222/HEXA-H/ulysse-nvim-config.git ~/.config/nvim   # Windows: $env:LOCALAPPDATA\nvim
./setup.sh      # Ubuntu / WSL: Neovim, ripgrep, fd, lazygit, tree-sitter, Node, Python
./wsl.sh        # WSL only: win32yank for a fast clipboard
./setup.ps1     # Windows: same dependencies via winget
```

Install a Nerd Font, then run `nvim`: Lazy and Mason install plugins, LSPs and formatters on first launch.

## Layout

- `lua/config/`: options, keymaps, lazy.nvim bootstrap
- `lua/plugins/`: one file per plugin group, auto-imported (LSP, cmp, Treesitter, Telescope, Neo-tree, Oil, Conform, LazyGit, Gitsigns, UI)

## Main keymaps (leader = `Space`)

| Keys | Action |
| --- | --- |
| `<leader>ff` / `fw` / `fb` / `fe` | Telescope: files / grep / buffers / file browser |
| `<leader>e` / `<leader>o` | Floating Neo-tree / Oil |
| `gd` / `gr` / `K` | LSP: definition / references / hover |
| `<leader>ra` / `<leader>ca` / `<leader>le` | LSP: rename / code action / line error |
| `<leader>lg` / `<leader>gp` / `<leader>gr` / `]c` `[c` | LazyGit / preview, reset, jump Git hunks |
| `<Tab>` / `<S-Tab>` / `<leader>b` / `<leader>x` | Next / previous / new / close buffer |
| `<C-h/j/k/l>` / `<leader>fs` | Move between windows / open buffer in new tab |
| `<leader>f` | Format buffer |
| `<C-s>` | Save |
| `<leader>h` / `<leader>cc` / `<Esc>` | Bottom terminal / Claude terminal / leave terminal mode |
