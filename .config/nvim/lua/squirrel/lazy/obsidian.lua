return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  opts = {
    legacy_commands = false,
    sync = {
      enabled = true,
    },
    workspaces = {
      {
        name = "default",
        path = "/mnt/d/iCloudDrive/iCloud~md~obsidian/Vault",
      },
    },
    daily_notes = {
      folder = "Work/Dail Notes",
      date_format = "DD-MM-YYYY",
      default_tags = { "daily-notes" },
      workdays_only = true,
    },
  },
}
