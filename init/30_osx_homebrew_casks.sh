# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Exit if Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Brew casks need Homebrew to install." && return 1

# Homebrew casks
casks=(
  # Applications
  docker-desktop
  dropbox
  firefox
  google-chrome
  gpg-suite
  hammerspoon
  iterm2
  licecap
  macvim-app
  slack
  spotify
  temurin
  vlc
)

# Install Homebrew casks.
casks=($(setdiff "${casks[*]}" "$(brew list --cask 2>/dev/null)"))
if (( ${#casks[@]} > 0 )); then
  e_header "Installing Homebrew casks: ${casks[*]}"
  for cask in "${casks[@]}"; do
    brew install --cask $cask
  done
  brew cleanup
fi
