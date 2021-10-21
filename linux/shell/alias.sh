#!/bin/bash

if [[ $TERM == "xterm-kitty" ]]; then
    alias ssh="TERM=xterm-256color ssh"
fi

# alias for change to directories
alias repos="cd /media/magonxesp/DATA/repos"
alias basetis="cd ~/basetis"

# alias for permissions
alias own="sudo chown $USER:$USER"
alias ownr="sudo chown -R $USER:$USER"
