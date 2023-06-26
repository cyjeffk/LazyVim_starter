-- stylua: ignore
if false then return {} end

-- every spec file under config.plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- theprimeagen vim-be-good
  {
    'ThePrimeagen/vim-be-good',
    cmd = "VimBeGood",
  },
}
