#!/bin/bash

# System
print_in_blue "\n   Packages - System\n\n"
sudo apt install -y vim
sudo apt install -y neofetch
sudo apt install -y htop

# YARN
if [ -d "$HOME/.nvm" ]; then
    print_in_blue "\n   Packages - Node\n\n"

    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo 'deb https://dl.yarnpkg.com/debian/ stable main' | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt-get update
    sudo apt-get install --no-install-recommends -y yarn
fi
