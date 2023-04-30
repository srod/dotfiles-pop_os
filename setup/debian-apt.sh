#!/usr/bin/env bash

# System
ohai "Packages - System"
sudo apt install -y bat
# sudo apt install -y ngrep
# sudo apt install -y nmap
# sudo apt install -y tcpdump
sudo apt install -y vim
sudo apt install -y default-jre
sudo apt install -y xclip
sudo apt install -y neofetch
sudo apt install -y htop
sudo apt install -y software-properties-gtk

# Security
ohai "Packages - Security"
if read -q "choice?Would you like to install Clamav? (y/N)"; then
  echo
  sudo apt install -y clamav
  sudo sed -i '/Example/d' /etc/clamav/freshclam.conf
  sudo systemctl enable clamav-freshclam.service
  sudo apt install -y ufw gufw
  sudo systemctl enable ufw.service
fi

# Utilities
ohai "Packages - Utilities"
if read -q "choice?Would you like to install insync? (y/N)"; then
  echo
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ACCAF35C
  sudo touch /etc/apt/sources.list.d/insync.list
  echo 'deb http://apt.insync.io/ubuntu jammy non-free contrib' | sudo tee -a /etc/apt/sources.list.d/insync.list
  sudo apt-get update
  sudo apt-get install -y insync
fi

sudo apt-get install -y meld
sudo apt-get install -y unrar
sudo apt-get install -y pdfarranger

# Office
ohai "Packages - Office"
if read -q "choice?Would you like to install LibreOffice? (y/N)"; then
  echo
  sudo add-apt-repository ppa:libreoffice/ppa
  sudo apt-get update
  sudo apt-get dist-upgrade -y
fi

# Fonts
ohai "Packages - Fonts"
sudo apt-get install -y ttf-mscorefonts-installer
sudo apt-get install -y fonts-firacode
sudo apt-get install -y fonts-powerline

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d ~/.fonts
fc-cache -fv
rm -f Meslo.zip
