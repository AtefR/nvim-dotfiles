pcall(vim.cmd.packadd, "opencode.nvim")

local ok, opencode = pcall(require, "opencode")
if not ok then
  return
end

vim.g.opencode_opts = vim.g.opencode_opts or {}
vim.o.autoread = true

vim.keymap.set({ "n", "x" }, "<leader>oa", function()
  opencode.ask("@this: ", { submit = true })
end, { desc = "Opencode ask" })

vim.keymap.set({ "n", "x" }, "<leader>os", function()
  opencode.select()
end, { desc = "Opencode select action" })

vim.keymap.set({ "n", "t" }, "<leader>ot", function()
  opencode.toggle()
end, { desc = "Opencode toggle" })

vim.keymap.set({ "n", "x" }, "<leader>or", function()
  return opencode.operator("@this ")
end, { expr = true, desc = "Opencode add range" })

vim.keymap.set("n", "<leader>ol", function()
  return opencode.operator("@this ") .. "_"
end, { expr = true, desc = "Opencode add line" })
