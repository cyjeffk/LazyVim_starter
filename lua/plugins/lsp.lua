-- stylua: ignore
if false then return {} end

-- every spec file under config.plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins

-- Verible lint rules in the home directory. os_homedir() works on Linux and
-- Windows (os.getenv("HOME") is unset on Windows). The flag is only passed when
-- the file exists, so machines without it still get a working server.
local verible_cmd = { "verible-verilog-ls" }
local verible_rules = vim.fs.joinpath(vim.uv.os_homedir(), "rules.verible_lint")
if vim.uv.fs_stat(verible_rules) then
  vim.list_extend(verible_cmd, { "--rules_config", verible_rules })
end

return {
  -- for json, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason, etc.
  -- { import = "lazyvim.plugins.extras.lang.json" },

  -- add lang extras
  -- { import = "lazyvim.plugins.extras.lang.go" },

  -- add servers to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      -- selectively disable autoformat in config/autocmds
      -- autoformat = false,
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        -- pyright = {},
        verible = {
          -- more flags: "--rules_config_search", "--rules=-no-tabs"
          cmd = verible_cmd,
          -- root_dir = function()
          --   return vim.loop.cwd()
          -- end,
        },
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },

  -- cmdline tools and lsp servers
  {

    "mason-org/mason.nvim",
    opts = function(_, opts)
      -- mypy and ruff installation somehow wouldn't work if they were added to opts.server of nvim-lspconfig
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        -- Python
        -- "black",
        -- "mypy",
        -- "ruff",
        -- Go
        -- "gomodifytags",
        -- "impl",
        -- "gofumpt",
        -- "goimports-reviser",
        -- Bash
        "bash-language-server",
        "shellcheck",
      })
    end,
  },

  -- formatters
  -- {
  --   -- "jose-elias-alvarez/null-ls.nvim",
  --   "nvimtools/none-ls.nvim",
  --   -- ft = { "python" },
  --   opts = function(_, opts)
  --     if type(opts.sources) == "table" then
  --       local nls = require("null-ls")
  --       vim.list_extend(opts.sources, {
  --         -- Python
  --         nls.builtins.diagnostics.mypy,
  --         nls.builtins.diagnostics.ruff,
  --         nls.builtins.formatting.black,
  --         -- SystemVerilog
  --         nls.builtins.formatting.verible_verilog_format,
  --       })
  --     end
  --   end,
  -- },
}
