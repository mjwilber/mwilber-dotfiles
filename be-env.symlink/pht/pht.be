echo "(prophet.be) $*"
# Description: Prophet environment
########################################################
# Setup project environment.
# Usage: project <projectName>
# Variables set: PRJ, PRJ_HOME, ANT_HOME, PATH, JAVA_HOME
#

export PRJ=pht
# Could the default of this be develop?
export PBRANCH=${1:-prophet}

[ ! -d "~/projects/$PRJ" ] || echo "Could not find the root project directory ~/projects/$PRJ"

################################################################
#         CHANGES prophet to look here for host configuration
################################################################
export CONFIG_DIR_HOST=~/projects/$PRJ

# Setup the new project
export PRJ_HOME=~/projects/$PRJ/${PBRANCH}
echo PRJ_HOME=$PRJ_HOME

if [ -e "$CONFIG_DIR_HOST/.private.d" ]; then
    for i in $(ls "$CONFIG_DIR_HOST/.private.d"); do
        echo "Running: $CONFIG_DIR_HOST/.private.d/$i"
        . "$CONFIG_DIR_HOST/.private.d/$i"
    done
fi

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

mark -p projectbe ~/.be-env/pht

cd $PRJ_HOME;
pwd
