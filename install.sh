#!/usr/bin/env bash

set -Eeuo pipefail

readonly REPO_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
readonly DOTNET_DIR="${DOTNET_DIR:-$HOME/.dotnet}"
readonly DOTNET_CHANNEL="${DOTNET_CHANNEL:-10.0}"

log() {
  printf '\n==> %s\n' "$*"
}

die() {
  printf 'Error: %s\n' "$*" >&2
  exit 1
}

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

is_wsl() {
  [[ -n "${WSL_DISTRO_NAME:-}" || -n "${WSL_INTEROP:-}" ]] ||
    grep -qi microsoft /proc/version 2>/dev/null
}

install_apt_prerequisites() {
  command_exists apt-get || return 0

  log "Installing Ubuntu prerequisites"
  sudo apt-get update
  sudo apt-get install -y \
    build-essential \
    ca-certificates \
    curl \
    file \
    git \
    procps \
    unzip
}

configure_brew_path() {
  if [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  elif [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
}

install_homebrew() {
  configure_brew_path
  command_exists brew && return 0

  log "Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  configure_brew_path
  command_exists brew || die "Homebrew installation completed but brew is not on PATH"
}

install_brew_bundle() {
  local brewfile="$REPO_DIR/Brewfile"

  if is_wsl || [[ "$(uname -s)" == "Linux" ]]; then
    brewfile="$REPO_DIR/Brewfile.linux"
  fi

  log "Installing Homebrew dependencies from $(basename "$brewfile")"
  brew update
  brew bundle install --file="$brewfile"
}

install_dotnet() {
  if command_exists dotnet && dotnet --list-sdks | grep -qE '(^|[[:space:]])8\.'; then
    log ".NET 10 SDK already installed"
    return 0
  fi

  log "Installing .NET SDK ${DOTNET_CHANNEL}"
  "$REPO_DIR/dotnet-install.sh" \
    --channel "$DOTNET_CHANNEL" \
    --install-dir "$DOTNET_DIR" \
    --no-path
}

restore_dotnet_tools() {
  log "Restoring local .NET tools"
  export DOTNET_ROOT="$DOTNET_DIR"
  export PATH="$DOTNET_DIR:$DOTNET_DIR/tools:$PATH"
  dotnet tool restore --tool-manifest "$REPO_DIR/dotnet-tools.json"
}

install_oh_my_zsh() {
  [[ -d "$HOME/.oh-my-zsh" ]] && return 0

  log "Installing Oh My Zsh"
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

install_tpm() {
  local tpm_dir="$HOME/.tmux/plugins/tpm"
  [[ -d "$tpm_dir" ]] && return 0

  log "Installing tmux Plugin Manager"
  git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
}

link_dotfiles() {
  log "Linking dotfiles with GNU Stow"
  cd "$REPO_DIR"
  stow --restow .
}

install_wsl_config() {
  is_wsl || return 0

  local windows_profile
  windows_profile="$(cmd.exe /C 'echo %USERPROFILE%' 2>/dev/null | tr -d '\r')" ||
    die "Unable to determine the Windows user profile"
  [[ -n "$windows_profile" ]] || die "Windows user profile path is empty"

  windows_profile="$(wslpath "$windows_profile")" ||
    die "Unable to convert the Windows user profile path"

  local target="$windows_profile/.wslconfig"
  if cmp -s "$REPO_DIR/wsl/.wslconfig" "$target" 2>/dev/null; then
    log "WSL configuration is already up to date"
    return 0
  fi

  log "Installing WSL configuration to $target"
  install -m 0644 "$REPO_DIR/wsl/.wslconfig" "$target"
}

sync_neovim() {
  command_exists nvim || return 0

  log "Synchronizing Neovim plugins"
  nvim --headless "+Lazy! sync" +qa
}

main() {
  cd "$REPO_DIR"

  install_apt_prerequisites
  install_homebrew
  install_brew_bundle
  install_dotnet
  restore_dotnet_tools
  install_oh_my_zsh
  install_tpm
  install_wsl_config
  link_dotfiles
  sync_neovim

  log "Installation complete"
  printf 'Restart your shell, or run: exec zsh\n'
}

main "$@"
