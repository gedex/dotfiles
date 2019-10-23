export PATH

if [[ -d "$HOME/code/flutter/bin" ]]; then
	PATH="$(path_remove $HOME/code/flutter/bin):$HOME/code/flutter/bin"
fi
