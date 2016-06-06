shopt -s histappend	# Append to HISTFILE on shell exit rather than overwrite

export HISTCONTROL=ignoreboth:erasedups

export HISTFILESIZE=20000
export HISTSIZE=2000
# Infinite history
# export HISTFILESIZE=-1
# export HISTSIZE=-1

export HISTTIMEFORMAT='%F %T '
export HISTIGNORE="pwd:ls:h:history:clear:c:"

# TODO: consider history re-read, -a = append new stuff, -c clear current shell's hist cache, -r read hist file again
# PROMPT_COMMAND=....;history -a; history -c; history -r
