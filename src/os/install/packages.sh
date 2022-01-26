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

# Security
sudo apt install -y clamav
sudo sed -i '/Example/d' /etc/clamav/freshclam.conf
sudo systemctl enable clamav-freshclam.service
sudo apt install -y ufw gufw
sudo systemctl enable ufw.service
sudo snap install authy --beta

# Browsers
print_in_blue "\n   Packages - Browsers\n\n"
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
sudo apt update
sudo apt-get install -y google-chrome-stable

# GPG
print_in_blue "\n   Packages - GPG\n"
curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
sudo apt install -y ./keybase_amd64.deb
run_keybase
rm -rf keybase_amd64.deb

# IDE
print_in_blue "\n   Packages - IDE\n\n"
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install -y apt-transport-https sublime-text

print_in_blue "\n   Package - Visual Studio Code\n\n"
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt install -y apt-transport-https
sudo apt update
sudo apt install -y code-insiders
rm microsoft.gpg

# Terminal
# print_in_blue "\n   Packages - Terminal\n\n"

# Utilities
sudo snap install standard-notes

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ACCAF35C
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys ACCAF35C

sudo touch /etc/apt/sources.list.d/insync.list
echo 'deb http://apt.insync.io/ubuntu eoan non-free contrib' | sudo tee -a /etc/apt/sources.list.d/insync.list
sudo apt-get update
sudo apt-get install -y insync

sudo apt-get install -y meld
sudo apt-get install -y unrar
sudo apt-get install -y pdfarranger

# Office
print_in_blue "\n   Packages - Office\n\n"
sudo add-apt-repository ppa:libreoffice/ppa
sudo apt-get update
sudo apt-get dist-upgrade -y

# Videos
print_in_blue "\n   Packages - Videos\n\n"
sudo apt-get install -y vlc
sudo snap install shotcut --classic

# Fonts
print_in_blue "\n   Packages - Fonts\n\n"
sudo apt-get install -y ttf-mscorefonts-installer
sudo apt-get install -y fonts-firacode
sudo apt-get install -y fonts-powerline

# YARN
if [ -d "$HOME/.nvm" ]; then
    print_in_blue "\n   Packages - Node\n\n"

    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo 'deb https://dl.yarnpkg.com/debian/ stable main' | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt-get update
    sudo apt-get install --no-install-recommends -y yarn
fi
