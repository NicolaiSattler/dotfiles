require("neotest").setup({
  adapters = {
    require("neotest-dotnet")({
      discovery_root = "project"
    })
  },
})

vim.keymap.set('n', '<leader>tr', function() require('neotest').run.run() end, { desc = '[T]est [N]earest' })
vim.keymap.set('n', '<leader>ts', function() require('neotest').run.stop() end, { desc = '[T]est [S]top' })
vim.keymap.set('n', '<leader>tf', function() require('neotest').run.run(vim.fn.expand("%")) end, { desc = '[T]est [F]ile' })
vim.keymap.set('n', '<leader>tf', function() require('neotest').run.run(vim.fn.expand("%")) end, { desc = '[T]est [F]ile' })
vim.keymap.set('n', '<leader>to', function() require('neotest').output.open() end, { desc = '[T]est [O]utput]]' })
vim.keymap.set('n', '<leader>ta', function() require('neotest').summary.open() end, { desc = '[T]est Summ[a]ry' })
