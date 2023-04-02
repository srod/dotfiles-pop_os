#!/bin/bash

# System
echo "Packages - System"
sudo apt install -y bat
sudo apt install -y ngrep
sudo apt install -y nmap
sudo apt install -y tcpdump
sudo apt install -y vim
sudo apt install -y default-jre
sudo apt install -y xclip
sudo apt install -y neofetch
sudo apt install -y htop
# sudo apt install -y snapd
sudo apt install -y software-properties-gtk

# Security
sudo apt install -y clamav
sudo sed -i '/Example/d' /etc/clamav/freshclam.conf
sudo systemctl enable clamav-freshclam.service
sudo apt install -y ufw gufw
sudo systemctl enable ufw.service
# sudo snap install authy --beta

# Browsers
# echo "Packages - Browsers"
# wget https://dl-ssl.google.com/linux/linux_signing_key.pub -O /tmp/google.pub
# sudo gpg --no-default-keyring --keyring /etc/apt/keyrings/google-chrome.gpg --import /tmp/google.pub
# echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
# sudo apt update
# sudo apt-get install -y google-chrome-stable

# GPG
# echo "Packages - GPG"
# curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
# sudo apt install -y ./keybase_amd64.deb
# run_keybase
# rm -rf keybase_amd64.deb

# IDE
# echo "Package - Visual Studio Code"
# wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
# sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
# sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
# sudo apt update
# sudo apt install -y apt-transport-https code
# rm -f packages.microsoft.gpg

# Utilities
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ACCAF35C
sudo touch /etc/apt/sources.list.d/insync.list
echo 'deb http://apt.insync.io/ubuntu jammy non-free contrib' | sudo tee -a /etc/apt/sources.list.d/insync.list
sudo apt-get update
sudo apt-get install -y insync

sudo apt-get install -y meld
sudo apt-get install -y unrar
sudo apt-get install -y pdfarranger

# Office
echo "Packages - Office"
sudo add-apt-repository ppa:libreoffice/ppa
sudo apt-get update
sudo apt-get dist-upgrade -y

# Videos
# echo "Packages - Videos"
# sudo apt-get install -y vlc
# sudo snap install shotcut --classic

# Snaps
# sudo snap install standard-notes
# sudo snap install discord
# sudo snap install slack
# sudo snap install bitwarden
# sudo snap install spotify
# sudo snap install sublime-text --classic
# sudo snap install telegram-desktop
# sudo snap install plex-desktop

# Fonts
echo "Packages - Fonts"
sudo apt-get install -y ttf-mscorefonts-installer
sudo apt-get install -y fonts-firacode
sudo apt-get install -y fonts-powerline

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d ~/.fonts
fc-cache -fv
rm -f Meslo.zip
