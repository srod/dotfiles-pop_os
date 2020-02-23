#!/bin/bash

install_gems() {

    gem install git-up

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_blue "\n   GEMs\n\n"

    install_gems

}

main
