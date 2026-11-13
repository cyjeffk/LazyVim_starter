return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add more treesitter parsers
      vim.list_extend(opts.ensure_installed, {
        "jsonnet",
      })
    end,
  },
}
