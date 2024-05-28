
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
- eza
- bat
- zoxide
- fzf
- tree
- ripgrep
- neovim

# dotfiles
To trust dev-cert on linux run

```bash
dotnet tool update -g linux-dev-certs
dotnet linux-dev-certs install

```
# Requirements
Developing in c#:
- [dotnet 8 sdk](https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/sdk-8.0.300-macos-arm64-installer)

- For debugging download:
    - Download [netcoredbg](https://github.com/Samsung/netcoredbg)
    - extract the folder in `/usr/local/bin/netcoredbg`
    - set rights `chmod 744 /usr/local/bin/netcoredbg/*`
    - remove quaratine label `find /usr/local/bin/netcoredbg/* | xargs xattr -r -d com.apple.quarantine`
