echo "(forecast-engine.be) $*"
# Description: Prophet environment
########################################################
# Variables set: PRJ, PRJ_HOME, ANT_HOME, PATH, JAVA_HOME
#

export PRJ=forecast-engine
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

mark -p phome $PRJ_HOME

cd $PRJ_HOME;
pwd
