return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  opts = {
    legacy_commands = false,
    sync = {
      enabled = false,
    },
    workspaces = {
      {
        name = "work",
        path = "/mnt/d/iCloudDrive/iCloud~md~obsidian/Vault",
      },
      {
        name = "home",
        path = "/Users/nieksa/Library/Mobile Documents/iCloud~md~obsidian/Documents/Vault",
      },
    },
    daily_notes = {
      folder = "Work/Daily Notes",
      date_format = "YY-MM-DD",
      default_tags = { "daily-notes" },
      workdays_only = true,
    },
  },
}
