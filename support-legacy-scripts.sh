#!/bin/bash

#
# Check if python 3 is installed
#
which python3

if [[ $? -gt 0 ]]
then
  echo "Se necesita Python 3.9 o mayor para continuar"
fi

#
# Install python dependencies
#
pip3 install -r ${DOTFILES_ROOT_DIRECTORY}/share/scripts/requirements.txt
