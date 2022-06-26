#!/bin/bash

if [[ -f "$HOME/.zshrc" ]]; then
    # Init zshrc
    source ${DOTFILES_ROOT_DIRECTORY}/share/shell/zsh/zshrc
fi
