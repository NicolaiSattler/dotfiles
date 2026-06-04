return {
  "jiaoshijie/undotree",
  event = "InsertEnter",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    local ut = require("undotree")

    ut.setup({
      float_diff = true,
      layout = "left_bottom",
      ignore_filetype = { "Undotree", "UndotreeDiff", "qf", "TelescopePrompt" },
      window = {
        winblend = 30,
      },
      keymaps = {
        ["move_next"] = "j",
        ["move_prev"] = "k",
        ["move2parent"] = "gj",
        ["move_change_next"] = "J",
        ["move_change_prev"] = "K",
        ["action_enter"] = "<cr>",
        ["enter_diffbuf"] = "p",
        ["quit"] = "q",
      },
    })

    vim.keymap.set("n", "<leader>u", require("undotree").toggle, { noremap = true, silent = true })
  end,
}
