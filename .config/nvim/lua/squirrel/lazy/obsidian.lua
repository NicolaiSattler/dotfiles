local function note_id(date_format)
  return function(title, dir)
    local slug = vim.trim(title or "")
    if slug == "" then
      slug = "note"
    else
      slug = require("obsidian.builtin").title_to_slug(slug)
    end

    local base = date_format and string.format("%s-%s", os.date(date_format), slug) or slug
    local id = base
    local suffix = 2

    while dir and (dir / id):with_suffix(".md", true):exists() do
      id = string.format("%s-%d", base, suffix)
      suffix = suffix + 1
    end

    return id
  end
end

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  cmd = "Obsidian",
  opts = {
    legacy_commands = false,
    sync = {
      enabled = false,
    },
    notes_subdir = "",
    new_notes_location = "notes_subdir",
    note_id_func = note_id("%Y%m%d%H%M"),
    frontmatter = {
      enabled = true,
      sort = { "id", "aliases", "tags" },
    },
    workspaces = {
      {
        name = "work",
        path = "/mnt/d/iCloudDrive/iCloud~md~obsidian/Zettelkast",
      },
      {
        name = "home",
        path = "/Users/nieksa/Library/Mobile Documents/iCloud~md~obsidian/Documents/Zettelkast",
      },
    },
    templates = {
      folder = "Templates",
      customizations = {
        ["Concept Note"] = {
          notes_subdir = "20 Notes",
          note_id_func = note_id("%Y%m%d%H%M"),
        },
        ["Meeting Note"] = {
          notes_subdir = "40 Journal/Meetings",
          note_id_func = note_id("%Y-%m-%d"),
        },
        MOC = {
          notes_subdir = "10 MOCs",
          note_id_func = note_id(),
        },
        ["Project Note"] = {
          notes_subdir = "50 Projects/Work",
          note_id_func = note_id(),
        },
        ["Source Note"] = {
          notes_subdir = "30 Sources",
          note_id_func = note_id("%y-%m-%d"),
        },
      },
    },
    daily_notes = {
      folder = "40 Journal/Daily",
      date_format = "YY-MM-DD",
      default_tags = { "daily-notes" },
      workdays_only = true,
    },
    attachments = {
      folder = "Attachments",
    },
    completion = {
      min_chars = 2,
      match_case = false,
      create_new = true,
    },
    picker = {
      name = "fzf-lua",
    },
  },
}
