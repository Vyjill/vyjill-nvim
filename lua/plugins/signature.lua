return {
  "ray-x/lsp_signature.nvim",
  event = "LspAttach",
  opts = {
    bind = true,
    handler_opts = {
      border = "rounded",
    },
    hint_enable = false, -- Set to true if you also want inline virtual parameter hints
    floating_window = true,
  },
}
