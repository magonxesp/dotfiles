#!/bin/bash

# export DEFAULT_USER="$(whoami)"

if [[ -d "$HOME/.local/bin" ]]; then
    export PATH=$PATH:$HOME/.local/bin
fi
