# Dotfiles

Mis dotfiles personales

## Instalación

### Dependencias

Antes de ejecutar el script de instalacion hay que asegurarse de que en el sistema estan inslatados estos paquetes.

Tanto para macOS y linux:
* ✅ [python 3](https://www.python.org/downloads) (3.9 o superior)
* ✅ [zsh](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH)
* ✅ [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh/wiki)
* ✅ [neofetch](https://github.com/dylanaraps/neofetch)

Solo en linux:
* ✅ [imagemagick](https://imagemagick.org/script/download.php)
* ✅ [rofi](https://github.com/davatorium/rofi)
* ✅ [kitty](https://github.com/kovidgoyal/kitty)

Solo en macOS:
* ✅ [iTerm2](https://iterm2.com/downloads.html)
* ✅ [kitty](https://github.com/kovidgoyal/kitty) (opcional)

Para instalar los dotfiles hay que ejecutar el script ``install.sh``
```sh
chmod +x install.sh
./install.sh
```

## Comandos

El comando ```dotfiles``` puede ayudar a refrescar los enlaces simbolicos de los dotfiles

```sh
$ dotfiles reload-symlinks
```
