# Copilot instructions for this repository

This repository is a personal dotfiles setup. The main code surface is Neovim config under `.config/nvim` (Lua modules under `lua/squirrel`).

## Build, test, and lint commands

There is no dedicated project build/test/lint pipeline in this repo. Use these concrete commands instead:

```bash
# Bootstrap tools from Brewfile
brew bundle

# Apply dotfiles symlinks from repo root
stow .

# Sync/update Neovim plugins in headless mode
nvim --headless "+Lazy! sync" +qa
```

Single-test command: **not applicable** (no automated test suite is defined in this repo).

## High-level architecture

- Entry point: `.config/nvim/init.lua` only does `require("squirrel")`.
- `lua/squirrel/init.lua` orchestrates startup in this order: options (`set`), keymaps (`remap`), utility autocmds, lazy.nvim bootstrap, colorscheme, custom commands.
- Plugin system:
  - `lua/squirrel/lazy_init.lua` bootstraps `lazy.nvim`.
  - `require("lazy").setup({ spec = "squirrel.lazy" })` auto-loads plugin specs from `lua/squirrel/lazy/*.lua`.
  - Each file in `lua/squirrel/lazy/` is one plugin spec + its config.
- Language tooling is split by concern:
  - Generic LSP setup in `lua/squirrel/lazy/lspconfig.lua` (mason + mason-lspconfig + blink capabilities).
  - .NET-focused behavior in `lua/squirrel/lazy/easy-dotnet.lua` and `lsp/easy_dotnet.lua`.
  - C# snippets in `lua/custom/csharp.lua`.
  - C# debugging stack in `lua/squirrel/lazy/nvim-dap.lua` + `nvim-dap-view.lua` + `squirrel/dap_signs.lua`.

## Key conventions in this codebase

- Keep Neovim Lua code modular: new behavior usually belongs in `lua/squirrel/*` or a new plugin spec file in `lua/squirrel/lazy/`.
- Use `vim.keymap.set(..., { desc = "..." })` for new mappings; existing mappings rely on readable descriptions for discoverability.
- Preserve leader conventions (`vim.g.mapleader = " "` and `maplocalleader = " "`).
- Maintain existing event-based lazy-loading patterns (`event`, `cmd`, `ft`, `lazy`) when adding plugins.
- Keep Copilot Enterprise host values aligned:
  - `vim.g.copilot_enterprise_uri` in `lua/squirrel/set.lua`
  - `auth_provider_url` in `lua/squirrel/lazy/copilot.lua`
- If you touch C# files in this repo, also follow `.copilot/copilot-instructions.md` and `.copilot/instructions/csharp.instructions.md` (C#-specific standards and formatting expectations).
- Tree-sitter config contains custom parser registration under the `User TSUpdate` autocmd in `lua/squirrel/lazy/treesitter.lua`; preserve that pattern when adding parsers.
