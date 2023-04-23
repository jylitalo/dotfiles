#!/bin/sh

mkdir -p ~/bin ~/jylitalo ~/Yleisradio
if [ -f $HOME/etc/Brewfile ]; then
  brew bundle install --file=$HOME/etc/Brewfile
fi

