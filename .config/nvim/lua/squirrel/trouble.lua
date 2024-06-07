vim.keymap.set('n', '<leader>q', ":Trouble diagnostics toggle<CR>", { desc = 'Open diagnostics list' })
--
-- Automatically open Trouble Quickfixlist
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  callback = function()
    vim.cmd([[Trouble qflist open]])
  end,
})
