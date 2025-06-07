# Setup Homebrew
GOARCH=$(uname -m)
BREW_PATH=/usr/local
if [ "$GOARCH" = "arm64" ]; then
  BREW_PATH=/opt/homebrew
fi

eval "$(${BREW_PATH}/bin/brew shellenv)"
# Setup dotfiles
alias config='/usr/bin/git --git-dir=/Users/jylitalo/.dotfiles/ --work-tree=/Users/jylitalo'

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
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  fi
}
RPROMPT=$'$(vcs_info_wrapper)'
PROMPT="%n@%m %9~ %# "

# setup chtf
if [[ -f "${BREW_PATH}/share/chtf/chtf.sh" ]]; then
  source "${BREW_PATH}/share/chtf/chtf.sh"
  chtf 1.9.6
fi

# colima setup
# if command -v colima &> /dev/null; then
#   if ! colima status &> /dev/null; then
#     colima start --ssh-agent --vm-type=vz --mount-type=virtiofs
#   fi
# fi

# setup docker-buildx
if [ ! -d ~/.docker/cli-plugins ]; then
  mkdir -p ~/.docker/cli-plugins
  ln -sfn "${BREW_PATH}/opt/docker-buildx/bin/docker-buildx" ~/.docker/cli-plugins/docker-buildx
fi

# Local add-ons
if [ -f "$HOME/.zshrc_local" ]; then
  source "$HOME/.zshrc_local"
fi

# Add $HOME/bin to PATH
PATH=$PATH:$HOME/bin

# zsh completion
if [ -d "$HOME/etc/zsh_functions" ]; then
  fpath+=($HOME/etc/zsh_functions)
  export fpath
fi
autoload -U compinit
compinit
if [ -f "${BREW_PATH}/share/zsh/site-functions/aws_zsh_completer.sh" ]; then
  source "${BREW_PATH}/share/zsh/site-functions/aws_zsh_completer.sh"
fi
unset BREW_PATH
eval "$(atuin init zsh)"
figlet -f slant $HOST

# update option+left/right for backward-word/forward-word
bindkey '\e\e[C' forward-word                                                                                                                                                                     [dark-theme]
bindkey '\e\e[D' backward-word

# added by Snowflake SnowSQL installer v1.2
export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH
. "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
nvm use 20.13.1
