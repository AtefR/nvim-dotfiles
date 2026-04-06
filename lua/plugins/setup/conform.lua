require("conform").setup({
  notify_on_error = false,
  formatters_by_ft = {
    lua = { "stylua" },
    php = { "pint" },
    blade = { "blade-formatter" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    json = { "prettier" },
    html = { "prettier" },
    css = { "prettier" },
    scss = { "prettier" },
    markdown = { "prettier" },
    yaml = { "prettier" },
  },
})

vim.keymap.set("n", "<leader>f", function()
  require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "[F]ormat buffer" })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("user-conform-format", { clear = true }),
  callback = function(args)
    local disable_filetypes = { c = true, cpp = true }
    local filetype = vim.bo[args.buf].filetype

    if disable_filetypes[filetype] then
      return
    end

    require("conform").format({
      timeout_ms = 500,
      lsp_format = "fallback",
      bufnr = args.buf,
    })
  end,
})
