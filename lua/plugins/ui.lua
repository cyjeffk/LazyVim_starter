-- Total line count for the statusline. A function, because a string like
-- "vim.fn.line('$')" is recompiled by lualine with loadstring on every redraw.
local function line_count()
  return tostring(vim.fn.line("$"))
end

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
    opts = {
      sections = {
        lualine_y = {
          { line_count, separator = " ", padding = { left = 1, right = 0 } },
          { "progress", separator = " ", padding = { left = 0, right = 0 } },
          { "location", padding = { left = 0, right = 1 } },
        },
      },
    },
  },
}
