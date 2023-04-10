#!/usr/bin/env bash

set -e

ohai "Installing NVM"

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

nvm install 18

# PNPM

ohai "Installing PNPM"
corepack enable
corepack prepare pnpm@latest --activate
export PNPM_HOME=~/.local/share/pnpm
export PATH="$PNPM_HOME:$PATH"
mkdir -p ~/.local/share/pnpm
pnpm add -g $(cat setup/npmfile)
