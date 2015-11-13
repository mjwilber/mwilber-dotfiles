[ -z "$PS1" ] || echo "(alias.bash)"

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

# ack could also 
##!/usr/bin/env bash
#grep -rI –color –exclude-dir=\.bzr –exclude-dir=\.git –exclude-dir=\.hg –exclude-dir=\.svn –exclude-dir=build –exclude-dir=dist –exclude=tags $*

# PRINT Colors: printf "\e[%dm%d dark\e[0m  \e[%d;1m%d bold\e[0m\n" {30..37}{,,,}
box() { t="$1xxxx";c=${2:-#}; echo ${t//?/$c}; echo "$c $1 $c"; echo ${t//?/$c}; }
alias json-decode="php -r 'print_r(json_decode(file_get_contents(\"php://stdin\")));'"

function untab() {
 	tmpFile=`mktemp`;
 	# debug echo $tmpFile
 	for f in $*; do
 		echo -n "Expanding $f ... ";
 		if grep -qP "\t" ${f}
 		then
 			expand --tabs=4 ${f} > ${tmpFile}; mv ${tmpFile} ${f}
 			echo "Complete!"
 		else
 			echo "No tab characters found"
 		fi
 	done
}

alias removeTrailing="sed 's/\\s\\+$//'"

alias restartUnity="pkill unity-2d-pane"
# Show perms/owner at each dir level.
treeperms(){ d=$(cd "$1" ; pwd -P) ; ls -ld "$d"; [[ "$d" != "/" ]] && treeperms $(dirname "$d"); }


fij() {
  search_term=$1
  shift;
  file_search=${@:-"*.[jsw]ar"}

  #debug
  echo "Searching for [${search_term}] in: ${file_search}";

  for j in ${file_search}; do
     if jar tvf $j | grep "$search_term" >/dev/null; then
       echo ""; echo $j; jar tvf $j | grep "$search_term";
     fi
  done
}

catmanifest() { # $@ = list of jar(s)
    for j in $@;  do    unzip -c -q $j META-INF/MANIFEST.MF; done
}
  
catfromjar() { # $@ = jar
    if [ $# -le 0 ]; then
      echo "Usage: $0 <jarfile> file0 [fileX ...]";
      return;
    fi
    j=$1;
    shift;
    unzip -c -q $j $@
}

grepmanifest() {
  grep_flags=""

  # if $1 starts with a dash -> treat these as flags to grep
  if [ ${1:0:1} == "-" ]; then
    grep_flags=$1
    shift;
  fi

  search_term=$1
  shift;

  file_search=${@:-"*.[jsw]ar"}

  #debug
  echo "Searching for [${search_term}] in: ${file_search}: with grep_flags: ${grep_flags}";
  
  for j in ${file_search}; do echo ""; echo "#_#_#_#: $j"; catmanifest $j | grep ${grep_flags} ${search_term}; done
}

