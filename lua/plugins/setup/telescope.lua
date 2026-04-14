local configured = false

local function ensure_telescope()
  if configured then
    return
  end

  pcall(vim.cmd.packadd, "plenary.nvim")
  pcall(vim.cmd.packadd, "telescope.nvim")
  pcall(vim.cmd.packadd, "telescope-ui-select.nvim")
  pcall(vim.cmd.packadd, "telescope-fzf-native.nvim")

  local telescope = require("telescope")
  local themes = require("telescope.themes")

  telescope.setup({
    defaults = {
      mappings = {
        n = {
          ["<Esc>"] = "close",
          ["q"] = "close",
        },
        i = {
          ["<Esc>"] = "close",
          ["<C-c>"] = "close",
        },
      },
    },
    extensions = {
      ["ui-select"] = { themes.get_dropdown() },
    },
  })

  pcall(telescope.load_extension, "fzf")
  pcall(telescope.load_extension, "ui-select")

  configured = true
end

local function with_builtin(fn)
  return function()
    ensure_telescope()
    return require("telescope.builtin")[fn]()
  end
end

vim.keymap.set("n", "<leader>sh", with_builtin("help_tags"), { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", with_builtin("keymaps"), { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sf", with_builtin("find_files"), { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>ss", with_builtin("builtin"), { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set({ "n", "v" }, "<leader>sw", with_builtin("grep_string"), { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", with_builtin("live_grep"), { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", with_builtin("diagnostics"), { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", with_builtin("resume"), { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", with_builtin("oldfiles"), { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader>sc", with_builtin("commands"), { desc = "[S]earch [C]ommands" })
vim.keymap.set("n", "<leader><leader>", with_builtin("buffers"), { desc = "[ ] Find existing buffers" })

vim.keymap.set("n", "<leader>/", function()
  ensure_telescope()
  local builtin = require("telescope.builtin")
  local themes = require("telescope.themes")

  builtin.current_buffer_fuzzy_find(themes.get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>s/", function()
  ensure_telescope()
  require("telescope.builtin").live_grep({
    grep_open_files = true,
    prompt_title = "Live Grep in Open Files",
  })
end, { desc = "[S]earch [/] in Open Files" })

vim.keymap.set("n", "<leader>sn", function()
  ensure_telescope()
  require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })

return {
  ensure = ensure_telescope,
}
