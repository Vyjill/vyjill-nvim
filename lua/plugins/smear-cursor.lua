-- ~/.config/nvim/lua/plugins/smear-cursor.lua
return {
  "sphamba/smear-cursor.nvim",
  event = "VeryLazy",
  opts = {
    -- Optional tuning: uncomment to make the smear snappier
    -- stiffness = 0.8,                      -- Default: 0.6 (0.1 to 1.0)
    -- trailing_stiffness = 0.5,             -- Default: 0.3 (0.1 to 1.0)
    -- distance_stop_animating = 0.5,        -- Default: 0.1
    -- hide_target_hack = false,             -- Set to true if your terminal flickers
  },
}
