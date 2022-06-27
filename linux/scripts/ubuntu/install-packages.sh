#!/bin/bash

sudo apt update

# setup packages
echo "Instalando paquetes necesarios..."
sudo apt install -y \
  curl \
  python3 \
  python3-pip \
  imagemagick \
  kitty \
  rofi \
  fonts-powerline \
  neofetch \
  htop \
  nodejs \
  npm \
  vim \
  fonts-font-awesome \
  bspwm \
  xfce4 \
  picom

sudo apt-add-repository ppa:neovim-ppa/stable -y
sudo apt update
sudo apt install -y neovim

echo "Instalando temas..."
sudo apt install -y arc-theme

sudo add-apt-repository ppa:papirus/papirus -y
sudo apt-get update
sudo apt-get install -y papirus-icon-theme


read -p "Install extra packages (y/n)" extra

if [[ "$extra" != "y" ]]; then
  exit 0
fi

echo "Instalando paquetes extra..."

# setup docker
echo "Instalando docker..."
sudo apt update
sudo apt install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
