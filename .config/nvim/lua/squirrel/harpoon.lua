local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "[H]arpoon [a]dd item"})
vim.keymap.set("n", "<leader>hr", function() harpoon:list():remove() end, { desc = "[H]arpoon [r]emove item"})
vim.keymap.set("n", "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "[H]arpoon [l]ist"})
vim.keymap.set("n", "<leader>[", function() harpoon:list():prev() end, { desc = "[H]arpoon next"})
vim.keymap.set("n", "<leader>]", function() harpoon:list():next() end, { desc = "[H]arpoon previous"})

-- vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
-- vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
-- vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
-- vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

-- Toggle previous & next buffers stored within Harpoon list
