require('nvim-treesitter-textobjects').setup {
  move = {
    enable = true,
    set_jumps = true,
  },
  select = {
    enable = true,
    lookahead = true,
  },
}

local ts_textobjects = require('nvim-treesitter-textobjects.select')

vim.keymap.set({ 'x', 'o' }, 'af', function()
  ts_textobjects.select_textobject('@function.outer', 'textobjects')
end, { desc = 'Select around function' })

vim.keymap.set({ 'x', 'o' }, 'if', function()
  ts_textobjects.select_textobject('@function.inner', 'textobjects')
end, { desc = 'Select inner function' })

vim.keymap.set({ 'x', 'o' }, 'ac', function()
  ts_textobjects.select_textobject('@class.outer', 'textobjects')
end, { desc = 'Select around class' })

vim.keymap.set({ 'x', 'o' }, 'ic', function()
  ts_textobjects.select_textobject('@class.inner', 'textobjects')
end, { desc = 'Select inner class' })

local ts_move = require('nvim-treesitter-textobjects.move')

vim.keymap.set({ 'n', 'x', 'o' }, ']f', function()
  ts_move.goto_next_start('@function.outer', 'textobjects')
end, { desc = 'Jump to next function' })

vim.keymap.set({ 'n', 'x', 'o' }, '[f', function()
  ts_move.goto_previous_start('@function.outer', 'textobjects')
end, { desc = 'Jump to previous function' })

vim.keymap.set({ 'n', 'x', 'o' }, ']c', function()
  ts_move.goto_next_start('@class.outer', 'textobjects')
end, { desc = 'Jump to next class' })

vim.keymap.set({ 'n', 'x', 'o' }, '[c', function()
  ts_move.goto_previous_start('@class.outer', 'textobjects')
end, { desc = 'Jump to previous class' })

local ok, ts_node_action = pcall(require, 'ts-node-action')
if ok then
  vim.keymap.set({ 'n', 'x' }, '<leader>ta', function()
    ts_node_action.node_action()
  end, { desc = 'Treesitter: Trigger node action' })
end