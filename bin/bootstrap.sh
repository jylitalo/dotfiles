#!/bin/sh

mkdir -p ~/bin ~/etc/zsh_functions ~/jylitalo ~/Yleisradio
if [ -f $HOME/etc/Brewfile ]; then
  brew bundle install --file=$HOME/etc/Brewfile
fi
pip3 install boto3 requests

