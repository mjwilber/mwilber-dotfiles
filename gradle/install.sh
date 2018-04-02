#!/usr/bin/env bash
# We need to do it this way, because the .gradle directory is used to hold a whole mess
# of cached items (mostly from library repos).

echo -n "  Creating gradle directory  "
mkdir -p ~/.gradle

echo "Done."


echo -n "  Symlink default gradle.properties from ~/.gradle to DOTFILES/gradle/gradle.properties  "
source=$DOTFILES/gradle/gradle.properties
target=~/.gradle/gradle.properties

if [ -L "$target" ]; then
  echo " -- link exists"
elif [ -e "$target" ]; then
  echo " -- OVERRIDDEN"
else
  # $file is already absolute no need to specify DOTFILES again
  # ln -s $DOTFILES/$file $target
  ln -s "$source" "$target"
  echo "linked!"
fi

