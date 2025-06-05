return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    icons = {
      rules = false,
      breadcrumb = ' ',
      separator = '󱦰  ',
      group = '󰹍 ',
    },
    opts = {
      spec = {
        {
          mode = { 'n', 'v' },
          { '<leader>f', group = 'Find' },
          { '<leader>g', group = 'Git' },
          { '<leader>R', group = 'Replace' },
          { '<leader>c', group = 'LSP (Trouble)' },
          { '<leader>s', group = 'Search' },
          { '<leader>x', group = 'diagnostics/quickfix (Trouble)' },
          { '<leader>u', group = 'Toggle Features' },
          { '[', group = 'prev' },
          { ']', group = 'next' },
          { 'g', group = 'goto' },
        },
      },
    },
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show { global = false }
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
  },
}
