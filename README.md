# Neovim Config

Neovim configuration using vim.pack (0.12+).

## Requirements

- Neovim 0.12+
- npm (for intelephense, prettier)
- make (for telescope-fzf-native)

## Plugins

- **Completion**: Blink.cmp (with native fallback enabled)
- **UI**: Neo-tree, Telescope, mini.nvim, Todo Comments
- **LSP**: Mason + nvim-lspconfig
- **Formatting**: Conform.nvim (stylua, pint, blade-formatter, prettier)
- **Treesitter**: nvim-treesitter
- **Git**: Gitsigns

## Laravel

Laravel.nvim for enhanced Laravel development:

- `<leader>ll` - Laravel picker
- `<leader>la` - Artisan commands
- `<leader>lr` - Routes
- `<leader>lm` - Make commands
- `<leader>lh` - Docs

## Keymaps

- `<C-h/j/k/l>` - Navigate windows
- `<C-S-h/j/k/l>` - Move windows
- `<leader>e` - Toggle Neo-tree
- `<leader>f` - Format buffer

## Install

Start Neovim and plugins will install automatically via vim.pack.

## Update

Run `:UpdateRemotePlugins` after adding new LSP plugins.
