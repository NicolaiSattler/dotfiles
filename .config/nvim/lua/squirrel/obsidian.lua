require("obsidian").setup({
  workspaces = {
    {
      name = "Work",
      path = "/home/nieksa/vault/Work"
    }
  },
  completion = {
    nvim_cmp = true;
    min_chars = 2;
  }
})
