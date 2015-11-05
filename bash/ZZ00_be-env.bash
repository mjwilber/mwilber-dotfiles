echo -n "(be-env.bash)"

if [ -z "${PRJ_ENV}" ]; then
    echo " - None";
	return;
fi

alias phome='cd ${PRJ_HOME:-${HOME}}'

function proj_spec(){
	echo -n ${PRJ:--}\(${PBRANCH:--}\);
}

########################################################################
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


#  To add tab completion
#  _completeuse() {
#  local curw=${COMP_WORDS[COMP_CWORD]}
#  local wordlist=$(find -L $BE_HOME -type f -a -name "*.use" -printf "%f\\n" | awk -F "." '{print $1}')
#  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
#  return 0
# }
#
# complete -F _completeuse use


use_list() {
    local use_home=${USE_HOME:-$HOME/.be-env}
    if [ ! -d "$use_home" ]; then
        echo "No be home dir! Set USE_HOME to a valid directory or create ~/.be-env"
        return 1
    fi

    find -L "$use_home" -name '*.use' -print0 | while read -d '' -r f; do
        local name=$(basename "${f//.use/}") 
        local desc=

        if [ -z "$desc" ]; then
            echo "$name"
        else
            echo "$name" "-" "$desc"
        fi
    done
}

function use ()
{
    local use_home=${USE_HOME:-$HOME/.be-env}
    local use_name="$1"
	if [ -z "$use_name" ]; then
	    echo "Usage: use <tool> [<version>]"
		echo
		use_list
		return 1
	fi

    local use_file="$(find -L "$use_home" -name "${use_name}.use")"
    if [ -z "$use_file" ]; then 
        echo "Use env" "$use_name" "not found in" "$use_home"
		use_list
        return 1
    fi

	shift;
	source $use_file $*
}

echo " - $PRJ"
source "$PRJ_ENV" "${PRBRANCH:-trunk}"

