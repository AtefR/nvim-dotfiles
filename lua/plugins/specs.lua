local gh = function(repo)
  return "https://github.com/" .. repo
end

local specs = {
  { src = gh("NMAC427/guess-indent.nvim") },
  { src = gh("lewis6991/gitsigns.nvim") },
  { src = gh("folke/which-key.nvim") },
  { src = gh("nvim-lua/plenary.nvim") },
  { src = gh("MunifTanjim/nui.nvim") },
  { src = gh("nvim-neo-tree/neo-tree.nvim"), version = vim.version.range("3") },
  { src = gh("nvim-telescope/telescope.nvim") },
  { src = gh("nvim-telescope/telescope-ui-select.nvim") },
  { src = gh("neovim/nvim-lspconfig") },
  { src = gh("mason-org/mason.nvim") },
  { src = gh("mason-org/mason-lspconfig.nvim") },
  { src = gh("WhoIsSethDaniel/mason-tool-installer.nvim") },
  { src = gh("j-hui/fidget.nvim") },
  { src = gh("stevearc/conform.nvim") },
  { src = gh("saghen/blink.cmp"), version = vim.version.range("1") },
  { src = gh("L3MON4D3/LuaSnip"), version = vim.version.range("2") },
  { src = gh("catppuccin/nvim") },
  { src = gh("folke/todo-comments.nvim") },
  { src = gh("nvim-mini/mini.nvim") },
  { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
  { src = gh("nvim-neotest/nvim-nio") },
  { src = gh("adalessa/laravel.nvim") },
  { src = gh("windwp/nvim-autopairs") },
}

if vim.fn.executable("make") == 1 then
  table.insert(specs, { src = gh("nvim-telescope/telescope-fzf-native.nvim") })
end

if vim.g.have_nerd_font then
  table.insert(specs, { src = gh("nvim-tree/nvim-web-devicons") })
end

return specs
