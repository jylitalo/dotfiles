#!/bin/bash
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
export LANG=C.UTF-8
if [[ "$PATH" != "$HOME/.local/bin:$HOME/bin:"* ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
if [[ "$TERM" == "xterm-ghostty" ]]; then
    TERM="xterm"
fi
export PATH TERM

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            # shellcheck disable=SC1090
            . "$rc"
        fi
    done
fi
unset rc
# shellcheck disable=SC2139
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias k=kubecolor
alias v=nvim
# eval "$(atuin init bash)"
