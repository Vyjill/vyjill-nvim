local opt = vim.opt

opt.clipboard = "unnamedplus" -- Sync with Windows system clipboard
opt.number = true             -- Show line numbers
opt.relativenumber = true     -- Relative line numbers
opt.shiftwidth = 2            -- 2 spaces for indent
opt.tabstop = 2               -- 2 spaces for tabs
opt.expandtab = true          -- Convert tabs to spaces
opt.ignorecase = true         -- Case-insensitive search...
opt.smartcase = true          -- ...unless capital letter is used
opt.termguicolors = true      -- True color support
opt.cursorline = true         -- Highlight current line
opt.splitright = true         -- Vertical splits open to the right
opt.splitbelow = true         -- Horizontal splits open below
opt.undofile = true           -- Persistent undo history
