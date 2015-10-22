
[ -z "$PS1" ] || echo "(alias.bash)"

#SVN I use a wrapper for it to do some nice terminal and formatting items
alias svn=svn-wrap.sh

# Aliases for pagers
alias more='less'
alias mroe='less'
alias meor='less'
alias mreo='less'

# Alias out some standard shell commands with additional flags
alias rm='rm -v'
alias ls='ls --color=auto -F'
alias la='ls --color=auto -aF'
alias ll='ls --color=auto -alF'
alias dirs='ls -adlF'

# alias which 'alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'
# alias whence='type -a'
alias which='type -a'
#
# # Alias out some shell/process status items
alias h='history'
alias j='jobs -l'
alias path='echo -e ${PATH//:/\\n}'
# alias classpath='echo -e ${CLASSPATH//:/\\n}'
# alias psg='ps -ef | grep '
alias clrae='clear'
alias clera='clear'
alias clare='clear'
alias celar='clear'
alias claer='clear'
alias cealr='clear'
alias cls='clear'
#
# # Alias out some navigational commands
alias ..='cd ..'
alias ...='cd ../..'

# #####################################################################
alias home="pushd ${HOME}"
#
# sudo mount 192.68.42.64:/backup /mnt/readynas
# sudo mount 192.68.42.64:/media /mnt/readynas 
# umount /mnt/readynas

# TODO: Conditionally add this if ack not in path
alias ack=ack-grep

# ack could also 
##!/usr/bin/env bash
#grep -rI –color –exclude-dir=\.bzr –exclude-dir=\.git –exclude-dir=\.hg –exclude-dir=\.svn –exclude-dir=build –exclude-dir=dist –exclude=tags $*

box() { t="$1xxxx";c=${2:-#}; echo ${t//?/$c}; echo "$c $1 $c"; echo ${t//?/$c}; }
