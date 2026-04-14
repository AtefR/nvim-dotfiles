require("which-key").setup({
  delay = 0,
  icons = { mappings = vim.g.have_nerd_font },
  spec = {
    { "<leader>s", group = "[S]earch", mode = { "n", "v" } },
    { "<leader>t", group = "[T]oggle" },
    { "<leader>l", group = "[L]aravel", mode = { "n" } },
    { "gr", group = "LSP Actions", mode = { "n" } },
  },
})
