#!/usr/bin/env bash

if [ "$(uname)" == "Darwin" ]; then
    echo "Running on OSX"
else
    echo "Running on $(uname)"
fi

echo "Installing dotfiles"

echo "Initializing submodule(s)"
git submodule update --init --recursive

source install/link.sh
source install/subinstalls.sh

echo "Done."
