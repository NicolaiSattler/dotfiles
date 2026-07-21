return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local fzf = require("fzf-lua")

    fzf.setup({
      winopts = {
        height = 0.4,
        width = 1.0,
        row = 1.0,
        preview = { hidden = "hidden" },
      },
      defaults = {
        formatter = "path.filename_first",
      },
      fzf_opts = {
        ["--cycle"] = true,
      },
    })

    local function live_grep_git_root()
      local current_file = vim.api.nvim_buf_get_name(0)
      local current_dir = current_file ~= "" and vim.fn.fnamemodify(current_file, ":h") or vim.fn.getcwd()
      local git_root =
        vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
      if vim.v.shell_error ~= 0 then
        print("Not a git repository. Searching in current working directory")
        git_root = vim.fn.getcwd()
      end
      fzf.live_grep({ cwd = git_root })
    end

    vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})

    vim.keymap.set("n", "<leader>?", fzf.oldfiles, { desc = "[?] Find recently opened files" })
    vim.keymap.set("n", "<leader><space>", fzf.buffers, { desc = "[ ] Find existing buffers" })
    vim.keymap.set("n", "<leader>s/", function()
      fzf.live_grep({ grep_open_files = true, prompt = "Live Grep in Open Files> " })
    end, { desc = "[S]earch [/] in Open Files" })
    vim.keymap.set("n", "<leader>si", function()
      fzf.files({ cmd = "fd -e png -e jpg -e jpeg -e webp", prompt = "Images> " })
    end, { desc = "[S]earch [I]mages" })
    vim.keymap.set("n", "<leader>sf", fzf.files, { desc = "[S]earch [F]iles" })
    vim.keymap.set("n", "<leader>sh", fzf.help_tags, { desc = "[S]earch [H]elp" })
    vim.keymap.set("n", "<leader>sw", fzf.grep_cword, { desc = "[S]earch current [W]ord" })
    vim.keymap.set("n", "<leader>sg", function()
      fzf.live_grep({ rg_opts = "--column -n --no-heading --color=always -j1" })
    end, { desc = "[S]earch by [G]rep" })
    vim.keymap.set("n", "<leader>sG", ":LiveGrepGitRoot<cr>", { desc = "[S]earch by [G]rep on Git Root" })
    vim.keymap.set("n", "<leader>R", fzf.registers, { desc = "Show [r]egisters", noremap = true, silent = true })
    vim.keymap.set("n", "<leader>ss", fzf.lsp_live_workspace_symbols, { desc = "[S]earch [S]ymbols" })
  end,
}
