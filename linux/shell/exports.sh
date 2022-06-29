#!/bin/bash

if [[ -d "/usr/local/go/bin" ]]; then
    export PATH=$PATH:/usr/local/go/bin
fi


if [[ -f "$DOTFILES_DIRECTORY/shell/themes.sh" ]]; then
    source "$DOTFILES_DIRECTORY/shell/themes.sh"
fi

export NEOFETCH_IMAGE_BACKEND="kitty"
