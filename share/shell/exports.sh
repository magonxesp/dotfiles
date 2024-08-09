#!/bin/bash

if [[ -d "$DOTFILES_ROOT_DIRECTORY/bin" ]]; then
    export PATH=$PATH:$DOTFILES_ROOT_DIRECTORY/bin
fi

if [[ -d "$HOME/.local/bin" ]]; then
    export PATH=$PATH:$HOME/.local/bin
fi

if [[ -d "$HOME/.yarn/bin" ]]; then
    export PATH=$PATH:$HOME/.yarn/bin
fi
    
if [[ -d "$HOME/.deno" ]]; then
    export DENO_INSTALL="$HOME/.deno"
    export PATH="$DENO_INSTALL/bin:$PATH"
fi

if [[ -d "$HOME/.sdkman" ]]; then
    export SDKMAN_DIR="$HOME/.sdkman"
    [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
fi
