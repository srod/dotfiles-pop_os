#!/usr/bin/env bash

set -e

zsh_bin=$(grep /zsh$ /etc/shells | tail -1)

if [ "$zsh_bin" != "" ]; then
  ohai "ZSH installed"
else
  ohai "Installing ZSH"
  if [ "$SYSTEM_TYPE" = "Darwin" ]; then
    brew install zsh
  elif [ -f "/etc/debian_version" ]; then
    sudo apt install -y zsh
  fi
  chsh -s $(grep /zsh$ /etc/shells | tail -1)
fi
