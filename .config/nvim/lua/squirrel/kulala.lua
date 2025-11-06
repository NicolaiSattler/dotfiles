local kulala = require("kulala")

kulala.setup({
	global_keymaps = {
		["Send request"] = {
			"<leader>ks",
			function()
				require("kulala").run()
			end,
			mode = { "n", "v" },
			desc = "Send request",
		},
		["Send all requests"] = {
			"<leader>ka",
			function()
				require("kulala").run_all()
			end,
			mode = { "n", "v" },
			ft = "http",
		},
		["Replay the last request"] = {
			"<leader>kr",
			function()
				require("kulala").replay()
			end,
			ft = { "http", "rest" },
		},
		["Find request"] = false,
	},
})
