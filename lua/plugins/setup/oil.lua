pcall(vim.cmd.packadd, "oil.nvim")

local ok, oil = pcall(require, "oil")
if not ok then
  return
end

local detail = false

oil.setup({
  default_file_explorer = true,
  columns = {
    "icon",
  },
  use_default_keymaps = true,
  keymaps = {
    ["gd"] = {
      desc = "Toggle file detail view",
      callback = function()
        detail = not detail
        if detail then
          oil.set_columns({ "icon", "permissions", "size", "mtime" })
        else
          oil.set_columns({ "icon" })
        end
      end,
    },
  },
  view_options = {
    show_hidden = false,
  },
})
