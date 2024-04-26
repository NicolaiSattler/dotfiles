local ut = require('undotree')

ut.setup({
  float_diff = true,
  layout = "left_bottom",
  ignore_filetype = { 'Undotree', 'UndotreeDiff', 'qf', 'TelescopePrompt'},
  window = {
    winblend = 30
  },
  keymaps = {
    ['j'] = "move_next",
    ['k'] = "move_prev",
    ['gj'] = "move2parent",
    ['J'] = "move_change_next",
    ['K'] = "move_change_prev",
    ['<cr>'] = "action_enter",
    ['p'] = "enter_diffbuf",
    ['q'] = "quit",
  },
})

vim.keymap.set('n', '<leader>u', require('undotree').toggle, { noremap = true, silent = true })

-- Save undo history to make Undotree even more awesome <3
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
