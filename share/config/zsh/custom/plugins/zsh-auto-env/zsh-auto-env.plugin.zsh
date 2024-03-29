source_env_dir_file() {
	env_dir="$(pwd)/.envrc"

    if [[ -f "$env_dir" ]]; then
        source $env_dir
    fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd source_env_dir_file
