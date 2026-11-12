return {
  -- 1. Rapid screen jumping (Press 's' + 2 chars to jump anywhere)
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash jump" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    },
  },

  -- 2. Color-coded CSV/TSV columns and SQL-like querying
  {
    "cameron-wags/rainbow_csv.nvim",
    config = true,
    ft = {
      "csv",
      "tsv",
      "csv_semicolon",
      "csv_whitespace",
      "csv_pipe",
      "rfc_csv",
      "rfc_semicolon",
    },
    cmd = {
      "RainbowDelim",
      "RainbowDelimSimple",
      "RainbowDelimQuoted",
      "RainbowMultiDelim",
    },
  },

  -- 3. Text & assignment alignment (Visual mode: <leader>aa to align by char, <leader>aw by word)
  {
    "Vonr/align.nvim",
    branch = "v2",
    lazy = true,
    keys = {
      {
        "<leader>aa",
        function()
          require("align").align_to_char({ length = 1 })
        end,
        mode = "x",
        desc = "Align to 1 character",
      },
      {
        "<leader>aw",
        function()
          require("align").align_to_string({ preview = true, regex = false })
        end,
        mode = "x",
        desc = "Align to string",
      },
    },
  },

  -- 4. Enhanced Ctrl+a / Ctrl+x toggling (true/false, yes/no, on/off, days, hex)
  {
    "nat-418/boole.nvim",
    keys = {
      { "<C-a>", "<cmd>Boole increment<cr>", desc = "Increment / toggle value" },
      { "<C-x>", "<cmd>Boole decrement<cr>", desc = "Decrement / toggle value" },
    },
    opts = {
      mappings = {
        increment = "<C-a>",
        decrement = "<C-x>",
      },
    },
  },
}
