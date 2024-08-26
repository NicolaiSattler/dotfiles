require("obsidian").setup({
  workspaces = {
    {
      name = "Work",
      path = "$HOME/vault/work"
    }
  },
  completion = {
    nvim_cmp = true;
    min_chars = 2;
  }
})
