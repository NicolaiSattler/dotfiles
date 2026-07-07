return {
  "mistweaverco/kulala.nvim",
  keys = {
    { "<leader>K", desc = "Kulala" },
  },
  ft = { "http", "rest" },
  init = function()
    vim.filetype.add({
      extension = {
        ["http"] = "http",
      },
    })

    vim.api.nvim_create_autocmd("BufWinEnter", {
      group = vim.api.nvim_create_augroup("KulalaExpandResponse", { clear = true }),
      callback = function(args)
        local name = vim.api.nvim_buf_get_name(args.buf)
        if not name:match("^kulala://") then return end
        vim.wo.foldenable = false
        vim.wo.foldlevel = 99
      end,
    })
  end,
  opts = {
    global_keymaps = true,
    global_keymaps_prefix = "<leader>K",
    kulala_keymaps_prefix = "",
    request_timeout = 10000,
    default_view = "body",
    response_format = {
      indent = 2,
      expand_tabs = true,
      sort_keys = false,
    },
    contenttypes = {
      ["application/json"] = {
        ft = "json",
        formatter = { "jq", "." },
        pathresolver = nil,
      },
      ["application/xml"] = {
        ft = "xml",
        formatter = { "xmllint", "--format", "--recover", "-" },
        pathresolver = { "xmllint", "--xpath", "{{path}}", "-" },
      },
      ["text/xml"] = {
        ft = "xml",
        formatter = { "xmllint", "--format", "--recover", "-" },
        pathresolver = { "xmllint", "--xpath", "{{path}}", "-" },
      },
      ["application/soap+xml"] = {
        ft = "xml",
        formatter = { "xmllint", "--format", "--recover", "-" },
        pathresolver = { "xmllint", "--xpath", "{{path}}", "-" },
      },
      ["text/html"] = {
        ft = "html",
        formatter = { "xmllint", "--format", "--html", "--recover", "-" },
        pathresolver = nil,
      },
    },
  },
}
