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

  -- add servers to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      -- disable automatical format on save
      autoformat = false,
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
          root_dir = function () return vim.loop.cwd() end
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
      table.insert(opts.ensure_installed, "black")
      table.insert(opts.ensure_installed, "mypy")
      table.insert(opts.ensure_installed, "ruff")
    end,
  },

  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    -- ft = { "python" },
    opts = function(_, opts)
      local nls = require("null-ls")
      table.insert(opts.sources, nls.builtins.diagnostics.mypy)
      table.insert(opts.sources, nls.builtins.diagnostics.ruff)
      table.insert(opts.sources, nls.builtins.formatting.black)
      table.insert(opts.sources, nls.builtins.formatting.verible_verilog_format)
    end,
  },
}
