vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set this to false if you don't use a Nerd Font.
vim.g.have_nerd_font = true

require('vim._core.ui2').enable()

require('config.options')
require('config.diagnostics')
require('config.keymaps')
require('config.autocmds')
require('plugins.bootstrap')
