return {
  -- 1. Theme (Exact NvChad Wombat palette)
  {
    "echasnovski/mini.base16",
    priority = 1000,
    config = function()
      require("mini.base16").setup({
        palette = {
          base00 = "#202020",
          base01 = "#303030",
          base02 = "#373737",
          base03 = "#3e3e3e",
          base04 = "#484848",
          base05 = "#d6d2c9",
          base06 = "#ddd9d0",
          base07 = "#e4e0d7",
          base08 = "#FFCC66", -- Variables / amber
          base09 = "#dc8cff", -- Integers / constants / purple
          base0A = "#efdeab", -- Classes / yellow
          base0B = "#AEE474", -- Strings / green
          base0C = "#7EB6BC", -- Support / regex / teal
          base0D = "#88B8F6", -- Functions / blue
          base0E = "#FF8F7E", -- Keywords / salmon-red
          base0F = "#dc8c64", -- Deprecated / embedded
        },
      })

      -- Apply exact base_30 UI accents, polish_hl, and italic comments
      local hl = vim.api.nvim_set_hl
      hl(0, "Normal", { fg = "#d6d2c9", bg = "#202020" })
      hl(0, "NormalFloat", { fg = "#d6d2c9", bg = "#1b1b1b" })
      hl(0, "FloatBorder", { fg = "#353535", bg = "#1b1b1b" })
      hl(0, "CursorLine", { bg = "#292929" })
      hl(0, "Visual", { bg = "#373737" })
      hl(0, "LineNr", { fg = "#535353", bg = "#202020" })
      hl(0, "CursorLineNr", { fg = "#e4e0d7", bold = true })
      hl(0, "StatusLine", { fg = "#d6d2c9", bg = "#262626" })
      hl(0, "Pmenu", { fg = "#d6d2c9", bg = "#292929" })
      hl(0, "PmenuSel", { fg = "#1b1b1b", bg = "#95e454", bold = true })

      -- Fix Diagnostic colors so Errors are red and Warnings are yellow
      hl(0, "DiagnosticError", { fg = "#FF8F7E" })
      hl(0, "DiagnosticWarn", { fg = "#FFCC66" })
      hl(0, "DiagnosticInfo", { fg = "#88B8F6" })
      hl(0, "DiagnosticHint", { fg = "#7EB6BC" })
      hl(0, "DiagnosticUnderlineError", { sp = "#FF8F7E", undercurl = true })
      hl(0, "DiagnosticUnderlineWarn", { sp = "#FFCC66", undercurl = true })
      hl(0, "DiagnosticUnderlineInfo", { sp = "#88B8F6", undercurl = true })
      hl(0, "DiagnosticUnderlineHint", { sp = "#7EB6BC", undercurl = true })

      -- Fix the gutter sign colors to match
      hl(0, "DiagnosticSignError", { fg = "#FF8F7E" })
      hl(0, "DiagnosticSignWarn", { fg = "#FFCC66" })
      hl(0, "DiagnosticSignInfo", { fg = "#88B8F6" })
      hl(0, "DiagnosticSignHint", { fg = "#7EB6BC" })

      -- Italic comments (using grey_fg2 for readability)
      hl(0, "Comment", { fg = "#5a5a5a", italic = true })
      hl(0, "@comment", { link = "Comment" })

      -- Exact polish_hl from your wombat.lua
      hl(0, "@punctuation.bracket", { fg = "#feedba" })
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
