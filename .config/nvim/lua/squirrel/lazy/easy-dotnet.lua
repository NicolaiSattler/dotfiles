return {
  "GustavEikaas/easy-dotnet.nvim",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
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
      },
    })

    vim.keymap.set("n", "<C-T>", function()
      dotnet.testrunner()
    end, { desc = "Open Testrunner" })

    vim.keymap.set("n", "<C-B>", function()
      dotnet.build_solution_quickfix()
    end, { desc = "Build Solution" })
  end,
}
