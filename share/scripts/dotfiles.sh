#!/bin/bash

case $1 in
    "update")
        git -C ${DOTFILES_ROOT_DIRECTORY} reset --hard HEAD
        git -C ${DOTFILES_ROOT_DIRECTORY} pull origin master
    ;;
    "reload-symlinks")
        python3 $DOTFILES_ROOT_DIRECTORY/share/scripts/symlinks.py
    ;;
    "kitty-colors")
        python3 $DOTFILES_ROOT_DIRECTORY/share/scripts/kittycolors.py ${@:2}
    ;;
    "install-scripts-depencencies")
        pip3 install -r $DOTFILES_ROOT_DIRECTORY/share/scripts/requirements.txt
    ;;
    "os"*)
        if [[ -f ${DOTFILES_DIRECTORY}/scripts/commands.sh ]]; then
            ${DOTFILES_DIRECTORY}/scripts/commands.sh ${@:2}
        fi
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
        echo "  update  Actualiza todos los dotfiles a la ultima version, descartando cualquier cambio que no haya sido comiteado con antelación"
        echo ""
        echo "  reload-symlinks  Actualiza los enlaces simbolicos de los dotfiles"
        echo ""
        echo "  kitty-colors [fichero]  Transforma un fichero exportado de terminal.sexy en formato JSON a el formato de la configuración de kitty"
        echo ""
        echo "  install-scripts-depencencies  Instala las dependecias de los scripts de python"
        echo ""
        echo "  os [comando]  Ejecuta un comando diseñado especificamente para el sistema operativo que se esta usando"
    ;;    
    *)
        echo "El comando $1 no existe, usa la opcion -h para la ayuda"
        exit 1
    ;;
esac