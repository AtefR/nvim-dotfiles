require("catppuccin").setup({
  flavour = "macchiato",
  integrations = {
    gitsigns = true,
    telescope = true,
    treesitter = true,
    mason = true,
    which_key = true,
    mini = true,
  },
})

vim.cmd.colorscheme("catppuccin-nvim")
