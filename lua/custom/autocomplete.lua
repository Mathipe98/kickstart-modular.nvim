local cmp = require 'cmp'
local luasnip = require 'luasnip'
local cmp_autopairs = require 'nvim-autopairs.completion.cmp'

require('luasnip.loaders.from_vscode').lazy_load()

local function border(hl_name)
  return {
    { '╭', hl_name },
    { '─', hl_name },
    { '╮', hl_name },
    { '│', hl_name },
    { '╯', hl_name },
    { '─', hl_name },
    { '╰', hl_name },
    { '│', hl_name },
  }
end

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup {
  completion = {
    completeopt = 'menu,menuone,noinsert',
  },
  -- window = {
  -- documentation = {
  -- 	border = border("CmpDocBorder"),
  -- },
  -- completion = {
  -- 	side_padding = 0,
  -- 	winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None",
  -- 	scrollbar = false,
  -- },
  -- },
  formatting = {
    format = function(entry, item)
      local icons = require 'custom.icons.lspkind'
      if icons[item.kind] then
        item.kind = icons[item.kind] .. item.kind
      end

      local widths = {
        abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
        menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
      }

      for key, width in pairs(widths) do
        if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
          item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. '…'
        end
      end

      return item
    end,
  },
  -- formatting = {
  -- 	fields = { "abbr", "kind", "menu" },
  --
  -- 	format = function(_, item)
  -- 		local icons = require("custom.icons.lspkind")
  -- 		local icon = icons[item.kind] or ""
  --
  -- 		icon = (" " .. icon .. " ")
  -- 		item.kind = string.format("%s %s", icon, item.kind)
  --
  -- 		return item
  -- 	end,
  -- },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  preselect = cmp.PreselectMode.Item,
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),

    ['<CR>'] = cmp.mapping.confirm {
      select = true,
    },

    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item(cmp_select)
      elseif require('luasnip').expand_or_jumpable() then
        require('luasnip').expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(cmp_select)
      elseif require('luasnip').jumpable(-1) then
        require('luasnip').jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'copilot' },
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'nvim_lsp_signature_help' },
  },
}

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  },
})

-- require("luasnip.loaders.from_vscode").lazy_load()

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  }),
})
