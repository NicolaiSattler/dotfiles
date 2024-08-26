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
    local cmd = 'dotnet build -c Debug "' .. path .. '"'

    print('\n')
    print('Cmd to execute: ' .. cmd)

    local f = os.execute(cmd)

    if f == 0 then
        print('\nBuild: ' .. vim.g.gsign('✔️ ', 'OK'))
    else
        print('\nBuild: ' .. vim.g.gsign('❌', 'ERR') .. '(code: ' .. f .. ')')
    end
end

vim.api.nvim_set_keymap('n', '<C-S-b>', ':lua vim.g.dotnet_build_project()<CR>', { noremap = true, silent = true })
