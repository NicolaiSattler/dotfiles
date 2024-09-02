local dap = require('dap')
dap.adapters.coreclr = {
  type = 'executable',
  command = 'netcoredbg',
  args = {'--interpreter=vscode'}
}

local request = function()
    local path = vim.fn.input({prompt = 'Path to dll: ', default = vim.fn.getcwd() .. '/bin/Debug/', completion = 'file'})
    vim.cmd('redraw')

    return path
end

vim.g.dotnet_get_dll_path = function()
    if vim.g['dotnet_last_dll_path'] == nil then
        vim.g['dotnet_last_dll_path'] = request()
    else
        if vim.fn.confirm('Do you want to change the path to dll?\n' .. vim.g['dotnet_last_dll_path'], '&yes\n&no', 2) == 1 then
            vim.g['dotnet_last_dll_path'] = request()

            vim.cmd('redraw')
        end
    end
    return vim.g['dotnet_last_dll_path']
end


local config = {
    {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        console = "integratedTerminal",
        justMyCode = false,
        stopAtEntry = false,
        program = function()
            if vim.fn.confirm('Recompile first?', '&yes\n&no', 2) == 1 then
                vim.g.dotnet_build_project()
            end
            return vim.g.dotnet_get_dll_path()
        end,
        cwd = function()
            return vim.fn.input("Workspace folder: ", vim.fn.getcwd() .. "/", "file")
        end,
        env = {
            ASPNETCORE_ENVIRONMENT = "Development"
        }
    }
}

dap.configurations.cs = config

require('dap-go').setup()
--require('dap.ext.vscode').load_launchjs({}, nil)

vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = 'continue' })
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end, { desc = 'step over'})
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end, { desc = 'step into'})
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end, { desc = 'step out'})
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end, { desc = 'toggle breakpoint'})
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end, { desc = 'set breakpoint'})
vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Trace message: ')) end, { desc = 'set trace point'})
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end, { desc = 'open REPL'})
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end, { desc = 're-run last configuration'})
vim.keymap.set({'n', 'v'}, '<Leader>dh', function() require('dap.ui.widgets').hover() end, { desc = '[d]ap [h]over - view value under cursor'})
vim.keymap.set({'n', 'v'}, '<Leader>dp', function() require('dap.ui.widgets').preview() end, { desc = '[d]ap [p]review'})
vim.keymap.set('n', '<Leader>df', function() local widgets = require('dap.ui.widgets') widgets.centered_float(widgets.frames) end, { desc = '[d]ap focus [f]rames'})
vim.keymap.set('n', '<Leader>ds', function() local widgets = require('dap.ui.widgets') widgets.centered_float(widgets.scopes) end, { desc = '[d]ap focus [s]copes'})
vim.api.nvim_set_keymap('n', '<C-S-b>', ':lua vim.g.dotnet_build_project()<CR>', { noremap = true, silent = true })

vim.g['dap_DapBreakpoint_sign'] = vim.g.gsign(' ', '->')
vim.fn.sign_define('DapBreakpoint', { text=vim.g.gsign(' ', 'B'), texthl='DapBreakpoint', linehl='DapBreakpointLine', numhl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointCondition', { text=vim.g.gsign(' ', 'B?'), texthl='DapBreakpoint', linehl='DapBreakpointLine', numhl='DapBreakpoint' })
vim.fn.sign_define('DapBreakpointRejected', { text=vim.g.gsign(' ', 'B!'), texthl='DapBreakpoint', linehl='DapBreakpointLine', numhl= 'DapBreakpoint' })
vim.fn.sign_define('DapLogPoint', { text=vim.g.gsign(' ', 'Bi'), texthl='DapLogPoint', linehl='DapLogPointLine', numhl= 'DapLogPoint' })
vim.fn.sign_define('DapStopped', { text=vim.g.gsign(' ', '=>'), texthl='DapStopped', linehl='DapStoppedLine', numhl= 'DapStopped' })
