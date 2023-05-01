# Nuke - Remove node_modules and the lock file, then reinstall
reinstall_modules () {
  if read -q "choice?Remove and reinstall all node_modules? (y/N)"; then
    echo
    project_dir=$(pwd)
    # Check file exists, remove it and print message
    check-and-remove() {
      if [ -d "$project_dir/$1" ]; then
        echo -e "\e[35mRemoveing $1...\e[0m"
        rm -rf "$project_dir/$1"
      fi
    }
    # Delete node_modules and lock files
    check-and-remove 'node_modules'
    check-and-remove 'yarn.lock'
    check-and-remove 'package-lock.json'
    check-and-remove 'pnpm-lock.yaml'
    # Reinstall with PNPM (or yarn or NPM)
    if hash 'pnpm' 2> /dev/null; then
      echo -e "\e[35mReinstalling with pnpm...\e[0m"
      pnpm install
    elif hash 'yarn' 2> /dev/null; then
      echo -e "\e[35mReinstalling with yarn...\e[0m"
      yarn
      echo -e "\e[35mCleaning Up...\e[0m"
      yarn autoclean
    elif hash 'npm' 2> /dev/null; then
      echo -e "\e[35mReinstalling with NPM...\e[0m"
      npm install
    else
      echo -e "🚫\033[0;91m Unable to proceed, pnpm/ yarn/ npm not installed\e[0m"
    fi
  else
    # Cancelled by user
    echo -e "\n\033[0;91mAborting...\e[0m"
  fi
}

alias node-nuke='reinstall_modules'

# Prints out versions of core Node.js packages
print_node_versions () {
  versions=''
  format_verion_number () {
    echo "$($1 --version 2>&1 | head -n 1 | sed 's/[^0-9.]*//g')"
  }

  get_version () {
    if hash $1 2> /dev/null || command -v $1 >/dev/null; then
      versions="$versions\e[36m\e[1m $2: \033[0m$(format_verion_number $1) \n\033[0m"
    else
      versions="$versions\e[33m\e[1m $2: \033[0m\033[3m Not installed\n\033[0m"
    fi
  }
  # Source NVM if not yet done
  if typeset -f source_nvm > /dev/null && source_nvm

  # Print versions of core Node things
  get_version 'node' 'Node.js'
  get_version 'npm' 'NPM'
  get_version 'yarn' 'Yarn'
  get_version 'nvm' 'NVM'
  # get_version 'ni' 'ni'
  get_version 'pnpm' 'pnpm'
  get_version 'tsc' 'TypeScript'
  # get_version 'bun' 'Bun'
  # get_version 'deno' 'Deno'
  get_version 'git' 'Git'
  echo -e $versions
}

alias node-versions='print_node_versions'

# Location of NVM, will inherit from .zshenv if set
NVM_DIR=${NVM_DIR:-$XDG_DATA_HOME/nvm}

# On first time using Node command, import NVM if present and not yet sourced
function source_nvm node npm pnpm yarn $NVM_LAZY_CMD {
  if [ -f "$NVM_DIR/nvm.sh" ] && ! which nvm &> /dev/null; then
    echo -e "\033[1;93mInitialising NVM...\033[0m"
    source "${NVM_DIR}/nvm.sh"
    nvm use default
  fi
  unfunction node npm pnpm yarn source_nvm $NVM_LAZY_CMD
  hash "$0" 2> /dev/null && command "$0" "$@"
}

# Helper function to install NVM
install_nvm () {
  nvm_repo='https://github.com/nvm-sh/nvm.git'
  if [ -d "$NVM_DIR" ]; then # Already installed, update
    cd $NVM_DIR && git pull
  else # Not yet installed, promt user to confirm before proceeding
    if read -q "choice?Install NVM now? (y/N)"; then
      echo -e "\nInstalling..."
      git clone $nvm_repo $NVM_DIR
      cd $NVM_DIR && git checkout v0.39.3
    else
      echo -e "\nAborting..."
      return
    fi
  fi
  # All done, import / re-import NVM script
  source "${NVM_DIR}/nvm.sh"
  # Then install Node
  nvm install v18
}

# NVM commands
alias nvmlr='nvm ls-remote'
alias nvmlts='nvm install --lts && nvm use --lts'
alias nvmlatest='nvm install node --latest-npm && nvm use node'
alias nvmsetup='install_nvm'
