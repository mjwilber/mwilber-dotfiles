#!/bin/bash

DOTFILES=$HOME/.dotfiles

echo "creating symlinks"
linkables=$( find -H "$DOTFILES" -maxdepth 3 -name '*.symlink' )
for file in $linkables ; do
    target="$HOME/.$( basename $file ".symlink" )"
    echo "  creating symlink for $file"
    # $file is already absolute no need to specify DOTFILES again
    # ln -s $DOTFILES/$file $target
    ln -s $file $target
done
