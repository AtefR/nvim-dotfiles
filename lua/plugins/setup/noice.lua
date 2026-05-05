pcall(vim.cmd.packadd, "nvim-notify")
pcall(vim.cmd.packadd, "noice.nvim")

local ok_notify, notify = pcall(require, "notify")
if ok_notify then
  notify.setup({
    stages = "fade",
    timeout = 3000,
    background_colour = "#000000",
  })
  vim.notify = notify
end

local ok_noice, noice = pcall(require, "noice")
if not ok_noice then
  return
end

noice.setup({
  cmdline = {
    enabled = true,
    view = "cmdline_popup",
  },
  messages = {
    enabled = true,
    view = "notify",
    view_error = "notify",
    view_warn = "notify",
    view_history = "messages",
    view_search = "virtualtext",
  },
  popupmenu = {
    enabled = true,
    backend = "nui",
  },
  notify = {
    enabled = true,
    view = "notify",
  },
  lsp = {
    progress = {
      enabled = true,
      view = "mini",
    },
    hover = {
      enabled = true,
    },
    signature = {
      enabled = true,
      auto_open = {
        enabled = true,
      },
    },
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  routes = {
    {
      filter = {
        event = "msg_show",
        any = {
          { find = "written" },
          { find = "%d+L, %d+B" },
        },
      },
      opts = { skip = true },
    },
  },
  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = true,
  },
})
