pcall(vim.cmd.packadd, "alpha-nvim")

local dashboard = require("alpha.themes.dashboard")
local alpha = require("alpha")

local plugin_count = #require("plugins.specs")
local version = vim.version()

dashboard.section.header.val = {
  [[                                                     ]],
  [[  _   _                 _                            ]],
  [[ | \ | | ___  _____   _(_)_ __ ___                   ]],
  [[ |  \| |/ _ \/ _ \ \ / / | '_ ` _ \                  ]],
  [[ | |\  |  __/ (_) \ V /| | | | | | |                 ]],
  [[ |_| \_|\___|\___/ \_/ |_|_| |_| |_|                 ]],
  [[                                                     ]],
}

dashboard.section.buttons.val = {
  dashboard.button("e", "New file", "<cmd>ene <bar> startinsert<CR>"),
  dashboard.button(
    "SPC s f",
    "Find file",
    "<cmd>lua require('plugins.setup.telescope').ensure(); require('telescope.builtin').find_files()<CR>"
  ),
  dashboard.button(
    "SPC s .",
    "Recent files",
    "<cmd>lua require('plugins.setup.telescope').ensure(); require('telescope.builtin').oldfiles()<CR>"
  ),
  dashboard.button("SPC e", "Explorer", "<cmd>lua require('oil').toggle_float()<CR>"),
  dashboard.button(
    "SPC s n",
    "Config files",
    "<cmd>lua require('plugins.setup.telescope').ensure(); require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })<CR>"
  ),
  dashboard.button("q", "Quit", "<cmd>qa<CR>"),
}

dashboard.section.footer.val = string.format(
  "Neovim %d.%d.%d  |  %d plugins via vim.pack",
  version.major,
  version.minor,
  version.patch,
  plugin_count
)

dashboard.config.layout[1].val = 6
dashboard.config.opts.noautocmd = true
dashboard.config.opts.autostart = false

alpha.setup(dashboard.config)

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("user-alpha-start", { clear = true }),
  nested = true,
  once = true,
  callback = function()
    local argc = vim.fn.argc()
    if argc > 1 then
      return
    end

    if argc == 1 then
      local args = vim.v.argv or {}
      local last_arg = args[#args]
      if type(last_arg) ~= "string" or last_arg == "" then
        return
      end

      local stat = vim.uv.fs_stat(vim.fn.fnamemodify(last_arg, ":p"))
      if not stat or stat.type ~= "directory" then
        return
      end
    end

    if vim.bo.filetype ~= "alpha" then
      vim.cmd("silent! Alpha")
    end
  end,
})
