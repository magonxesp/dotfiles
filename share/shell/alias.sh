#!/bin/bash

alias dotfiles="$DOTFILES_ROOT_DIRECTORY/share/scripts/dotfiles.sh"

if [[ $TERM == "xterm-kitty" ]]; then
    alias ssh="TERM=xterm-256color ssh"
fi

# alias for change to directories
if [[ -d "/media/magonxesp/DATA/repos" ]]; then
  alias repos="cd /media/magonxesp/DATA/repos"
fi

# alias for permissions
alias own="sudo chown $USER:$USER"
alias ownr="sudo chown -R $USER:$USER"
