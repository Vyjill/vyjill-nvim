return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "markdown.mdx" },
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>m", "<cmd>RenderMarkdown toggle<cr>", ft = { "markdown", "markdown.mdx" }, desc = "Toggle markdown rendering" },
    },
    opts = {
      -- The Wombat theme handles the colors natively, we just need the structure
      heading = {
        sign = false,
        icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
      },
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
    },
  }
}
