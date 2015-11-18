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
# Shell prompt based on the Solarized Dark theme.
# Screenshot: http://i.imgur.com/EkEtphC.png
# Heavily inspired by @necolas’s prompt: https://github.com/necolas/dotfiles
# iTerm → Profiles → Text → use 13pt Monaco with 1.1 vertical spacing.

# From : https://github.com/mathiasbynens/dotfiles/raw/master/.bash_prompt
# if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
# 	export TERM='gnome-256color';
# elif infocmp xterm-256color >/dev/null 2>&1; then
# 	export TERM='xterm-256color';
# fi;
# 
# prompt_git() {
# 	local s='';
# 	local branchName='';
# 
# 	# Check if the current directory is in a Git repository.
# 	if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]; then
# 
# 		# check if the current directory is in .git before running git checks
# 		if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]; then
# 
# 			# Ensure the index is up to date.
# 			git update-index --really-refresh -q &>/dev/null;
# 
# 			# Check for uncommitted changes in the index.
# 			if ! $(git diff --quiet --ignore-submodules --cached); then
# 				s+='+';
# 			fi;
# 
# 			# Check for unstaged changes.
# 			if ! $(git diff-files --quiet --ignore-submodules --); then
# 				s+='!';
# 			fi;
# 
# 			# Check for untracked files.
# 			if [ -n "$(git ls-files --others --exclude-standard)" ]; then
# 				s+='?';
# 			fi;
# 
# 			# Check for stashed files.
# 			if $(git rev-parse --verify refs/stash &>/dev/null); then
# 				s+='$';
# 			fi;
# 
# 		fi;
# 
# 		# Get the short symbolic ref.
# 		# If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
# 		# Otherwise, just give up.
# 		branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
# 			git rev-parse --short HEAD 2> /dev/null || \
# 			echo '(unknown)')";
# 
# 		[ -n "${s}" ] && s=" [${s}]";
# 
# 		echo -e "${1}${branchName}${2}${s}";
# 	else
# 		return;
# 	fi;
# }
# 
# if tput setaf 1 &> /dev/null; then
# 	tput sgr0; # reset colors
# 	bold=$(tput bold);
# 	reset=$(tput sgr0);
# 	# Solarized colors, taken from http://git.io/solarized-colors.
# 	black=$(tput setaf 0);
# 	blue=$(tput setaf 33);
# 	cyan=$(tput setaf 37);
# 	green=$(tput setaf 64);
# 	orange=$(tput setaf 166);
# 	purple=$(tput setaf 125);
# 	red=$(tput setaf 124);
# 	violet=$(tput setaf 61);
# 	white=$(tput setaf 15);
# 	yellow=$(tput setaf 136);
# else
# 	bold='';
# 	reset="\e[0m";
# 	black="\e[1;30m";
# 	blue="\e[1;34m";
# 	cyan="\e[1;36m";
# 	green="\e[1;32m";
# 	orange="\e[1;33m";
# 	purple="\e[1;35m";
# 	red="\e[1;31m";
# 	violet="\e[1;35m";
# 	white="\e[1;37m";
# 	yellow="\e[1;33m";
# fi;
# 
# # Highlight the user name when logged in as root.
# if [[ "${USER}" == "root" ]]; then
# 	userStyle="${red}";
# else
# 	userStyle="${orange}";
# fi;
# 
# # Highlight the hostname when connected via SSH.
# if [[ "${SSH_TTY}" ]]; then
# 	hostStyle="${bold}${red}";
# else
# 	hostStyle="${yellow}";
# fi;
# 
# # Set the terminal title to the current working directory.
# PS1="\[\033]0;\w\007\]";
# PS1+="\[${bold}\]\n"; # newline
# PS1+="\[${userStyle}\]\u"; # username
# PS1+="\[${white}\] at ";
# PS1+="\[${hostStyle}\]\h"; # host
# PS1+="\[${white}\] in ";
# PS1+="\[${green}\]\w"; # working directory
# PS1+="\$(prompt_git \"\[${white}\] on \[${violet}\]\" \"\[${blue}\]\")"; # Git repository details
# PS1+="\n";
# PS1+="\[${white}\]\$ \[${reset}\]"; # `$` (and reset color)
# export PS1;
# 
# PS2="\[${yellow}\]→ \[${reset}\]";
# export PS2;
