vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("gd", function()
			require("telescope.builtin").lsp_definitions(require("telescope.themes").get_ivy())
		end, "[g]oto [d]efinition")
		-- map('gr', function() require('telescope.builtin').lsp_references(require('telescope.themes').get_ivy()) end, '[g]oto [r]eferences')
		map("gi", function()
			require("telescope.builtin").lsp_implementations(require("telescope.themes").get_ivy())
		end, "[g]oto [i]mplementation")
		map("<leader>D", function()
			require("telescope.builtin").lsp_type_definitions(require("telescope.themes").get_ivy())
		end, "Type [D]efinition")
		map("<leader>ss", function()
			require("telescope.builtin").lsp_document_symbols(require("telescope.themes").get_ivy())
		end, "Search [D]ocument [S]ymbols")
		map("<leader>sws", function()
			require("telescope.builtin").lsp_dynamic_workspace_symbols(require("telescope.themes").get_ivy())
		end, "[S]earch [W]orkspace [S]ymbols")
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

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
			client
			and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
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
	roslyn = {},
	-- csharp_ls = {},
	jsonls = {},
	yamlls = {},
}

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
	"stylua", -- Used to format Lua code
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
