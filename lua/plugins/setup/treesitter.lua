local configured = false

local function ensure_treesitter()
  if configured then
    return
  end

  pcall(vim.cmd.packadd, "nvim-treesitter")

  require("nvim-treesitter").setup({
    ensure_installed = {
      "bash",
      "c",
      "diff",
      "html",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "query",
      "vim",
      "vimdoc",
    },
  })

  configured = true
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("user-treesitter-lazy", { clear = true }),
  once = true,
  callback = function()
    ensure_treesitter()
  end,
})

return {
  ensure = ensure_treesitter,
}
