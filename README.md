# Dotfiles

Mis dotfiles personales

## Instalación

### Dependencias

Antes de ejecutar el script de instalacion hay que asegurarse de que en el sistema estan inslatados estos paquetes.

Tanto para macOS y linux:

* ⚠️ [python 3](https://www.python.org/downloads) (3.9 o superior)
	* Python ya no es necesario y los scripts que hay se han deprecado a favor del nuevo programa `dotfiles` escrito en kotlin.
	* Para poder volver a usar los scripts en python tienes que ejecutar el script `support-legacy-scripts.sh` y ejecutar a posterior el script deseado desde el comando `dotfiles-legacy` (puede que algunos scripts hayan dejado de funcionar).
* ✅ [zsh](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH)
* ✅ [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh/wiki)
* ✅ [neofetch](https://github.com/dylanaraps/neofetch)
* ✅ [powerline fonts](https://github.com/powerline/fonts)
* ✅ [imagemagick](https://imagemagick.org/script/download.php)

Solo en linux:

* ✅ [kitty](https://github.com/kovidgoyal/kitty)
* ✅ [GNOME](https://www.gnome.org/)

Solo en macOS:

* ✅ [iTerm2](https://iterm2.com/downloads.html)
* ✅ [yabai](https://github.com/koekeishiya/yabai)
* ✅ [skhd](https://github.com/koekeishiya/skhd)

## Instalación en Ubuntu

Para instalar una shell existen los siguientes scripts.

Para instalar zsh.
```sh
$ linux/scripts/ubuntu/install-zsh.sh
```

Despues de instalar la shell ya puedes instalar el resto de paquetes necesarios.

```sh
$ linux/scripts/ubuntu/install-packages.sh
```

## Ejecutar el script de instalacion

Una vez ya esta instalada la shell y el resto de paquetes necesarios ya puedes instalar los dotfiles.

Para instalar los dotfiles hay que ejecutar el script ``install.sh``

```sh
$ chmod +x install.sh
$ ./install.sh
```

## Comandos

El comando ```dotfiles``` puede ayudar a refrescar los enlaces simbolicos de los dotfiles

```sh
$ dotfiles update-symlinks
```

## Configuración del entorno de escritorio

* [GNOME](docs/gnome.md)
