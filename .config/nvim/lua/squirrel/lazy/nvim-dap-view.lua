return {
  "igorlfs/nvim-dap-view",
  lazy = false,
  version = "1.*",
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  ---@module 'dap-view'
  opts = {},
  config = function()
    require("dap-view").setup({
      winbar = {
        sections = { "scopes", "threads", "watches", "exceptions", "breakpoints", "repl", "console" },
        default_section = "scopes",
      },
    })
    require("squirrel.dap_signs").setup()

    local dap = require("dap")
    dap.listeners.after.event_initialized["dapview_config"] = function()
      vim.cmd("DapViewOpen")
    end
    dap.listeners.before.event_terminated["dapview_config"] = function()
      vim.cmd("DapViewClose")
    end
    dap.listeners.before.event_exited["dapview_config"] = function()
      vim.cmd("DapViewClose")
    end
  end,
}
