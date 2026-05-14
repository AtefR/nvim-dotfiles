pcall(vim.cmd.packadd, "windsurf.nvim")

local ok, codeium = pcall(require, "codeium")
if not ok then
  return
end

codeium.setup({
  enable_cmp_source = false,
  virtual_text = {
    enabled = true,
    map_keys = false,
    idle_delay = 120,
    filetypes = {
      TelescopePrompt = false,
      alpha = false,
      oil = false,
      help = false,
      markdown = false,
      text = false,
      gitcommit = false,
    },
  },
})

vim.keymap.set("i", "<C-l>", function()
  return require("codeium.virtual_text").accept()
end, { expr = true, silent = true, desc = "Windsurf accept" })

vim.keymap.set("i", "<M-]>", function()
  require("codeium.virtual_text").cycle_completions(1)
end, { silent = true, desc = "Windsurf next" })

vim.keymap.set("i", "<M-[>", function()
  require("codeium.virtual_text").cycle_completions(-1)
end, { silent = true, desc = "Windsurf prev" })

vim.keymap.set("i", "<C-]>", function()
  require("codeium.virtual_text").clear()
end, { silent = true, desc = "Windsurf clear" })
