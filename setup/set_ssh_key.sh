#!/usr/bin/env bash

set -e

ohai "Generating an SSH key"

read -r -p "Email: " email

ssh-keygen -t ed25519 -C $email -f ~/.ssh/id_ed25519
eval "$(ssh-agent -s)"
touch ~/.ssh/config
echo "Host *\n AddKeysToAgent yes\n UseKeychain yes\n IdentityFile ~/.ssh/id_ed25519" | tee ~/.ssh/config

if [ "$SYSTEM_TYPE" = "Darwin" ]; then
  ssh-add --apple-use-keychain ~/.ssh/id_ed25519
else
  ssh-add ~/.ssh/id_ed25519
fi
