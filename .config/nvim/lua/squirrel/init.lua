require("squirrel.lazy")
require("squirrel.remap")
require("squirrel.lsp")
require("squirrel.treesitter")
require("squirrel.whichkey")
require("squirrel.telescope")
require("squirrel.cmp")
require("squirrel.colors")
require("squirrel.set")

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', {
    clear = true
})

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
