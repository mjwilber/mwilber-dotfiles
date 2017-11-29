echo "(prophet.be) $*"
# Description: Prophet environment
########################################################
# Setup project environment.
# Usage: project <projectName>
# Variables set: PRJ, PRJ_HOME, ANT_HOME, PATH, JAVA_HOME
#

export PRJ=prophet
export PBRANCH=${1:-trunk}


################################################################
#         CHANGES prophet to look here for host configuration
################################################################
export CONFIG_DIR_HOST=~/projects/$PRJ

# Setup the new project
export PRJ_HOME=~/projects/$PRJ/${PBRANCH}
echo PRJ_HOME=$PRJ_HOME

if [ -e "$PRJ_HOME/user.properties" ]; then

	. "$PRJ_HOME/user.properties" 2> /dev/null

	echo --------------------------
	cat "$PRJ_HOME/user.properties"
	echo --------------------------
	echo --------------------------
	echo 
fi

use jdk 8
use ant prophet_proj

if [ -d $PRJ_HOME/etc-template ]; then
    alias editphtcfg="gvim -p $CONFIG_DIR_HOST/$(hostname).properties $PRJ_HOME/etc-template/prophet/$USER.properties"
elif [ -d $PRJ_HOME/etc ]; then
    alias editphtcfg="gvim -p $CONFIG_DIR_HOST/$(hostname).properties $PRJ_HOME/etc/prophet/$USER.properties"
fi

mark -p phome $PRJ_HOME
mark -p pweb $PRJ_HOME/deploy/prophet.ear/web.war/prophet
mark -p webapp $PRJ_HOME/deploy/webapps/ROOT
mark -p etc $PRJ_HOME/etc
mark -p modules $PRJ_HOME/modules
mark -p patch $PRJ_HOME/var/databases/export/patch

if [ -d ~/projects/prophet/data ]; then
    mark data ~/projects/prophet/data
elif [ -d ~/projects/prophet-data ]; then
    mark data ~/projects/prophet-data
fi

cd $PRJ_HOME;
pwd
