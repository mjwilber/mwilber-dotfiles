echo "(generic.be) $*"
########################################################
# Description: A generic project setup (PRJ_HOME=~/projects/<PRJ>)
# Setup project environment.
# Usage: project <projectName>
# Variables set: PRJ, PRJ_HOME, ANT_HOME, PATH, JAVA_HOME
#

export PRJ
export PBRANCH=${1:-trunk}

# Setup the new project
export PRJ_HOME=~/projects/$PRJ/${PBRANCH}

if [ -e "$PRJ_HOME/user.properties" ]; then

	. "$PRJ_HOME/user.properties" 2> /dev/null

	echo --------------------------
	cat "$PRJ_HOME/user.properties"
	echo --------------------------
	echo --------------------------
	echo 
fi

mark -p phome $PRJ_HOME

cd $PRJ_HOME;
pwd

