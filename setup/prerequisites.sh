#!/usr/bin/env bash

# List of apps to install
core_packages=(
  'git' # Needed to fetch dotfiles
  'vim' # Needed to edit files
  'zsh' # Needed as bash is crap
  'curl' # Needed for NVM
)

# Color variables
BLUE='\033[0;34m'
YELLOW='\033[0;93m'
LIGHT='\x1b[2m'
RESET='\033[0m'

# Shows help menu / introduction
function print_usage () {
  echo -e "${BLUE}Prerequisite Dependency Installation Script${LIGHT}\n"\
  "\n${RESET}"
}

function install_debian () {
  echo -e "${BLUE}Installing ${1} via apt-get${RESET}"
  sudo apt install $1
}
function install_arch () {
  echo -e "${BLUE}Installing ${1} via Pacman${RESET}"
  sudo pacman -S $1
}
function install_mac () {
  echo -e "${BLUE}Installing ${1} via Homebrew${RESET}"
  brew install $1
}
function get_homebrew () {
  echo -e "${BLUE}Setting up Homebrew${RESET}"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  export PATH=/opt/homebrew/bin:$PATH
}

# Detect OS type, then triggers install using appropriate package manager
function multi_system_install () {
  app=$1
  if [ "$(uname -s)" = "Darwin" ]; then
    if ! hash brew 2> /dev/null; then get_homebrew; fi
    install_mac $app # MacOS via Homebrew
  elif [ -f "/etc/arch-release" ] && hash pacman 2> /dev/null; then
    install_arch $app # Arch Linux via Pacman
  elif [ -f "/etc/debian_version" ] && hash apt 2> /dev/null; then
    install_debian $app # Debian via apt-get
  else
    echo -e "${YELLOW}Skipping ${app}, as couldn't detect system type ${RESET}"
  fi
}

# Show usage instructions, help menu
print_usage

# For each app, check if not present and install
for app in ${core_packages[@]}; do
  if ! hash "${app}" 2> /dev/null; then
    multi_system_install $app
  else
    echo -e "${YELLOW}${app} is already installed, skipping${RESET}"
  fi
done

# All done
echo -e "\n${BLUE}Jobs complete, exiting${RESET}"
exit 0
