return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opt = {
    workspaces = {
      {
        name = "default",
        path = "/mnt/d/iCloudDrive/iCloud~md~obsidian/Vault",
      },
    },
  },
}
