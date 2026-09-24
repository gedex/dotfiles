# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Keep Homebrew ahead of /usr/bin.
PATH="/opt/homebrew/bin:$(path_remove /opt/homebrew/bin)"
export PATH

# Trim new lines and copy to clipboard
# alias c="tr -d '\n' | pbcopy"

# Make 'less' more.
[[ "$(type -P lesspipe.sh)" ]] && eval "$(lesspipe.sh)"

# Start ScreenSaver. This will lock the screen if locking is enabled.
alias ss="open /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app"

# Copy last commit hash to clipboard
alias cplc="git rev-parse HEAD | tr -d '\n' | pbcopy"

# gnubin
export GNUBIN="/opt/homebrew/opt/coreutils/libexec/gnubin"
PATH=$(path_remove $GNUBIN):$GNUBIN
