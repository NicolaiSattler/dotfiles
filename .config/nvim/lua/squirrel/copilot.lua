return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      auth_provider_url = "https://stichting-bkr.ghe.com",
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
  end,
}
