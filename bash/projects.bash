echo "(projects.bash)"

BEFILES_HOME=~/bin/.be
USEFILES_HOME=~/bin/.use

function beUsage()
{
	echo "Usage: be <projectName>"
	echo "Project '${1}' doesn't exist.  Try one of these:"
	for befiles in $(ls ${BEFILES_HOME}/*.be); do
		echo "	$(basename $befiles | sed 's/.be//g' )"
	done
	echo ""
	return
}

function be ()
{
	if [ $# -ge 1 ]; then
		local _name=$1
		shift;

		# Check that we have the appropriate number of arguements
		local befile=${BEFILES_HOME}/$_name.be

		# Check for an existing .be file or an alias if a project file exits
		if [ ! -e $befile ] && [ -e ${BEFILES_HOME}/projects.txt ]; then
			befile=""
			beproject=$(grep -i $_name ${BEFILES_HOME}/projects.txt | cut -d: -f 1)  2> /dev/null
			if [ -n "$beproject" ]; then
				befile=${BEFILES_HOME}/${beproject}.be
				if [ ! -e $befile ]; then befile=""; fi
			fi
		fi

		# Check the results from trying to find the project
		if [ -n "$befile" ] && [ -e $befile ]; then
			. $befile $*
			return;
		else
		    echo " ERROR: No project named or aliased as [$_name] exists!";
		fi
	fi

	# To get here there has to be no befile to use
	beUsage $_name
}

function use ()
{
	usefile=${USEFILES_HOME}/$1.use
	if [ $# -lt 1 ] || [ ! -e $usefile ]; then
		echo "Usage: use <toolName>"
		echo "Tool $1 doesn't seem to exist.  Try one of these:"
		for usefiles in $(ls ${USEFILES_HOME}/*.use); do
			echo "	$(basename $usefiles | sed 's/.use//g' )"
		done
		return
	fi

	shift;
	. $usefile $*

	unset usefile
}

# To add tab completion
_completebe() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(find ~/bin/.be -type f -a -name "*.be" -printf "%f\\n" | awk -F "." '{print $1}')
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}

_completeuse() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(find ~/bin/.use -type f -a -name "*.use" -printf "%f\\n" | awk -F "." '{print $1}')
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}

complete -F _completebe  be
complete -F _completeuse use


########################################################


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


# Find files modified (svn status)
function saveWork() {
    tar cvf saved-changes-2013-04-12.tar  `svn status | awk '/^[AM]/ { print $NF }'`
}

