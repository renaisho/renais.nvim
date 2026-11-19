return {
  { -- Autocompletion
    'saghen/blink.cmp',
    version = '1.*', -- prebuilt fuzzy matcher binaries ship with tagged releases
    event = 'InsertEnter',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default': <C-n>/<C-p> select, <C-y> accept, <C-space> open menu,
        -- <C-e> close, <C-b>/<C-f> scroll docs.
        preset = 'default',
        -- Jump forward / backward through the placeholders of an expanded snippet.
        ['<C-l>'] = { 'snippet_forward', 'fallback' },
        ['<C-h>'] = { 'snippet_backward', 'fallback' },
      },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 300 },
      },
      sources = {
        default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },
      signature = { enabled = true },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
