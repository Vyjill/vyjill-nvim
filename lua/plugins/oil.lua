local show_dotfiles = false
local show_gitignored = false
local ignored_cache = {} -- Map of [dir] -> { [filename] = true }

local function get_ignored_set(dir)
  if ignored_cache[dir] ~= nil then
    return ignored_cache[dir]
  end

  local ignored = {}
  local entries = vim.fn.readdir(dir)
  if #entries > 0 then
    local res = vim.system(
      { "git", "check-ignore", "-z", "--stdin" },
      { cwd = dir, stdin = table.concat(entries, "\0") .. "\0" }
    ):wait()

    if res.code == 0 and res.stdout then
      for name in vim.gsplit(res.stdout, "\0", { plain = true }) do
        if name ~= "" then
          ignored[name] = true
        end
      end
    end
  end

  ignored_cache[dir] = ignored
  return ignored
end

local function toggle_filter(which)
  if which == "dotfiles" then
    show_dotfiles = not show_dotfiles
  elseif which == "gitignored" then
    show_gitignored = not show_gitignored
  end

  vim.notify(
    string.format("Oil filters → Dotfiles: %s | Gitignored: %s", show_dotfiles and "ON" or "OFF",
      show_gitignored and "ON" or "OFF"),
    vim.log.levels.INFO,
    { title = "oil.nvim" }
  )
  require("oil.actions").refresh.callback()
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
      -- Both filters are evaluated independently; Oil's internal toggle_hidden is bypassed
      is_hidden_file = function(name, bufnr)
        local is_dot = vim.startswith(name, ".")
        local dir = require("oil").get_current_dir(bufnr)
        local is_ignored = dir and (get_ignored_set(dir)[name] == true) or false

        -- nvim-tree behavior: hidden if EITHER active filter catches it
        if is_dot and not show_dotfiles then
          return true
        end
        if is_ignored and not show_gitignored then
          return true
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
      -- Refresh & clear gitignore cache
      ["R"] = {
        callback = function()
          ignored_cache = {}
          require("oil.actions").refresh.callback()
        end,
        desc = "Refresh directory",
      },

      -- Independent toggles (replaces built-in actions.toggle_hidden)
      ["H"] = {
        callback = function()
          toggle_filter("dotfiles")
        end,
        desc = "Toggle dotfiles (.gitignore, .github)",
      },
      ["I"] = {
        callback = function()
          toggle_filter("gitignored")
        end,
        desc = "Toggle gitignored files (target/)",
      },
      ["<C-s>"] = false, -- Unbind Oil's default split shortcut so your Ctrl+s save keymap works
    },
  },
}
