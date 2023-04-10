#!/usr/bin/env bash

set -e

CONFIG="setup/install.conf.yaml"
DOTBOT_DIR="dotbot"

DOTBOT_BIN="bin/dotbot"
BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until this script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

cd "${BASEDIR}"
git config --global url."git@github.com:".insteadOf git://github.com/
git -C "${DOTBOT_DIR}" submodule sync --quiet --recursive
git submodule update --init --recursive "${DOTBOT_DIR}"
"${BASEDIR}/${DOTBOT_DIR}/${DOTBOT_BIN}" -d "${BASEDIR}" -c "${CONFIG}" "${@}"

. "${BASEDIR}/setup/utils.sh"
. "${BASEDIR}/setup/zsh.sh"
. "${BASEDIR}/setup/nvm.sh"
. "${BASEDIR}/setup/packages.sh"
. "${BASEDIR}/setup/set_ssh_key.sh"
