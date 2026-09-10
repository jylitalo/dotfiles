# dotfiles
personal dotfiles for Linux & MacOS

Based on https://www.atlassian.com/git/tutorials/dotfiles

## Setup

```
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
git clone --bare https://github.com/jylitalo/dotfiles.git $HOME/.dotfiles
config checkout
config config --local status.showUntrackedFiles no
# Homebrew installation on MacOS
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Directory tree

- `Library/` is MacOS specific thing
- `.config/` is Linux specific thing

### Shells

Right now I am using zsh in MacOS and bash in Linux (as they are defaults in each OS)
