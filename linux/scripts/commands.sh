#!/bin/bash

# linux dotfiles commands
case $1 in
    "set-gnome-keybindings")
        $DOTFILES_DIRECTORY/config/gnome/keybindings.sh
        python3 $DOTFILES_DIRECTORY/scripts/gnome-keybindings.py
    ;;
    "-h")
        echo "Dotfiles linux"
        echo ""
        echo "USO: dotfiles os [-h] [comando]"
        echo "OPCIONES:"
        echo "  -h      Muestra la ayuda del comando"
        echo ""
        echo "ARGUMENTOS:"
        echo "  comando El nombre del comando a ejecutar para gestionar los dotfiles"
        echo ""
        echo "COMANDOS:"
        echo "  set-gnome-keybindings  Establece los atajos de teclado personalizados"
    ;;    
    *)
        echo "El comando $1 no existe, usa la opcion -h para la ayuda"
        exit 1
    ;;
esac
