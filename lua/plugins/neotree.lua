return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree float toggle<CR>", desc = "Toggle Floating Tree" },
    },
    opts = {
      popup_border_style = "rounded",
      window = {
        position = "float",
      },
      -- Automatically close the floating tree when a file is opened
      event_handlers = {
        {
          event = "file_opened",
          handler = function()
            require("neo-tree.command").execute({ action = "close" })
          end
        },
      },
    },
  }
}
