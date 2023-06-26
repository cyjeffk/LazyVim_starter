-- stylua: ignore
if false then return {} end

-- every spec file under config.plugins will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- comments
  -- disable mini.comment
  { "echasnovski/mini.comment", enabled = false },
  -- add Comment.nvim
  -- { 'numToStr/Comment.nvim', opts = {} },
  { import = "user_specs.comment" },

  -- add chatgpt.nvim
  -- { import = "user_specs.chatgpt_nvim" },
}
