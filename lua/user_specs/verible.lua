-- stylua: ignore
return {
  {
    "chipsalliance/verible",
    -- name = "verible",
    ft = { "systemverilog", "verilog" },
    -- root_dir = function () return vim.loop.cwd() end,
    config = function()
      require('lspconfig').verible.setup({
        root_dir = function () return vim.loop.cwd() end,
      })
    end,
  },
}

