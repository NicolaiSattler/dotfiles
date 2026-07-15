return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require("dap")
    dap.adapters.coreclr = {
      type = "executable",
      command = "netcoredbg",
      args = { "--interpreter=vscode" },
    }

    -- local request = function()
    --   local path =
    --     vim.fn.input({ prompt = "Path to dll: ", default = vim.fn.getcwd() .. "/bin/Debug/", completion = "file" })
    --
    --   return path
    -- end
    --
    -- vim.g.dotnet_get_dll_path = function()
    --   if vim.g["dotnet_last_dll_path"] == nil then
    --     vim.g["dotnet_last_dll_path"] = request()
    --   else
    --     if
    --       vim.fn.confirm("Do you want to change the path to dll?\n" .. vim.g["dotnet_last_dll_path"], "&yes\n&no", 2)
    --       == 1
    --     then
    --       vim.g["dotnet_last_dll_path"] = request()
    --     end
    --   end
    --   return vim.g["dotnet_last_dll_path"]
    -- end

    local config = {
      {
        name = "Attach to process",
        type = "coreclr",
        request = "attach",
        processId = function()
          return coroutine.create(function(coro)
            require("fzf-lua").fzf_exec("ps aux", {
              prompt = "Select process> ",
              fzf_opts = { ["--header-lines"] = "1" },
              actions = {
                ["default"] = function(selected)
                  if selected and #selected > 0 then
                    local pid = selected[1]:match("^%S+%s+(%d+)")
                    coroutine.resume(coro, tonumber(pid))
                  end
                end,
              },
            })
          end)
        end,
      },
      -- {
      --   type = "coreclr",
      --   name = "launch - netcoredbg",
      --   request = "launch",
      --   console = "integratedTerminal",
      --   justMyCode = false,
      --   stopAtEntry = false,
      --   program = function()
      --     if vim.fn.confirm("Recompile first?", "&yes\n&no", 2) == 1 then
      --       vim.g.dotnet_build_project()
      --     end
      --     return vim.g.dotnet_get_dll_path()
      --   end,
      --   cwd = function()
      --     return vim.fn.input("Workspace folder: ", vim.fn.getcwd() .. "/", "file")
      --   end,
      --   env = {
      --     ASPNETCORE_ENVIRONMENT = "Development",
      --   },
      -- },
    }

    dap.configurations.cs = config

    vim.keymap.set("n", "<F5>", function()
      require("dap").continue()
    end, { desc = "continue" })
    vim.keymap.set("n", "<F10>", function()
      require("dap").step_over()
    end, { desc = "step over" })
    vim.keymap.set("n", "<F11>", function()
      require("dap").step_into()
    end, { desc = "step into" })
    vim.keymap.set("n", "<F12>", function()
      require("dap").step_out()
    end, { desc = "step out" })
    vim.keymap.set("n", "<leader>b", function()
      require("dap").toggle_breakpoint()
    end, { desc = "toggle breakpoint" })
    vim.keymap.set("n", "<leader>B", function()
      require("dap").set_breakpoint()
    end, { desc = "set breakpoint" })
    vim.keymap.set("n", "<leader>lp", function()
      require("dap").set_breakpoint(nil, nil, vim.fn.input("Trace message: "))
    end, { desc = "set trace point" })
    vim.keymap.set("n", "<leader>dr", function()
      require("dap").repl.open()
    end, { desc = "open REPL" })
  end,
}
