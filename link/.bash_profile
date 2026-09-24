# Homebrew first so source/* scripts that call `brew` can find it.
[ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv bash)"

if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi
. "$HOME/.cargo/env"
