return {
  'liuchengxu/vista.vim',
  config = function()
    vim.g.vista_default_executive = 'ctags'
    vim.g.vista_icon_indent = { '╰─▸ ', '├─▸ ' }
    vim.g.vista_sidebar_width = 60
    vim.keymap.set('n', '<leader>tt', ':Vista!!<CR>', { desc = 'Toggle Vista' })
  end,
}
