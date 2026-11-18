-- ~/.config/nvim/lua/config/rust_lsp.lua

-- 1. Check if the current project is a Verus project
local is_verus = false
local cargo_toml = io.open(vim.fn.getcwd() .. "/Cargo.toml", "r")
if cargo_toml then
  local content = cargo_toml:read("*a")
  if content:find("vstd") or content:find("metadata.verus") then
    is_verus = true
  end
  cargo_toml:close()
end

-- 2. Default to standard Rust tools
local lsp_cmd = { "rust-analyzer" }
local check_cmd = { "cargo", "check", "--workspace", "--message-format=json" }

-- 3. Swap to Verus tools if verified code is detected
if is_verus then
  lsp_cmd = { "verus-analyzer" }
  check_cmd = { "cargo", "verus", "verify", "--message-format=json" }
end

-- 4. Define the native configuration
vim.lsp.config("rust_analyzer", {
  cmd = lsp_cmd,
  -- ADD THIS: Force the LSP and its internal metadata checks to use 1.94.0, 
  -- completely ignoring the 1.91.1 rust-toolchain.toml file in the workspace.
  cmd_env = { RUSTUP_TOOLCHAIN = "1.94.0" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", "rust-project.json" },
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = true,
      check = {
        overrideCommand = check_cmd,
      },
      inlayHints = {
        parameterHints = { enable = false },
        typeHints = { enable = false },
      },
    },
  },
})

vim.lsp.enable("rust_analyzer")
-- 5. Tell Neovim to automatically start this server for Rust files
vim.lsp.enable("rust_analyzer")
