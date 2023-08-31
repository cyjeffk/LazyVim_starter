-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt

-- For Windows GUI
-- opt.guifont = "JetBrainsMono Nerd Font:h10:Consolas"

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
