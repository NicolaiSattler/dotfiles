local M = {}

function M.setup(notes_root)
  notes_root = vim.fs.normalize(vim.fn.expand(notes_root))
  local moc_dir = notes_root .. "/10 MOCs"
  local daily_dir = notes_root .. "/40 Journal/Daily"
  local daily_moc = "Daily Notes and Meetings MOC"

  local function replace_section(lines, first, last, entries)
    local updated = {}
    for index = 1, first do
      table.insert(updated, lines[index])
    end
    vim.list_extend(updated, entries)
    for index = last, #lines do
      table.insert(updated, lines[index])
    end
    return updated
  end

  local function update_section(lines, marker, entries)
    local first, last
    for index, line in ipairs(lines) do
      if line == "<!-- " .. marker .. ":start -->" then
        if first then
          error("Duplicate " .. marker .. " start marker")
        end
        first = index
      elseif line == "<!-- " .. marker .. ":end -->" then
        if last then
          error("Duplicate " .. marker .. " end marker")
        end
        last = index
      end
    end
    if not first or not last or first >= last then
      error("Missing or malformed " .. marker .. " markers")
    end
    return replace_section(lines, first, last, entries)
  end

  local function links_for(paths)
    table.sort(paths)
    local entries = {}
    for _, path in ipairs(paths) do
      table.insert(entries, "- [[" .. path .. "]]")
    end
    return entries
  end

  local function update_mocs()
    local mocs = {}
    for _, path in ipairs(vim.fn.globpath(moc_dir, "*.md", false, true)) do
      local name = vim.fs.basename(path):sub(1, -4)
      mocs[name] = { path = path, notes = {} }
    end

    local daily_notes = {}
    for _, path in ipairs(vim.fn.globpath(notes_root, "**/*.md", false, true)) do
      local relative = path:sub(#notes_root + 2)
      local folder = relative:match("^([^/]+)/")
      if folder ~= "Templates" and folder ~= "10 MOCs" and folder ~= "00 Home" then
        local targets = {}
        for _, line in ipairs(vim.fn.readfile(path)) do
          for link in line:gmatch("%[%[([^%]]+)%]%]") do
            local target = vim.trim(link:match("^[^|#]+") or ""):gsub("%.md$", "")
            for name in pairs(mocs) do
              if target == name or target == "10 MOCs/" .. name or target == "Zettelkast/10 MOCs/" .. name then
                targets[name] = true
              end
            end
          end
        end

        local is_daily = vim.fs.dirname(path) == daily_dir and vim.fs.basename(path):match("^%d%d%-%d%d%-%d%d%.md$")
        if is_daily then
          table.insert(daily_notes, vim.fs.basename(path):sub(1, -4))
        end
        for name in pairs(targets) do
          if not (name == daily_moc and is_daily) then
            table.insert(mocs[name].notes, relative:sub(1, -4))
          end
        end
      end
    end

    for name, moc in pairs(mocs) do
      local ok, err = pcall(function()
        local buffer = vim.fn.bufnr(moc.path)
        if buffer ~= -1 and vim.bo[buffer].modified then
          error("MOC has unsaved edits; save it before updating")
        end
        local lines = vim.fn.readfile(moc.path)
        local updated = vim.deepcopy(lines)
        if name == daily_moc then
          updated = update_section(updated, "daily-notes", links_for(daily_notes))
        end

        local has_markers = false
        for _, line in ipairs(updated) do
          if line == "<!-- moc-links:start -->" or line == "<!-- moc-links:end -->" then
            has_markers = true
          end
        end
        if not has_markers then
          local section = {
            "## Automatically linked notes",
            "",
            "<!-- moc-links:start -->",
            "<!-- moc-links:end -->",
            "",
          }
          local insert_at = #updated + 1
          for index, line in ipairs(updated) do
            if line == "## Related maps" then
              insert_at = index
              break
            end
          end
          if insert_at == #updated + 1 and updated[#updated] ~= "" then
            table.insert(updated, "")
            insert_at = #updated + 1
          end
          for offset, line in ipairs(section) do
            table.insert(updated, insert_at + offset - 1, line)
          end
        end
        updated = update_section(updated, "moc-links", links_for(moc.notes))
        if not vim.deep_equal(lines, updated) then
          if vim.fn.writefile(updated, moc.path) ~= 0 then
            error("Could not write MOC")
          end
          if buffer ~= -1 and vim.api.nvim_buf_is_loaded(buffer) then
            vim.api.nvim_buf_call(buffer, function()
              local view = vim.fn.winsaveview()
              vim.cmd("silent keepalt edit!")
              vim.fn.winrestview(view)
            end)
          end
        end
      end)
      if not ok then
        vim.notify(moc.path .. ": " .. tostring(err), vim.log.levels.ERROR)
      end
    end
  end

  local group = vim.api.nvim_create_augroup("DailyNotesMoc", { clear = true })
  vim.api.nvim_create_autocmd("BufWritePost", {
    group = group,
    pattern = "*.md",
    callback = function(event)
      local path = vim.fs.normalize(vim.api.nvim_buf_get_name(event.buf))
      if path:sub(1, #notes_root + 1) == notes_root .. "/" then
        update_mocs()
      end
    end,
  })
end

return M
