#!/bin/bash

declare -r NVM_DIRECTORY="$HOME/.nvm"
declare -r NVM_GIT_REPO_URL="https://github.com/creationix/nvm.git"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_node() {

    nvm install $1
    npm install npm@6 -g

}

install_nvm() {

    git clone --quiet $NVM_GIT_REPO_URL $NVM_DIRECTORY

}

update_nvm() {

    cd $NVM_DIRECTORY
    git fetch --quiet origin
    git checkout --quiet $(git describe --abbrev=0 --tags)
    . $NVM_DIRECTORY/nvm.sh

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_blue "\n   NVM\n\n"

    if [ ! -d "$NVM_DIRECTORY" ]; then
        install_nvm
    else
        update_nvm
    fi

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

    install_node 14
    install_node 12
    install_node 10

    cd $DOTFILES/src/os

}

main
