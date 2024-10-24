return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    -- "folke/tokyonight.nvim",
    'marko-cerovac/material.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('lualine').setup {
      options = {
        theme = 'marko-cerovac/material.nvim',
      },
      sections = {
        lualine_b = { 'diagnostics' },
        lualine_x = { 'filetype' },
        lualine_y = {},
      },
    }
  end,
}
