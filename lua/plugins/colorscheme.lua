return {
  -- elevate priority for main colorscheme
  {
    "catppuccin",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    opts = {
      -- flavour = 'mocha', -- latte, frappe, macchiato, mocha
      -- LazyVim already lists integrations explicitly; auto-detection cost 1.6-4s on NFS
      auto_integrations = false,
    },
  },

  -- configure LazyVim to load same colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
      -- colorscheme = "tokyonight",
    },
  },
}
