# Command upgrades
alias ll="ls -ahlF --color"
alias lf='ls -A | grep' # Use grep to find files
alias ln="ln -v"
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias vi="${HOMEBREW_PREFIX:-/usr}/bin/vim"
alias vim="${HOMEBREW_PREFIX:-/usr}/bin/vim"

if [ "$(uname -s)" != "Darwin" ]; then
  alias pbcopy="xclip -selection clipboard"
  alias pbpaste="xclip -selection clipboard -o"
fi

# Finding files and directories
alias dud='du -d 1 -h' # List sizes of files within directory
alias duf='du -sh *' # List total size of current directory
alias ff='find . -type f -name' # Find a file by name within current directory
(( $+commands[fd] )) || alias fd='find . -type d -name' # Find direcroy by name

# Command line history
# alias h='history' # Shows full history
alias h-search='fc -El 0 | grep' # Searchses for a word in terminal history
alias top-history='history 0 | awk '{print $2}' | sort | uniq -c | sort -n -r | head'
# alias histrg='history -500 | rg' # Rip grep search recent history

# Navigation
alias dotfiles="cd $DOTFILES"

# Maintenance
alias pid="ps x | grep -i $1"
alias grep="grep --color=auto"
alias aliases="code $DOTFILES/config/zsh/aliases/general.zsh"

# Network
alias network.ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias network.ips="ifconfig -a | grep -o 'inet6\? \(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sed -e 's/inet6* //'"
alias network.speedtest="speedtest --server-id=2231"
alias network.ping='prettyping --nolegend'
# alias ping=network.ping

# Utils
alias clean.node="rm -rf node_modules"
alias clean.npm="clean.node && npm cache verify && npm install"
alias clean.pnpm="clean.node && pnpm i"
alias json="python -mjson.tool"
alias copyssh="pbcopy < $HOME/.ssh/id_ed25519.pub"

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"

# External Services
# alias myip='curl icanhazip.com'
alias weather='curl wttr.in/77600'
alias weather-short='curl "wttr.in/77600?format=3"'
# alias cheat='curl cheat.sh/'
# alias tinyurl='curl -s "http://tinyurl.com/api-create.php?url='
# alias joke='curl https://icanhazdadjoke.com'
alias hackernews='curl hkkr.in'
alias worldinternet='curl https://status.plaintext.sh/t'
