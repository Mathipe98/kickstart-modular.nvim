local opt = vim.opt
local o = vim.o
local g = vim.g

vim.scriptencoding = 'utf-8'
o.encoding = 'utf-8'
o.fileencoding = 'utf-8'

o.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20'
o.number = true
o.relativenumber = true

o.title = true
o.titlelen = 0
o.titlestring = 'neovim %{getcwd()}'

o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.expandtab = true

o.smartindent = true
o.autoindent = true

o.wrap = true
o.breakindent = true
o.linebreak = true

o.swapfile = false
o.undofile = true

o.hlsearch = false
o.incsearch = true

o.termguicolors = true

o.scrolloff = 8
o.signcolumn = 'yes'
o.isfname = '@-@'

o.clipboard = 'unnamedplus'
opt.wildignore:append { '*/node_modules/*' }
o.updatetime = 50

o.conceallevel = 1

--opt.colorcolumn = "80"
g.mapleader = ' '

vim.filetype.add {
  pattern = {
    ['.*/sway/config.d/.*%.conf'] = 'swayconfig',
    ['.*/tmux/.*%.conf'] = 'tmux',
    ['.*/hypr/.*%.conf'] = 'hyprlang',
    ['.*/kitty/.*%.conf'] = 'kitty',
    ['.*/kitty.conf'] = 'kitty',
    ['.*%.resx'] = 'xml',
    ['.*.http'] = 'http',
    ['.*.zmk'] = 'dts',
    ['.*.dtsi.min'] = 'dts',
    ['.*.keymap'] = 'dts',
  },
  extension = {
    wofi = 'rasi',
  },
}

local severity = vim.diagnostic.severity

vim.diagnostic.config {
  severity_sort = true,
  virtual_text = { prefix = '' },
  signs = {
    text = {
      [severity.ERROR] = '󰅙',
      [severity.WARN] = '',
      [severity.INFO] = '󰋼',
      [severity.HINT] = '󰌵',
    },
  },
  underline = true,
  float = { border = 'single' },
  -- virtual_text = {
  -- 	prefix = function(diagnostic)
  -- 		return signs[vim.diagnostic.severity[diagnostic.severity]]
  -- 	end,
  --        severity = {
  --            min = vim.diagnostic.severity.HINT
  --        }
  -- },
}

vim.lsp.inlay_hint.enable(true)
vim.diagnostic.config {
  update_in_insert = true,
}
