return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
      {
        '<leader>tF',
        function()
          -- 定義一個全局變數來追蹤自動格式化的狀態
          vim.g.autoformat_enabled = not vim.g.autoformat_enabled
          if vim.g.autoformat_enabled then
            vim.notify('Conform Autoformat: Enabled', vim.log.levels.INFO)
          else
            vim.notify('Conform Autoformat: Disabled', vim.log.levels.INFO)
          end
        end,
        mode = 'n',
        desc = '[T]oggle [F]ormat on save',
      },
    },
    opts = {
      notify_on_error = false,
      init = function()
        if vim.g.autoformat_enabled == nil then
          vim.g.autoformat_enabled = true -- 預設啟用自動格式化
        end
      end,
      format_on_save = function(bufnr)
        -- 檢查 autoformat_enabled 狀態
        if not vim.g.autoformat_enabled then
          return nil -- 如果自動格式化被禁用，則不觸發
        end

        local enable_filetypes = {
          lua = true,
          javascript = true,
          typescript = true,
          css = true,
          scss = true,
          json = true,
          html = true,
          yaml = true,
          python = true,
        }
        local filetype = vim.bo[bufnr].filetype
        if enable_filetypes[filetype] then
          return {
            timeout_ms = 2000,
            lsp_format = 'fallback', -- 允許 LSP 格式化作為備用
          }
        end
        return nil -- 不在清單中的文件類型不觸發保存時格式化
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        css = { 'prettier' },
        scss = { 'prettier' },
        json = { 'prettier' },
        html = { 'prettier' },
        yaml = { 'prettier' },
        python = { 'isort', 'yapf' },
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
