# To colorize your terminal you need these settings in your shell. I put them in my .bash_profile:
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced


# Reset
off='\033[0m'       # Text Reset

# Regular Colors
black='\033[0;30m'        # Black
red='\033[0;31m'          # Red
green='\033[0;32m'        # Green
yellow='\033[0;33m'       # Yellow
blue='\033[0;34m'         # Blue
purple='\033[0;35m'       # Purple
cyan='\033[0;36m'         # Cyan
white='\033[0;37m'        # White

# Bold
Black='\033[1;30m'       # Black
Red='\033[1;31m'         # Red
Green='\033[1;32m'       # Green
Yellow='\033[1;33m'      # Yellow
Blue='\033[1;34m'        # Blue
Purple='\033[1;35m'      # Purple
Cyan='\033[1;36m'        # Cyan
White='\033[1;37m'       # White

# Underline
_black_='\033[4;30m'       # Black
_red_='\033[4;31m'         # Red
_green_='\033[4;32m'       # Green
_yellow_='\033[4;33m'      # Yellow
_blue_='\033[4;34m'        # Blue
_purple_='\033[4;35m'      # Purple
_cyan_='\033[4;36m'        # Cyan
_white_='\033[4;37m'       # White

# Background
on_black='\033[0;40m'       # Black
on_red='\033[0;41m'         # Red
on_green='\033[0;42m'       # Green
on_yellow='\033[0;43m'      # Yellow
on_blue='\033[0;44m'        # Blue
on_purple='\033[0;45m'      # Purple
on_cyan='\033[0;46m'        # Cyan
on_white='\033[0;47m'       # White

# High Intensty
bLACK='\033[0;90m'       # Black
rED='\033[0;91m'         # Red
gREEN='\033[0;92m'       # Green
yELLOW='\033[0;93m'      # Yellow
bLUE='\033[0;94m'        # Blue
pURPLE='\033[0;95m'      # Purple
cYAN='\033[0;96m'        # Cyan
wHITE='\033[0;97m'       # White

# Bold High Intensty
BLACK='\033[1;90m'      # Black
RED='\033[1;91m'        # Red
GREEN='\033[1;92m'      # Green
YELLOW='\033[1;93m'     # Yellow
BLUE='\033[1;94m'       # Blue
PURPLE='\033[1;95m'     # Purple
CYAN='\033[1;96m'       # Cyan
WHITE='\033[1;97m'      # White

# High Intensty backgrounds
on_BLACK='\033[0;100m'   # Black
on_RED='\033[0;101m'     # Red
on_GREEN='\033[0;102m'   # Green
on_YELLOW='\033[0;103m'  # Yellow
on_BLUE='\033[0;104m'    # Blue
on_PURPLE='\033[10;95m'  # Purple
on_CYAN='\033[0;106m'    # Cyan
on_WHITE='\033[0;107m'   # White


alias colors='{
  echo -e -n "${black}black ${Black}Black ${on_white}${BLACK}BLACK$off "
  echo -e -n "${red}red ${Red}Red ${on_yellow}${RED}RED$off "
  echo -e -n "${green}green ${Green}Green ${on_blue}${GREEN}GREEN$off "
  echo -e -n "${yellow}yellow ${Yellow}Yellow ${on_red}${YELLOW}YELLOW$off "
  echo -e -n "${blue}blue ${Blue}Blue ${on_green}${BLUE}BLUE$off "
  echo -e -n "${purple}purple ${Purple}Purple ${on_cyan}${PURPLE}PURPLE$off "
  echo -e -n "${cyan}cyan ${Cyan}Cyan ${on_blue}${CYAN}CYAN$off "
  echo -e -n "${white}white ${White}White ${on_purple}${WHITE}WHITE$off \n"
}'

function example_color_my_prompt {
    local user_and_host="\[${Yellow}\]\u@\h"
    local current_location="\[${Cyan}\]\w"
    local git_branch_color="\[${Red}\]"
    local git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
    local prompt_tail="\[${Purple}\]$"
    local last_color="\[${off}\]"
    export PS1="$user_and_host $current_location $git_branch_color$git_branch$prompt_tail$last_color "
}
#color_my_prompt
