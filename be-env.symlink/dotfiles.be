echo "(dotfiles.be) $*"
########################################################
# Description: Project setup for the existing dotfiles
#

export PRJ=dotfiles
#export PRJ_NAME=<use to override liquid prompt display name
export PBRANCH=${1:-develop}

# Setup the new project
if [ -z ${DOTFILES+x} ]; then
    export DOTFILES=~/.dotfiles
fi

export PRJ_HOME="$DOTFILES"
if [ ! -d ${PRJ_HOME} ]; then
    echo "NO project home found!!!!"
fi

mark -p phome $PRJ_HOME

cd $PRJ_HOME;
pwd

