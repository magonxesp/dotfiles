#!/bin/bash

if [[ -d "/usr/local/go/bin" ]]; then
    export PATH=$PATH:/usr/local/go/bin
fi

export NEOFETCH_IMAGE_BACKEND="kitty"
