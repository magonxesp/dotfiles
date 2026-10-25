#!/bin/bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

if [[ "$TERM" == "xterm-kitty" ]] || [[ "$TERM" == "xterm-ghostty" ]]; then
    export NEOFETCH_IMAGE_BACKEND="kitty"
else
    export NEOFETCH_IMAGE_BACKEND="iterm2"
fi
