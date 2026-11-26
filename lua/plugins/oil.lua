local show_gitignored = false
local ignored_cache = {} -- Map of [dir] -> { [filename] = true }

local function get_ignored_set(dir)
  if ignored_cache[dir] ~= nil then
    return ignored_cache[dir]
  end

  local ignored = {}
  -- Single fast git call for the entire directory
  local res = vim.system(
    { "git", "status", "--porcelain", "--ignored", "--untracked-files=all", "-z", "." },
    { cwd = dir }
  ):wait()

  if res.code == 0 and res.stdout then
    for entry in vim.gsplit(res.stdout, "\0", { plain = true }) do
      if entry:sub(1, 3) == "!! " then
        local rel = entry:sub(4):gsub("/$", "")
        local top = rel:match("^([^/]+)")
        if top then
          ignored[top] = true
        end
      end
    end
  end
  ignored_cache[dir] = ignored
  return ignored
end

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
        if vim.startswith(name, ".") then
          return true
        end
        if not show_gitignored then
          local dir = require("oil").get_current_dir(bufnr)
          if dir then
            return get_ignored_set(dir)[name] == true
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
      -- Refresh (also clears gitignore cache so new ignores are picked up)
      ["R"] = {
        callback = function()
          ignored_cache = {}
          require("oil.actions").refresh.callback()
        end,
        desc = "Refresh directory",
      },
      ["H"] = { "actions.toggle_hidden", desc = "Toggle hidden dotfiles" },
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
