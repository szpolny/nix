return {
  { 'L3MON4D3/LuaSnip', keys = {} },
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
    event = 'VimEnter',
    version = '*',
    build = 'cargo build --release',
    config = function()
      require('blink.cmp').setup {
        snippets = { preset = 'luasnip' },
        signature = { enabled = true },
        appearance = {
          nerd_font_variant = 'mono',
        },
        sources = {
          default = { 'lsp', 'path', 'snippets', 'lazydev', 'buffer' },
          providers = {
            lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
          },
        },
        keymap = {
          ['<C-f>'] = {},
        },

        completion = {
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
          },
        },

        fuzzy = { implementation = 'prefer_rust_with_warning' },
      }

      require('luasnip.loaders.from_vscode').lazy_load()
    end,
  },
}
