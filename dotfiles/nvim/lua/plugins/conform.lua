return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    dependencies = {
      { 'mason-org/mason.nvim' },
    },
    keys = {
      {
        '<leader>df',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        nix = { 'alejandra' },
        rust = { 'rustfmt' },
      },
    },
  },
  { 'zapling/mason-conform.nvim', opts = {} },
}
