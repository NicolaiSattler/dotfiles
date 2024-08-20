require("obsidian").setup({
  workspaces = {
    {
      name = "Work",
      path = "$HOME/vault/Work"
    }
  },
  completion = {
    nvim_cmp = true;
    min_chars = 2;
  }
})
