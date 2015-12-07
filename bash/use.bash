# echo -n "(use)"

BE_HOME=${BE_HOME:-$HOME/.be-env}

#  To add tab completion
_completeuse() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(find -L $BE_HOME -type f -a -name "*.use" -printf "%f\\n" | awk -F "." '{print $1}')
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}
#
complete -F _completeuse use
echo "Adding complete functionality to use"


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
