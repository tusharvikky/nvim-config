return -- Save and load buffers (a session) automatically for each folder
{
  'rmagatti/auto-session',
  config = function()
    require('auto-session').setup {
      log_level = 'error',
      auto_session_suppress_dirs = { '~/', '~/Downloads' },
    }
  end,
}
