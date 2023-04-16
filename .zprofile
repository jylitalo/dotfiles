# Setup Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
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
PROMPT="[%m:%~]%# "

# Add $HOME/bin to PATH
PATH=$PATH:$HOME/bin
