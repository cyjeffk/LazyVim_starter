-- Also used for verilog (see verilog.lua). 'commentstring' ("// %s") comes from
-- Neovim's own ftplugin; 'wrap' and 'breakindent' are set globally in options.lua.
vim.opt_local.textwidth = 100 -- SystemVerilog standard line length
vim.opt_local.colorcolumn = "+1" -- marker at column 101
vim.b.autoformat = false -- no format-on-save (verible LSP would reformat)
