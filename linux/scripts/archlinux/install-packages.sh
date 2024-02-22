#!/bin/bash
if [[ ! -d "$HOME/.local/bin" ]]; then
    mkdir -p "$HOME/.local/bin"
fi

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
    kitty \
    xorg-xsetroot \
    gtk-engine-murrine

# Install extra packages from AUR
yay -S pfetch

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

nvm install --lts
nvm use --lts
nvm alias default $(node -v)
