pcall(vim.cmd.packadd, 'nui.nvim')
pcall(vim.cmd.packadd, 'neo-tree.nvim')

require('neo-tree').setup({
  close_if_last_window = true,
  popup_border_style = 'rounded',
  enable_git_status = true,
  enable_diagnostics = true,

  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = true,
      hide_by_name = {
        'node_modules',
        'vendor',
      },
    },
    follow_current_file = {
      enabled = true,
    },
  },

  window = {
    position = 'left',
    width = 32,
  },
})
