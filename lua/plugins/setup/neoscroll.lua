require("neoscroll").setup({
  easing_function = "quadratic",
  cursor_scrolls_vertically = true,
  performance_mode = false,
  respect_scroll_time = false,
  stop_eof = true,
  hide_cursor = false,
  scroll_forward_keys = { "<C-d>", "<PageDown>", "j" },
  scroll_backward_keys = { "<C-u>", "<PageUp>", "k" },
})

vim.keymap.set({ "n", "v" }, "<C-u>", function()
  require("neoscroll").ctrl_u({ duration = 250, easing = "quadratic" })
end, { desc = "Scroll up" })
vim.keymap.set({ "n", "v" }, "<C-d>", function()
  require("neoscroll").ctrl_d({ duration = 250, easing = "quadratic" })
end, { desc = "Scroll down" })
vim.keymap.set({ "n", "v" }, "<C-b>", function()
  require("neoscroll").ctrl_b({ duration = 250, easing = "quadratic" })
end, { desc = "Scroll up (page)" })
vim.keymap.set({ "n", "v" }, "<C-f>", function()
  require("neoscroll").ctrl_f({ duration = 250, easing = "quadratic" })
end, { desc = "Scroll down (page)" })
vim.keymap.set({ "n", "v" }, "<C-y>", function()
  require("neoscroll").scroll(1, { duration = 250, easing = "quadratic" })
end, { desc = "Scroll up (line)" })
vim.keymap.set({ "n", "v" }, "<C-e>", function()
  require("neoscroll").scroll(-1, { duration = 250, easing = "quadratic" })
end, { desc = "Scroll down (line)" })
