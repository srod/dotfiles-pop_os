# Command upgrades
alias ll="ls -alh"
alias ln="ln -v"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias vi="/usr/bin/vim"

# Navigation
alias dotfiles="cd $DOTFILES"

# Update
alias aptup="sudo apt update && sudo apt upgrade"
alias npmup="npm -g update; npm install -g npm"
alias update="aptup; npmup"

# Utils
alias clean.node="rm -rf node_modules"
alias clean.npm="clean.node && npm cache verify && npm install"
alias clean.yarn="clean.node && yarn"
