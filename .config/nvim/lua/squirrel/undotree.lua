vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

-- Save undo history to make Undotree even more awesome <3
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
