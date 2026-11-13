-- Verible lint rules in the home directory. os_homedir() works on Linux and
-- Windows (os.getenv("HOME") is unset on Windows). The flag is only passed when
-- the file exists, so machines without it still get a working server.
local verible_cmd = { "verible-verilog-ls" }
local verible_rules = vim.fs.joinpath(vim.uv.os_homedir(), "rules.verible_lint")
if vim.uv.fs_stat(verible_rules) then
  vim.list_extend(verible_cmd, { "--rules_config", verible_rules })
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- bash-language-server; mason installs it, and it runs shellcheck (below)
        bashls = {},
        verible = {
          -- more flags: "--rules_config_search", "--rules=-no-tabs"
          cmd = verible_cmd,
        },
      },
    },
  },

  -- extra mason tools (appended to LazyVim's list via opts_extend)
  { "mason-org/mason.nvim", opts = { ensure_installed = { "shellcheck" } } },
}
