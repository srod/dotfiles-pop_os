# Git aliases

alias gg="git grep"
alias ga="git add"
alias gd="git diff"
alias gds="git diff --staged"
alias gc="git commit --verbose"
alias gs="git status -sb"
alias gco="git checkout"
alias gpr="git pull --rebase"
alias git_conflicts="git diff --name-only --diff-filter=U"

# Shorthand clone (e.g. $ clone srod/dotfiles)
function clone {
  default_service='github.com' # Used if full URL isn't specified
  default_username='srod' # Used if repo org / username isn't specified
  use_ssh=true # Use SSH instead of HTTPS
  user_input=$1
  target=${2:-''}
  # Help flag passed, show manual and exit
  if [[ $user_input == --help ]] || [[ $user_input == -h ]]; then
    echo -e 'This will clone a git repo, and cd into it.';
    echo -e 'Either specify repo name, oe user/repo, or a full URL.'
    echo -e 'If no target directory is specified, the repo name will be used.'
    echo -e 'E.g. `$ clone srod/dotfiles`'
    return;
  # No input specified, prompt user
  elif [ $# -eq 0 ]; then
    echo 'Enter a user/repo or full URL: ';
    read user_input;
  fi
  # Determine input type, and make clone url
  if [[ $user_input == git@* || $user_input == *://* ]]
  then
    # Full URL was provided
    REPO_URL=$user_input;
  elif [[ $user_input == */* ]]; then
    # Username/repo was provided
    if [ "$use_ssh" = true ] ; then
      REPO_URL="git@$default_service:$user_input.git";
    else
      REPO_URL="https://$default_service/$user_input.git";
    fi
  else
    # Just repo name was provided
    if [ "$use_ssh" = true ] ; then
      REPO_URL="git@$default_service:$default_username/$user_input.git";
    else
      REPO_URL="https://$default_service/$default_username/$user_input.git";
    fi
  fi

  # Clone repo
  git clone $REPO_URL $target;

  # cd into newly cloned directory
  cd "$(basename "$_" .git)"

  # Print results
  if test "$?" -eq 0; then
    echo -e "☑️  \033[1;96mCloned $REPO_URL into $(pwd), and cd'd into it.\033[0m"
  else
    echo -e "❌ \033[1;91mFailed to clone $REPO_URL\033[0m"
  fi
}

# Sync fork against upstream repo
function gsync {
  # If no upstream origin provided, prompt user for it
  if ! git remote -v | grep -q 'upstream'; then
    echo 'Enter the upstream git url: ';
    read url;
    git remote add upstream "$url"
  fi
  git remote -v
  git fetch upstream
  git pull upstream master
  git checkout master
  git rebase upstream/master
}

# Make git commit with -m
function gcommit {
  commit_msg=$@
  if [ $# -eq 0 ]; then
    echo 'Enter a commit message';
    read commit_msg;
  fi
  git commit -m "$commit_msg"
}

alias gcm="gcommit"

# Prompt for main SSH key passphrase, so u don't need to enter it again until session killed
# alias add-key='eval "$(ssh-agent)" && ssh-add ~/.ssh/id_ed25519'
