local set = vim.keymap.set

set('v', 'J', ":m '>+1<CR>gv=gv")
set('v', 'K', ":m '<-2<CR>gv=gv")

set('n', 'J', 'mzJ`z')
set('n', '<C-d>', '<C-d>zz')
set('n', '<C-u>', '<C-u>zz')
set('n', 'n', 'nzzzv')
set('n', 'N', 'Nzzzv')

set('x', '<leader>p', '"_dP')

set('n', '<leader>y', '"+y')
set('v', '<leader>y', '"+y')
set('n', '<leader>Y', '"+Y')

set('n', '<leader>d', '"_d')
set('v', '<leader>d', '"_d')

set('n', '<C-k>', '<cmd>cnext<CR>zz')
set('n', '<C-j>', '<cmd>cprev<CR>zz')
set('n', '<leader>k', '<cmd>lnext<CR>zz')
set('n', '<leader>j', '<cmd>lprev<CR>zz')

-- NAVIGATING BUFFERS
set('n', '<A-,>', vim.cmd.bprevious)
set('n', '<A-.>', vim.cmd.bnext)
set('n', '<A-c>', vim.cmd.bd)
set('n', '<leader>bq', '<cmd>bp<bar>sp<bar>bn<bar>bd<CR>')
-- set('n', '<space>e', vim.diagnostic.open_float)
-- set('n', '[d', vim.diagnostic.goto_prev)
-- set('n', ']d', vim.diagnostic.goto_next)
-- set('n', '<space>q', vim.diagnostic.setloclist)

-- RESIZING SPLITS
set('n', '<A-a>', '<C-w>5<')
set('n', '<A-d>', '<C-w>5>')
set('n', '<A-s>', '<C-w>+')
set('n', '<A-w>', '<C-w>-')

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Neo-tree keybindings
set('n', '<C-n>', '<Cmd>Neotree toggle<CR>')
