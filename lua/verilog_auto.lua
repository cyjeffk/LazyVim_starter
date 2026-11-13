-- Emacs verilog-mode AUTOs for (System)Verilog buffers; the Neovim side of
-- Vim's verilog_emacsauto plugin. after/ftplugin/systemverilog.lua maps:
--   <localleader>e  expand AUTOs                          (verilog-batch-auto)
--   <localleader>k  kill AUTOs, keep the /*AUTO*/ comments (verilog-batch-delete-auto)
--   <localleader>d  show what expanding would change      (verilog-batch-diff-auto)
-- Emacs rewrites the file on disk, so the buffer is saved first and reloaded after.
local M = {}

M.elisp = vim.fs.joinpath(vim.uv.os_homedir(), ".elisp", "verilog-mode.el")

-- verilog-mode messages look like "%Error: file:line: text"; drop everything else
local efm = "%%%trror: %f:%l: %m,%%%tarning: %f:%l: %m,%-G%.%#"

local available
--- Emacs and verilog-mode.el are both present (typically not on Windows).
function M.available()
  if available == nil then
    available = vim.fn.executable("emacs") == 1 and vim.uv.fs_stat(M.elisp) ~= nil
  end
  return available
end

-- Run one verilog-batch-* function on file; returns exit code and output lines.
local function emacs(func, file)
  local res = vim.system({
    "emacs", "--batch", "--no-site-file", "-l", M.elisp,
    -- spaces, not tabs, in generated code (so no :retab afterwards)
    "--eval", "(setq-default indent-tabs-mode nil)",
    file, "-f", func,
  }, { text = true }):wait()
  local lines = vim.split(vim.trim((res.stdout or "") .. (res.stderr or "")), "\n")
  lines = vim.tbl_filter(function(l) return not l:match("^Processing ") end, lines)
  return res.code, lines
end

-- Load verilog-mode errors/warnings into quickfix and open it if any parsed.
local function report(title, lines)
  vim.fn.setqflist({}, " ", { title = "verilog-mode: " .. title, lines = lines, efm = efm })
  if #vim.fn.getqflist() > 0 then
    vim.cmd("botright copen")
  end
end

-- Show the diff output in a scratch split (q closes it).
local function show_diff(lines)
  vim.cmd("botright new")
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].buftype, vim.bo[buf].bufhidden, vim.bo[buf].modifiable = "nofile", "wipe", false
  vim.bo[buf].filetype = "diff"
  vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = buf, desc = "Close" })
end

local function run(func, title, modifies)
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" then
    return vim.notify("verilog-mode: buffer has no file", vim.log.levels.WARN)
  end
  if vim.bo.modified then
    local ok, err = pcall(vim.cmd, "silent write")
    if not ok then
      return vim.notify("verilog-mode: save failed: " .. err, vim.log.levels.ERROR)
    end
  end
  vim.api.nvim_echo({ { "verilog-mode: " .. title .. " ..." } }, false, {})
  vim.cmd.redraw()

  local code, lines = emacs(func, file)
  if code ~= 0 then
    report(title, lines)
    return vim.notify("verilog-mode: " .. title .. " failed\n" .. table.concat(lines, "\n"), vim.log.levels.ERROR)
  end
  if modifies then
    local view = vim.fn.winsaveview()
    vim.cmd("silent edit") -- reload the file Emacs wrote
    vim.fn.winrestview(view)
    report(title, lines) -- warnings, if any
    vim.notify("verilog-mode: " .. title .. " done")
  elseif vim.iter(lines):any(function(l) return l:find("Difference in AUTO expansion found", 1, true) end) then
    show_diff(lines)
  else
    vim.notify("verilog-mode: AUTOs are up to date")
  end
end

--- Map <localleader>e/k/d in buffer buf, if Emacs and verilog-mode.el exist.
function M.attach(buf)
  if not M.available() then
    return
  end
  local function map(key, func, title, modifies)
    vim.keymap.set("n", "<localleader>" .. key, function()
      run(func, title, modifies)
    end, { buffer = buf, desc = "verilog-mode: " .. title })
  end
  map("e", "verilog-batch-auto", "expand AUTOs", true)
  map("k", "verilog-batch-delete-auto", "kill AUTOs", true)
  map("d", "verilog-batch-diff-auto", "diff AUTOs", false)
end

return M
