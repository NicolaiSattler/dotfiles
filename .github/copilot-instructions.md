<<<<<<< HEAD
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
||||||| parent of 32479a9 (full screen wezterm)
=======
# Copilot Instructions

## What this repo is

Personal dotfiles for a .NET developer. Managed with [GNU Stow](https://www.gnu.org/software/stow/) — files are placed at the exact relative path they will be symlinked to in `$HOME`.

**Primary environments:** macOS (personal) and WSL2/Ubuntu (professional).

## Deployment

```bash
brew bundle          # install all tools from Brewfile
cd ~/dotfiles
stow .               # symlink everything into $HOME
```

To install a specific .NET SDK version:
```bash
sudo ./dotnet-install.sh --channel 8.0 --install-dir /usr/lib/dotnet
```

## Architecture

```
dotfiles/
├── .config/
│   └── nvim/              # Neovim config
│       ├── init.lua        # Entry: loads lua/squirrel
│       └── lua/
│           └── squirrel/   # All nvim config lives here
│               ├── lazy/   # One file per plugin
│               └── *.lua   # set.lua, remap.lua, colors.lua, ...
├── wezterm/
│   └── .wezterm.lua        # Terminal config, platform-branched
├── tmux/
│   └── tmux-sessionizer    # Session helper script
├── .tmux.conf
├── .zshrc
├── .zsh_aliases
├── .gitconfig
└── Brewfile
```

## Key conventions

### Stow layout
Every file must live at the path it should occupy relative to `$HOME`. Do not create intermediate wrapper directories. When adding a new tool's config, mirror `~/.config/<tool>/` as `.config/<tool>/` inside the repo.

### Neovim: `squirrel` namespace
All Neovim Lua code lives under `lua/squirrel/`. The entry point is `lua/squirrel/init.lua`, which requires the sub-modules. Plugins are managed by [lazy.nvim](https://github.com/folke/lazy.nvim); each plugin gets its own file in `lua/squirrel/lazy/`.

### Cross-platform branching
WezTerm config (`wezterm/.wezterm.lua`) branches on `wezterm.target_triple` to handle macOS vs Windows/WSL2 differences. Follow the same pattern when a config must differ between platforms — use a conditional block rather than separate files.

### Consistent theme: Tokyo Night Moon
All tools use the **Tokyo Night Moon** colour scheme (`#1e2030` background, `#82aaff` accent). Maintain this when configuring new tools.

### .NET tooling in Neovim
`easy-dotnet.nvim` provides the full .NET workflow inside Neovim (build, test, debug, run). It uses the Roslyn LSP. Key bindings set in `lua/squirrel/lazy/easy-dotnet.lua`:
- `<C-T>` — open test runner
- `<C-B>` — build solution

### tmux prefix
The tmux prefix is `Ctrl-A` (not the default `Ctrl-B`). Split panes with `prefix + v` (vertical) and `prefix + h` (horizontal).

### Shell aliases
Git shortcuts live in `.zsh_aliases`. Common ones: `gc` (commit), `gp` (push HEAD), `gl` (pretty log via bat), `gb` (fzf branch switcher), `lg` (lazygit). Navigation: `ll` / `lt` use `eza`. File search (`v`) pipes `fd` → `fzf` → `nvim`.
>>>>>>> 32479a9 (full screen wezterm)
