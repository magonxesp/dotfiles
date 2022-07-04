#!/bin/bash

echo "Instalando fish..."
sudo apt install -y fish curl
chsh -s $(which fish)
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish

# install fish plugins
omf install foreign-env
omf install bass
