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

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
  callback = function(ev)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = ev.buf, silent = true, desc = desc })
    end

    -- Find usages in Telescope fuzzy finder
    map("<leader>fu", function()
      require("telescope.builtin").lsp_references({
        include_declaration = false,
      })
    end, "Find usages (LSP references)")

    -- Hover documentation popup (press <leader>lh a second time to jump inside the popup)
    map("<leader>lh", function()
      vim.lsp.buf.hover({ border = "rounded" })
    end, "LSP hover documentation")

    -- Quick fixes & code actions (works in Normal and Visual mode)
    map("<leader>la", vim.lsp.buf.code_action, "LSP code actions / quick fixes", { "n", "v" })

    map("<leader>ld", function()
      vim.diagnostic.open_float({ border = "rounded" })
    end, "Line diagnostics float")

    -- Smart workspace rename
    map("<leader>lr", vim.lsp.buf.rename, "LSP smart rename")
  end,
})
