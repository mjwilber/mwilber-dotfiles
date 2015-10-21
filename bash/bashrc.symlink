# .bashrc
[ -z "$PS1" ] || echo "(~/.bashrc)"

export EDITOR=vi

if [ -n "$PS1" ]; then # Run the rest only for interactive shells
	# Source global definitions
	if [ -f /etc/bashrc ]; then
		. /etc/bashrc
	fi


	shopt -s cdspell	# Changing directories ignores spmall typos
	shopt -s histappend	# Append to HISTFILE on shell exit rather than overwrite

	# Set default prompt

	# User specific aliases and functions
	[ -e ~/.alias ] && . ~/.alias
	[ -e ~/.path_functions ] && . ~/.path_functions

	# [ -e ~/bin/bashmarks.bash ] && . ~/bin/bashmarks.bash 
	[ -e ~/.marksrc ] && . ~/.marksrc

	[ -e ~/bin/project-env.sh ] && . ~/bin/project-env.sh

	export PROMPT_COMMAND="history -a; history -n;${PROMPT_COMMAND}"

fi
