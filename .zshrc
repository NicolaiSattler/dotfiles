# add brew and netcoredbg to path
export PATH="~/.dotnet/tools:/opt/homebrew/bin:/Applications/netcoredbg:/home/linuxbrew/.linuxbrew/bin:/usr/local/go/bin:/opt/homebrew/bin:/usr/local/bin/netcoredbg/netcoredbg:$PATH" >> ~/.zshrc
export ZSH="$HOME/.oh-my-zsh"                           # Path to your oh-my-zsh installation.
export EDITOR='nvim'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"       # colorize man with bat.

zstyle ':omz:update' mode reminder                      # ow my zsh update: remind me to update

bindkey -v                                              # enable vi mode
bindkey jj vi-cmd-mode

plugins=(git z fzf vi-mode)

ZSH_THEME="wezm+" # set by `omz`
# ENABLE_CORRECTION="true"

# FZF
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"
export FZF_COMPLETION_OPTS='--border --info=inline'

source $ZSH/oh-my-zsh.sh
# https://github.com/zsh-users/zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

alias ..='cd ..'
alias ll='eza -alh --icons --git'
alias lt="eza --tree --level=2 --long --icons --git"
alias myip='curl http://ipecho.net/plain; echo'
alias bathelp='bat --plain --language=help'
alias vim=$(brew --prefix)'/bin/nvim'

alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gs="git status"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gdiffc="git diff"
alias gco="git checkout"
alias gb='git branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'
alias gcoall='git checkout -- .'

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

# Add ssh-keys
eval `ssh-agent -s`
ssh-add
