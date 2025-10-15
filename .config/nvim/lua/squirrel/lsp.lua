-- Language Server Protocol configuration
local on_attach = function(client, bufnr)
  --disable inline buffer errors
  vim.diagnostic.config({ virtual_text = false })
  require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)

  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>cn', vim.lsp.buf.rename, '[C]hange [N]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', function() require('telescope.builtin').lsp_definitions(require('telescope.themes').get_ivy()) end, '[g]oto [d]efinition')
  nmap('gr', function() require('telescope.builtin').lsp_references(require('telescope.themes').get_ivy()) end, '[g]oto [r]eferences')
  nmap('gi', function() require('telescope.builtin').lsp_implementations(require('telescope.themes').get_ivy()) end, '[g]oto [i]mplementation')
  nmap('<leader>D', function() require('telescope.builtin').lsp_type_definitions(require('telescope.themes').get_ivy()) end, 'Type [D]efinition')
  nmap('<leader>ss', function() require('telescope.builtin').lsp_document_symbols(require('telescope.themes').get_ivy()) end, 'Search [D]ocument [S]ymbols')
  nmap('<leader>sws', function() require('telescope.builtin').lsp_dynamic_workspace_symbols(require('telescope.themes').get_ivy()) end, '[S]earch [W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  -- nmap('<leader>wl', function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, '[W]orkspace [L]ist Folders')
  --  nmap('<leader>th', vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({})), '[t]oggle inlay [hint]')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

local servers = {
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      diagnostics = { disable = { 'missing-fields' } },
    },
  },
  cssls = {},
  html = {},
  roslyn = {},
  -- csharp_ls = {},
  jsonls = {},
  yamlls = {},
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'
local lspconfig = require("lspconfig")

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

for server_name, config in pairs(servers) do
  lspconfig[server_name].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = config.settings,
    filetypes = config.filetypes, -- optional
  }
end

local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

--csharp extended
require("csharpls_extended").buf_read_cmd_bind()

-- change filetype for razor based files
vim.api.nvim_command([[autocmd BufNewfile, BufRead *.cshtml set filetype=html.cshtml.razor]])
vim.api.nvim_command([[autocmd BufNewfile, BufRead *.razor set filetype=html.cshtml.razor]])
