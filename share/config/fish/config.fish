if status is-login
    fenv "source $HOME/.fish_profile"
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    bass "source $DOTFILES_ROOT_DIRECTORY/share/shell/init.sh"
    neofetch
end
