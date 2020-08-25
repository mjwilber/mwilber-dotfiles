[ -z "$PS1" ] || echo "(alias.bash)"

for func_source in $BASH_CONFIG/functions/*; do  source $func_source; done

alias start-ssh-agent='eval "$(ssh-agent -s)"'
alias ssh-add-baxter='ssh-add ~/.ssh/baxterplanning/id_rsa'

# See http://marklodato.github.io/2013/10/31/autostart-tmux-on-ssh.html
# SSH to $1 and then attach to tmux if it exists or start it
alias tmux-on="ssh $1 -t -- /bin/sh -c 'tmux has-session && exec tmux attach || exec tmux"

#SVN I use a wrapper for it to do some nice terminal and formatting items
alias svn=svn-wrap.sh

# Conditionally add an alias for ack if it doesn't exist, but ack-grep does
if ! which ack > /dev/null; then
    which ack-grep > /dev/null && alias ack=ack-grep
fi

# Aliases for pagers
alias more='less'
alias mroe='less'
alias meor='less'
alias mreo='less'

# Alias out some standard shell commands with additional flags
alias rm='rm -v'

if [ "$(uname)" == "Darwin" ]; then
    alias l='ls -GlFat'
    alias ls='ls  -GFh'
    alias la='ls -GahF'
    alias ll='ls -GlhF'
    alias lla='ls -GalhF'

else    
    alias l='ls --color=auto -lFat'
    alias ls='ls --color=auto -Fh'
    alias la='ls --color=auto -ahF'
    alias ll='ls --color=auto -lhF'
    alias lla='ls --color=auto -alhF'
fi

alias dirs='ls -adlhF'

# alias which 'alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'
alias whence='type -a'
# Leave which alone as /bin/which simply returns the file path which is more handy usually
# alias which='type -a'
#

# Turn bc into a floating point beast
alias bc='bc -l'

# Simplify just getting the date in YYYY-mm-dd (%F) format
alias now='date +%T'
alias dt='date +%F'

# # Alias out some shell/process status items
# alias h='history' - See functions

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
alias c='clear'
#
# # Alias out some navigational commands
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

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
alias g="git"

# Network
alias ports='netstat -tulanp'
alias weather='curl wttr.in'
