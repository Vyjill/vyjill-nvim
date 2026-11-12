return {
  -- 1. Theme (Catppuccin)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      integrations = {
        lualine = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },

  -- 2. Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "catppuccin",
    },
    opts = {
      options = { theme = "auto" },
    },
  },

  -- 3. Keybind helper popup
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
