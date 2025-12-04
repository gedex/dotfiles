# Git shortcuts.
alias g='git'

if [ -z "$EDITOR" ]; then
    case $OSTYPE in
      linux*)
        alias gd='git diff | vim -R -'
        ;;
      darwin*)
        alias gd='git diff | mate'
        ;;
      *)
        alias gd='git diff'
        ;;
    esac
else
    alias gd="git diff | $EDITOR"
fi

alias ghrr="gh pr list --search='is:open user-review-requested:@me'"
alias ghpr="gh pr list --search='is:open author:@me'"
alias ghe='HTTPS_PROXY="socks5://127.0.0.1:8080" gh'

export GITHUB_USERNAME=gedex
export GPG_TTY=$(tty)
