pcall(vim.cmd.packadd, "trouble.nvim")

local ok, trouble = pcall(require, "trouble")
if not ok then
  return
end

trouble.setup({})

-- Disable Trouble's global main-window tracking hook (BufEnter/WinEnter).
-- It can trigger tab-number errors in some environments.
pcall(vim.api.nvim_clear_autocmds, { group = "trouble.main", event = "BufEnter" })
pcall(vim.api.nvim_clear_autocmds, { group = "trouble.main", event = "WinEnter" })

vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Trouble: Diagnostics" })
vim.keymap.set("n", "<leader>xw", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Trouble: Buffer diagnostics" })
vim.keymap.set("n", "<leader>xl", "<cmd>Trouble loclist toggle<cr>", { desc = "Trouble: Location list" })
vim.keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Trouble: Quickfix list" })
vim.keymap.set("n", "gR", "<cmd>Trouble lsp_references toggle<cr>", { desc = "Trouble: LSP references" })
