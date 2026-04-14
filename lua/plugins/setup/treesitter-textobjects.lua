local configured = false

local function ensure_textobjects()
  if configured then
    return
  end

  require("plugins.setup.treesitter").ensure()
  pcall(vim.cmd.packadd, "nvim-treesitter-textobjects")

  require("nvim-treesitter-textobjects").setup({
    move = {
      enable = true,
      set_jumps = true,
    },
    select = {
      enable = true,
      lookahead = true,
    },
  })

  configured = true
end

local function with_select(capture)
  return function()
    ensure_textobjects()
    require("nvim-treesitter-textobjects.select").select_textobject(capture, "textobjects")
  end
end

local function with_move(method, capture)
  return function()
    ensure_textobjects()
    require("nvim-treesitter-textobjects.move")[method](capture, "textobjects")
  end
end

vim.keymap.set({ "x", "o" }, "af", with_select("@function.outer"), { desc = "Select around function" })
vim.keymap.set({ "x", "o" }, "if", with_select("@function.inner"), { desc = "Select inner function" })
vim.keymap.set({ "x", "o" }, "ac", with_select("@class.outer"), { desc = "Select around class" })
vim.keymap.set({ "x", "o" }, "ic", with_select("@class.inner"), { desc = "Select inner class" })

vim.keymap.set({ "n", "x", "o" }, "]f", with_move("goto_next_start", "@function.outer"), { desc = "Jump to next function" })
vim.keymap.set({ "n", "x", "o" }, "[f", with_move("goto_previous_start", "@function.outer"), { desc = "Jump to previous function" })
vim.keymap.set({ "n", "x", "o" }, "]c", with_move("goto_next_start", "@class.outer"), { desc = "Jump to next class" })
vim.keymap.set({ "n", "x", "o" }, "[c", with_move("goto_previous_start", "@class.outer"), { desc = "Jump to previous class" })

vim.keymap.set({ "n", "x" }, "<leader>ta", function()
  ensure_textobjects()
  local ok, ts_node_action = pcall(require, "ts-node-action")
  if ok then
    ts_node_action.node_action()
  end
end, { desc = "Treesitter: Trigger node action" })

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  group = vim.api.nvim_create_augroup("user-treesitter-textobjects-lazy", { clear = true }),
  once = true,
  callback = function()
    ensure_textobjects()
  end,
})

return {
  ensure = ensure_textobjects,
}
