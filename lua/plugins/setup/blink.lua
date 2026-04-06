require("luasnip").setup({})

require("blink.cmp").setup({
  keymap = {
    preset = "enter",
  },
  appearance = {
    nerd_font_variant = "mono",
  },
  completion = {
    -- accept = { auto_brackets = { enabled = false } },
    list = { selection = { preselect = false, auto_insert = true } },
    ghost_text = { enabled = true },
    keyword = { range = "full" },
    documentation = { auto_show = false, auto_show_delay_ms = 500 },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  snippets = { preset = "luasnip" },
  fuzzy = { implementation = "lua" },
  signature = { enabled = true },
})
