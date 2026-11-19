-- nvim-treesitter `main` branch (the archived `master` branch does not support
-- Neovim 0.12). `main` has no `nvim-treesitter.configs` module: parsers are
-- installed with `install()`, and highlight / indent are switched on per buffer.
local ensure_installed = {
  'bash',
  'c',
  'diff',
  'html',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'query',
  'vim',
  'vimdoc',
  'python',
  'typescript',
  'pug',
}

-- Filetypes that keep Vim's own indent rules instead of treesitter indent.
local indent_disabled = { ruby = true }

return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false, -- `main` does not support lazy-loading
    build = ':TSUpdate',
    config = function()
      local ts = require 'nvim-treesitter'
      ts.install(ensure_installed)

      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('kickstart-treesitter', { clear = true }),
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(args.match)
          if not lang then
            return
          end
          -- Autoinstall languages that are not installed
          if not vim.tbl_contains(ts.get_installed(), lang) and vim.tbl_contains(ts.get_available(), lang) then
            ts.install(lang)
            return
          end
          -- Treesitter highlight stays off (Vim regex syntax is used); enable
          -- it per buffer with `vim.treesitter.start(args.buf)` if wanted.
          local ok, has_parser = pcall(vim.treesitter.language.add, lang)
          if ok and has_parser and not indent_disabled[args.match] then
            vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
}
-- vim: ts=2 sts=2 sw=2 et
