pcall(vim.cmd.packadd, "neogen")

local ok, neogen = pcall(require, "neogen")
if not ok then
  return
end

neogen.setup({})

vim.keymap.set("n", "<leader>nf", function()
  neogen.generate({ type = "func" })
end, { desc = "Neogen: Function annotation" })

vim.keymap.set("n", "<leader>nc", function()
  neogen.generate({ type = "class" })
end, { desc = "Neogen: Class annotation" })

vim.keymap.set("n", "<leader>nt", function()
  neogen.generate({ type = "type" })
end, { desc = "Neogen: Type annotation" })
