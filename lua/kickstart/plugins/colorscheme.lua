return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    -- 'folke/tokyonight.nvim',
    'rktjmp/lush.nvim',
    'metalelf0/jellybeans-nvim',
    -- 'nyoom-engineering/oxocarbon.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      -- require('tokyonight').setup {
      --   styles = {
      --     comments = { italic = false }, -- Disable italics in comments
      --   },
      -- }

      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load
      -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
      -- vim.cmd.colorscheme 'tokyonight-night'
      -- vim.cmd.colorscheme 'oxocarbon'
      vim.cmd.colorscheme 'jellybeans-nvim'
      vim.opt.termguicolors = true

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
