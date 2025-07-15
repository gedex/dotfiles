# Load nave- and npm-related functions.
source $DOTFILES/source/50_node.sh init

# Install latest Node.js, set as default, install global npm modules.
nave_install 22.12.0
nave_default 22.12.0
