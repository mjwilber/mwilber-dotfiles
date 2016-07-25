echo -n "(be-env.bash)"

BE_HOME=${BE_HOME:-$HOME/.be-env}

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

echo " - $PRJ"
source "$PRJ_ENV" "${PRBRANCH:-trunk}"

PROPHET_BE_ENV=$(dirname $PRJ_ENV)
[ -d $PROPHET_BE_ENV ] && [[ ":$PATH:" != *":$PROPHET_BE_ENV:"* ]] && export PATH="$PROPHET_BE_ENV:$PATH"

# [[ -n "$LP_OS" ]] && type -t prompt_tag && prompt_tag $PRJ
