-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

if vim.g.neovide then
  -- vim.g.neovide_cursor_trail_legnth = 0
  vim.g.neovide_cursor_animation_length = 0
  vim.o.guifont = "JetBrainsMono Nerd Font,Consolas:h10"
end

if vim.g.nvy then
  opt.guifont = "JetBrainsMono Nerd Font:h10:Consolas"
end

opt.title = true
-- opt.titlestring = [[%f %h%m%r%w %{v:progname} (%{tabpagenr()} of %{tabpagenr('$')})]]
-- opt.scrolloff = 8 -- Lines of context
-- opt.colorcolumn = '100'

opt.breakindent = true -- Enable break indent
opt.wrap = true -- Enable line wrap
-- if vim.bo.filetype == "" then
--   vim.opt_local.breakindent = true -- Enable break indent
--   vim.opt_local.wrap = true -- Enable line wrap
-- end
