#!/bin/bash

#
# Shell startup script (like .profile)
#
source ${DOTFILES_ROOT_DIRECTORY}/share/shell/exports.sh

if [[ -f $DOTFILES_DIRECTORY/shell/exports.sh ]]; then
    source ${DOTFILES_DIRECTORY}/shell/exports.sh
fi
