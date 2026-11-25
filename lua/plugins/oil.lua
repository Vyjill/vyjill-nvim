local show_gitignored = false

return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "-",         "<cmd>Oil<cr>",         desc = "Open parent directory (Oil)" },
    { "<leader>o", "<cmd>Oil --float<cr>", desc = "Open floating Oil" },
  },
  opts = {
    default_file_explorer = true,
    view_options = {
      is_hidden_file = function(name, bufnr)
        -- Always treat dotfiles as hidden (toggled via 'H' / actions.toggle_hidden)
        if vim.startswith(name, ".") then
          return true
        end
        -- Hide gitignored files unless toggled on with 'I'
        if not show_gitignored then
          local dir = require("oil").get_current_dir(bufnr)
          if dir then
            local check = vim.system({ "git", "check-ignore", "-q", dir .. name }):wait()
            return check.code == 0
          end
        end
        return false
      end,
    },
    keymaps = {
      -- ~/.config/nvim/lua/plugins/oil.lua
      -- Free up <C-h/j/k/l> for global window navigation
      ["<C-h>"] = false,
      ["<C-j>"] = false,
      ["<C-k>"] = false,
      ["<C-l>"] = false,

      -- Custom Oil toggles & refresh (Shift+R, Shift+I, Shift+H)
      ["R"] = { "actions.refresh", desc = "Refresh directory" },
      ["H"] = { "actions.toggle_hidden", desc = "Toggle hidden files" },
      ["I"] = {
        callback = function()
          show_gitignored = not show_gitignored
          require("oil.actions").refresh.callback()
        end,
        desc = "Toggle gitignored files",
      },

      ["<C-s>"] = false, -- Unbind Oil's default split shortcut so your Ctrl+s save keymap works
    },
  },
}
