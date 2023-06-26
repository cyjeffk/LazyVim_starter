-- stylua: ignore
return {
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function(_, opts)
      opts.pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
      local ft = require('Comment.ft')
      ft({"systemverilog", "verilog"}, {"//%s", "/*%s*/"})
      require("Comment").setup(opts)
    end,
  },
}

