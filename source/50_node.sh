export NVM_DIR=~/.nvm
[[ "$1" != init && ! -s "$NVM_DIR/nvm.sh" ]] && return 1

[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

# Install nvm if it isn't already installed.
function nvm_setup() {
  [[ -s "$NVM_DIR/nvm.sh" ]] && return
  e_header "Installing nvm"
  # PROFILE=/dev/null keeps the installer from appending to shell rc files;
  # this file loads nvm instead.
  curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | PROFILE=/dev/null bash
  source "$NVM_DIR/nvm.sh"
}

# Install a version of node, set as default, install npm modules, etc.
function node_install() {
  [[ ! "$1" ]] && echo "Specify a node version or \"latest\"" && return 1
  local version=$1
  [[ "$version" == "latest" ]] && version=node
  e_header "Installing Node.js $1"
  nvm install "$version" && nvm alias default "$version" && npm_install
}

# Global npm modules to install.
npm_globals=(
  babel-cli
  eslint
  grunt-cli
  pushstate-server
  webpack
  yarn
)

# Because "rm -rf node_modules && npm install" takes WAY too long. Not sure
# if this really works as well, though. We'll see.
alias npm_up='npm prune && npm install && npm update'

# Update npm and install global modules.
function npm_install() {
  local installed modules
  e_header "Updating npm"
  npm update -g npm
  { pushd "$(npm config get prefix)/lib/node_modules"; installed=(*); popd; } >/dev/null
  modules=($(setdiff "${npm_globals[*]}" "${installed[*]}"))
  if (( ${#modules[@]} > 0 )); then
    e_header "Installing Npm modules: ${modules[*]}"
    npm install -g "${modules[@]}"
  fi
}

# pnpm
export PNPM_HOME="/Users/akeda/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
