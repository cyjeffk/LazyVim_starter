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
  },
  filename = {
    ['rt.lib'] = 'cdslib',
    ['.cdsinit'] = 'skill',
    ['.cdsinit_post'] = 'skill',
    ['.vlogifrc'] = 'skill',
    ['.simrc'] = 'skill',
    ['Makeppfile'] = 'make',
  },
  pattern = {
    ['cds.lib.*'] = 'cdslib',
  },
})
