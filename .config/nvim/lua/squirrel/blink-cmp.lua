local blink = require("blink-cmp")

blink.setup({
	keymap = {
		preset = "default",
	},
	appearance = {
		nerd_font_variant = "mono",
	},
	menu = {
		auto_show = false,
	},

	documentation = { auto_show = false, auto_show_delay_ms = 500 },
	ghost_text = { enabled = true, show_with_menu = false },
	sources = {
		default = { "lsp", "path", "snippets", "lazydev", "buffer", "copilot" },
		providers = {
			-- copilot = { module = "blink-cmp-copilot", score_offset = 100, async = true },
			copilot = { name = "copilot", module = "blink-copilot", async = true },
			lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
		},
	},
	snippets = { preset = "luasnip" },
	fuzzy = { implementation = "lua" },
	signature = { enabled = true },
})
