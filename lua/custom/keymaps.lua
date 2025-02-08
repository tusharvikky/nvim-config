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

-- Select all
Map('n', '<C-a>', 'gg<S-v>G')

-- Disable continuations
Map('n', '<Leader>o', 'o<Esc>^Da', { desc = 'Insert new line below' }) -- Inserts new line below the current line and sets insert mode
Map('n', '<Leader>O', 'O<Esc>^Da', { desc = 'Insert new line above' }) -- Inserts new line above the current line and sets insert mode
-- nvim-comment
Map({ 'n', 'v' }, '<leader>/', ':CommentToggle<cr>', { desc = 'Comment Toggle anything' })

-- Move current line/block down/up using Alt+j/k
Map('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move current line/block down' })
Map('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move current line/block up' })

-- For visual mode (selecting lines)
Map('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move current line/block down' })
Map('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move current line/block up' })

-- Better movement key to shift text left and right
Map('v', '<', '<gv', { desc = 'Intending lines left' })
Map('v', '>', '>gv', { desc = 'Intending lines right' })

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
Map('n', '<tab>', ':tabnext<Return>')
Map('n', '<s-tab>', ':tabprev<Return>')

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
-- vim: ts=2 sts=2 sw=2 et