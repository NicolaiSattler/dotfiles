local open_with_trouble = require("trouble.sources.telescope").open
local telescope = require('telescope');

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ['<C-t>'] = open_with_trouble,
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
  pickers = {
    find_files = {
      theme = "dropdown",
    }
  },

  extensions = {
    media_files = {
      filetypes = { "png", "webp", "jpg", "jpeg"},
      find_cmd = "rg"
    },
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "ignore_case"
    }
  }
}

-- Enable telescope fzf native, if installed
telescope.load_extension('fzf')
telescope.load_extension('media_files')

local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == '' then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ':h')
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 then
    print 'Not a git repository. Searching on current working directory'
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep {
      search_dirs = { git_root },
    }
  end
end

local function telescope_live_grep_open_files()
  require('telescope.builtin').live_grep( 
    require('telescope.themes').get_ivy(),
    {
      grep_open_files = true,
      prompt_title = 'Live Grep in Open Files',
      max_result = 50
    })
end

local function telescope_live_grep_fixed()
    require('telescope.builtin').live_grep(
      require('telescope.themes').get_ivy(),
      {
        prompt_title = 'Live Grep in Open Files',
        max_result = 50,
        additional_args = { "-j1" }
      })
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

vim.keymap.set('n', '<leader>?', function() require('telescope.builtin').oldfiles(require('telescope.themes').get_ivy()) end, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', function() require('telescope.builtin').buffers(require('telescope.themes').get_ivy()) end, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
--vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })
--vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>si', ':Telescope media_files<CR>', { desc = '[S]earch [I]mages' })
vim.keymap.set('n', '<leader>sf', function() require('telescope.builtin').find_files(require('telescope.themes').get_ivy()) end, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', function() require('telescope.builtin').grep_string(require('telescope.themes').get_ivy()) end, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', telescope_live_grep_fixed, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
--vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
--vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

-- vim.keymap.set('n', '<leader>/', function()
--   -- You can pass additional configuration to telescope to change theme, layout, etc.
--   require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
--     winblend = 10,
--     previewer = false,
--   })
-- end, { desc = '[/] Fuzzily search in current buffer' })
