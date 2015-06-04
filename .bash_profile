# ~/.bash_profile: executed by bash for login shells.
echo "(~/.bash_profile)"

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin
export PATH

export HISTTIMEFORMAT='%F %T '
export HISTIGNORE="pwd:ls:h:history:clear:c:"
