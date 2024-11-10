-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

function Map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  mode = mode or 'n'
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end
local opts = { noremap = true, silent = true }

--  See `:help hlsearch`
Map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear highlights' })

-- Diagnostic keymaps
Map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
Map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- Map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- Map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- Map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- Map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
Map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
Map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
Map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
Map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Select all
Map('n', '<C-a>', 'gg<S-v>G')

-- Disable continuations
Map('n', '<Leader>o', 'o<Esc>^Da', { noremap = true, silent = true, desc = 'Insert new line below' }) -- Inserts new line below the current line and sets insert mode
Map('n', '<Leader>O', 'O<Esc>^Da', { noremap = true, silent = true, desc = 'Insert new line above' }) -- Inserts new line above the current line and sets insert mode
-- nvim-comment
Map({ 'n', 'v' }, '<leader>/', ':CommentToggle<cr>', { desc = 'Comment Toggle anything' })

-- Move current line/block down/up using Alt+j/k
Map('n', '<A-j>', ':m .+1<CR>==', { noremap = true, silent = true, desc = 'Move current line/block down' })
Map('n', '<A-k>', ':m .-2<CR>==', { noremap = true, silent = true, desc = 'Move current line/block up' })

-- For visual mode (selecting lines)
Map('v', '<A-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = 'Move current line/block down' })
Map('v', '<A-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = 'Move current line/block up' })

-- [[ File Explorer ]]

Map('n', '<leader>e', function()
  if vim.api.nvim_buf_get_option(0, 'filetype') == 'netrw' then
    vim.cmd 'bprev' -- Switch back to previous buffer
  else
    vim.cmd 'Explore' -- Open file explorer
  end
end, { desc = 'Toggle File Explorer' })
-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- window management
-- New tab
Map('n', 'te', ':tabedit<Return>')
Map('n', '<tab>', ':tabnext<Return>', opts)
Map('n', '<s-tab>', ':tabprev<Return>', opts)

-- Resize window
Map('n', '<C-w><left>', '<C-w><')
Map('n', '<C-w><right>', '<C-w>>')
Map('n', '<C-w><up>', '<C-w>+')
Map('n', '<C-w><down>', '<C-w>-')

Map('n', '<leader>to', '<cmd>tabnew<CR>', { desc = 'Open new tab' }) -- open new tab
Map('n', '<leader>tx', '<cmd>tabclose<CR>', { desc = 'Close current tab' }) -- close current tab
Map('n', '<leader>tn', '<cmd>tabn<CR>', { desc = 'Go to next tab' }) --  go to next tab
Map('n', '<leader>tp', '<cmd>tabp<CR>', { desc = 'Go to previous tab' }) --  go to previous tab
Map('n', '<leader>tf', '<cmd>tabnew %<CR>', { desc = 'Open current buffer in new tab' }) --  move current buffer to new tab

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

-- vim: ts=2 sts=2 sw=2 et
