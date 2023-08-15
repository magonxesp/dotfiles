#!/bin/bash

# export DEFAULT_USER="$(whoami)"

if [[ -d "$HOME/.local/bin" ]]; then
    export PATH=$PATH:$HOME/.local/bin
fi

if [[ -d "$HOME/.sdkman" ]]; then
    export SDKMAN_DIR="$HOME/.sdkman"
    [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
fi
