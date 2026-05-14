require("plugins.hooks")
vim.pack.add(require("plugins.specs"))

require("plugins.setup.colorscheme")
require("plugins.setup.ghostty_progress")
require("plugins.setup.noice")
require("plugins.setup.alpha")
require("plugins.setup.opencode")
require("plugins.setup.guess_indent")
require("plugins.setup.gitsigns")
require("plugins.setup.which_key")
require("plugins.setup.telescope")
require("plugins.setup.lsp")
require("plugins.setup.lint")
require("plugins.setup.conform")
require("plugins.setup.blink")
require("plugins.setup.treesitter")
require("plugins.setup.treesitter-textobjects")
require("plugins.setup.oil")
require("plugins.setup.web_devicons")

vim.api.nvim_create_autocmd("InsertEnter", {
  group = vim.api.nvim_create_augroup("user-defer-windsurf", { clear = true }),
  once = true,
  callback = function()
    require("plugins.setup.windsurf")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("user-defer-laravel-php", { clear = true }),
  pattern = { "php" },
  once = true,
  callback = function()
    require("plugins.setup.laravel")
    require("plugins.setup.php_easy")
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("user-deferred-plugin-setup", { clear = true }),
  once = true,
  callback = function()
    vim.schedule(function()
      require("plugins.setup.todo_comments")
      require("plugins.setup.trouble")
      require("plugins.setup.markdown_plus")
      require("plugins.setup.fugitive")
      require("plugins.setup.neogen")
      require("plugins.setup.ufo")
      require("plugins.setup.mini")
      require("plugins.setup.lualine")
      require("plugins.setup.autopairs")
      require("plugins.setup.neoscroll")
      require("plugins.setup.harpoon")
      require("plugins.setup.tabout")
    end)
  end,
})
