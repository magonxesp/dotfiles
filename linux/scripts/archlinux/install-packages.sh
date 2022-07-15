#!/bin/bash

if [[ -z $(which yay) ]]; then
    echo "Needs the yay aur helper installed"
    exit 1
fi

# Install fonts
sudo pacman -S ttf-dejavu \
    ttf-liberation \
    ttf-droid \
    ttf-ubuntu-font-family \
    noto-fonts \
    ttf-font-awesome \
    powerline-fonts

yay -S ttf-gelasio-ib \
    ttf-caladea \
    ttf-liberation-sans-narrow \
    ttf-ms-fonts

# Install icons and themes
sudo pacman -S papirus-icon-theme

# Install needed packages
sudo pacman -S git \
    bspwm \
    sxhkd \
    xfce4 \
    neovim \
    vim \
    python \
    python-pip \
    imagemagick \
    rofi \
    htop \
    curl \
    neofetch \
    nodejs \
    npm \
    picom \
    kitty \
    xorg-xsetroot
