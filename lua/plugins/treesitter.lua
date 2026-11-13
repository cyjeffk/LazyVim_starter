return {
  -- Extra parsers. LazyVim declares opts_extend = { "ensure_installed" }, so
  -- this list is appended to LazyVim's instead of replacing it.
  { "nvim-treesitter/nvim-treesitter", opts = { ensure_installed = { "jsonnet" } } },
}
