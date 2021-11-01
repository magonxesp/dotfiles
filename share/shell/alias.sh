#!/bin/bash

alias reload-shell="source $DOTFILES_STARTUP_SCRIPT"
alias dotfiles="$DOTFILES_ROOT_DIRECTORY/share/scripts/dotfiles.sh"

if [[ $TERM == "xterm-kitty" ]]; then
    alias ssh="TERM=xterm-256color ssh"
fi

# alias for change to directories
if [[ -d "/media/magonxesp/DATA/repos" ]]; then
  alias repos="cd /media/magonxesp/DATA/repos"
fi

if [[ -d "$HOME/basetis" ]]; then
  alias basetis="cd $HOME/basetis"
fi

# alias for permissions
alias own="sudo chown $USER:$USER"
alias ownr="sudo chown -R $USER:$USER"
