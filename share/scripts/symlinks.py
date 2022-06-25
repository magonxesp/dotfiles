from typing import List
import yaml
import os
import shutil


def parse_sym_links_config(symlinksfile: str):
    with open(symlinksfile) as file:
        config = yaml.load(file, Loader=yaml.CLoader)

        if "symlinks" in config:
            return config["symlinks"]
    
    return None


def makelink(override: bool, origin: str, destination: str):
    if os.path.exists(origin) is False:
        raise Exception("The file {} cannot be linked because doesn't exists!".format(origin))

    if os.path.exists(destination) and override is False:
        return

    if os.path.isfile(destination) and override:
        os.remove(destination)
    
    if os.path.islink(destination) and override:
        os.unlink(destination)

    if os.path.isdir(destination) and override:
        shutil.rmtree(destination)

    link_directory = os.path.dirname(destination)

    if os.path.isdir(link_directory) is False and os.path.isdir(origin) is False:
        os.makedirs(link_directory)

    os.symlink(origin, destination)


def makelinks(override: bool, links: List[str]):
    for link in links:
        symlink = link.split(":")

        destination = os.path.expanduser(symlink[0])
        origin = os.path.expanduser(symlink[1])

        makelink(override, origin, destination)


def main():
    dotfiles_directory = os.getenv('DOTFILES_DIRECTORY')   
    
    if dotfiles_directory is None:
        raise Exception("The environment variable DOTFILES_DIRECTORY does not exists")
    
    symlinks_config_file = os.path.join(dotfiles_directory, "symlinks", "config.symlinks.yml")

    print("Applying symliks from", symlinks_config_file)

    config = parse_sym_links_config(symlinks_config_file)

    if config is None:
        raise Exception("Symlinks not found")

    makelinks(config["override"], config["links"])


if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print(str(e))
        exit(1)
