local map = vim.keymap.set

-- Clear search highlights with Esc
map("n", "<Esc>", "<cmd>noh<CR>", { desc = "Clear highlights" })

-- Save file with Ctrl+s
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "Save file" })

-- NvChad-style window navigation (Ctrl + h/j/k/l)
map("n", "<C-h>", "<C-w>h", { desc = "Switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Switch window up" })

-- Cycle buffers with Tab / Shift+Tab
map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- VS Code-style bottom terminal (<leader>h)
map("n", "<leader>h", function()
  vim.cmd("botright 12split | terminal")
  vim.cmd("startinsert")
end, { desc = "Horizontal terminal" })

-- Open current buffer in a new tab
map("n", "<leader>fs", "<cmd>tab split<CR>", { desc = "Split to new tab" })

-- Open Claude in a full-screen terminal tab and enter insert mode
map("n", "<leader>cc", "<cmd>vsplit | term claude<CR>i", { desc = "Claude Terminal" })

-- Create a new empty buffer
map("n", "<leader>b", "<cmd>enew<CR>", { desc = "New Buffer" })

-- Create a new empty buffer
map("n", "<leader>x", "<cmd>bd<CR>", { desc = "Kill Buffer" })

-- Exit terminal input mode with Esc so you can scroll or switch windows
map("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
