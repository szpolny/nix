return {
  {
    'gambhirsharma/vesper.nvim',
    name = 'vesper',
    config = function()
      -- vim.cmd [[colorscheme vesper]]
    end,
  },
  {
    'rebelot/kanagawa.nvim',
  },
  { 'savq/melange-nvim' },
  { 'vague2k/vague.nvim', opts = {} },
  {
    'sainnhe/gruvbox-material',
    enabled = true,
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_foreground = 'mix'
      vim.g.gruvbox_material_ui_contrast = 'hard'
      vim.g.gruvbox_material_float_style = 'bright'
      vim.g.gruvbox_material_statusline_style = 'material'

      vim.g.gruvbox_material_better_performance = 1

      vim.cmd.colorscheme 'gruvbox-material'
    end,
  },
}
