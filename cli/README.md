# Dotfiles CLI

A command-line tool for managing your dotfiles configuration.

## Requirements

- Go 1.23 or higher

## Installation

```bash
go install .
```

## Usage

### Update Symbolic Links

```bash
dotfiles update-symlinks
```

### Update Dotfiles

```bash
dotfiles update
```

Requires `DOTFILES_ROOT_DIRECTORY` and `DOTFILES_DIRECTORY` environment variables to be set.

## Environment Variables

- `DOTFILES_ROOT_DIRECTORY`: Path to the root directory of your dotfiles repository
- `DOTFILES_DIRECTORY`: Path to the dotfiles configuration directory

## Symbolic Links Configuration

Create YAML files in `$DOTFILES_DIRECTORY/symlinks/` with the following format:

```yaml
symlinks:
  override: false
  links:
    - ~/.config/nvim:$DOTFILES_DIRECTORY/config/nvim
    - ~/.bashrc:$DOTFILES_DIRECTORY/shell/bashrc
```

Each link is formatted as `destination:origin`.
