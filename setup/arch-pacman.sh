#!/usr/bin/env bash

pacman_apps=(
  # Essentials
  'base-devel'    # Base development tools
  'git'           # Version controll
  'wget'          # Download files
  'yay'           # AUR helper

  # CLI Power Basics
  'bat'           # Output highlighting (better cat)
  'xclip'         # System clipboard

  # Security Utilities
  'clamav'        # Open source virus scanning suite
  'gnupg'         # PGP encryption, signing and verifying
  'openssl'       # Cryptography and SSL/TLS Toolkit
  'ufw'           # Uncomplicated Firewall
  'gufw'          # GUI for UFW

  # Monitoring, management and stats
  'htop'          # Process viewer
  'speedtest-cli' # Command line speed test utility

  # CLI Fun
  'neofetch'      # Show off distro and system info

  # Apps
  'meld'         # File and folder comparison
  'unrar'        # Unrar files
  'pdfarranger'  # PDF page manipulation

  # Fonts
  'ttf-firacode-nerd' # Fira Code with Nerd Fonts
  'powerline-fonts'   # Powerline fonts
  'ttf-meslo-nerd'    # Meslo Nerd Font
)

yay_apps=(
  'insync'       # Google Drive sync
  'ttf-ms-win11' # Windows 11 font
)

# Print intro message
echo -e "${tty_blue}Starting Arch package install / update script"
echo -e "${tty_light}The following script is for Arch / Arch-based headless systems, and will"
echo -e "update database, upgrade packages, clear cache then install all listed CLI apps."
echo -e "${tty_yellow}Before proceeding, ensure your happy with all the packages listed in \e[4m${0##*/}"
echo -e "${tty_reset}"

# Check pacman actually installed
if ! hash pacman 2> /dev/null; then
  echo "${tty_yellow}Pacman doesn't seem to be present on your system. Exiting...${tty_reset}"
  exit 1
fi

# Update package database
sudo pacman -Syy --noconfirm

# Upgrade currently installed packages
sudo pacman -Syu --noconfirm

# Clear old package caches
sudo pacman -Sc --noconfirm
paccache -r

# Install packages
for app in ${pacman_apps[@]}; do
  if hash "${app}" 2> /dev/null; then
    echo -e "${tty_yellow}[Skipping]${tty_light} ${app} is already installed${tty_reset}"
  elif [[ $(echo $(pacman -Qk $(echo $app | tr 'A-Z' 'a-z') 2> /dev/null )) == *"total files"* ]]; then
    echo -e "${tty_yellow}[Skipping]${tty_light} ${app} is already installed via Pacman${tty_reset}"
  elif hash flatpak 2> /dev/null && [[ ! -z $(echo $(flatpak list --columns=ref | grep $app)) ]]; then
    echo -e "${tty_yellow}[Skipping]${tty_light} ${app} is already installed via Flatpak${tty_reset}"
  else
    echo -e "${tty_blue}[Installing]${tty_light} Downloading ${app}...${tty_reset}"
    sudo pacman -S ${app} --needed --noconfirm
  fi
done

for app in ${yay_apps[@]}; do
  if hash "${app}" 2> /dev/null; then
    echo -e "${tty_yellow}[Skipping]${tty_light} ${app} is already installed${tty_reset}"
  elif [[ $(echo $(yay -Qm $(echo $app | tr 'A-Z' 'a-z') 2> /dev/null )) == *"total files"* ]]; then
    echo -e "${tty_yellow}[Skipping]${tty_light} ${app} is already installed via Pacman${tty_reset}"
  else
    echo -e "${tty_blue}[Installing]${tty_light} Downloading ${app}...${tty_reset}"
    yay -S ${app} --needed --noconfirm
  fi
done

ohai "Finished installing / updating Arch packages."
