vim.filetype.add({
  -- Mirrors ~/.vimrc. Without these, Neovim guesses .lib=faust, .inc=pov,
  -- .f=fortran, .spi=spyce, empty .v=V-lang, and .scs/.vh get no filetype.
  extension = {
    -- SPICE / Spectre
    cir = 'spice',
    ckt = 'spice',
    inc = 'spice',
    lib = 'spice',
    spf = 'spice',
    spi = 'spice',
    scs = 'spectre',
    -- (System)Verilog; .f/.init/.adinit are file lists / init files
    v = 'systemverilog',
    vh = 'systemverilog',
    vlib = 'systemverilog',
    vt = 'systemverilog',
    f = 'verilog',
    init = 'verilog',
    adinit = 'verilog',
    -- SKILL / OCEAN / Cadence shell-like configs
    ocn = 'ocean',
    state = 'skill',
    sx = 'csh',
    ses = 'csh',
    -- bar = function(path, bufnr)
    --   if some_condition() then
    --     return 'barscript', function(bufnr)
    --       -- Set a buffer variable
    --       vim.b[bufnr].barscript_version = 2
    --     end
    --   end
    --   return 'bar'
    -- end,
  },
  filename = {
    ['rt.lib'] = 'cdslib',
    ['.cdsinit'] = 'skill',
    ['.cdsinit_post'] = 'skill',
    ['.vlogifrc'] = 'skill',
    ['.simrc'] = 'skill',
    ['Makeppfile'] = 'make',
    -- ['.foorc'] = 'toml',
    -- ['/etc/foo/config'] = 'toml',
  },
  pattern = {
    ['cds.lib.*'] = 'cdslib',
    -- ['.*/etc/foo/.*'] = 'fooscript',
    -- -- Using an optional priority
    -- ['.*/etc/foo/.*%.conf'] = { 'dosini', { priority = 10 } },
    -- -- A pattern containing an environment variable
    -- ['${XDG_CONFIG_HOME}/foo/git'] = 'git',
    -- ['README.(a+)$'] = function(path, bufnr, ext)
    --   if ext == 'md' then
    --     return 'markdown'
    --   elseif ext == 'rst' then
    --     return 'rst'
    --   end
    -- end,
  },
})
