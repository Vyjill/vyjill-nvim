return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    require("nvim-treesitter.install").compilers = { "zig", "gcc", "clang" }

    local ts = require("nvim-treesitter")
    ts.setup({})

    -- Install core parsers
    ts.install({
      "lua",
      "vim",
      "vimdoc",
      "query",
      "markdown",
      "markdown_inline",
      "json",
      "bash",
    })

    -- Enable Treesitter syntax highlighting and indentation for every file type
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
