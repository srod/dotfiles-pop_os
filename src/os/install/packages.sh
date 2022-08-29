#!/bin/bash

# System
print_in_blue "\n   Packages - System\n\n"
sudo apt install -y bat
sudo apt install -y ngrep
sudo apt install -y nmap
sudo apt install -y tcpdump
sudo apt install -y vim
sudo apt install -y default-jre
sudo apt install -y xclip
sudo apt install -y neofetch
sudo apt install -y htop
sudo apt install -y snapd
sudo apt install -y software-properties-gtk

# Fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d ~/.fonts
fc-cache -fv
rm -f Meslo.zip

# Browsers
# print_in_blue "\n   Packages - Browsers\n\n"
# wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
# echo 'deb [arch=aarch64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
# sudo apt update
# sudo apt-get install -y google-chrome-stable

# GPG
# print_in_blue "\n   Packages - GPG\n"
# curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
# sudo apt install -y ./keybase_amd64.deb
# run_keybase
# rm -rf keybase_amd64.deb

# IDE
print_in_blue "\n   Packages - IDE\n\n"
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install -y apt-transport-https sublime-text

# print_in_blue "\n   Package - Visual Studio Code\n\n"
# curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
# sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
# sudo sh -c 'echo "deb [arch=aarch64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
# sudo apt install -y apt-transport-https
# sudo apt update
# sudo apt install -y code-insiders
# rm microsoft.gpg

# YARN
if [ -d "$HOME/.nvm" ]; then
    print_in_blue "\n   Packages - Node\n\n"

    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo 'deb https://dl.yarnpkg.com/debian/ stable main' | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt-get update
    sudo apt-get install --no-install-recommends -y yarn
fi

# Fonts
print_in_blue "\n   Packages - Fonts\n\n"
sudo apt-get install -y ttf-mscorefonts-installer
sudo apt-get install -y fonts-firacode
sudo apt-get install -y fonts-powerline
