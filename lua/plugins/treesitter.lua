return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    require("nvim-treesitter.install").compilers = { "zig", "gcc", "clang" }

    -- Register the custom Verus parser on TSUpdate
    vim.api.nvim_create_autocmd("User", {
      pattern = "TSUpdate",
      callback = function()
        require("nvim-treesitter.parsers").verus = {
          install_info = {
            url = "https://github.com/secure-foundations/tree-sitter-verus",
            files = { "src/parser.c", "src/scanner.c" },
            branch = "main",
          },
        }
      end,
    })

    local ts = require("nvim-treesitter")
    ts.setup({})

    ts.install({
      "lua",
      "vim",
      "vimdoc",
      "query",
      "markdown",
      "markdown_inline",
      "json",
      "bash",
      "rust",
    })

    -- Map Rust buffers to use the `verus` parser
    vim.treesitter.language.register("verus", "rust")

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
