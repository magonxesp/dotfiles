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
* ✅ [powerline fonts](https://github.com/powerline/fonts)
* ✅ [imagemagick](https://imagemagick.org/script/download.php)

Solo en linux:

* ✅ [rofi](https://github.com/davatorium/rofi)
* ✅ [kitty](https://github.com/kovidgoyal/kitty)
* ✅ [bspwm](https://wiki.archlinux.org/title/Bspwm_(Espa%C3%B1ol))
* ✅ [picom](https://wiki.archlinux.org/title/Picom)

Solo en macOS:

* ✅ [iTerm2](https://iterm2.com/downloads.html)
* ✅ [yabai](https://github.com/koekeishiya/yabai)
* ✅ [skhd](https://github.com/koekeishiya/skhd)

Para instalar los dotfiles hay que ejecutar el script ``install.sh``

NOTA: Para instalar usando zsh hay que instalarlo antes de ejecutar el script ``install.sh``. Si el fichero ``.zshrc`` no esta disponible se usara ``.bashrc`` por defecto.

```sh
chmod +x install.sh
./install.sh
```

## Comandos

El comando ```dotfiles``` puede ayudar a refrescar los enlaces simbolicos de los dotfiles

```sh
dotfiles reload-symlinks
```
