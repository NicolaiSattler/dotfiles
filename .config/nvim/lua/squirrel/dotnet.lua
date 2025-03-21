local dotnet = require("easy-dotnet")
dotnet.setup({
    test_runner = {
        viewmode = "float",
        noBuild = true,
        noRestore = true,
        icons = {
            passed = "",
            skipped = "",
            failed = "",
            success = "",
            reload = "",
            test = "",
            sln = "󰘐",
            project = "󰘐",
            dir = "",
            package = "",
        },
        mappings = {
            run_test_from_buffer = { lhs = "<leader>er", desc = "run test from buffer" },
            debug_test_from_buffer = { lhs = "<leader>ed", desc = "debug test from buffer" },
        }
    }
})

-- obsolete
vim.g.dotnet_build_project = function()
    local default_path = vim.fn.getcwd() .. '/'

    if vim.g['dotnet_last_proj_path'] ~= nil then
        default_path = vim.g['dotnet_last_proj_path']
    end

    local path = vim.fn.input({
        prompt = 'Path to your *.csproj file: ',
        default = default_path,
        completion = 'file'
    })

    vim.g['dotnet_last_proj_path'] = path
    local cmd = 'dotnet build -c Debug "' .. path .. '" > /dev/null 2>&1'

    print('\n')
    print('Building...')

    local f = os.execute(cmd)

    if f == 0 then
        print('\nBuild: ' .. vim.g.gsign('✔️ ', 'OK'))
    else
        print('\nBuild: ' .. vim.g.gsign('❌', 'ERR') .. '(code: ' .. f .. ')')
    end
end

vim.api.nvim_set_keymap('n', '<C-S-b>', ':lua vim.g.dotnet_build_project()<CR>', { noremap = true, silent = true })
