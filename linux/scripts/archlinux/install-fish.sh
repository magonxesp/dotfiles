#!/bin/bash

sudo pacman -S fish
curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
chsh -s $(which fish)

omf install foreign-env
omf install bass
