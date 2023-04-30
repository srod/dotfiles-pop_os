prepend-path() {
  [ -d $1 ] && PATH="$1:$PATH"
}

prepend-path "/bin"
prepend-path "/usr/bin"
prepend-path "/usr/local/bin"
prepend-path "$HOMEBREW_PREFIX/bin"
prepend-path "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin"
prepend-path "$HOMEBREW_PREFIX/opt/grep/libexec/gnubin"
prepend-path "$DOTFILES/bin"
prepend-path "/sbin"
prepend-path "/usr/sbin"
prepend-path "/usr/local/sbin"

# Remove duplicates (preserving prepended items)
# Source: http://unix.stackexchange.com/a/40755
PATH=$(echo -n $PATH | awk -v RS=: '{ if (!arr[$0]++) {printf("%s%s",!ln++?"":":",$0)}}')

export PATH
