#!/bin/bash

echo -n "  Creating git aliases "

git config --global alias.st status; echo -n "."
git config --global alias.ss 'status -s'; echo -n "."
git config --global alias.ci commit; echo -n "."
git config --global alias.br branch; echo -n "."
git config --global alias.co checkout; echo -n "."
git config --global alias.unstage 'reset HEAD --'; echo -n "."
git config --global alias.last 'log -1 HEAD'; echo -n "."
git config --global alias.open '!xdg-open `git config remote.origin.url`'; echo -n "."
git config --global alias.browse '!git open'; echo -n "."
# ll = log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat
# ld = log --pretty=format:"%C(yellow)%h\\ %C(green)%ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short --graph
# ls = log --pretty=format:"%C(green)%h\\ %C(yellow)[%ad]%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=relative
# hist "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
# git config --global alias.type 'cat-file -t'
# git config --global alias.dump 'cat-file -p'

echo "  Done."
