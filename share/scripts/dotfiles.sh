#!/bin/bash

case $1 in
    "update")
        git -C ${DOTFILES_ROOT_DIRECTORY} reset --hard HEAD
        git -C ${DOTFILES_ROOT_DIRECTORY} pull origin master
    ;;
    "reload-symlinks")
        deno run -A $DOTFILES_ROOT_DIRECTORY/share/scripts/symlinks.ts
    ;;
    "clean-symlinks")
        deno run -A $DOTFILES_ROOT_DIRECTORY/share/scripts/clean-symlinks.ts
    ;;
    "kitty-colors")
        deno run --allow-read "$DOTFILES_ROOT_DIRECTORY/share/scripts/kittycolors.ts" "${@:2}"
    ;;
    "reload")
        source $DOTFILES_ROOT_DIRECTORY/share/shell/init.sh
    ;;
    "os"*)
        if [[ -f ${DOTFILES_DIRECTORY}/scripts/commands.sh ]]; then
            ${DOTFILES_DIRECTORY}/scripts/commands.sh ${@:2}
        else
            echo "No hay comandos disponibles para este sistema operativo"
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
        echo "  clean-symlinks  Limpia los enlaces simbolicos rotos configurados en los dotfiles"
        echo ""
        echo "  kitty-colors [fichero]  Transforma un fichero exportado de terminal.sexy en formato JSON a el formato de la configuración de kitty"
        echo ""
        echo "  reload  Recarga la configuración de los dotfiles"
        echo ""
        echo "  os [comando]  Ejecuta un comando diseñado especificamente para el sistema operativo que se esta usando"
    ;;    
    *)
        echo "El comando $1 no existe, usa la opcion -h para la ayuda"
        exit 1
    ;;
esac
