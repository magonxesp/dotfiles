# Dotfiles

Mis dotfiles personales

## Instalación

### Dependencias

Antes de ejecutar el script de instalacion hay que asegurarse de que en el sistema estan inslatados estos paquetes.

Tanto para macOS y linux:

* ✅ [Deno](https://docs.deno.com/runtime/#install-deno)
* ✅ [zsh](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH)
* ✅ [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh/wiki)
* ✅ [neofetch](https://github.com/dylanaraps/neofetch)
* ✅ [powerline fonts](https://github.com/powerline/fonts)
* ✅ [imagemagick](https://imagemagick.org/script/download.php)

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
