return {
  "stevearc/quicker.nvim",
  ft = "qf",
  ---@module "quicker"
  ---@type quicker.SetupOptions
  opts = {},
  config = function()
    require("quicker").setup({
      keys = {
        {
          ">",
          function()
            require("quicker").expand({ before = 2, after = 2, add_to_existing = true })
          end,
          desc = "Expand quickfix context",
        },
        {
          "<",
          function()
            require("quicker").collapse()
          end,
          desc = "Collapse quickfix context",
        },
      },
    })

    vim.keymap.set("n", "<leader>qq", function()
      require("quicker").toggle()
    end, {
      desc = "Toggle quickfix",
    })
    vim.keymap.set("n", "<leader>qd", function()
      if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
        require("quicker").toggle()
      else
        vim.diagnostic.setqflist({ open = true })
      end
    end, {
      desc = "Toggle project diagnostics",
    })
    vim.keymap.set("n", "<leader>l", function()
      require("quicker").toggle({ loclist = true })
    end, {
      desc = "Toggle loclist",
    })
  end,
}
