local servers = {
  lua_ls = {
    settings = {
      Lua = {},
    },
  },
  intelephense = {
    cmd = { "intelephense", "--stdio" },
    filetypes = { "php" },
    root_markers = { "artisan", "composer.json", ".git" },
    settings = {
      intelephense = {
        files = {
          maxSize = 2000000,
        },
      },
    },
  },
}

require("mason").setup({})
require("fidget").setup({})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      vim.keymap.set(mode or "n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    local builtin = require("telescope.builtin")

    map("grr", builtin.lsp_references, "[G]oto [R]eferences")
    map("gri", builtin.lsp_implementations, "[G]oto [I]mplementation")
    map("grd", builtin.lsp_definitions, "[G]oto [D]efinition")
    map("grt", builtin.lsp_type_definitions, "[G]oto [T]ype Definition")
    map("gO", builtin.lsp_document_symbols, "Open Document Symbols")
    map("gW", builtin.lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    map("<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
    map("gK", vim.lsp.buf.signature_help, "Signature Documentation")

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
      local highlight_group = vim.api.nvim_create_augroup("user-lsp-highlight", { clear = false })

      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_group,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_group,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("user-lsp-detach", { clear = true }),
        callback = function(detach_event)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = highlight_group, buffer = detach_event.buf })
        end,
      })
    end

    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
      end, "[T]oggle Inlay [H]ints")
    end
  end,
})

local ensure_installed = vim.tbl_keys(servers)
vim.list_extend(ensure_installed, {
  "stylua",
  "intelephense",
  "pint",
  "blade-formatter",
  "prettier",
})

require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
require("mason-lspconfig").setup({
  ensure_installed = {},
  automatic_enable = false,
})

for server_name, server in pairs(servers) do
  server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
end

for server_name, server in pairs(servers) do
  if server_name == "lua_ls" then
    server.settings = vim.tbl_deep_extend("force", server.settings or {}, {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
        workspace = {
          checkThirdParty = false,
          library = vim.tbl_extend("force", vim.api.nvim_get_runtime_file("", true), {
            "${3rd}/luv/library",
            "${3rd}/busted/library",
          }),
        },
      },
    })
  end

  if server_name == "intelephense" then
    server.on_init = function(client)
      client.config.settings.intelephense = vim.tbl_deep_extend("force", client.config.settings.intelephense or {}, {
        files = {
          maxSize = 5000000,
        },
      })
    end
  end

  if vim.lsp.config and vim.lsp.enable then
    vim.lsp.config(server_name, server)
    vim.lsp.enable(server_name)
  else
    require("lspconfig")[server_name].setup(server)
  end
end
