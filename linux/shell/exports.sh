#!/bin/bash

if [[ "$USER" == "magonxesp" ]]; then
    export PATH=$PATH:/home/magonxesp/.local/bin
fi

if [[ -d /usr/local/go/bin ]]; then
    export PATH=$PATH:/usr/local/go/bin
fi

export NEOFETCH_IMAGE_BACKEND="kitty"
