pcall(vim.cmd.packadd, "nvim-nio")
pcall(vim.cmd.packadd, "laravel.nvim")

local ok_nio = pcall(require, "nio")
if not ok_nio then
  return
end

local ok, laravel = pcall(require, "laravel")
if not ok then
  return
end

laravel.setup({
  features = {
    pickers = {
      provider = "telescope",
    },
  },
})

vim.g.Laravel = laravel

local function map(lhs, fn, desc, opts)
  vim.keymap.set("n", lhs, fn, vim.tbl_extend("keep", opts or {}, { desc = desc }))
end

map("<leader>ll", function() Laravel.pickers.laravel() end, "Laravel: Open Laravel Picker")
map("<leader>la", function() Laravel.pickers.artisan() end, "Laravel: Open Artisan Picker")
map("<leader>lr", function() Laravel.pickers.routes() end, "Laravel: Open Routes Picker")
map("<leader>lm", function() Laravel.pickers.make() end, "Laravel: Open Make Picker")
map("<leader>lc", function() Laravel.pickers.commands() end, "Laravel: Open Commands Picker")
map("<leader>lo", function() Laravel.pickers.resources() end, "Laravel: Open Resources Picker")
map("<leader>lt", function() Laravel.commands.run("actions") end, "Laravel: Open Actions Picker")
map("<leader>lu", function() Laravel.commands.run("hub") end, "Laravel Artisan hub")
map("<leader>lh", function() Laravel.run("artisan docs") end, "Laravel: Open Documentation")
map("<c-g>", function() Laravel.commands.run("view:finder") end, "Laravel: Open View Finder")
map("<leader>lp", function() Laravel.commands.run("command_center") end, "Laravel: Open Command Center")

map("gf", function()
  local ok, res = pcall(function()
    if Laravel.app("gf").cursorOnResource() then
      return "<cmd>lua Laravel.commands.run('gf')<cr>"
    end
  end)
  if not ok or not res then
    return "gf"
  end
  return res
end, "Laravel: Go to resource", { expr = true, noremap = true })
