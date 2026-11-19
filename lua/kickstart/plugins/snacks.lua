return {
  { -- Fuzzy finder (files, grep, LSP, ...) and vim.ui.select
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      picker = { ui_select = true },
    },
    config = function(_, opts)
      require('snacks').setup(opts)
      -- Snacks draws directory names with NonText, which nord colours the same
      -- as the float background, so paths vanish. Use the comment colour instead.
      local function set_picker_highlights()
        for _, group in ipairs { 'SnacksPickerDir', 'SnacksPickerPathHidden', 'SnacksPickerPathIgnored' } do
          vim.api.nvim_set_hl(0, group, { link = 'Comment' })
        end
      end
      set_picker_highlights()
      vim.api.nvim_create_autocmd('ColorScheme', { callback = set_picker_highlights })
    end,
    keys = {
      { '<leader>sh', function() Snacks.picker.help() end, desc = '[S]earch [H]elp' },
      { '<leader>sk', function() Snacks.picker.keymaps() end, desc = '[S]earch [K]eymaps' },
      { '<leader>sf', function() Snacks.picker.files() end, desc = '[S]earch [F]iles' },
      { '<C-p>', function() Snacks.picker.files() end, desc = '[S]earch [F]iles (ctrl-p)' },
      { '<leader>ss', function() Snacks.picker.pickers() end, desc = '[S]earch [S]elect Picker' },
      { '<leader>sw', function() Snacks.picker.grep_word() end, desc = '[S]earch current [W]ord', mode = { 'n', 'x' } },
      { '<leader>sg', function() Snacks.picker.grep() end, desc = '[S]earch by [G]rep' },
      { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = '[S]earch [D]iagnostics' },
      { '<leader>sr', function() Snacks.picker.resume() end, desc = '[S]earch [R]esume' },
      { '<leader>s.', function() Snacks.picker.recent() end, desc = '[S]earch Recent Files ("." for repeat)' },
      { '<leader><leader>', function() Snacks.picker.buffers() end, desc = '[ ] Find existing buffers' },
      { '<leader>/', function() Snacks.picker.lines() end, desc = '[/] Fuzzily search in current buffer' },
      { '<leader>s/', function() Snacks.picker.grep_buffers() end, desc = '[S]earch [/] in Open Files' },
      { '<leader>sn', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, desc = '[S]earch [N]eovim files' },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
