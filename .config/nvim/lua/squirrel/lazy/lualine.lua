return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local function macro_recording()
      local noice = require("noice")
      local mode = noice.api.status.mode.get()

      if mode then
        return string.match(mode, "^recording @.*") or ""
      end

      return ""
    end

    local job_indicator = { require("easy-dotnet.ui-modules.jobs").lualine }

    require("lualine").setup({
      opt = function(_, opts)
        local trouble = require("trouble")
        local symbols = trouble.statusline({
          mode = "lsp_document_symbols",
          groups = {},
          title = true,
          filter = { range = true },
          format = "{kind_icon}{symbol.name:Normal}",
          hl_group = "lualine_c_normal",
        })
        table.insert(opts.sections.lualine_c, {
          symbols.get,
          cond = symbols.has,
        })
      end,
      options = {
        icons_enabled = true,
        theme = "auto",
        -- component_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { macro_recording, "buffers" },
        lualine_x = { job_indicator, "filetype" },
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      extensions = {
        "man",
        "lazy",
      },
    })
  end,
}
