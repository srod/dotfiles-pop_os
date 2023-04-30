# export ADOTDIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/antigen"
# export DOTFILES="${HOME}/.dotfiles"
# export ZDOTDIR="${DOTFILES}/config/zsh"
# export XDG_DATA_HOME="${HOME}/.local/share"
# export XDG_CONFIG_HOME="${HOME}/.config"
# ZSH_THEME="powerlevel10k/powerlevel10k"
# HOMEBREW_PREFIX=/opt/homebrew

zsh_dir=${${ZDOTDIR}:-$HOME/.config/zsh}

# MacOS-specific services
if [ "$(uname -s)" = "Darwin" ]; then
  # Add Brew to path, if it's installed
  if [[ -d /opt/homebrew/bin ]]; then
    eval $(/opt/homebrew/bin/brew shellenv)
  fi
fi

# Source all ZSH config files (if present)
if [[ -d $zsh_dir ]]; then
  # Setup Antigen, and import plugins
  source ${zsh_dir}/helpers/setup-antigen.zsh
  source ${zsh_dir}/helpers/import-plugins.zsh
fi

# Source custom functions
source ${zsh_dir}/functions/*.zsh

# Plugins list
# plugins=(zsh-completions zsh-autosuggestions zsh-better-npm-completion zsh-syntax-highlighting history-substring-search jsontools sudo urltools web-search git gpg-agent ssh-agent node npm vscode)

# Setup plugin `history-substring-search`
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Source Oh My Zsh
# source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ${zsh_dir}/.p10k.zsh ]] || source ${zsh_dir}/.p10k.zsh
