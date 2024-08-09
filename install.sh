#!/bin/bash

#
# Export dotfiles is currently installing
#
export IS_DOTFILES_INSTALL="true"

#
# OS Selection
#
read -p "Selecciona el sistema operativo: " system

if [[ "$system" != "macOS" && "$system" != "linux" ]]
then
    echo "El sistema operativo $system no esta soportado"
    echo "Los sistemas operativos soportados son:"
    echo " > macOS"
    echo " > linux"
    exit 1
fi


#
# Dotfiles directory path check
#
dotfiles_directory="$HOME/dotfiles"

if [[ ! -d "$dotfiles_directory" ]]
then
    echo "No se encuentra el directorio de los dotfiles en $dotfiles_directory."
    exit 1
fi

#
# Backup directory
#
# Save files like .profile or .bashrc for restore
# if necesary
#
home_dotfiles_backups="$dotfiles_directory/backups"

#
# OS Install script
#
# The OS install script installs packages needed
# for the correct functionality of the available
# configurations
#
so_install_script="$dotfiles_directory/install-${system,,}.sh"

#
# Export the absolute path to the dotfiles directory
#
export DOTFILES_ROOT_DIRECTORY="$dotfiles_directory"
export DOTFILES_DIRECTORY="$dotfiles_directory/$system"

echo "La ruta de los dotfiles se ha configurado en $dotfiles_directory"

#
# Execute the OS install script if exists and if it is not installed
#
if [[ -f $so_install_script ]] && [[ $DOTFILES_OS_PACKAGES_INSTALLED != "true" ]]
then
    $so_install_script
fi

#
# Startup scripts for the different supported shells
#
profile_files=(
    ~/.profile
    ~/.zprofile
)

#
# Write exports on the startup scripts
#
exports=(
    "export DOTFILES_IS_INSTALLED=true"
    "export DOTFILES_OS_PACKAGES_INSTALLED=true"
    "export DOTFILES_ROOT_DIRECTORY=$dotfiles_directory"
    "export DOTFILES_DIRECTORY=$dotfiles_directory/$system"
    '. "$DOTFILES_ROOT_DIRECTORY/share/shell/shell.sh"'
)

if [[ -z "$DOTFILES_IS_INSTALLED" ]]; then
    IFS=$'\n'; echo "${exports[*]}" | tee -a ${profile_files[@]}
else
    echo "Parece que los dotfiles ya estaban instalados, en caso de haber cambios asegurate que estan estas lineas en los ficheros ${profile_files[@]}"
    IFS=$'\n'; echo "${exports[*]}"
fi

#
# Launch dotfiles init script
#
source ${DOTFILES_ROOT_DIRECTORY}/share/shell/init.sh

#
# Check dotfiles command is available
#
which dotfiles

if [[ $? -gt 0 ]]
then
  echo "El comando dotfiles no se encuentra o puede que no se haya añadido a la variable PATH"
fi

#
# Setup the symlinks from the home directory to the dotfiles directory
#
dotfiles update-symlinks

if [[ $? -gt 0 ]]
then
    echo "No se ha podido crear los enlaces simbolicos debido a un error!"
    exit 1
fi

#
# Set the install process as ended
#
export IS_DOTFILES_INSTALL=""

echo "Para aplicar los cambios reinicia la terminal"
