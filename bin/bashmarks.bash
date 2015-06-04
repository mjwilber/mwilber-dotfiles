[ -z "$PS1" ] || echo "(~/bin/bashmarks.bash)"

# An associative array that is used to hold name->directory entries
declare -A go_dirs;


function go_usage {
	echo "go Usage";
	if [ -n "$1" ]; then
		echo $@;
	fi
	return 1;
}

function __go_list {
	for i in "${!go_dirs[@]}"; do
		if [ -n "${go_dirs[$i]}" ]; then
			local dest="${go_dirs[$i]/$HOME/~}";	# Convert $HOME -> ~ for display
			printf "%15s : %s\n" $i $dest;
		fi
	done | sort -i
}

function go {
	
	#if [ -n "$1" ]; then "" empty case handled by ""
		case "$1" in
			"-d" | "--delete" )
				[ -n "$2" ] || go_usage "No name specified to delete!" || return;
				local to_dir=${go_dirs[$2]};
				if [ -n "$to_dir" ]; then
					go_dirs[$2]="";	# This could be replaced by recreating go_dirs, but .?
				fi
				return;;
			"-s" | "--save" )
				[ -n "$2" ] || go_usage "No name specified for the save!" || return;
				[ -n "$3" ] || go_usage "No directory specified!" || return;
				go_dirs[$2]=$3;
				return;;
			"" | "-l" | "--list" )
				__go_list;
				return;;
			* )
				local to_dir=${go_dirs[$1]};
				echo "[$to_dir]";
				if [ -z "$to_dir" ]; then
					echo "No entry for [$1] found!";
				else
					pushd "$to_dir";
				fi
				;;
		esac
	#fi
}


# Read in the items in the user's ~/.bashmarks file
# This files should be in the format:    name<tab>directory
if [ -e ~/.bashmarks ]; then
	while read line; do	# Apparently read line turns tabs into spaces
		key=`echo $line | cut --delimiter=" " --fields=1`;
		value=`echo $line | cut --delimiter=" " --fields=2`;
		value=${value/\~/$HOME};	# Translate ~ -> $HOME so that pushd works
		go -s $key $value
	done < ~/.bashmarks
fi

# echo "The following go locations are available:";
# go -l
