require("dapui").setup({
    icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
    mappings = {
      -- Use a table to apply multiple mappings
      expand = { "<CR>", "<2-LeftMouse>" },
      open = "o",
      remove = "d",
      edit = "e",
      repl = "r",
      toggle = "t",
    },
    -- Expand lines larger than the window
    -- Requires >= 0.7
    expand_lines = vim.fn.has("nvim-0.7") == 1,
    -- Layouts define sections of the screen to place windows.
    -- The position can be "left", "right", "top" or "bottom".
    -- The size specifies the height/width depending on position. It can be an Int
    -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
    -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
    -- Elements are the elements shown in the layout (in order).
    -- Layouts are opened in order so that earlier layouts take priority in window sizing.
    layouts = {
      {
        elements = {
        -- Elements can be strings or table with id and size keys.
          "repl",
          "breakpoints",
          "stacks",
          "watches",
        },
        size = 60, -- 40 columns
        position = "right",
      },
      {
        elements = {
          "scopes",
          --"console",
        },
        size = 0.25, -- 25% of total lines
        position = "bottom",
      },
    },
    controls = {
      -- Requires Neovim nightly (or 0.8 when released)
      enabled = true,
      -- Display controls in this element
      element = "repl",
      icons = {
        pause = "",
        play = "",
        step_into = "",
        step_over = "",
        step_out = "",
        step_back = "",
        run_last = "↻",
        terminate = "□",
      },
    },
    floating = {
      max_height = nil, -- These can be integers or a float between 0 and 1.
      max_width = nil, -- Floats will be treated as percentage of your screen.
      border = "single", -- Border style. Can be "single", "double" or "rounded"
      mappings = {
        close = { "q", "<Esc>" },
      },
    },
    windows = { indent = 1 },
    render = {
      max_type_length = nil, -- Can be integer or nil.
      max_value_lines = 100, -- Can be integer or nil.
    }
})

local dap, dapui = require("dap"), require("dapui")

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

--function DapuiOpen()
--  dapui.open()
--end
--
--function DapuiClose()
--    dapui.close()
--end
--
--function DapuiEnable()
--    dap.listeners.after.event_initialized["dapui_config"] = DapuiOpen
--    dap.listeners.before.event_terminated["dapui_config"] = DapuiClose
--    dap.listeners.before.event_exited["dapui_config"] = DapuiClose
--end
--
--function DapuiDisable()
--    dap.listeners.after.event_initialized["dapui_config"] = nil
--    dap.listeners.before.event_terminated["dapui_config"] = nil
--    dap.listeners.before.event_exited["dapui_config"] = nil
--end
--
--vim.cmd[[
--:command DapuiEnable lua DapuiEnable()
--:command DapuiDisable lua DapuiDisable()
--:command DapuiShow lua require("dapui").open()
--]]
