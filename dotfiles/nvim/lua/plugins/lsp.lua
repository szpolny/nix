return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'mason-org/mason.nvim' },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'j-hui/fidget.nvim',
      'saghen/blink.cmp',
    },
    config = function()
      vim.diagnostic.config {
        update_in_insert = true,
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        },
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      require('mason').setup()

      require('mason-lspconfig').setup {
        automatic_enable = true,
        ensure_installed = {
          'lua_ls',
          'lemminx',
          'eslint',
          'ts_ls',
        },
        handler = function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
          }
        end,
      }

      require('mason-tool-installer').setup {
        ensure_installed = {
          'rust_analyzer',
          'bacon',
          'bacon-ls',
        },
      }

      require('lspconfig').rust_analyzer.setup {
        capabilities = capabilities,
        settings = {
          ['rust-analyzer'] = {
            checkOnSave = {
              enable = false,
            },
            diagnostics = {
              enable = false,
            },
          },
        },
      }

      require('lspconfig').bacon_ls.setup {
        capabilities = capabilities,
        autostart = true,
      }

      vim.lsp.inlay_hint.enable()
    end,
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
}
