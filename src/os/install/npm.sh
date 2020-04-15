#!/bin/bash

install_npm_package() {

    npm install --global $2

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_blue "\n   NPM\n\n"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_npm_package "npm (update)" "npm"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_npm_package "npm-check" "npm-check"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_npm_package "serve" "serve"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_npm_package "eslint" "eslint"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_npm_package "diff-so-fancy" "diff-so-fancy"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    install_npm_package "sass" "sass"

}

main
