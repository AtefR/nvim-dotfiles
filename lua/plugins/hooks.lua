local group = vim.api.nvim_create_augroup("user-pack-hooks", { clear = true })

local function plugin_path(name)
  return vim.fs.joinpath(vim.fn.stdpath("data"), "site", "pack", "core", "opt", name)
end

vim.api.nvim_create_autocmd("PackChanged", {
  group = group,
  callback = function(ev)
    local name = ev.data.spec.name
    local kind = ev.data.kind

    if kind ~= "install" and kind ~= "update" then
      return
    end

    if name == "telescope-fzf-native.nvim" and vim.fn.executable("make") == 1 then
      vim.system({ "make" }, { cwd = plugin_path(name) }):wait()
      return
    end

    if name == "LuaSnip" and vim.fn.has("win32") == 0 and vim.fn.executable("make") == 1 then
      vim.system({ "make", "install_jsregexp" }, { cwd = plugin_path(name) }):wait()
      return
    end

    if name == "nvim-treesitter" then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end

      pcall(vim.cmd, "TSUpdate")
    end
  end,
})
