#!/usr/bin/env bash

DOTFILES=$HOME/.dotfiles

echo "Running sub-module installs"
subinstalls=$( find -H $DOTFILES -mindepth 2 -maxdepth 3 -name 'install.sh' )
for file in $subinstalls ; do
  echo $file
    target="$file"
    echo "  Running sub-module install for: $(basename $(dirname $file))"
    source "$target"
done
