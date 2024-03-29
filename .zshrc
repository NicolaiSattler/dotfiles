# add brew and netcoredbg to path
export PATH="/opt/homebrew/bin:/Applications/netcoredbg:$PATH" >> ~/.zshrc       
export ZSH="$HOME/.oh-my-zsh"                           # Path to your oh-my-zsh installation.
export EDITOR='nvim'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"       # colorize man with bat.

zstyle ':omz:update' mode reminder                      # ow my zsh update: remind me to update
bindkey -v                                              # enable vi mode

plugins=(git z fzf)

ZSH_THEME="wezm+" # set by `omz`
# ENABLE_CORRECTION="true"

# FZF
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"
export FZF_COMPLETION_OPTS='--border --info=inline'

source $ZSH/oh-my-zsh.sh
# https://github.com/zsh-users/zsh-autosuggestions 
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

alias ..='cd ..'
alias ll='exa -alh'
alias myip='curl http://ipecho.net/plain; echo'
alias bathelp='bat --plain --language=help'
alias vim='/opt/homebrew/bin/nvim'

gitcleanup() {
    git branch | grep -v "main" | xargs git branch -D
}
gitdiff() {
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
}

help() {
    "$@" --help 2>&1 | bathelp
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
