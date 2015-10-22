# mwilber-dotfiles

Installation of my environment - many ideas for install stolen from nicknisi/dotfiles.
This contains bash (prompt, marks, alias), vim and conky configurations.

## Contents

+ Initial setup
+ vim setup
+ bash setup
+ tmux configuration (Possibly in the future)
+ git configuration

## Initial setup and installation

I found it easier to close using ssh, but this is the gist to get it to the machine.
*Request git installed*

```bash
git clone https://github.com/nicknisi/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

`install.sh` will start by initializing the submodules used by this repository. There are currently none, but this would allow us to pull in other repos of similar shell things. Then, it will install all symbolic links into your home directory. Every file with a `.symlink` extension will be symlinked to the home directory with a `.` in front of it. As an example, `vimrc.symlink` will be symlinked in the home directory as `~/.vimrc`. Then, this script will create a `~/.vim-tmp` directory in your home directory, as this is where vim is configured to. 

-----

+ zsh configuration
+ vim configuration

## Install

I've found ssh cloning to be easier to setup

1. `git clone https://github.com/nicknisi/dotfiles.git ~/.dotfiles`
1. `cd ~/.dotfiles`
1. `./install.sh`

## ZSH Plugins

By default, the `.zshrc` file will source any file within `.dotfiles/zsh` that have the `.zsh` extension.

## Vim Plugins

Vim plugins are managed with [vim-plug](https://github.com/junegunn/vim-plug). To install, run `vim +PlugInstall`.
