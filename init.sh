#!/bin/bash

# Inicializa los scripts compartidos para cualquier sistema operativo
source ${DOTFILES_ROOT_DIRECTORY}/share/shell/exports.sh
source ${DOTFILES_ROOT_DIRECTORY}/share/shell/alias.sh

# Inicializa los script especificos del sistema operativo
if [[ -f $DOTFILES_DIRECTORY/shell/alias.sh ]]; then
    source ${DOTFILES_DIRECTORY}/shell/alias.sh
fi

if [[ -f $DOTFILES_DIRECTORY/shell/exports.sh ]]; then
    source ${DOTFILES_DIRECTORY}/shell/exports.sh
fi

source ${DOTFILES_ROOT_DIRECTORY}/share/shell/startup.sh
