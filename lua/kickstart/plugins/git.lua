-- Here is a more advanced example where we pass configuration
-- options to `gitsigns.nvim`. This is equivalent to the following Lua:
--    require('gitsigns').setup({ ... })
--
-- See `:help gitsigns` to understand what the configuration keys do
return {
  -----------------------------------------------------------------------------
  -- Git signs written in pure lua
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git [c]hange' })

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git [c]hange' })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function()
          gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'stage git hunk' })
        map('v', '<leader>hr', function()
          gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'reset git hunk' })
        -- normal mode
        map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
        map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
        map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
        map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'git [u]ndo stage hunk' })
        map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
        map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
        map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
        map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
        map('n', '<leader>hD', function()
          gitsigns.diffthis '@'
        end, { desc = 'git [D]iff against last commit' })
        -- Toggles
        map('n', '<leader>htb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
        map('n', '<leader>htD', gitsigns.toggle_deleted, { desc = '[T]oggle git show [D]eleted' })
      end,
    },
  },

  -----------------------------------------------------------------------------
  -- Tabpage interface for cycling through diffs
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewFileHistory' },
    keys = {
      { '<Leader>gd', '<cmd>DiffviewFileHistory %<CR>', desc = 'Diff File' },
      { '<Leader>gv', '<cmd>DiffviewOpen<CR>', desc = 'Diff View' },
    },
    opts = function()
      local actions = require 'diffview.actions'
      vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
        group = vim.api.nvim_create_augroup('rafi_diffview', {}),
        pattern = 'diffview:///panels/*',
        callback = function()
          vim.opt_local.cursorline = true
          vim.opt_local.winhighlight = 'CursorLine:WildMenu'
        end,
      })

      return {
        enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
        keymaps = {
          view = {
            { 'n', 'q', actions.close },
            { 'n', '<Tab>', actions.select_next_entry },
            { 'n', '<S-Tab>', actions.select_prev_entry },
            { 'n', '<LocalLeader>a', actions.focus_files },
            { 'n', '<LocalLeader>e', actions.toggle_files },
          },
          file_panel = {
            { 'n', 'q', actions.close },
            { 'n', 'h', actions.prev_entry },
            { 'n', 'o', actions.focus_entry },
            { 'n', 'gf', actions.goto_file },
            { 'n', 'sg', actions.goto_file_split },
            { 'n', 'st', actions.goto_file_tab },
            { 'n', '<C-r>', actions.refresh_files },
            { 'n', '<LocalLeader>e', actions.toggle_files },
          },
          file_history_panel = {
            { 'n', 'q', '<cmd>DiffviewClose<CR>' },
            { 'n', 'o', actions.focus_entry },
            { 'n', 'O', actions.options },
          },
        },
      }
    end,
  },

  -----------------------------------------------------------------------------
  -- Magit clone for Neovim
  {
    'NeogitOrg/neogit',
    dependencies = {
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    cmd = 'Neogit',
    keys = {
      { '<Leader>mg', '<cmd>Neogit<CR>', desc = 'Neogit' },
    },
    -- See: https://github.com/TimUntersberger/neogit#configuration
    opts = {
      disable_signs = false,
      disable_context_highlighting = false,
      disable_commit_confirmation = false,
      signs = {
        section = { '>', 'v' },
        item = { '>', 'v' },
        hunk = { '', '' },
      },
      integrations = {
        diffview = true,
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
