# dotfiles
personal dotfiles for MacOS

Based on https://www.atlassian.com/git/tutorials/dotfiles

## Setup

```
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
git clone --bare https://github.com/jylitalo/dotfiles.git $HOME/.dotfiles
config checkout
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

