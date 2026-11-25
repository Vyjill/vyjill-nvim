return {
  -- 1. Git diff signs in the gutter + quick hunk actions
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "▐" },
        change = { text = "▐" },
        delete = { text = "" }, -- nf-fa-circle (solid)
        topdelete = { text = "" },
        changedelete = { text = "▐" },
        untracked = { text = "┋" },
      },
      signs_staged = {
        add          = { text = "▕" },
        change       = { text = "▕" },
        delete       = { text = "" }, -- nf-oct-circle (crisp hollow ring)
        topdelete    = { text = "" },
        changedelete = { text = "▕" },
      },
      blame = true, -- Subtle ghost-text git blame at end of current line
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 400,
      },
      current_line_blame_formatter = "  <author>, <author_time:%R> • <summary>",
      preview_config = {
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local map = function(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        -- Hunk navigation
        map("n", "]h", function() gs.nav_hunk("next") end, "Next git hunk")
        map("n", "[h", function() gs.nav_hunk("prev") end, "Previous git hunk")

        -- Hunk actions
        map("n", "<leader>gp", gs.preview_hunk, "Preview git hunk")
        map("n", "<leader>gs", gs.stage_hunk, "Stage git hunk")
        map("n", "<leader>gr", gs.reset_hunk, "Reset git hunk")
      end,
    },
  },

  -- 2. Auto-close brackets, quotes, and parentheses
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      fast_wrap = {},
      disable_filetype = { "TelescopePrompt", "vim" },
    },
  },

  -- 3. Vertical indentation guide lines
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      indent = { char = "│" },
      scope = { enabled = true, show_start = false, show_end = false },
    },
  },
}
