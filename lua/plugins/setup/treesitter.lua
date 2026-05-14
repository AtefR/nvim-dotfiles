local configured = false

local function ensure_treesitter()
  if configured then
    return
  end

  pcall(vim.cmd.packadd, "nvim-treesitter")

  local ts_ok, ts_configs = pcall(require, "nvim-treesitter.configs")
  if not ts_ok then
    local legacy_ok, legacy_ts = pcall(require, "nvim-treesitter")
    if not legacy_ok then
      return
    end
    ts_configs = legacy_ts
  end

  ts_configs.setup({
    ensure_installed = {
      "bash",
      "c",
      "diff",
      "html",
      "javascript",
      "lua",
      "luadoc",
      "markdown",
      "markdown_inline",
      "query",
      "tsx",
      "typescript",
      "vue",
      "vim",
      "vimdoc",
    },
    highlight = {
      enable = true,
    },
  })

  configured = true
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("user-treesitter-lazy", { clear = true }),
  once = true,
  callback = function()
    ensure_treesitter()
  end,
})

return {
  ensure = ensure_treesitter,
}
