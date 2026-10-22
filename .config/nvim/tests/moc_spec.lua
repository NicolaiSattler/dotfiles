local root = vim.fn.tempname()
local test_path = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p")
local source = vim.fs.dirname(vim.fs.dirname(test_path)) .. "/lua/squirrel/moc.lua"
local notes = root .. "/Zettelkast"
local moc = notes .. "/10 MOCs/Example MOC.md"
local daily = notes .. "/10 MOCs/Daily Notes and Meetings MOC.md"
local notifications = {}
local original_notify = vim.notify
vim.notify = function(message)
  table.insert(notifications, message)
end

local function write(path, lines)
  vim.fn.mkdir(vim.fs.dirname(path), "p")
  vim.fn.writefile(lines, path)
end

local function read(path)
  return table.concat(vim.fn.readfile(path), "\n")
end

local function save(path)
  vim.api.nvim_buf_set_name(0, path)
  vim.api.nvim_exec_autocmds("BufWritePost", { buffer = 0 })
end

local ok, err = pcall(function()
  write(moc, { "# Example", "", "## Notes", "- [[Curated]]", "", "## Related maps", "- [[Other MOC]]" })
  write(daily, { "# Daily", "<!-- daily-notes:start -->", "<!-- daily-notes:end -->" })
  write(notes .. "/20 Notes/B.md", { "[[Example MOC|Example]] [[Example MOC#Notes]]" })
  write(notes .. "/20 Notes/A.md", { "[[10 MOCs/Example MOC.md]]" })
  write(notes .. "/Templates/Example.md", { "[[Example MOC]]" })
  write(notes .. "/40 Journal/Daily/26-10-22.md", { "[[Daily Notes and Meetings MOC]]" })
  write(notes .. "/40 Journal/Daily/26-10-21.md", {})
  local integration = dofile(source)
  integration.setup(notes)
  integration.setup(notes)
  assert(#vim.api.nvim_get_autocmds({ group = "DailyNotesMoc" }) == 1)
  save(notes .. "/20 Notes/B.md")
  assert(#notifications == 0, table.concat(notifications, "\n"))
  local text = read(moc)
  assert(text:find("- [[Curated]]", 1, true))
  assert(text:find("- [[Other MOC]]", 1, true))
  assert(text:find("- [[20 Notes/A]]\n- [[20 Notes/B]]", 1, true))
  assert(not text:find("Templates/Example", 1, true))
  assert(read(daily):find("- [[26-10-21]]\n- [[26-10-22]]", 1, true))
  assert(not read(daily):find("40 Journal/Daily", 1, true))
  local stat = vim.uv.fs_stat(moc)
  save(notes .. "/20 Notes/B.md")
  assert(vim.deep_equal(stat.mtime, vim.uv.fs_stat(moc).mtime), "Unchanged MOC was rewritten")
  write(notes .. "/20 Notes/B.md", {})
  vim.fn.delete(notes .. "/20 Notes/A.md")
  save(notes .. "/20 Notes/B.md")
  assert(not read(moc):find("20 Notes/", 1, true), "Removed links remained")
  local buffer = vim.fn.bufadd(moc)
  vim.fn.bufload(buffer)
  write(notes .. "/20 Notes/B.md", { "[[Zettelkast/10 MOCs/Example MOC]]" })
  save(root .. "/Outside.md")
  assert(not read(moc):find("20 Notes/B", 1, true), "Save outside vault updated MOCs")
  save(notes .. "/20 Notes/B.md")
  assert(
    table.concat(vim.api.nvim_buf_get_lines(buffer, 0, -1, false), "\n"):find("20 Notes/B", 1, true),
    "Loaded MOC buffer was not refreshed"
  )
  write(notes .. "/20 Notes/B.md", {})
  save(notes .. "/20 Notes/B.md")
  vim.api.nvim_buf_set_lines(buffer, 0, 1, false, { "# Unsaved" })
  write(notes .. "/20 Notes/B.md", { "[[Example MOC]]" })
  save(notes .. "/20 Notes/B.md")
  assert(not read(moc):find("20 Notes/B", 1, true))
  assert(#notifications == 1 and notifications[1]:find("unsaved edits", 1, true))
  vim.bo[buffer].modified = false
  write(moc, { "# Example", "<!-- moc-links:start -->" })
  save(notes .. "/20 Notes/B.md")
  assert(#notifications == 2 and notifications[2]:find("malformed", 1, true))
  assert(read(moc) == "# Example\n<!-- moc-links:start -->")
end)

vim.notify = original_notify
vim.fn.delete(root, "rf")
if not ok then
  error(err)
end
print("MOC integration tests passed")
