return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  dependencies = {
    "github/copilot.vim",
  },
  config = function()
    require("copilot").setup({
      auth_provider_url = "https://stichting-bkr.ghe.com",
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
  end,
}
