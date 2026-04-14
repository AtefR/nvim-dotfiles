pcall(vim.cmd.packadd, "nvim-lint")

local lint = require("lint")

lint.linters_by_ft = {
  php = { "phpstan" },
}

local function try_lint(bufnr)
  if vim.bo[bufnr].filetype ~= "php" then
    return
  end

  lint.try_lint(nil, { bufnr = bufnr })
end

vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("user-lint-run", { clear = true }),
  callback = function(args)
    try_lint(args.buf)
  end,
})

vim.keymap.set("n", "<leader>cp", function()
  try_lint(vim.api.nvim_get_current_buf())
end, { desc = "[C]ode PHPStan" })
