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

vim.g.use_simple = function()
    if vim.g['simple_sign_code'] then
        return true
    else
        return false
    end
end

vim.g.gsign = function(normal, simple)
    if vim.g.use_simple() then
        return simple
    else
        return normal
    end
end
