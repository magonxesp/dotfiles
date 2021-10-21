#!/bin/bash

case $1 in
    "reload-symlinks")
        python3 $DOTFILES_ROOT_DIRECTORY/share/scripts/symlinks.py
    ;;
    "kitty-colors")
        python3 $DOTFILES_ROOT_DIRECTORY/share/scripts/kittycolors.py ${@:2}
    ;;
    "install-scripts-depencencies")
        pip3 -r $DOTFILES_ROOT_DIRECTORY/share/scripts/requirements.txt
    ;;    
    "-h")
        echo "Dotfiles"
        echo ""
        echo "USO: dotfiles [-h] [comando]"
        echo "OPCIONES:"
        echo "  -h      Muestra la ayuda del comando"
        echo ""
        echo "ARGUMENTOS:"
        echo "  comando El nombre del comando a ejecutar para gestionar los dotfiles"
        echo ""
        echo "COMANDOS:"
        echo "  reload-symlinks Actualiza los enlaces simbolicos de los dotfiles"
        echo ""
        echo "  kitty-colors [fichero] Transforma un fichero exportado de terminal.sexy en formato JSON a el formato de la configuración de kitty"
        echo ""
        echo "  install-scripts-depencencies Instala las dependecias de los scripts de python"
    ;;    
    *)
        echo "El comando $1 no existe, usa la opcion -h para la ayuda"
        exit 1
    ;;
esac