require("tabout").setup({
  tabkey = "<Tab>",
  backwards_tabkey = "<S-Tab>",
  act_as_tab = true,
  enable_leading = false,
  completion = false,
  ignore_beginning = true,
  indent_mappings = false,
})

vim.keymap.set({ "i", "v" }, "<Tab>", function()
  local success, tabout = pcall(require, "tabout.tabout")
  if success then
    return tabout.tabout()
  end
  return "<Tab>"
end, { expr = true })

vim.keymap.set({ "i", "v" }, "<S-Tab>", function()
  local success, tabout = pcall(require, "tabout.tabout")
  if success then
    return tabout.tabout_backwards()
  end
  return "<S-Tab>"
end, { expr = true })
