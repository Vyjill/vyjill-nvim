return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Open parent directory (Oil)" },
    { "<leader>o", "<cmd>Oil --float<cr>", desc = "Open floating Oil" },
  },
  opts = {
    default_file_explorer = true,
    view_options = {
      show_hidden = true, -- Show dotfiles like .gitignore or .env
    },
    keymaps = {
      ["<C-s>"] = false, -- Unbind Oil's default split shortcut so your Ctrl+s save keymap works
    },
  },
}
