local dotnet = require("easy-dotnet")
dotnet.setup({
	lsp = {
		enabled = true,
		roslynator_enabled = true,
	},
	server = {
		log_level = "Information",
	},
	notifications = {
		handler = false,
	},
	diagnostics = {
		setqflist = true,
	},
	test_runner = {
		viewmode = "buf",
		noBuild = true,
		noRestore = true,
		icons = {
			passed = "",
			skipped = "",
			failed = "",
			success = "",
			reload = "",
			test = "",
			sln = "󰘐",
			project = "󰘐",
			dir = "",
			package = "",
		},
		-- mappings = {
		--     run_test_from_buffer = { lhs = "<leader>er", desc = "run test from buffer" },
		--     debug_test_from_buffer = { lhs = "<leader>ed", desc = "debug test from buffer" },
		-- }
	},
})

vim.keymap.set("n", "<C-T>", function()
	dotnet.testrunner()
end, { desc = "Open Testrunner" })

vim.keymap.set("n", "<C-B>", function()
	dotnet.build_solution_quickfix()
end, { desc = "Build Solution" })
