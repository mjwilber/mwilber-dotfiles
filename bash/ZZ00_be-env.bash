echo -n "(be-env.bash)"

BE_HOME=${BE_HOME:-$HOME/.be-env}

# Anything above the line is useful for any environment, below the line is useful for actual project shells

#Bash completion for ◲ desk
_be_completion() {
    BE_HOME=${BE_HOME:-$HOME/.be-env}

    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}

    case ${COMP_CWORD} in
        1)
            COMPREPLY=($(compgen -W "edit . go help list ls version edit create" ${cur}))
            ;;
        2)
            case ${prev} in
                edit|go|.)
                    if [[ -d $BE_HOME ]]; then
                        local befiles=$(be list | cut -d' ' -f1)
                    else
                        local befiles=""
                    fi
                    COMPREPLY=( $(compgen -W "${befiles}" -- ${cur}) )
                    ;;
            esac
            ;;
        *)
            COMPREPLY=()
            ;;
    esac
}

complete -F _be_completion be

# Check for shell being opened in a specific environment
if [ -z "${PRJ_ENV}" ]; then
    echo " - None";
	return;
fi

################################ PROJECT ENVIRONMENT ASSUMED #################################

alias phome='cd ${PRJ_HOME:-${HOME}}'

function proj_spec(){
	echo -n ${PRJ:--}\(${PBRANCH:--}\);
}


#  Colors
#
RED="\[\e[1;31m\]"
BLUEGREEN="\[\e[0;34m\]"
GREEN="\[\e[01;32m\]"
BLUE="\[\e[01;34m\]"
SEAGREEN_BOLD="\[\e[1;36m\]"
ColorOff="\[\e[0m\]"			# Text Reset

CWD_COLOR=$GREEN
CMD_COLOR=$BLUE
LOCATION_COLOR=$GREEN

# Set the title and the prompt for an interactive shell
if [ "$PS1" ]; then
  #debug echo "In PS1 = $TERM"
    case $TERM in
    xterm*)
        if [ -e /etc/sysconfig/bash-prompt-xterm ]; then
            PROMPT_COMMAND=/etc/sysconfig/bash-prompt-xterm
        else
            PROMPT_COMMAND='printf "\033]0;%s@%s[%s(%s)]:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PRJ:--}" "${PBRANCH:--}" "${PWD/#$HOME/~}"'
        fi
        # PS1="\n${CWD_COLOR}\u@\h:\w${ColorOff}\n[\t][\$(proj_spec)] [\#]\$> "
        PS1="\n${LOCATION_COLOR}\u@\h:\w\n${CMD_COLOR}[\$(proj_spec)] \D{%l:%M%P} [\#]\$>${ColorOff} "
        ;;
    screen)
        if [ -e /etc/sysconfig/bash-prompt-screen ]; then
            PROMPT_COMMAND=/etc/sysconfig/bash-prompt-screen
        else
            PROMPT_COMMAND='printf "\033]0;%s@%s[%s(%s)]:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PRJ:--}" "${PBRANCH:--}" "${PWD/#$HOME/~}";history -a'
        fi
        PS1="\n${CWD_COLOR}\u@\h:\w${ColorOff}\n[\t][\$(proj_spec)] [\#]\$> "
        ;;
    dumb)
        PS1="[\#]\$> "
        ;;
    *)
        [ -e /etc/sysconfig/bash-prompt-default ] && PROMPT_COMMAND=/etc/sysconfig/bash-prompt-default
        PS1="\n${CWD_COLOR}\u@\h:\w${ColorOff}\n[\t][\$(proj_spec)] [\#]\$> "
        ;;
    esac
fi


# Description: Find files modified (svn status)
function saveWork() {
    tar cvf saved-changes-2013-04-12.tar  `svn status | awk '/^[AM]/ { print $NF }'`
}


echo " - $PRJ ---- $PRJ_ENV"
source "$PRJ_ENV" "${PRBRANCH:-trunk}"

PRJ_ENV_HOME=$(dirname $PRJ_ENV)
[ -d $PRJ_ENV_HOME ] && [[ ":$PATH:" != *":$PRJ_ENV_HOME:"* ]] && export PATH="$PRJ_ENV_HOME:$PATH"

[[ -n "$LP_OS" ]] && type -t prompt_tag && prompt_tag $PRJ
