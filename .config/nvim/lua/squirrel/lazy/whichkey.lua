return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {},
  config = function()
    local wk = require("which-key")
    wk.add({
      { "<leader>u", desc = "[U]ndotree" },
    })
  end,
}
