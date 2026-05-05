pcall(vim.cmd.packadd, "nvim-lint")

local lint = require("lint")

local function resolve_phpstan_cmd(bufnr)
  local cwd = vim.fn.getcwd(-1, vim.fn.bufwinid(bufnr))
  local local_phpstan = vim.fs.joinpath(cwd, "vendor", "bin", "phpstan")

  if vim.fn.executable(local_phpstan) == 1 then
    return local_phpstan
  end

  if vim.fn.executable("phpstan") == 1 then
    return "phpstan"
  end

  return nil
end

if lint.linters.phpstan then
  lint.linters.phpstan.cmd = function(ctx)
    local bufnr = ctx and ctx.bufnr or vim.api.nvim_get_current_buf()
    return resolve_phpstan_cmd(bufnr)
  end
end

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
