#cmd
alias c='clear_screen'
alias ..='cd ..'

#git
set rootdq '/mnt/c/DataQuint'
set rootdoc '/mnt/c/Users/NicolaiSättler/Documents'
set rootcs '/mnt/c/Users/NicolaiSättler/Documents/Privé/CodeSquirrel'

alias cleanup='git branch --merged | grep  -v "\\*\\|master\\|develop" | xargs -n 1 git branch -d'
alias graphfull='git log --graph --all --decorate --oneline --stat'
alias graph='git log --graph --abbrev-commit --decorate --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n"" %C(white)%s%C(reset) %C(dim white)- %an%C(reset)" --all'
alias dqdirstatus='loop_dir_git_status $rootdq'
alias dqdirpull='loop_dir_git_pull $rootdq'
alias dqdirfetch='loop_dir_git_fetch $rootdq'
alias dqdircheckout='loop_dir_git_checkout $rootdq'
alias dqdirpush='loop_dir_git_push $rootdq'
alias dqdirgc='loop_dir_git_gc $rootdq'
#alias jtags='ctags -R app config lib && sed -i ‘’ -E ‘/^(if|switch|function|module\.exports|it|describe).+language:js$/d’ tags'

fish_vi_key_bindings

#powerline
#installation --> sudo apt isntall fish powerline
set fish_function_path $fish_function_path "/usr/share/powerline/bindings/fish"
source /usr/share/powerline/bindings/fish/powerline-setup.fish
powerline-setup
