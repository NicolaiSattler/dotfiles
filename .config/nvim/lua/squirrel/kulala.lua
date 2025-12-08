return {
  "mistweaverco/kulala.nvim",
  lazy = true,
  ft = { "http", "rest" },
  config = function()
    local kulala = require("kulala.config")

    kulala.setup({
      global_keymaps = true,
      global_keymaps_prefix = "<leader>K",
      kulala_keymaps_prefix = "",
      opts = {
        request_timeout = 10000,
      },
    })
  end,
}
