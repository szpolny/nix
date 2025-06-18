return {
  {
    {
      'zbirenbaum/copilot.lua',
      cmd = 'Copilot',
      opts = {
        suggestion = {
          enable = true,
          auto_trigger = true,
          keymap = {
            accept = '<C-a>',
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '<C-]>',
          },
        },
      },
    },
    {
      'CopilotC-Nvim/CopilotChat.nvim',
      dependencies = {
        'zbirenbaum/copilot.lua',
        { 'nvim-lua/plenary.nvim', branch = 'master' },
      },
      build = 'make tiktoken',
      config = function()
        local chat = require 'CopilotChat'

        chat.setup {}

        vim.api.nvim_create_autocmd('BufEnter', {
          pattern = 'copilot-*',
          callback = function()
            -- Set buffer-local options
            vim.opt_local.relativenumber = false
            vim.opt_local.number = false
            vim.opt_local.conceallevel = 0
          end,
        })

        vim.keymap.set('n', '<leader>ic', function()
          chat.open()
        end, { desc = 'Open Copilot Chat' })
      end,
    },
  },
}
