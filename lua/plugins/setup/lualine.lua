require("lualine").setup({
  options = {
    theme = "auto",
    globalstatus = true,
    disabled_filetypes = { "alpha", "starter" },
    component_separators = "",
    section_separators = "",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = {
      {
        "diagnostics",
        symbols = {
          error = "E",
          warn = "W",
          info = "I",
          hint = "H",
        },
      },
      { "filetype", icon_only = true, separator = "" },
      { "filename", path_separators = "" },
    },
    lualine_x = {
      {
        function()
          local ok, diagnostics = pcall(vim.diagnostic.get, 0)
          if ok then
            local errors = 0
            local warnings = 0
            for _, d in ipairs(diagnostics) do
              if d.severity == vim.diagnostic.severity.ERROR then
                errors = errors + 1
              elseif d.severity == vim.diagnostic.severity.WARN then
                warnings = warnings + 1
              end
            end
            if errors > 0 or warnings > 0 then
              return string.format("E%d W%d", errors, warnings)
            end
          end
          return ""
        end,
      },
      { "diff" },
      { "searchcount" },
    },
    lualine_y = {
      { "progress", separator = " " },
      {
        function()
          local ok, laravel = pcall(function()
            return require("laravel")
          end)
          if ok then
            local status_ok, status = pcall(function()
              return laravel.app("status"):get("laravel")
            end)
            if status_ok and status then
              return " Laravel " .. status
            end
          end
          return ""
        end,
        color = { fg = "#F55247" },
      },
      {
        function()
          local ok, laravel = pcall(function()
            return require("laravel")
          end)
          if ok then
            local status_ok, status = pcall(function()
              return laravel.app("status"):get("php")
            end)
            if status_ok and status then
              return " PHP " .. status
            end
          end
          return ""
        end,
        color = { fg = "#AEB2D5" },
      },
    },
    lualine_z = {
      { "location" },
      -- { "windows", show_filename_only = true },
      {
        function()
          local count = #vim.lsp.get_clients()
          if count > 0 then
            return " LSP " .. count
          end
          return ""
        end,
      },
    },
  },
  inactive_sections = {
    lualine_c = { "filename" },
    lualine_x = { "location" },
  },
  extensions = { "neo-tree", "lazy" },
})
