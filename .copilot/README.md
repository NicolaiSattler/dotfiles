# Microsoft Copilot CLI configuration

The files in this directory are linked to `~/.copilot` through GNU Stow:

```bash
cd ~/dotfiles
stow --restow .
```

Only declarative configuration, instructions, hooks, agents, and skills belong
here. Session state, logs, authentication data, caches, and lock files remain
under the local `~/.copilot` directory.

## Awesome Lists
- [Awesome-copilot](https://github.com/github/awesome-copilot)
- [Skills](https://skills.sh)
