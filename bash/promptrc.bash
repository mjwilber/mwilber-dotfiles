#
# Some ideas from http://java.dzone.com/articles/cool-interesting-useful-unique
# 
echo "(promptrc.bash)"
export PS1='\n${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h \[\e[1;36m\]\A \[\033[01;34m\]\w [\#]\$>\[\033[00m\] '
#export PS1="\n\u@\h \t \w[\#]\$> "
#export PS1="\`if [ \$? = 0 ]; then echo \e[33\;40m\\\^\\\_\\\^\e[0m; else echo \e[36\;40m\\\-\e[0m\\\_\e[36\;40m\\\-\e[0m; fi\` \[\033[38m\]\u \[\033[0;36m\]\j \[\033[1;32m\]\!\[\033[01;34m\] \w \[\033[31m\]\`ruby -e \"print (%x{git branch 2> /dev/null}.split(%q{\n}).grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1) ')\"\`\[\033[37m\]$\[\033[00m\] "
#export PS1="\[\033[0;34m\][\[\e[0;36m\]$(date +%H:%M)\[\033[0;34m\]]\[\033[0;34m\][\[\033[0;32m\]\u\[\033[1;38m\]@\[\e[0;36m\]\h:\[\033[0;34m\]\w\[\033[0;32m\]$(parse_git_branch)\[\033[0;34m\]]\[\033[0;32m\]\n$ "


# http://java.dzone.com/articles/cool-interesting-useful-unique
#function parse_git_dirty {
#  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
#}

#function parse_git_branch {
#  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1$(parse_git_dirty))/"
#}
#
#function resetPrompt {
#  local        BLUE="\[\033[0;34m\]"
#  local         RED="\[\033[0;31m\]"
#   local   LIGHT_RED="\[\033[1;31m\]"
#   local       GREEN="\[\033[0;32m\]"
#   local LIGHT_GREEN="\[\033[1;32m\]"
#   local       WHITE="\[\033[1;37m\]"
#   local        GRAY="\[\033[1;38m\]"
#   local        TEAL="\[\e[0;36m\]"
#   case $TERM in
# *)
# TITLEBAR=""
# ;;
# esac
# 
# if [ 0 -eq ${UID} ]; then
#   export PS1="${TITLEBAR}\
# $BLUE[$RED\$(date +%H:%M)$BLUE]\
# $BLUE[$RED\u$GRAY@$TEAL\h:$BLUE\w$GREEN\$(parse_git_branch)$BLUE]\
# $GREEN\n\$"
# else
#  export PS1="${TITLEBAR}\
# $BLUE[$TEAL\$(date +%H:%M)$BLUE]\
# $BLUE[$GREEN\u$GRAY@$TEAL\h:$BLUE\w$GREEN\$(parse_git_branch)$BLUE]\
# $GREEN\n\$ "
# fi
# 
# export PS2='> '
# export PS4='+ ' 
# } 
# 