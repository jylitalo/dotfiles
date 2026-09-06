#!/bin/sh
# shellcheck disable=SC1091,SC3024,SC3030

LANG=C
# Setup Homebrew
if [ -z "$HOMEBREW_PREFIX" ] && [ -f /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -z "$HOMEBREW_PREFIX" ] && [ -f /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi
if [ ! -z "$TERM" ]; then
  infocmp "$TERM" > /dev/null 2>&1
  ret=$?
  if [ "$ret" -ne "0" ] && [ "$TERM" = "xterm-ghostty" ]; then
    TERM=xterm
  fi
fi
# Setup dotfiles
# shellcheck disable=SC2139
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
##
# Setup prompt
##
setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats '%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:*' enable git
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    # shellcheck disable=SC1087,SC2154
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}
# shellcheck disable=SC2016,SC2034
RPROMPT='$(vcs_info_wrapper)'
# shellcheck disable=SC2034
PROMPT="%n@%m %9~ %# "

# colima setup
# if command -v colima &> /dev/null; then
#   if ! colima status &> /dev/null; then
#     colima start --ssh-agent --vm-type=vz --mount-type=virtiofs
#   fi
# fi

# setup docker-buildx
if [ ! -d ~/.docker/cli-plugins ]; then
  mkdir -p ~/.docker/cli-plugins
  ln -sfn "${HOMEBREW_PREFIX}/opt/docker-buildx/bin/docker-buildx" ~/.docker/cli-plugins/docker-buildx
fi

# Local add-ons
if [ -f "$HOME/.zshrc_local" ]; then
  . "$HOME/.zshrc_local"
fi

# Add $HOME/bin to PATH
PATH=$PATH:$HOME/bin

# zsh completion
if [ -d "$HOME/etc/zsh_functions" ]; then
  fpath+=("$HOME/etc/zsh_functions")
  export fpath
fi
autoload -U compinit
compinit
if [ -n "$HOMEBREW_PREFIX" ]; then
  if [ -f "${HOMEBREW_PREFIX}/share/zsh/site-functions/aws_zsh_completer.sh" ]; then
    . "${HOMEBREW_PREFIX}/share/zsh/site-functions/aws_zsh_completer.sh"
  fi
  # added by Snowflake SnowSQL installer v1.2
  export PATH=/Applications/SnowSQL.app/Contents/MacOS:"$PATH"
  [ -f "$HOMEBREW_PREFIX/bin/atuin" ] || brew install atuin
  [ -f "$HOMEBREW_PREFIX/bin/figlet" ] || brew install figlet
  [ -f "$HOMEBREW_PREFIX/bin/fzf" ] || brew install fzf
  [ -f "$HOMEBREW_PREFIX/bin/zoxide" ] || brew install zoxide
  [ ! -f "$HOME/.cargo/env" ] || . "$HOME/.cargo/env"
  [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && . "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
  [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && . "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
  export NVM_DIR="$HOME/.nvm"
fi

eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)" # we want atuin keymaps to override fzf

figlet -f slant "$HOST"

# update option+left/right for backward-word/forward-word
bindkey '\e\e[C' forward-word
bindkey '\e\e[D' backward-word

export PATH="$HOME/.local/bin:$PATH"
alias k=kubecolor
alias v=nvim
