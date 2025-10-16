# Dotfile

This repository contains my dotfiles which I use for my day to day usage. 
I'm a dotnet developer running WSL2 (Ubuntu) professionally and MacOS personally. Therefor there are some environment based configurations.

# Brew
_Make sure to have [brew](https://docs.brew.sh) installed as package manager._

> run `brew bundle` it will install taps and brews

# ZSH and Starship
Install the following command line utilties:
- zsh
- To install `oh-my-zsh` execute the following command.
```bash
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
> Change default shell with chsh -s /bin/zsh

Check out my [Brewfile](./Brewfile) for a better look for all the cli tools I use.

# Git
I do not have any editor plugins for git. I prefer the buildin git cli utilties with some extra's like [delta](https://github.com/dandavison/delta)

- Git [aliases](./.zshrc) for quick command
- Git [configuration](./.gitconfig) for delta, merge editor etc.

# Initialization
```bash
cd dotfiles
stow .
```
> `stow` will create a symlink in the root folder.

## SSL with developer certificates
To trust dev-cert on linux run

```bash
dotnet tool update -g linux-dev-certs
dotnet linux-dev-certs install

```
# Requirements
## Nerd Font
Make sure to have install `JetBrains Mono`

## C# SDK
Install the SDK with:
```bash
sudo ./dotnet-install.sh  --channel 8.0 --install-dir /usr/lib/dotnet
```
> change the channel to download other versions.
or download vi [dotnet 8 sdk](https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/sdk-8.0.300-macos-arm64-installer)
