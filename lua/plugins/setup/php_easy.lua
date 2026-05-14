pcall(vim.cmd.packadd, "php.easy.nvim")

local ok, php_easy = pcall(require, "php-easy-nvim")
if not ok then
  return
end

php_easy.setup({})

local group = vim.api.nvim_create_augroup("php-easy-keymaps", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "php",
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }

    vim.keymap.set("n", "-#", "<cmd>PHPEasyAttribute<cr>", opts)
    vim.keymap.set("n", "-b", "<cmd>PHPEasyDocBlock<cr>", opts)
    vim.keymap.set("n", "-r", "<cmd>PHPEasyReplica<cr>", opts)
    vim.keymap.set("n", "-c", "<cmd>PHPEasyCopy<cr>", opts)
    vim.keymap.set("n", "-d", "<cmd>PHPEasyDelete<cr>", opts)
    vim.keymap.set("n", "-uu", "<cmd>PHPEasyRemoveUnusedUses<cr>", opts)
    vim.keymap.set("n", "-e", "<cmd>PHPEasyExtends<cr>", opts)
    vim.keymap.set("n", "-i", "<cmd>PHPEasyImplements<cr>", opts)
    vim.keymap.set("n", "--i", "<cmd>PHPEasyInitInterface<cr>", opts)
    vim.keymap.set("n", "--c", "<cmd>PHPEasyInitClass<cr>", opts)
    vim.keymap.set("n", "--ac", "<cmd>PHPEasyInitAbstractClass<cr>", opts)
    vim.keymap.set("n", "--t", "<cmd>PHPEasyInitTrait<cr>", opts)
    vim.keymap.set("n", "--e", "<cmd>PHPEasyInitEnum<cr>", opts)
    vim.keymap.set({ "n", "v" }, "-c", "<cmd>PHPEasyAppendConstant<cr>", opts)
    vim.keymap.set({ "n", "v" }, "-p", "<cmd>PHPEasyAppendProperty<cr>", opts)
    vim.keymap.set({ "n", "v" }, "-m", "<cmd>PHPEasyAppendMethod<cr>", opts)
    vim.keymap.set("n", "__", "<cmd>PHPEasyAppendConstruct<cr>", opts)
    vim.keymap.set("n", "_i", "<cmd>PHPEasyAppendInvoke<cr>", opts)
    vim.keymap.set("n", "-a", "<cmd>PHPEasyAppendArgument<cr>", opts)
  end,
})
