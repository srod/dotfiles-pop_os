zsh_dir=${${ZDOTDIR}:-$HOME/.config/zsh}
utils_dir="${XDG_CONFIG_HOME}/utils"

# MacOS-specific services
if [ "$(uname -s)" = "Darwin" ]; then
  # Add Brew to path, if it's installed
  if [[ -d /opt/homebrew/bin ]]; then
    eval $(/opt/homebrew/bin/brew shellenv)
  fi
fi

# Source all ZSH config files (if present)
if [[ -d $zsh_dir ]]; then
  source ${zsh_dir}/path.zsh

  # Import alias files
  source ${zsh_dir}/aliases/general.zsh
  source ${zsh_dir}/aliases/git.zsh
  source ${zsh_dir}/aliases/node-js.zsh

  # Setup Antigen, and import plugins
  source ${zsh_dir}/helpers/setup-antigen.zsh
  source ${zsh_dir}/helpers/import-plugins.zsh
fi

# Import utility functions
if [[ -d $utils_dir ]]; then
  source ${utils_dir}/am-i-online.sh
  source ${utils_dir}/dot.sh
  source ${utils_dir}/free-up-disk-space.sh
  # source ${utils_dir}/weather.sh
  source ${utils_dir}/welcome-banner.sh
fi

# Source custom functions
# source ${zsh_dir}/functions/*.zsh

# Setup plugin `history-substring-search`
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ${zsh_dir}/.p10k.zsh ]] || source ${zsh_dir}/.p10k.zsh

# If not running in nested shell, then show welcome message :)
if [[ "${SHLVL}" -lt 2 ]] && [[ -z "$SKIP_WELCOME" ]]; then
  welcome
fi
