#!/usr/bin/env bash

set -e

echo "==> Generating an SSH key"

read -r -p "Email: " email

ssh-keygen -t rsa -b 4096 -C "$email"
