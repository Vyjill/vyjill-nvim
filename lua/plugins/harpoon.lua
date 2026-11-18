return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      local map = vim.keymap.set
      
      -- Pin the current file to Harpoon
      map("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon: Add File" })
      
      -- Open the floating Harpoon menu to view/reorder your pinned files
      map("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Menu" })

      -- Instantly jump to files 1 through 4
      map("n", "<leader>&", function() harpoon:list():select(1) end, { desc = "Harpoon: Go to File 1" })
      map("n", "<leader>é", function() harpoon:list():select(2) end, { desc = "Harpoon: Go to File 2" })
      map("n", "<leader>\"", function() harpoon:list():select(3) end, { desc = "Harpoon: Go to File 3" })
      map("n", "<leader>'", function() harpoon:list():select(4) end, { desc = "Harpoon: Go to File 4" })
    end,
  }
}
