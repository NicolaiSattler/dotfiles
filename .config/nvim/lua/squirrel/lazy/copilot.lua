return {
  "zbirenbaum/copilot.lua",
  cmd = { "Copilot" },
  event = { "InsertEnter" },
  opts = {},
  config = function()
    require("copilot").setup({
      auth_provider_url = "https://stichting-bkr.ghe.com",
      suggestion = {
        enabled = false,
        debounce = 15,
        hide_during_completion = true,
      },
      logger = {
        file = vim.fn.stdpath("log") .. "/copilot-lua.log",
        file_log_level = vim.log.levels.OFF,
        print_log_level = vim.log.levels.WARN,
        trace_lsp = "off",
        trace_lsp_progress = false,
        log_lsp_messages = false,
      },
      panel = { enabled = false },
    })
  end,
}
