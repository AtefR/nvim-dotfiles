local parsers = {
  'bash',
  'c',
  'diff',
  'html',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'query',
  'vim',
  'vimdoc',
}

require('nvim-treesitter').install(parsers)

local function treesitter_try_attach(buf, language)
  if not vim.treesitter.language.add(language) then
    return
  end

  vim.treesitter.start(buf, language)
  vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
end

local available_parsers = require('nvim-treesitter').get_available()

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('user-treesitter-filetype', { clear = true }),
  callback = function(args)
    local buf = args.buf
    local filetype = args.match
    local language = vim.treesitter.language.get_lang(filetype) or filetype

    local installed = require('nvim-treesitter').get_installed 'parsers'

    if vim.tbl_contains(installed, language) then
      treesitter_try_attach(buf, language)
    elseif vim.tbl_contains(available_parsers, language) then
      require('nvim-treesitter').install(language):await(function()
        treesitter_try_attach(buf, language)
      end)
    else
      treesitter_try_attach(buf, language)
    end
  end,
})
