return {
  -- 1. Theme (Catppuccin - very close to NvChad's default dark themes)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },

  -- 2. Statusline (Replaces NvChad's statusline)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = { theme = "catppuccin" },
    },
  },

  -- 3. Keybind helper popup (Press Space and wait 0.5s to see shortcuts)
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
