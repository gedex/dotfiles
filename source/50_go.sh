export PATH

# Go Workspace.
export GOROOT="$(brew --prefix golang)/libexec"
export GOPATH="$HOME/code/go"

PATH="$(path_remove $GOPATH/bin):$GOPATH/bin"
PATH="$(path_remove $GOROOT/bin):$GOROOT/bin"

test -d "${GOPATH}" || mkdir "${GOPATH}"
