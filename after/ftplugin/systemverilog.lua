-- Also used for verilog (see verilog.lua). 'commentstring' ("// %s") comes from
-- Neovim's own ftplugin; 'wrap' and 'breakindent' are set globally in options.lua.
vim.opt_local.textwidth = 100 -- SystemVerilog standard line length
vim.opt_local.colorcolumn = "+1" -- marker at column 101
-- Show other people's tab characters at the standard width (as in Vim, less,
-- p4 diff). Indent stays 2 spaces: LazyVim's shiftwidth=2 + expandtab.
vim.opt_local.tabstop = 8
vim.opt_local.foldnestmax = 2 -- indent folds: module body and one level inside (as in Vim)
vim.b.autoformat = false -- no format-on-save (verible LSP would reformat)
