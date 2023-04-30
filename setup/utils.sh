#!/usr/bin/env bash

set -e

# string formatters
if [ -t 1 ]; then
  tty_escape() { printf "\033[%sm" "$1"; }
else
  tty_escape() { :; }
fi
tty_mkbold() { tty_escape "1;$1"; }
tty_blue="$(tty_mkbold 34)"
tty_yellow="$(tty_mkbold 93)"
tty_bold="$(tty_mkbold 39)"
tty_light='\x1b[2m'
tty_reset="$(tty_escape 0)"

ohai() {
  printf "${tty_blue}==>${tty_bold} %s${tty_reset}\n" "$1"
}

# Checks if a given package is installed
command_exists () {
  hash "$1" 2> /dev/null
}

# On error, displays death banner, and terminates app with exit code 1
terminate () {
  echo -e "\n${tty_blue}Installation failed. Terminating...\n${tty_reset}"
  exit 1
}

# Checks if command / package (in $1) exists and then shows
# either shows a warning or error, depending if package required ($2)
system_verify () {
  if ! command_exists $1; then
    if $2; then
      echo -e "🚫 ${tty_blue}Error:${tty_bold} $1 is not installed${tty_reset}"
      terminate
    else
      echo -e "⚠️  ${tty_blue}Warning:${tty_bold} $1 is not installed${tty_reset}"
    fi
  fi
}
