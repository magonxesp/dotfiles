#!/bin/bash

read -p "Directorio de los dotfiles (por defecto ~/dotfiles)" dotfiles_directory

if [[ -z "$dotfiles_directory" ]]
then
    dotfiles_directory="~/dotfiles"
fi

eval dotfiles_directory=$dotfiles_directory

echo "La ruta de los dotfiles se ha configurado en $dotfiles_directory"

if [[ -f "$HOME/.zshrc" ]]
then
    echo "export DOTFILES_DIRECTORY=$dotfiles_directory" >> $HOME/.zshrc
    echo 'source ${DOTFILES_DIRECTORY}/dotfiles.sh' >> $HOME/.zshrc
elif [[ -f "$HOME/.bashrc" ]]
then
    echo "export DOTFILES_DIRECTORY=$dotfiles_directory" >> $HOME/.bashrc
    echo 'source ${DOTFILES_DIRECTORY}/dotfiles.sh' >> $HOME/.bashrc
fi

echo "Para aplicar los cambios reinicia la terminal"
