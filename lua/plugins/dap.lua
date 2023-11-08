-- stylua: ignore
if true then return {} end

-- every spec file under config.plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- add dap
  { import = "lazyvim.plugins.extras.dap.core" },

  -- add nvim-dap-python
  {
    "mfussenegger/nvim-dap",

    dependencies = {
      {
        "mfussenegger/nvim-dap-python",
        -- stylua: ignore
        keys = {
          { "<leader>dan", function() require("dap-python").test_method() end, desc = "Python Test Method", mode = {"n"} },
          { "<leader>daf", function() require("dap-python").test_class() end, desc = "Python Test Class", mode = {"n"} },
          -- { "<leader>das <ESC>", function() require("dap-python").debug_selection() end, desc = "Python Debug Selection", mode = {"v"} },
        },
        config = function()
          local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
          require("dap-python").setup(path)
          -- NOTE: The following config has already been done by the plugin. Refer to python section in
          -- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/configurations.lua

          -- local dap = require("dap")
          -- dap.configurations.python = {
          --   {
          --     type = "python",
          --     request = "launch",
          --     name = "Attach to running Neovim instance",
          --     program = "${file}",
          --   },
          -- }
        end,
      },

      -- example from LazyVim's nlua setup
      -- {
      --   "jbyuki/one-small-step-for-vimkind",
      --   -- stylua: ignore
      --   keys = {
      --     { "<leader>daL", function() require("osv").launch({ port = 8086 }) end, desc = "Adapter Lua Server" },
      --     { "<leader>dal", function() require("osv").run_this() end, desc = "Adapter Lua" },
      --   },
      --   config = function()
      --     local dap = require("dap")
      --     dap.adapters.nlua = function(callback, config)
      --       callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
      --     end
      --     dap.configurations.lua = {
      --       {
      --         type = "nlua",
      --         request = "attach",
      --         name = "Attach to running Neovim instance",
      --       },
      --     }
      --   end,
      -- },
    },
  },

  -- mason.nvim integration
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        -- NOTE: Use dap adapter names, not mason.nvim pakacge names, e.g. python rather than debugpy
        "python",
      },
    },
  },
}
