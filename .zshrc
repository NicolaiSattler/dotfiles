export DOTNET_ROOT=~/.dotnet
export PATH="$DOTNET_ROOT:~/.dotnet/tools:/.cargo/bin:/Applications/netcoredbg:/home/linuxbrew/.linuxbrew/bin:/usr/local/go/bin:/opt/homebrew/bin:/usr/local/bin/netcoredbg/netcoredbg:$PATH" >> ~/.zshrc
export GH_HOST=stichting-bkr.ghe.com
export ASPNETCORE_ENVIRONMENT=Development
export SSL_CERT_DIR=$HOME/.aspnet/dev-certs/trust:/usr/lib/ssl/certs
export ZSH="$HOME/.oh-my-zsh"                           # Path to your oh-my-zsh installation.
export EDITOR='nvim'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"       # colorize man with bat.
export EZA_CONFIG="$HOME/.config/eza/"

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

bindkey -v                                              # enable vi mode
bindkey jj vi-cmd-mode
bindkey '^ ' autosuggest-execute

plugins=(git vi-mode)

# https://github.com/zsh-users/zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.cargo/env

alias ..='cd ..'
alias ll='eza -alh --icons --git'
alias lt="eza --tree --level=2 --long --icons --git"
alias myip='curl http://ipecho.net/plain; echo'
alias bathelp='bat --plain --language=help'
alias vim=$(brew --prefix)'/bin/nvim'
alias ff='firefox > /dev/null 2>&1 &'
alias kp='ps aux | fzf | awk "{print \$2}" | xargs kill -9'
alias v='fd --type f --hidden --exclude .git | fzf-tmux -p | xargs nvim'
alias vw='rg --color=always --line-number --no-heading --smart-case "${*:-}" | \
  fzf --ansi \
      --color "hl:-1:underline,hl+:-1:underline:reverse" \
      --delimiter : \
      --preview "bat --color=always {1} --highlight-line {2}" \
      --preview-window "up,60%,border-bottom,+{2}+3/3,~3" \
      --bind "enter:become(nvim {1} +{2})"'

alias gc="git commit"
alias gca="git commit --amend"
alias gcan="git commit -a --amend --no-edit"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gf="git fetch"
alias gs="git status"
alias gl="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit | bat -l gitlog"
alias gls='git log --graph --topo-order --abbrev-commit --pretty=format:"%h - %s (%ar) <%an>" | fzf-tmux | awk '"'"'{print $1}'"'"' | xargs git show'
alias gd="git diff"
alias gdc="git diff --cached"
alias gco="git checkout"
alias gb='branch=$(git branch -a | fzf-tmux | xargs echo -n) && [[ $branch == remotes/origin/* ]] && git checkout ${branch#remotes/origin/} || git checkout $branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'
alias gcoall='git checkout -- .'

function gitcleanup() {
    git branch | grep -v "main" | xargs git branch -D
}

function help() {
    "$@" --help 2>&1 | bathelp
}

#FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#Use fd instead of find
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
# Tokyo Night Moon
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none \
  --color=bg+:#283457 \
  --color=bg:#16161e \
  --color=border:#27a1b9 \
  --color=fg:#c0caf5 \
  --color=gutter:#16161e \
  --color=header:#ff9e64 \
  --color=hl+:#2ac3de \
  --color=hl:#2ac3de \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#2ac3de \
  --color=query:#c0caf5:regular \
  --color=scrollbar:#27a1b9 \
  --color=separator:#ff9e64 \
  --color=spinner:#ff007c \
"

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Add ssh-keys
eval `keychain id_rsa`

eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"
eval "$(starship init zsh)"
