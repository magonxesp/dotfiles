#!/bin/bash

if [[ -d "/usr/local/opt/m4/bin" ]]; then
    export PATH="/usr/local/opt/m4/bin:$PATH"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

if [[ -d "/usr/local/opt/php@7.4/bin" ]]; then
    export PATH="/usr/local/opt/php@7.4/bin:$PATH"
fi

if [[ "$TERM" == "xterm-kitty" ]]; then
    export NEOFETCH_IMAGE_BACKEND="kitty"
else
    export NEOFETCH_IMAGE_BACKEND="iterm2"
fi
