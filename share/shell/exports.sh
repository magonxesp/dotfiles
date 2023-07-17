#!/bin/bash

# export DEFAULT_USER="$(whoami)"

if [[ -d "$HOME/.local/bin" ]]; then
    export PATH=$PATH:$HOME/.local/bin
fi

# Bun JavaScript runtime
[ -s "$HOME/.bun/_bun" ] && source "/home/juanma-alvarez/.bun/_bun"

if [[ -d "$HOME/.bun" ]]; then
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
fi

if [[ -d "$HOME/.deno" ]]; then
    export DENO_INSTALL="$HOME/.deno"
    export PATH="$DENO_INSTALL/bin:$PATH"
fi
