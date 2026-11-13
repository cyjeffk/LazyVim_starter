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
        verible = {
          -- more flags: "--rules_config_search", "--rules=-no-tabs"
          cmd = verible_cmd,
        },
      },
    },
  },

  -- cmdline tools and lsp servers
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "bash-language-server",
        "shellcheck",
      })
    end,
  },
}
