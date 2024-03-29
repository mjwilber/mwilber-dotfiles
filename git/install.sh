#!/usr/bin/env bash

echo -n "  Creating git aliases "

git config --global alias.st status; echo -n "."
git config --global alias.ss 'status --short'; echo -n "."
git config --global alias.shorty 'status --short --branch'
git config --global alias.ci commit; echo -n "."
git config --global alias.br branch; echo -n "."
git config --global alias.co checkout; echo -n "."
git config --global alias.unstage 'reset HEAD --'; echo -n "."
git config --global alias.last 'log -1 HEAD'; echo -n "."
git config --global alias.open '!xdg-open `git config remote.origin.url`'; echo -n "."
git config --global alias.browse '!git open'; echo -n "."
# Some suggestions from https://dzone.com/articles/lesser-known-git-commands
git config --global alias.please 'push --force-with-lease'
git config --global alias.commend 'commit --amend --no-edit'
#    - Create a new repo with an empty first commit
git config --global alias.it '!git init && git commit -m “root” --allow-empty'
# git config --global alias.stsh 'stash --keep-index'
# git config --global alias.staash 'stash --include-untracked'
# git config --global alias.staaash 'stash --all'
git config --global alias.grog 'log --graph --abbrev-commit --decorate --all --format=format:"%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(dim white) - %an%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n %C(white)%s%C(reset)"'
git config --global alias.all 'fetch --all --prune'
git config --global alias.fall 'fetch --all --prune'

git config --global alias.recent "for-each-ref --sort=-committerdate refs/heads/ --format='%(HEAD) %(color:red)%(objectname:short)%(color:reset) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'"

# Other suggestions
# ll = log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat
# ld = log --pretty=format:"%C(yellow)%h\\ %C(green)%ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short --graph
# ls = log --pretty=format:"%C(green)%h\\ %C(yellow)[%ad]%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=relative
# hist "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short"
# git config --global alias.type 'cat-file -t'
# git config --global alias.dump 'cat-file -p'

# Show all branches (even across remotes)
git config --global alias.branches 'branch -a --color -v'

# Get short SHA-1 for object
git config --global alias.hash 'rev-parse HEAD'

# Update all submodules
git config --global alias.subs 'submodule foreach git pull origin master' # master == develop?

# List all modified files
git config --global alias.wip 'ls-files -m'

echo "  Done."
