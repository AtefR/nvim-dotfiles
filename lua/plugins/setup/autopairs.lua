local ok, autopairs = pcall(require, 'nvim-autopairs')
if not ok then return end

autopairs.setup {
  check_ts = true,
  ts_config = {
    lua = { 'string' },
    javascript = { 'template_string' },
  },
}