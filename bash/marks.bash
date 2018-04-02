echo "(marksrc.bash)"

# http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
# Jumping with symbolic links
# Under the hood this manual solution comes down to storing symbolic links in a hidden directory
# (e.g., ~/.marks). There are four shell functions jump, mark, unmark, and marks,
# and they look like this:

export MARKPATH=$HOME/.marks
function gop { 
    [ $# -eq 0 ] && marks && return;

    # First check the mark exists - fall through to error message if it doesn't
    [ -e $MARKPATH/$1 ] || [ -e $MARKPATH/$PRJ-$PBRANCH/$1 ] || echo "No such mark: $1"

    # If it exists globally go there
    [ -e $MARKPATH/$1 ] && pushd `readlink $MARKPATH/$1`
    # If it exists at a project level go there
    [ -e $MARKPATH/${PRJ}-${PBRANCH}/$1 ] && pushd `readlink $MARKPATH/${PRJ}-${PBRANCH}/$1`
}
function gocd { 
    [ $# -eq 0 ] && marks && return;

    # First check the mark exists - fall through to error message if it doesn't
    [ -e $MARKPATH/$1 ] || [ -e $MARKPATH/$PRJ-$PBRANCH/$1 ] || echo "No such mark: $1"
    [ -e $MARKPATH/$1 ] && cd -P "$MARKPATH/$1" 2>/dev/null
    [ -e $MARKPATH/${PRJ}-${PBRANCH}/$1 ] && cd -P $MARKPATH/${PRJ}-${PBRANCH}/$1
}

function markprint {
    if [ $# -gt 0 ]; then
        local marklink=$(find "$MARKPATH" "$MARKPATH/${PRJ}-${PBRANCH}" -maxdepth 1 -type l -print | grep "$1" | head -1);
        if [ -n "$marklink" ] && [ -e "$marklink" ]; then
            # One arg means to print the mark destination out
            readlink "$marklink"
        fi
    fi
}


#TODO:Check for absolute directory or document that a second arg can be relative, but then it will always be relative
#TODO:Use mark to set absolute directories using a second arg
#mark [-p] mark_name [directory_to_mark]
function mark {
    if [ $# -eq 0 ]; then
        echo "mark [-p] mark_name [direcotry_to_mark:-PWD]"
    elif [ $# -gt 1 ] && [ "$1" == "-p" ] && [ -z "${PRJ}" ]; then
        echo "No project environment found!!"
    else
      local proj_specific_dir="/"
      # Test for -p is $1 - Could not get getopts to register correctly     while getopts p o; do
      if [ "$1" == "-p" ]; then
        proj_specific_dir="/${PRJ}-${PBRANCH}/" 
        shift
      fi 
      # If there are two arguments the first is the mark and the second is what the marks points
      local mark_name="${1:-$(basename $(pwd))}"
      local directory_to_mark="${2:-$(pwd)}"
      
      #if [ $# -ge 2 ]; then
      #  directory_to_mark=$2
      #fi
      #TODO: Use force option when getopts is working again
      #debug echo proj_specific=$proj_specific_dir
      #debug echo directory_to_mark=$directory_to_mark
      #debug echo "mkdir -p \"$MARKPATH${proj_specific_dir}\"; ln -s \"$(pwd)\" \"$MARKPATH${proj_specific_dir}/$1\"";
	  #debug echo ${proj_specific_dir}/$1
	  if [ -h "$MARKPATH${proj_specific_dir}${mark_name}" ]; then
		#debug echo "Replaceing mark: ${mark_name}" Run: rm "$MARKPATH${proj_specific_dir}/${mark_name}"
		rm "$MARKPATH${proj_specific_dir}${mark_name}" >/dev/null
	    # echo -n "UPDATED ";
      # else
	    # echo -n "CREATED ";
      fi
      mkdir -p "$MARKPATH${proj_specific_dir}"; ln -s "$directory_to_mark" "$MARKPATH${proj_specific_dir}${mark_name}"
      # TODO: Use options (add quiet version as an option)
      echo "Mark '${proj_specific_dir}${mark_name}' -> $directory_to_mark";
    fi
}
function unmark { 
    [ -e $MARKPATH/$1 ] && rm -i "$MARKPATH/$1";
    [ -n "${PRJ}" ] && [ -e $MARKPATH/${PRJ}-${PBRANCH}/$1 ] && rm -i "$MARKPATH/${PRJ}-${PBRANCH}/$1"
}
function marks {
    find "$MARKPATH" "$MARKPATH/${PRJ}-${PBRANCH}" -maxdepth 1 -type l -print0 2>/dev/null | while read -d '' -r f; do
        local name=$(basename "${f}") 
        local link=$(readlink "$f" | sed -e "s|$HOME|~|")
		printf "%12s -> %s\n" $name $link
    done
}
function marks_old {
    ls -l "$MARKPATH" | grep "^l" | sed -r "s/\s+/ /g" | cut -d' ' -f9- | sed 's/ -/\t-/g' | sed 's/$HOME/~/g' && echo
    [ -n "${PRJ}" ] && [ -d "$MARKPATH/${PRJ}-${PBRANCH}" ] && echo "Project specific marks:" && ls -l "$MARKPATH/${PRJ}-${PBRANCH}" | grep "^l" | sed -r "s/\s+/ /g" | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}

# To add tab completion
_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(find $MARKPATH -maxdepth 1 -type l -exec basename {} \; )
  #Lookup project specific marks
  if [ -d "$MARKPATH/${PRJ:NONE}-${PBRANCH:NONE}" ]; then
      local pwordlist=$(find $MARKPATH/${PRJ:NONE}-${PBRANCH:NONE} -maxdepth 1 -type l -exec basename {} \; )
      wordlist=("${wordlist[@]}" "${pwordlist[@]}")
  fi
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}

complete -F _completemarks gop gocd unmark
