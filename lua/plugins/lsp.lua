return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
      { 'lbrayner/vim-rzip' },
      {
        'Hoffs/omnisharp-extended-lsp.nvim',
      },
      {
        'Decodetalkers/csharpls-extended-lsp.nvim',
      },
      {
        'b0o/schemastore.nvim',
      },
      { 'hrsh7th/cmp-nvim-lsp' },
      {
        'williamboman/mason.nvim',
        dependencies = {
          'williamboman/mason-lspconfig.nvim',
        },
      },
    },
    config = function()
      require 'custom.lsp'
    end,
    opts = { inlay_hints = { enabled = true } },
  },

  -- Rust things
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false,
  },
  {
    'saecki/crates.nvim',
    event = { 'BufRead Cargo.toml' },
    config = function()
      require('crates').setup()
    end,
  },

  -- TypeScript things
  -- {
  -- 	"pmizio/typescript-tools.nvim",
  -- 	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  -- 	config = function()
  -- 		require("typescript-tools").setup({
  -- 			single_file_support = false,
  -- 			root_dir = require("lspconfig.util").root_pattern(".git"),
  -- 		})
  -- 	end,
  -- },

  -- Lua things
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        { path = 'dapui' },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true }, -- optional `vim.uv` typings
}
