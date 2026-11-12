-- stylua: ignore
if false then return {} end

-- every spec file under config.plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- bufferline
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        -- stylua: ignore
        -- For ⁸·₂
        numbers = function(opts)
          return string.format('%s·%s', opts.raise(opts.id), opts.lower(opts.ordinal))
        end,
      },
    },
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      sections = {
        lualine_y = {
          { "vim.fn.line('$')", separator = " ", padding = { left = 1, right = 0 } },
          { "progress", separator = " ", padding = { left = 0, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
      },
    },
  },
}
