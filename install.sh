#!/usr/bin/env bash

set -e

SYSTEM_TYPE=$(uname -s) # Get system type - Linux / MacOS (Darwin)
CONFIG="setup/install.conf.yaml"
CONFIG_BREW="setup/brew.conf.yaml"
DOTBOT_DIR="dotbot"
DOTBOT_BIN="bin/dotbot"
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until this script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

. "${BASEDIR}/setup/utils.sh"

# If prerequesite packages not found, prompt to install
if ! command_exists git; then
  bash <(curl -s  -L 'https://raw.githubusercontent.com/srod/dotfiles-pop_os/feat/universal/setup/prerequisites.sh')
fi

# Verify required packages are installed
system_verify "git" true
system_verify "curl" true

# If XDG variables arn't yet set, then configure defaults
if [ -z ${XDG_CONFIG_HOME+x} ]; then
  ohai "XDG_CONFIG_HOME is not yet set. Will use ~/.config"
  export XDG_CONFIG_HOME="${HOME}/.config"
fi
if [ -z ${XDG_DATA_HOME+x} ]; then
  ohai "XDG_DATA_HOME is not yet set. Will use ~/.local/share"
  export XDG_DATA_HOME="${HOME}/.local/share"
fi

cd "${BASEDIR}"
git config --global url."git@github.com:".insteadOf git://github.com/
git -C "${DOTBOT_DIR}" submodule sync --quiet --recursive
git submodule update --init --recursive "${DOTBOT_DIR}"
"${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -d "${BASEDIR}" -c "${CONFIG}" "${@}"

. "${BASEDIR}/setup/zsh.sh"
. "${BASEDIR}/setup/nvm.sh"

if [ "$SYSTEM_TYPE" = "Darwin" ]; then
  # Mac OS
  # intall_macos_packages
  if ! command_exists brew; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    eval "$(echo 'eval $(/opt/homebrew/bin/brew shellenv)')"
  fi

  "${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -d "${BASEDIR}" --plugin-dir dotbot-brewfile -c "${CONFIG_BREW}" "${@}"

  source "${BASEDIR}/setup/macos/main.sh"
elif [ -f "/etc/arch-release" ]; then
  # Arch Linux
  . "${BASEDIR}/setup/arch-pacman.sh"
elif [ -f "/etc/debian_version" ]; then
  # Debian / Ubuntu
  . "${BASEDIR}/setup/debian-apt.sh"
fi

ohai "Installing Vim Plugins"
export VIMINIT=":source $XDG_CONFIG_HOME/vim/vimrc"
vim +PlugInstall +qall

ohai "Installing ZSH Plugins"
/bin/zsh -i -c "antigen update && antigen-apply"

. "${BASEDIR}/setup/set_ssh_key.sh"

source "${HOME}/.zshenv"
exec zsh
