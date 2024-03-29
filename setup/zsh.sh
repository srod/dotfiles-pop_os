#!/usr/bin/env bash

set -e

zsh_bin=$(grep /zsh$ /etc/shells | tail -1)

if [ "$zsh_bin" != "" ]; then
  ohai "ZSH installed"
else
  ohai "Installing ZSH"
  sudo apt install -y zsh
  chsh -s $(grep /zsh$ /etc/shells | tail -1)
fi
