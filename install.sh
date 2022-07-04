#!/bin/bash

export IS_DOTFILES_INSTALL="true"

read -p "Selecciona el sistema operativo: " system

if [[ "$system" != "macOS" && "$system" != "linux" ]]
then
    echo "El sistema operativo $system no esta soportado"
    echo "Los sistemas operativos soportados son:"
    echo " > macOS"
    echo " > linux"
    exit 1
fi

dotfiles_directory="$HOME/dotfiles"

if [[ ! -d "$dotfiles_directory" ]]
then
    echo "No se encuentra el directorio de los dotfiles en $dotfiles_directory."
    exit 1
fi

home_dotfiles_backups="$dotfiles_directory/backups"
so_install_script="$dotfiles_directory/install-${system,,}.sh"

export DOTFILES_ROOT_DIRECTORY="$dotfiles_directory"
export DOTFILES_DIRECTORY="$dotfiles_directory/$system"

echo "La ruta de los dotfiles se ha configurado en $dotfiles_directory"

# Operating system specific install
if [[ -f $so_install_script ]]
then
    $so_install_script
fi

if [[ ! -f "$HOME/.profile" ]]; then
    echo "Error: No existe el fichero .profile en $HOME"
    exit 1
fi

echo "export DOTFILES_ROOT_DIRECTORY=$dotfiles_directory" >> ~/.profile
echo "export DOTFILES_DIRECTORY=$dotfiles_directory/$system" >> ~/.profile
echo '. "$DOTFILES_ROOT_DIRECTORY/shell.sh"' >> ~/.profile
echo '. "$DOTFILES_ROOT_DIRECTORY/init.sh"' >> ~/.profile

source ${DOTFILES_ROOT_DIRECTORY}/init.sh

which python3

if [[ $? -gt 0 ]]
then
  echo "Se necesita Python 3.9 o mayor para continuar"
fi

pip3 install -r ${DOTFILES_ROOT_DIRECTORY}/share/scripts/requirements.txt
python3 ${DOTFILES_ROOT_DIRECTORY}/share/scripts/symlinks.py

if [[ $? -gt 0 ]]
then
    echo "No se ha podido crear los enlaces simbolicos debido a un error!"
    exit 1
fi

export IS_DOTFILES_INSTALL=""

echo "Para aplicar los cambios reinicia la terminal"
