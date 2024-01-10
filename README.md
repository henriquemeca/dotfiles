# dotfiles
Contains scrips to make setting up configurations in a new machine easier

## Github setup
First setup the git ssh keys: 

1. [Generate your ssh key](https://docs.github.com/en/enterprise-cloud@latest/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

2. [Add a new ssh key to git](https://docs.github.com/en/enterprise-cloud@latest/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)

To initialize the setup run:
```sheel
git clone git@github.com:henriquemeca/dotfiles.git ~/.dotfiles
```

#TODO 
Use `ln -s real_path symbolic_path` to dinamic create symbolic links between the repo and home folder
#TODO
Add .git config to the repo

Then give permission to the scripts in this project:
```shell
chmod -R +x .
```

# Setup vim
1. Install NeoVim

On mac:
```shell
brew install neovim
```
## Mac scripts

#TODO

Give more detailed info about setting up brew. Probably involves using `xcode-select --install` as pre requisite for brew and git.

Use the code bellow to keep up to date packages installed with `brew`:
```shell
brew bundle dump --describe
```

Install Homebrew, after setting up dotfiles , followed by the software listed in the Brewfile.

```zsh
# These could also be in an install script.

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Then pass in the Brewfile location...
brew bundle --file ~/.dotfiles/Brewfile

# ...or move to the directory first.
cd ~/.dotfiles && brew bundle
```

## TODO List

- Learn how to use [`defaults`](https://macos-defaults.com/#%F0%9F%99%8B-what-s-a-defaults-command) to record and restore System Preferences and other macOS configurations.
- Automate symlinking and run script files with a bootstrapping tool like [Dotbot](https://github.com/anishathalye/dotbot).
- Revisit the list in [`.zshrc`](.zshrc) to customize the shell.
- Find inspiration and examples in other Dotfiles repositories at [dotfiles.github.io](https://dotfiles.github.io/).

