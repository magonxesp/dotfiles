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

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm