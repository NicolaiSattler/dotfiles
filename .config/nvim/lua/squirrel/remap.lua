vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('i', 'jk', '<Esc>')

vim.keymap.set('n', 'Y', 'Vy')

--quickfixlist
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")

-- open netrw
vim.keymap.set('n', '<leader>pv', vim.cmd.Oil)
-- switch buffers
vim.keymap.set('n', '<leader>.', ":bnext<CR>", { desc = "Next buffer"})
vim.keymap.set('n', '<leader>,', ":bprevious<CR>", { desc = "Previous Buffer"})
-- git
vim.keymap.set("n", "<leader>gs", ":Neogit<CR>", { desc = "[g]it [s]tatus", silent = true})
vim.keymap.set("n", "<leader>gd", ":DiffviewOpen<CR>", { desc = "[g]it [d]iff", silent = true })
vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { desc = "[g]it [b]lame", silent = true })
-- Keymaps for better default experience
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
-- move selected lines with J & K to a different line. <3 ThePrimeagen
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
--keep the cursor centered! <3 ThePrimeagen
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "gd", "gdzz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- Diagnostic keymaps
-- replaced with trouble. save just in case. :)
--vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
--vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
--vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
vim.keymap.set('n', '<leader>f', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

vim.api.nvim_set_keymap('n', '<leader>bc', ':bd|e#|bd#<CR>', { noremap = true, silent =  true})

vim.api.nvim_set_keymap("n", "<leader>-", ":vertical resize -10<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<leader>+", ":vertical resize +10<CR>", {noremap=true})
