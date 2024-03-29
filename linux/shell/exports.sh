#!/bin/bash

if [[ -d "/usr/local/go/bin" ]]; then
    export PATH=$PATH:/usr/local/go/bin
fi

if [[ -f "$DOTFILES_DIRECTORY/shell/themes.sh" ]]; then
    source "$DOTFILES_DIRECTORY/shell/themes.sh"
fi

export NEOFETCH_IMAGE_BACKEND="kitty"

# Awesome themmes path, uncomment if awesomewm is installed
# export AWESOME_THEMES_PATH=$HOME/.config/awesome/themes

if [[ -d "$HOME/.nvm" ]]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi