--leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.guicursor = ""

vim.o.cursorline = true
vim.o.confirm = true
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- check if terminal supports this
vim.opt.termguicolors = true

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.wrap = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

vim.opt.breakindent = true
vim.opt.smartindent = true
vim.opt.wrap = false

-- Set highlight on search
vim.opt.hlsearch = false
-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enable mouse mode
vim.opt.mouse = "a"

vim.opt.swapfile = false
-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = "unnamedplus"
-- disable slow clipboard provider
-- vim.g.loaded_clipboard_provider = 1

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.colorcolumn = "120"
vim.opt.isfname:append("@-@")

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.opt.completeopt = "menuone,noselect"

--netrw
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

--copilot
vim.g.copilot_enterprise_uri = "https://stichting-bkr.ghe.com"
