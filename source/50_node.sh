[[ "$1" != init && ! -e ~/.nave ]] && return 1

export PATH
PATH=~/.nave/installed/default/bin:"$(path_remove ~/.nave/installed/*/bin)"

# Set a specific version of node as the "default" for "nave use default"
function nave_default() {
  local version
  local default=${NAVE_DIR:-$HOME/.nave}/installed/default
  [[ ! "$1" ]] && echo "Specify a node version or \"stable\"" && return 1
  [[ "$1" == "stable" ]] && version=$(nave stable) || version=${1#v}
  rm "$default" 2>/dev/null
  ln -s $version "$default"
  echo "Nave default set to $version"
}

# Install a version of node, set as default, install npm modules, etc.
function nave_install() {
  local version
  [[ ! "$1" ]] && echo "Specify a node version or \"stable\"" && return 1
  [[ "$1" == "stable" ]] && version=$(nave stable) || version=${1#v}
  if [[ ! -d "${NAVE_DIR:-$HOME/.nave}/installed/$version" ]]; then
    e_header "Installing Node.js $version"
    nave install $version
  fi
  [[ "$1" == "stable" ]] && nave_default stable && npm_install
}

# Use the version of node in the local .nvmrc file
alias nvmrc='exec nave use $(<.nvmrc)'

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
