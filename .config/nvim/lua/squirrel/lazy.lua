local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  --git
  'lewis6991/gitsigns.nvim',

  -- autodetect tabstop and shiftwidth
  'tpope/vim-sleuth',

  -- lsp
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        auth_provider_url = "https://stichting-bkr.ghe.com",
        -- suggestion = { enabled = false },
        -- panel = { enabled = false }
      })
    end,
  },
  "github/copilot.vim",
  "Decodetalkers/csharpls-extended-lsp.nvim",
  --dotnet <3
  {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = { "nvim-lua/plenary.nvim", 'nvim-telescope/telescope.nvim', },
    config = function()
      require("easy-dotnet").setup()
    end
  },
  -- start window
  "mhinz/vim-startify",
  -- noice - pretty commands :o 
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },
  --trouble - pretty lists :)
  {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
      {
        "<leader>q",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>ts",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>tr",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    }
  },
  -- workspace diagnosics
  {
    "artemave/workspace-diagnostics.nvim"
  },
  --debugger
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio'
    }
  },

  {
    'leoluz/nvim-dap-go'
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',

    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-document-symbol',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-path',
      'hrsh7th/vim-vsnip',
      -- for vim cmdline
      'hrsh7th/cmp-cmdline',
      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
      -- icons
      'onsails/lspkind.nvim'
    },
  },
  -- file explorer
  {
    'stevearc/oil.nvim',
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  -- Undotree
  {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim"
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  { "rose-pine/neovim", name = "rose-pine" },
  --{ 'Mofiqul/dracula.nvim', priority = 1000 },
  'nvim-lualine/lualine.nvim',
  {
    dependencies =
    {
      'nvim-tree/nvim-web-devicons'
    },
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    }
  },
  {
      'MeanderingProgrammer/render-markdown.nvim',
      dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
      opts = {},
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope-fzf-native.nvim',
        'nvim-telescope/telescope-media-files.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },
  {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      dependencies = { "nvim-lua/plenary.nvim" }
  },
  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim', opts = {}
  },
  {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      config = true
  },
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  'jlcrochet/vim-razor'
}, {})
