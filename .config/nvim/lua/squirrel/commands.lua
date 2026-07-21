-- close all buffers except the focused buffer one
vim.api.nvim_create_user_command("Bda", function()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.fn.buflisted(buf) == 1 then
      vim.api.nvim_buf_delete(buf, {})
    end
  end
end, {})

vim.api.nvim_create_user_command("Code", function()
  vim.notify("Opened VSCode in current directory", vim.log.levels.INFO)
  vim.fn.jobstart({ "code", "." }, { detach = true })
end, {})
