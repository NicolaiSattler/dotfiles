# MacOS dotfiles
_Make sure to have [brew](https://docs.brew.sh) installed as package manager._

> run `brew bundle` it will install taps and brews

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
- neovim
- [netcoredbg](https://github.com/Samsung/netcoredbg)
    - extract the folder in `/usr/local/bin/netcoredbg`
    - set rights `chmod 744 /usr/local/bin/netcoredbg/*`
    - remove quaratine label `find /usr/local/bin/netcoredbg/* | xargs xattr -r -d com.apple.quarantine`

