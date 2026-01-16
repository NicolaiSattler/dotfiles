return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {},
  config = function()
    local wk = require("which-key")
    wk.add({
      { "", group = "[C]ode", mode = { "n", "n" } },
      { "", group = "[S]earch" },
      { "", group = "[T]oggle" },
      { "", group = "[W]orkspace" },
      { "", group = "[R]ename" },
      { "", group = "[G]it" },
      { "", group = "Git [H]unk" },
      { "", group = "[D]ocument" },
      { "<leader>u", desc = "[U]ndotree" },
    })
  end,
}
