#!/bin/bash
if [[ ! -d "$HOME/.local/bin" ]]; then
    mkdir -p "$HOME/.local/bin"
fi

sudo apt update

# setup packages
echo "Instalando paquetes necesarios..."
sudo apt install -y \
  curl \
  python3 \
  python3-pip \
  imagemagick \
  rofi \
  fonts-powerline \
  htop \
  nodejs \
  npm \
  vim \
  fonts-font-awesome

sudo apt-add-repository ppa:neovim-ppa/stable -y
sudo apt update
sudo apt install -y neovim

read -p "Install extra packages (y/n)" extra

if [[ "$extra" != "y" ]]; then
  exit 0
fi

echo "Instalando paquetes extra..."

echo "Instalando sdkman..."
curl -s "https://get.sdkman.io" | bash

echo "Instalando rustup..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "Instalando nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

echo "Instalando ultima version de nodejs (LTS)..."
nvm install --lts
nvm use --lts
nvm alias default $(node -v)