-- Code outline sidebar built from LSP / treesitter symbols (replaces vista.vim + ctags).
return {
  'stevearc/aerial.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  cmd = { 'AerialToggle', 'AerialOpen', 'AerialNavToggle' },
  opts = {
    backends = { 'lsp', 'treesitter', 'markdown', 'man' },
    layout = { default_direction = 'right', min_width = 40 },
  },
  keys = {
    { '<leader>tt', '<cmd>AerialToggle!<CR>', desc = '[T]oggle code ou[t]line' },
  },
}
