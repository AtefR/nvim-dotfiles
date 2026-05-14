local configured = false

local function ensure_markdown_plus()
  if configured then
    return
  end

  pcall(vim.cmd.packadd, "markdown-plus.nvim")

  local ok, markdown_plus = pcall(require, "markdown-plus")
  if not ok then
    return
  end

  markdown_plus.setup({
    keymaps = {
      enabled = true,
    },
    features = {
      html_block_awareness = true,
    },
    list = {
      smart_outdent = true,
    },
  })
  configured = true
end

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("user-markdown-plus-lazy", { clear = true }),
  pattern = { "markdown" },
  once = true,
  callback = function()
    ensure_markdown_plus()
  end,
})

return {
  ensure = ensure_markdown_plus,
}
