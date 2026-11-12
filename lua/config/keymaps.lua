-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- netrw
vim.keymap.set("n", "<leader>fv", vim.cmd.Ex, { desc = "netrw" })

-- Block comments (built-in gc only does line comments)
--   gbc        toggle a block comment around the current line
--   {Visual}gb toggle a block comment around the selected lines
local block_comments = {
  c = { "/*", "*/" },
  cpp = { "/*", "*/" },
  systemverilog = { "/*", "*/" },
  verilog = { "/*", "*/" },
  lua = { "--[[", "]]" },
}

local function toggle_block_comment(srow, erow)
  local pair = block_comments[vim.bo.filetype]
  if not pair then
    vim.notify("No block comment defined for filetype '" .. vim.bo.filetype .. "'", vim.log.levels.WARN)
    return
  end
  local open, close = vim.pesc(pair[1]), vim.pesc(pair[2])
  local lines = vim.api.nvim_buf_get_lines(0, srow - 1, erow, false)
  if lines[1]:match("^%s*" .. open) and lines[#lines]:match(close .. "%s*$") then
    lines[1] = lines[1]:gsub("^(%s*)" .. open .. " ?", "%1", 1)
    lines[#lines] = lines[#lines]:gsub(" ?" .. close .. "(%s*)$", "%1", 1)
  else
    lines[1] = lines[1]:gsub("^(%s*)", "%1" .. pair[1] .. " ", 1)
    lines[#lines] = lines[#lines] .. " " .. pair[2]
  end
  vim.api.nvim_buf_set_lines(0, srow - 1, erow, false, lines)
end

vim.keymap.set("n", "gbc", function()
  local row = vim.fn.line(".")
  toggle_block_comment(row, row)
end, { desc = "Toggle block comment (line)" })

vim.keymap.set("x", "gb", function()
  local srow, erow = vim.fn.line("v"), vim.fn.line(".")
  if srow > erow then
    srow, erow = erow, srow
  end
  vim.api.nvim_feedkeys(vim.keycode("<Esc>"), "nx", false)
  toggle_block_comment(srow, erow)
end, { desc = "Toggle block comment (selection)" })
