local sev = vim.diagnostic.severity

vim.diagnostic.config({
  severity_sort = true,
  update_in_insert = false,
  float = {
    border = 'rounded',
    source = true,
  },
  signs = {
    text = {
      [sev.ERROR] = 'E',
      [sev.WARN]  = 'W',
      [sev.INFO]  = 'I',
      [sev.HINT]  = 'H',
    },
  },
  underline = {
    severity = {
      min = vim.diagnostic.severity.WARN,
    },
  },
  virtual_text = true,
  virtual_lines = false,
  jump = {
    on_jump = function(diagnostic, bufnr)
      if not diagnostic then return end
      vim.diagnostic.open_float(bufnr, {
        border = 'rounded',
        source = 'if_many',
        scope = 'line',
      })
    end,
  },
})