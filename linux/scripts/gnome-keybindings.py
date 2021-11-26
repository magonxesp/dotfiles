import yaml
import os


def keybindings(conf_path):
    with open(conf_path) as f:
        config = yaml.load(f, Loader=yaml.CLoader)
    
    if "keybindings" not in config:
        raise Exception("Missing keybindigs in config")

    return config["keybindings"]


def create(keybindings):
    _list = []
    i = 0

    for keybinding in keybindings:
        _list.append("'/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom{}/'".format(i))
        i += 1

    os.system("gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \"[{}]\"".format(",".join(_list)))


def set_properties(keybindings):
    i = 0

    for keybinding in keybindings:
        os.system("gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom{}/ name \"{}\"".format(i, keybinding["name"]))
        os.system("gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom{}/ command \"{}\"".format(i, keybinding["command"]))
        os.system("gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom{}/ binding \"{}\"".format(i, keybinding["binding"]))
        i += 1


def main():
    dotfiles_directory = os.getenv('DOTFILES_DIRECTORY')   

    if dotfiles_directory is None:
        raise Exception("The environment variable DOTFILES_DIRECTORY does not exists")
    
    keybindigs_config_file = os.path.join(dotfiles_directory, "config", "gnome", "custom.keybindings.yml")
    
    config = keybindings(keybindigs_config_file)

    create(config)
    set_properties(config)
 

if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print(e)
        exit(1)