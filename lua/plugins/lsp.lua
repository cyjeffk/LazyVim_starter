-- stylua: ignore
if false then return {} end

-- every spec file under config.plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- add verible-specific spec if directly using lazy to config LSP
  -- { import = "user_specs.verible" },

  -- for json, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason, etc.
  { import = "lazyvim.plugins.extras.lang.json" },

  -- add lang extras
  { import = "lazyvim.plugins.extras.lang.go" },

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
        pyright = {},
        verible = {
          cmd = {
            "verible-verilog-ls",
            -- add flags below
            "--rules_config_search",
            -- "--rules=-no-tabs",
          },
          root_dir = function()
            return vim.loop.cwd()
          end,
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

    "williamboman/mason.nvim",
    opts = function(_, opts)
      -- mypy and ruff installation somehow wouldn't work if they were added to opts.server of nvim-lspconfig
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        -- Python
        "black",
        "mypy",
        "ruff",
        -- Go
        "gomodifytags",
        "impl",
        "gofumpt",
        "goimports-reviser",
      })
    end,
  },

  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    -- ft = { "python" },
    opts = function(_, opts)
      if type(opts.sources) == "table" then
        local nls = require("null-ls")
        vim.list_extend(opts.sources, {
          -- Python
          nls.builtins.diagnostics.mypy,
          nls.builtins.diagnostics.ruff,
          nls.builtins.formatting.black,
          -- SystemVerilog
          nls.builtins.formatting.verible_verilog_format,
        })
      end
    end,
  },
}
