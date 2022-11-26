# MacOS dotfiles
_Make sure to have [brew](https://docs.brew.sh) installed as package manager._

Install the following command line utilties:
- zsh
    - To install `oh-my-zsh` execute the following command.
    ```bash
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    ```
    > Change default shell with chsh -s /bin/zsh
- zsh_autocomplete
- exa
- bat
- zoxide
- fzf
- tree
- ripgrep
- lvim
    - To install Lunar Vim execute the following command:
    ```bash
    LV_BRANCH='release-1.2/neovim-0.8' bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)
    ```
    > Make sure the Prerequisites are installed! https://www.lunarvim.org/docs/installation 
