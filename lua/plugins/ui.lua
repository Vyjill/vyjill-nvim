return {
  -- 1. Theme (NvChad Wombat palette via mini.base16)
  {
    "echasnovski/mini.base16",
    priority = 1000,
    config = function()
      require("mini.base16").setup({
        palette = {
          base00 = "#171717", -- Default Background
          base01 = "#1f1f1f", -- Lighter Background (status bars, line numbers)
          base02 = "#292929", -- Selection Background
          base03 = "#474747", -- Comments, Invisibles
          base04 = "#7e807e", -- Dark Foreground
          base05 = "#e3e0d7", -- Default Foreground
          base06 = "#f6f3e8", -- Light Foreground
          base07 = "#ffffff", -- Light Background
          base08 = "#e5786d", -- Variables, Errors
          base09 = "#e5786d", -- Integers, Booleans, Constants
          base0A = "#cae682", -- Classes, Search Text Background
          base0B = "#95e454", -- Strings
          base0C = "#8ac6f2", -- Support, Regex, Escape Chars
          base0D = "#8ac6f2", -- Functions, Methods
          base0E = "#cc99cc", -- Keywords, Storage
          base0F = "#d7875f", -- Deprecated, Embedded
        },
      })

      -- Restore italic comments (standard Vim + Treesitter)
      vim.api.nvim_set_hl(0, "Comment", { fg = "#474747", italic = true })
      vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })
    end,
  },

  -- 2. Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
