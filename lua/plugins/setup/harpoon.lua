local function setup_harpoon()
  local harpoon = require("harpoon")
  local telescope_ensure = require("plugins.setup.telescope").ensure

  harpoon:setup()

  local function toggle_telescope(harpoon_list)
    telescope_ensure()

    local file_paths = {}
    for _, item in ipairs(harpoon_list.items) do
      table.insert(file_paths, item.value)
    end

    local themes = require("telescope.themes")
    local builtin = require("telescope.builtin")

    local opts = themes.get_dropdown({
      prompt_title = "Harpoon",
    })

    opts.finder = require("telescope.finders").new_table({
      results = file_paths,
    })

    builtin.find_files(opts)
  end

  vim.keymap.set("n", "<leader>a", function()
    harpoon:list():add()
  end, { desc = "Add file to harpoon" })

  vim.keymap.set("n", "<leader>h", function()
    toggle_telescope(harpoon:list())
  end, { desc = "Toggle harpoon menu (telescope)" })

  vim.keymap.set("n", "<leader>1", function()
    harpoon:list():select(1)
  end, { desc = "Select harpoon 1" })

  vim.keymap.set("n", "<leader>2", function()
    harpoon:list():select(2)
  end, { desc = "Select harpoon 2" })

  vim.keymap.set("n", "<leader>3", function()
    harpoon:list():select(3)
  end, { desc = "Select harpoon 3" })

  vim.keymap.set("n", "<leader>4", function()
    harpoon:list():select(4)
  end, { desc = "Select harpoon 4" })

  vim.keymap.set("n", "<leader>ac", function()
    local list = harpoon:list()
    list:clear()
  end, { desc = "Clear all harpoon marks" })
end

setup_harpoon()

