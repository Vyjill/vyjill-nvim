return {
  {
    "williamboman/mason.nvim",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Configure lua_ls so it recognizes Neovim's global 'vim' variable
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      vim.lsp.config("basedpyright", {
        capabilities = capabilities,
        settings = {
          basedpyright = {
            analysis = {
              -- Downgrade from "recommended" to "standard"
              typeCheckingMode = "standard",
              -- Only calculate errors for the file you are actively looking at
              diagnosticMode = "openFilesOnly",
              -- Turn off visual clutter from inline type hints
              inlayHints = {
                variableTypes = false,
                functionReturnTypes = false,
              },
            },
          },
        },
      })

      -- Apply autocomplete capabilities to all other servers automatically
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
      })

      -- Bind LSP shortcuts only when an LSP attaches to the current buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = args.buf, desc = "LSP: " .. desc })
          end

          map("gd", vim.lsp.buf.definition, "Go to definition")
          map("gr", vim.lsp.buf.references, "Find references")
          map("K", vim.lsp.buf.hover, "Hover documentation")
          map("<leader>ra", vim.lsp.buf.rename, "Rename symbol")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("<leader>le", vim.diagnostic.open_float, "Show line error")
        end,
      })
    end,
  },
}
