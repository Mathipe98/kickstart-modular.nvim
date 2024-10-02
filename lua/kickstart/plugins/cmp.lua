--return {
--  {
--    'hrsh7th/nvim-cmp',
--    event = 'InsertEnter',
--    dependencies = {
--      {
--        -- snippet plugin
--        'L3MON4D3/LuaSnip',
--        dependencies = 'rafamadriz/friendly-snippets',
--        opts = { history = true, updateevents = 'TextChanged,TextChangedI' },
--        config = function(_, opts)
--          require('luasnip').config.set_config(opts)
--          require 'nvchad.configs.luasnip'
--        end,
--      },
--
--      -- autopairing of (){}[] etc
--      {
--        'windwp/nvim-autopairs',
--        opts = {
--          fast_wrap = {},
--          disable_filetype = { 'TelescopePrompt', 'vim' },
--        },
--        config = function(_, opts)
--          require('nvim-autopairs').setup(opts)
--
--          -- setup cmp for autopairs
--          local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
--          require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
--        end,
--      },
--
--      -- cmp sources plugins
--      {
--        'saadparwaiz1/cmp_luasnip',
--        'hrsh7th/cmp-nvim-lua',
--        'hrsh7th/cmp-nvim-lsp',
--        'hrsh7th/cmp-buffer',
--        'hrsh7th/cmp-path',
--      },
--    },
--    opts = function()
--      return require 'nvchad.configs.cmp'
--    end,
--  },
--}
return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        -- snippet plugin
        'L3MON4D3/LuaSnip',
        dependencies = 'rafamadriz/friendly-snippets',
        opts = { history = true, updateevents = 'TextChanged,TextChangedI' },
        config = function(_, opts)
          require('luasnip').config.set_config(opts)
          require 'kickstart.plugins.luasnip'
        end,
      },

      -- autopairing of (){}[] etc
      {
        'windwp/nvim-autopairs',
        opts = {
          fast_wrap = {},
          disable_filetype = { 'TelescopePrompt', 'vim' },
        },
        config = function(_, opts)
          require('nvim-autopairs').setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
          require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
    },
    opts = function()
      -- Ensure the base46 cache file is loaded if it exists
      local path_to_cache_file = vim.g.base46_cache .. 'cmp'
      if vim.fn.filereadable(path_to_cache_file) == 1 then
        dofile(path_to_cache_file)
      end

      -- `cmp` and snippet expansion setup
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

      -- Main cmp options
      local options = {
        completion = { completeopt = 'menu,menuone' },

        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },

        mapping = {
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),

          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },

          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),

          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },

        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'nvim_lua' },
          { name = 'path' },
        },
      }

      -- Combine with nvchad configurations if needed
      local nvchad_cmp_config = require 'kickstart.plugins.cmp'
      return vim.tbl_deep_extend('force', options, nvchad_cmp_config)
    end,
  },
}
