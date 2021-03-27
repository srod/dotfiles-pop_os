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
alias clean.ds_store="find . -type f -name '*.DS_Store' -ls -delete"
alias clean.node="rm -rf node_modules"
alias clean.npm="clean.node && npm cache verify && npm install"
alias clean.yarn="clean.node && yarn"
alias dropbox.conflicted="find ~/Dropbox/ -name '*Copie en conflit*' && find ~/Dropbox/ -name '*Conflict*' && find ~/Dropbox/ -name '*conflict*'"
alias json="python -mjson.tool"
weather() { curl -4 wttr.in/${1:-bussy-saint-georges} }
