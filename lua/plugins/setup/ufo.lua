pcall(vim.cmd.packadd, "promise-async")
pcall(vim.cmd.packadd, "nvim-ufo")

local ok, ufo = pcall(require, "ufo")
if not ok then
  return
end

ufo.setup()

vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
