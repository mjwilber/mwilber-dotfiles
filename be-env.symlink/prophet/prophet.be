echo "(prophet.be) $*"
# Description: Prophet environment
########################################################
# Setup project environment.
# Usage: project <projectName>
# Variables set: PRJ, PRJ_HOME, ANT_HOME, PATH, JAVA_HOME
#

export PRJ=prophet
export PBRANCH=${1:-trunk}

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

mark -p phome $PRJ_HOME
mark -p pweb $PRJ_HOME/deploy/prophet.ear/web.war/prophet
mark -p webapp $PRJ_HOME/deploy/webapps/ROOT
mark -p etc $PRJ_HOME/etc
mark -p modules $PRJ_HOME/modules
mark -p patch $PRJ_HOME/var/databases/export/patch
mark data ~/projects/prophet-data

cd $PRJ_HOME;
pwd
