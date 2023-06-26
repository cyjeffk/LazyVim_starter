-- stylua: ignore
if false then return {} end

-- every spec file under config.plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- add hardhacker
  -- { import = "user_specs.hardhacker_theme" },

  -- elevate priority for main colorscheme
  {
    "catppuccin",
    -- "hardhacker",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      -- flavour = 'mocha', -- latte, frappe, macchiato, mocha
    },
  },

  -- configure LazyVim to load same colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
      -- colorscheme = "hardhacker",
      -- colorscheme = "tokyonight",
    },
  },
}
