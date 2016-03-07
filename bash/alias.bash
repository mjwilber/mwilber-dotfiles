[ -z "$PS1" ] || echo "(alias.bash)"

for func_source in $BASH_CONFIG/functions/*; do  source $func_source; done

#SVN I use a wrapper for it to do some nice terminal and formatting items
alias svn=svn-wrap.sh

# TODO: Conditionally add this if ack not in path
alias ack=ack-grep

# Aliases for pagers
alias more='less'
alias mroe='less'
alias meor='less'
alias mreo='less'

# Alias out some standard shell commands with additional flags
alias rm='rm -v'
alias ls='ls --color=auto -F'
alias la='ls --color=auto -aF'
alias ll='ls --color=auto -lF'
alias lla='ls --color=auto -alF'
alias dirs='ls -adlF'

# alias which 'alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'
alias whence='type -a'
# Leave which alone as /bin/which simply returns the file path which is more handy usually
# alias which='type -a'
#

# Turn bc into a floating point beast
alias bc='bc -l'

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

alias json-decode="php -r 'print_r(json_decode(file_get_contents(\"php://stdin\")));'"

alias removeTrailing="sed 's/\\s\\+$//'"

alias restartUnity="pkill unity-2d-pane"

# alias update="sudo apt-get -qq update && sudo apt-get upgrade"
# alias install="sudo apt-get install"
# alias remove="sudo apt-get remove"
# alias search="apt-cache search"

alias liq='source $DOTFILES/liquidprompt/liquidprompt; [[ -n "${PRJ_NAME:-$PRJ}" ]] && prompt_tag ${PRJ_NAME:-$PRJ}'

# Dev tools
alias gw="./gradlew"
