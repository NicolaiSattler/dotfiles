return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    -- { "j-hui/fidget.nvim", opts = {} },
    "saghen/blink.cmp",
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("gd", function()
          vim.lsp.buf.definition()
        end, "[g]oto [d]efinition")
        map("gr", function()
          vim.lsp.buf.references()
        end, "[g]oto [r]eferences")
        map("gi", function()
          vim.lsp.buf.implementation()
        end, "[g]oto [i]mplementation")
        map("gD", function()
          vim.lsp.buf.type_definition()
        end, "[g]oto Type [D]efinition")
        map("<leader>sws", function()
          vim.lsp.buf.workspace_symbol()
        end, "[S]earch [W]orkspace [S]ymbols")

        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", "n")
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", "x")

        map("<leader>cn", vim.lsp.buf.rename, "[C]hange [N]ame")

        -- See `:help K` for why this keymap
        map("K", vim.lsp.buf.hover, "Hover Documentation")
        map("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

        -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
        ---@param client vim.lsp.Client
        ---@param method vim.lsp.protocol.Method
        ---@param bufnr? integer some lsp support methods only in specific files
        ---@return boolean
        local function client_supports_method(client, method, bufnr)
          if vim.fn.has("nvim-0.11") == 1 then
            return client:supports_method(method, bufnr)
          else
            return client.supports_method(method, { bufnr = bufnr })
          end
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if
          client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
        then
          local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
            end,
          })
        end

        do
          local codelens = vim.lsp.codelens
          local Provider

          for i = 1, 20 do
            local name, value = debug.getupvalue(codelens.get, i)

            if not name then
              break
            end

            if name == "Provider" then
              Provider = value
              break
            end
          end

          assert(Provider, "Could not find vim.lsp.codelens Provider")

          if not Provider._indent_alignment_patched then
            local original_on_win = Provider.on_win

            Provider.on_win = function(self, toprow, botrow)
              local original_range_lsp = vim.range.lsp

              -- codelens.on_win() uses range.start_col as the amount of
              -- padding before the virtual-line text. Replace that value
              -- with the indentation width of the actual source line.
              vim.range.lsp = function(bufnr, lsp_range, encoding)
                local range = original_range_lsp(bufnr, lsp_range, encoding)

                local row = lsp_range.start.line
                local line = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false)[1] or ""

                local indent = line:match("^%s*") or ""

                range.start_col = vim.fn.strdisplaywidth(indent)

                return range
              end

              -- Make sure vim.range.lsp is restored even if rendering fails.
              local ok, err = xpcall(function()
                original_on_win(self, toprow, botrow)
              end, debug.traceback)

              vim.range.lsp = original_range_lsp

              if not ok then
                error(err)
              end
            end

            Provider._indent_alignment_patched = true
          end
        end

        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
          map("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end, "[T]oggle Inlay [H]ints")
        end
      end,
    })

    vim.diagnostic.config({
      severity_sort = true,
      float = { border = "rounded", source = "if_many" },
      underline = { severity = vim.diagnostic.severity.ERROR },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "󰅚 ",
          [vim.diagnostic.severity.WARN] = "󰀪 ",
          [vim.diagnostic.severity.INFO] = "󰋽 ",
          [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
      },
      virtual_text = {
        virt_text_pos = "eol_right_align",
        source = "if_many",
        spacing = 2,
        format = function(diagnostic)
          local diagnostic_message = {
            [vim.diagnostic.severity.ERROR] = diagnostic.message,
            [vim.diagnostic.severity.WARN] = diagnostic.message,
            [vim.diagnostic.severity.INFO] = diagnostic.message,
            [vim.diagnostic.severity.HINT] = diagnostic.message,
          }
          return diagnostic_message[diagnostic.severity]
        end,
      },
    })

    local capabilities = require("blink.cmp").get_lsp_capabilities()
    local servers = {
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          diagnostics = { disable = { "missing-fields" } },
        },
      },
      cssls = {},
      html = {},
      jsonls = {},
      harper_ls = {
        filetypes = { "markdown", "gitcommit", "text", "norg", "org", "mdx" },
      },
    }

    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      "stylua", -- Used to format Lua code
      "csharpier", -- Used to format C# code
    })
    require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

    require("mason-lspconfig").setup({
      ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
      automatic_installation = false,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    })
  end,
}
