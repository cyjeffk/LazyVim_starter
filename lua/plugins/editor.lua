return {
  -- Detect tabstop and shiftwidth automatically.
  -- Not lazy-loaded: sleuth hooks BufReadPost, which has already fired for
  -- files given on the command line by the time VeryLazy runs.
  { "tpope/vim-sleuth" },
}
