-- stylua: ignore
if false then return {} end

-- every spec file under config.plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    opts = function(_, opts)
      -- add more treesitter buffers
      vim.list_extend(opts.ensure_installed, {
        "cpp",
        -- "help",
        "jsonnet",
        "perl",
        "verilog",
      })

      opts.context_commentstring = { enable = true }
    end,
  },

  -- Show the context of the currently visible buffer contents
  -- { "nvim-treesitter/nvim-treesitter-context" },
  -- { "nvim-treesitter/nvim-treesitter-context", event = "VeryLazy" },
}
