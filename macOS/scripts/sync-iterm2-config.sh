#!/bin/bash

iterm2_config_file="com.googlecode.iterm2.plist"
iterm2_config="~/.config/iterm2/$iterm2_config_file"
dotfiles_iterm2_config="$DOTFILES_DIRECTORY/config/iterm2"

eval iterm2_config=$iterm2_config

if [[ ! -f $iterm2_config ]]
then
    echo "No se encuetra la configuracion de iterm2 en $iterm2_config"
    exit 1
fi

if [[ ! -d $dotfiles_iterm2_config ]]
then
    echo "No se encutra el directorio $dotfiles_iterm2_config"
    exit 1
fi

cp ${iterm2_config} ${dotfiles_iterm2_config}/${iterm2_config_file}
