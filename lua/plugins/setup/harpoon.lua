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
    local actions = require("telescope.actions")

    local opts = themes.get_dropdown({
      prompt_title = "Harpoon",
    })

    opts.finder = require("telescope.finders").new_table({
      results = file_paths,
    })

    opts.attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = require("telescope.actions.state").get_selected_entry()
        local idx = 1
        for i, v in ipairs(harpoon_list.items) do
          if v.value == selection.path then
            idx = i
            break
          end
        end
        harpoon_list:select(idx)
      end)

      vim.keymap.set("i", "<C-o>", function()
        local selection = require("telescope.actions.state").get_selected_entry()
        local idx = 1
        for i, v in ipairs(harpoon_list.items) do
          if v.value == selection.path then
            idx = i
            break
          end
        end
        harpoon_list:remove_at(idx)
        vim.cmd("telescope_picker_restart!")
      end, { buffer = prompt_bufnr })

      return true
    end

    builtin.find_files(opts)
  end

  vim.keymap.set("n", "<leader>a", function()
    harpoon:list():add()
  end, { desc = "Add file to harpoon" })

  vim.keymap.set("n", "<leader>h", function()
    toggle_telescope(harpoon:list())
  end, { desc = "Toggle harpoon menu (telescope)" })

  vim.keymap.set("n", "<C-e>", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
  end, { desc = "Toggle harpoon menu" })

  vim.keymap.set("n", "<C-h>", function()
    harpoon:list():select(1)
  end, { desc = "Select harpoon 1" })

  vim.keymap.set("n", "<C-j>", function()
    harpoon:list():select(2)
  end, { desc = "Select harpoon 2" })

  vim.keymap.set("n", "<C-k>", function()
    harpoon:list():select(3)
  end, { desc = "Select harpoon 3" })

  vim.keymap.set("n", "<C-l>", function()
    harpoon:list():select(4)
  end, { desc = "Select harpoon 4" })

  vim.keymap.set("n", "<leader>hc", function()
    local list = harpoon:list()
    list:clear()
  end, { desc = "Clear all harpoon marks" })
end

setup_harpoon()

