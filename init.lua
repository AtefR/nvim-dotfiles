vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set this to false if you don't use a Nerd Font.
vim.g.have_nerd_font = true

require('config.options')
require('config.diagnostics')
require('config.keymaps')
require('config.autocmds')
require('plugins.bootstrap')
