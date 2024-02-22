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
  neofetch \
  htop \
  nodejs \
  npm \
  vim \
  fonts-font-awesome


curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
sudo ln -s ~/.local/kitty.app/bin/kitty /usr/local/bin/kitty
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop

sudo apt-add-repository ppa:neovim-ppa/stable -y
sudo apt update
sudo apt install -y neovim

echo "Instalando temas..."
sudo apt install -y arc-theme

sudo add-apt-repository ppa:papirus/papirus -y
sudo apt-get update
sudo apt-get install -y papirus-icon-theme

echo "Instalando nvm..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

echo "Instalando ultima version de nodejs (LTS)..."
nvm install --lts
nvm use --lts
nvm alias default $(node -v)

echo "Instalando plugins de zsh..."
export bin_path="$HOME/.local/bin"
curl -sfL https://direnv.net/install.sh | bash


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

echo "Instalando sdkman..."
curl -s "https://get.sdkman.io" | bash

echo "Instalando rustup..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh