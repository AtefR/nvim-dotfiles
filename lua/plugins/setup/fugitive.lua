pcall(vim.cmd.packadd, "vim-fugitive")

vim.keymap.set("n", "<leader>gs", "<cmd>Git<cr>", { desc = "Git status (fugitive)" })
vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<cr>", { desc = "Git blame" })
vim.keymap.set("n", "<leader>gd", "<cmd>Gvdiffsplit<cr>", { desc = "Git diff split" })
vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<cr>", { desc = "Git commit" })

local group = vim.api.nvim_create_augroup("user-fugitive-maps", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "fugitive",
  callback = function(ev)
    local map = function(lhs, rhs, desc)
      vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, remap = false, silent = true, desc = desc })
    end

    map("<leader>gp", "<cmd>Git push<cr>", "Git push")
    map("<leader>gP", "<cmd>Git pull --rebase<cr>", "Git pull --rebase")
  end,
})
