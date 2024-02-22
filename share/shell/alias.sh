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

alias neofetchl="neofetch --disable theme icons memory resolution wm terminal cpu gpu --color_blocks off"
alias github-configure-local-profile="git config --local user.email 'janma.360@gmail.com' && git config --local user.name 'MagonxESP'"
alias github-configure-global-profile="git config --global user.email 'janma.360@gmail.com' && git config --global user.name 'MagonxESP'"
alias time-ps="/usr/bin/time -f \"Memory=%K Average Memory=%M elapsed=%E cpu.sys=%S user=%U\""