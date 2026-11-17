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

-- Disable startup intro splash screen
vim.opt.shortmess:append("I")

-- Show inline LSP errors and warnings inside the buffer
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Keep signcolumn always open to prevent text shifting
vim.opt.signcolumn = "yes"

-- Cross-platform terminal shell (PowerShell on Windows, default shell on Linux/macOS)
if vim.fn.has("win32") == 1 then
  vim.opt.shell = vim.fn.executable("pwsh") == 1 and "pwsh" or "powershell"
  vim.opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
  vim.opt.shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait"
  vim.opt.shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode"
  vim.opt.shellquote = ""
  vim.opt.shellxquote = ""
end

-- Force correct diagnostic signs in the gutter with Nerd Font icons
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "", -- Red cross / circle
      [vim.diagnostic.severity.WARN]  = "", -- Yellow triangle
      [vim.diagnostic.severity.INFO]  = "", -- Blue info circle
      [vim.diagnostic.severity.HINT]  = "", -- Lightbulb
    },
  },
})

-- Fix 2-second WSL startup lag by replacing PowerShell clipboard with win32yank
if vim.fn.has('wsl') == 1 then
  vim.g.clipboard = {
    name = 'win32yank',
    copy = {
      ['+'] = 'win32yank.exe -i --crlf',
      ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
      ['+'] = 'win32yank.exe -o --lf',
      ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enabled = 0,
  }
end

-- Automatically equalize window splits when the terminal is resized
vim.api.nvim_create_autocmd("VimResized", {
  desc = "Automatically resize splits when terminal is resized",
  group = vim.api.nvim_create_augroup("resize_splits", { clear = true }),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Fix 1.1s Python file freeze: Disable legacy provider and style checks
vim.g.loaded_python3_provider = 0
vim.g.python_recommended_style = 0
