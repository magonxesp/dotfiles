#!/bin/bash

apt update

# setup packages
echo "Instalando paquetes..."
apt install -y \
  curl \
  flatpak \
  gnome-software \
  gnome-software-plugin-flatpak \
  gnome-tweaks \
  python3-pip \
  imagemagick \
  kitty \
  rofi \
  fonts-powerline \
  neofetch \
  htop \
  nodejs \
  npm


# setup docker
echo "Instalando docker..."
apt update
apt install -y \
  ca-certificates \
  curl \
  gnupg \
  lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update
apt install -y docker-ce docker-ce-cli containerd.io

curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose


echo "Instalando temas..."
apt install -y arc-theme

add-apt-repository ppa:papirus/papirus -y
apt-get update
apt-get install -y papirus-icon-theme

echo "Instalando paquetes extra..."
# lutris
add-apt-repository ppa:lutris-team/lutris -y
apt update
apt install -y lutris

# neovim
apt-add-repository ppa:neovim-ppa/stable -y
apt update
apt install -y neovim

# setup zsh
echo "Instalando zsh..."
apt install -y zsh curl
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
