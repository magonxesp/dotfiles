#!/bin/bash

distro=""

if [[ -f /etc/os-release ]]
then
    . /etc/os-release
    distro=$NAME
    VER=$VERSION_ID
fi

case ${distro,,} in
    "ubuntu")
        $DOTFILES_DIRECTORY/scripts/setup-ubuntu.sh
    ;;
esac
