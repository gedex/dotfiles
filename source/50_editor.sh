# Editing

export EDITOR=vim

if [[ ! "$SSH_TTY" ]]; then
  export LESSEDIT="$EDITOR ?lm+%lm -- %f"
  export GIT_EDITOR="$EDITOR -f"
fi

export VISUAL="$EDITOR"
