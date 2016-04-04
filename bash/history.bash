shopt -s histappend	# Append to HISTFILE on shell exit rather than overwrite

export HISTCONTROL=ignoreboth:erasedups
export HISTFILESIZE=20000
export HISTSIZE=2000
export HISTTIMEFORMAT='%F %T '
export HISTIGNORE="pwd:ls:h:history:clear:c:"
