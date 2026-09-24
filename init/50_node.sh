# Load nvm- and npm-related functions.
source $DOTFILES/source/50_node.sh init

# Install nvm and Node.js, set as default, install global npm modules.
nvm_setup
node_install 22
