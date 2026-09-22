# Nicolai's dotfiles

Personal development-environment configuration for:

- **WSL2 / Ubuntu** for daily .NET development
- **macOS** for personal use
- **Windows-hosted tools** such as VS Code and WezTerm

The repository is managed with [GNU Stow](https://www.gnu.org/software/stow/).
The main shell, terminal, Git, tmux, Copilot CLI, and Neovim configuration is
kept in this repository so it can be reproduced on a new machine.

> [!IMPORTANT]
> The `Brewfile` contains Linux/macOS CLI tools, macOS GUI casks, VS Code
> extensions, and Go tools. WSL uses `Brewfile.linux` instead, because macOS
> casks must be installed on macOS or Windows.

## Repository layout

| Path | Purpose |
| --- | --- |
| `.bashrc`, `.zshrc`, `.zsh_aliases` | Shell startup, environment variables, functions, and aliases |
| `.fzf.bash`, `.fzf.zsh` | fzf completion and key bindings |
| `.config/nvim/` | Neovim editor configuration and lazy.nvim lock file |
| `.config/starship.toml` | Starship prompt configuration |
| `.config/atuin/` | Atuin history configuration |
| `.config/bat/` | bat themes and settings |
| `.config/lazygit/` | Lazygit theme and settings |
| `.config/lazydocker/` | Lazydocker settings |
| `.config/gh/` | GitHub CLI configuration |
| `.config/mimeapps.list` | Linux default application associations |
| `.copilot/` | Copilot CLI instructions, agents, skills, hooks, and permissions |
| `.gitconfig` | Git defaults, delta integration, aliases, and merge tools |
| `.tmux.conf` | tmux key bindings, theme, plugins, and persistence |
| `wezterm/` | WezTerm configuration and Tokyo Night color schemes |
| `dotnet-install.sh` | Microsoft .NET SDK installer |
| `dotnet-tools.json` | Local .NET tool manifest |
| `Brewfile` | Homebrew packages, casks, VS Code extensions, and Go tools |
| `Brewfile.linux` | WSL/Linux-only Homebrew packages and Go tools |
| `wsl/.wslconfig` | Windows-hosted WSL2 settings |
| `install.sh` | Cross-platform bootstrap script |

## Installation

### WSL2 / Ubuntu

The supported bootstrap path is:

```bash
git clone https://github.com/NicolaiSattler/dotfiles.git "$HOME/dotfiles"
cd "$HOME/dotfiles"
./install.sh
```

The script installs Ubuntu prerequisites, Homebrew on Linux, the WSL-specific
`Brewfile.linux`, .NET 8, local .NET tools, Oh My Zsh, tmux Plugin Manager,
the Windows-hosted WSL2 configuration, Stow links, and Neovim plugins.

The script supports these environment variables:

```bash
DOTNET_CHANNEL=10.0 ./install.sh
DOTNET_DIR="$HOME/.dotnet" ./install.sh
```

For a dry review before installation, inspect `install.sh` and
`Brewfile.linux`. The script is intentionally non-interactive except for
`sudo`, Homebrew's installer, and any authentication prompts from external
tools.

The lower-level steps are shown below for troubleshooting or partial
installation.

Install [Homebrew on Linux](https://brew.sh/) manually if required:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
brew update
```

Install the Linux bundle manually:

```bash
brew bundle --file=Brewfile.linux
```

Install .NET and restore the repository tools manually:

```bash
./dotnet-install.sh --channel 8.0 --install-dir "$HOME/.dotnet"
export PATH="$HOME/.dotnet:$HOME/.dotnet/tools:$PATH"
dotnet tool restore --tool-manifest ./dotnet-tools.json
```

Install Oh My Zsh if it is not already present:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s "$(command -v zsh)"
```

Link the configuration and synchronize Neovim plugins:

```bash
git clone https://github.com/NicolaiSattler/dotfiles.git "$HOME/dotfiles"
cd "$HOME/dotfiles"
stow --restow .
nvim --headless "+Lazy! sync" +qa
```

Install tmux Plugin Manager manually:

```bash
git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
```

Start tmux and press `prefix + I` (`Ctrl-a`, then `Shift-i`) to install the
configured tmux plugins.

### macOS

Install Homebrew from [brew.sh](https://brew.sh/), then run the same bootstrap
script:

```bash
cd "$HOME/dotfiles"
./install.sh
```

On macOS, `install.sh` uses `Brewfile`, including its GUI casks and VS Code
extensions. The Brewfile should still be reviewed before use because it
contains personal application choices.

### Windows host

Install these outside WSL:

- VS Code
- WezTerm or Ghostty
- a Nerd Font such as JetBrains Mono
- Docker Desktop with WSL integration, or another Docker host

Use the VS Code Remote - WSL extension to open projects inside Ubuntu. The
WezTerm configuration already defines a `WSL:Ubuntu` domain when running on
Windows. On WSL, `install.sh` copies `wsl/.wslconfig` to the Windows user
profile as `.wslconfig`; restart WSL with `wsl --shutdown` for changes to
take effect. The `defaultVhdSize=200GB` setting applies to new WSL virtual
disks; it does not move or resize existing distributions.

The current Ubuntu distribution is stored separately on the Windows D drive:

```text
D:\WSL\ext4.vhdx
```

This location is managed by WSL's per-distribution registration rather than
`.wslconfig`. To reproduce it on another machine, install or import Ubuntu,
then move the distribution to the desired location with:

```powershell
wsl --manage Ubuntu --move D:\WSL
```

The VHDX itself should not be committed to this repository. Back it up or
export the distribution separately when migrating:

```powershell
wsl --export Ubuntu D:\Backups\ubuntu.tar
```

## Environment notes

The shell configuration currently assumes:

- `.NET` is installed under `$HOME/.dotnet`;
- Aspire is installed under `$HOME/.aspire/bin`;
- Rust may provide `$HOME/.cargo/env`;
- `nvim`, `fzf`, `bat`, `eza`, `fd`, `atuin`, `starship`, `zoxide`, and
  `keychain` are available;
- the GitHub Enterprise host is `stichting-bkr.ghe.com`;
- ASP.NET development certificates are trusted under
  `$HOME/.aspnet/dev-certs/trust`;
- Playwright uses `ENV=test`.

The shell files still contain hard-coded Homebrew and macOS paths. For a
portable WSL setup, replace those paths with conditional `brew --prefix`
lookups and Linux/macOS-specific path handling before migrating.

Do not copy authentication databases or host credentials between machines.
Authenticate again on the new device with the relevant tools, such as:

```bash
gh auth login
dotnet dev-certs https --trust
```

The `GITHUB_HOST` value is an environment setting for the configured GitHub
Enterprise instance; it is not a credential.

## Tool inventory

### Shell and terminal tools

| Tool | Used for |
| --- | --- |
| Bash | Default-compatible shell scripting and non-interactive startup |
| Zsh | Interactive shell used by `.zshrc` |
| Oh My Zsh | Zsh framework expected by the shell configuration |
| Starship | Cross-platform shell prompt |
| tmux | Terminal multiplexing, persistent sessions, and split panes |
| TPM | Installs and manages tmux plugins |
| WezTerm | Configured terminal emulator, including the Windows WSL domain |
| Ghostty | Alternative terminal emulator listed for macOS |
| JetBrains Mono / Nerd Font | Terminal and editor font with icon glyphs; the current Brewfile installs Hack Nerd Font while WezTerm is configured for JetBrains Mono |

### Navigation, search, and command-line UX

| Tool | Used for |
| --- | --- |
| `atuin` | Searchable shell history and Ctrl-R replacement |
| `bat` | Syntax-highlighted file and man-page viewer |
| `btop` | Interactive process, CPU, memory, and system monitor |
| `carapace` | Shell completion generator |
| `eza` | Modern `ls` replacement with tree, Git, and icon support |
| `fd` | Fast, user-friendly `find` replacement |
| `fzf` | Fuzzy finder used by shell completion, Git aliases, and file navigation |
| `fzf-tmux` | fzf interface displayed in a tmux popup or pane |
| `glow` | Terminal Markdown renderer |
| `ripgrep` (`rg`) | Fast text search, including the `vw` editor/search alias |
| `tree` | Directory tree display |
| `zoxide` | Frecency-based directory jumping |
| `dos2unix` | Converts Windows line endings to Unix line endings |
| `curl` | HTTP requests, downloads, and bootstrap scripts |
| `zsh-autosuggestions` | Fish-like suggestions while typing in Zsh |

### GitHub, Git, and repository tools

| Tool | Used for |
| --- | --- |
| Git | Version control and repository management |
| GitHub CLI (`gh`) | GitHub authentication, repositories, pull requests, and issues |
| `git-delta` | Side-by-side, syntax-highlighted Git diff pager |
| `diff-so-fancy` | Human-friendly diff formatting |
| Lazygit | Terminal UI for Git workflows |
| GNU Stow | Symlink manager for deploying this repository as dotfiles |
| Copilot CLI | Terminal-based AI coding assistant configuration under `.copilot/` |

### .NET and Azure development

| Tool | Used for |
| --- | --- |
| .NET SDK 8 | Building and running .NET applications |
| `dotnet-ef` | Entity Framework Core migrations and database operations |
| `dotnet-outdated-tool` | Finds outdated NuGet dependencies |
| `dotnet-repl` | Interactive .NET and C# REPL |
| `dotnet-format` | Formats and analyzes .NET code |
| `linux-dev-certs` | Installs trusted ASP.NET development certificates on Linux |
| Azure CLI | Azure resource management from the terminal |
| Azure Functions Core Tools v4 | Local Azure Functions development and execution |
| Aspire CLI | .NET Aspire app-host development and orchestration |
| Azure Data Studio | Database client listed as a macOS cask; use a supported replacement where needed |
| DB Browser for SQLite | Desktop SQLite database browser listed as a macOS cask |

### Languages, runtimes, and build tools

| Tool | Used for |
| --- | --- |
| Go | Go development and building Go-based tooling |
| Delve (`dlv`) | Go debugger |
| `gopls` | Go language server |
| `staticcheck` | Go static analysis |
| Node.js | JavaScript tooling and Neovim plugin development dependencies |
| Python | General scripting and development tooling |
| CMake | Cross-platform native build configuration |
| GNU Make | Build automation |
| Lua | Neovim configuration and Lua development |
| LuaRocks | Lua package manager |
| Tree-sitter | Incremental parsing used by Neovim syntax and language features |
| `icu4c` | Unicode and globalization libraries; the pinned `icu4c@76` entry is stale |

### Containers and debugging

| Tool | Used for |
| --- | --- |
| Docker | Container builds and local container workflows |
| Lazydocker | Terminal UI for Docker containers and images |
| `netcoredbg` | .NET debugger used by the Neovim DAP configuration |
| `win32yank` | Windows clipboard integration for Neovim; bundled as a Windows binary under `.config/nvim/` |
| `ios-webkit-debug-proxy` | iOS WebKit debugging; generally not relevant inside WSL |
| `font-hack-nerd-font` | Homebrew cask for a Nerd Font; the current terminal configuration uses JetBrains Mono instead |


## Common aliases

| Alias | Purpose |
| --- | --- |
| `ll` / `lt` | Long and tree views using `eza` |
| `lg` | Open Lazygit |
| `v` | Select a file with fzf and open it in Neovim |
| `vw` | Search text with ripgrep, preview with bat, and open the selected line in Neovim |
| `gs`, `gd`, `gdc` | Git status and working/index diff |
| `ga`, `gadd` | Interactive or regular Git staging |
| `gc`, `gca`, `gcan` | Commit and amend commits |
| `gp`, `gpu`, `gf` | Push, pull, and fetch |
| `gb`, `gba`, `gco` | Browse branches, list branches, and check out a branch |
| `gl`, `gls` | Formatted Git log and interactive commit inspection |
| `kp` | Select a process with fzf and terminate it |
| `myip` | Print the public IP address |
| `bathelp` | Render command help through bat |

## Maintenance checklist

Before moving to a new WSL device:

1. Split the Brewfile into Linux, macOS, and Windows-hosted sections.
2. Replace `exa`, `icu4c@76`, and `python@3.9` with supported entries.
3. Remove hard-coded `/opt/homebrew`, `/Applications`, and other macOS-only
   paths from the shell startup files.
4. Guard optional files such as `$HOME/.cargo/env` and fzf integrations.
5. Install and configure Docker Desktop WSL integration or Docker Engine.
6. Re-authenticate GitHub, Azure, Copilot, and any private package feeds.
7. Run `stow --restow .` and `nvim --headless "+Lazy! sync" +qa`.
