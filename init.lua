vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set this to false if you don't use a Nerd Font.
vim.g.have_nerd_font = true

require('config.options')
require('config.diagnostics')
require('config.keymaps')
require('config.autocmds')
require('plugins.bootstrap')
