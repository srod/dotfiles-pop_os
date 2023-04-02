#!/usr/bin/env bash

set -e

sudo dnf install -y zsh util-linux-user
chsh -s $(which zsh)
