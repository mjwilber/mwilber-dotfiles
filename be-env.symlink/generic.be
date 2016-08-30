echo "(generic.be) $*"
########################################################
# Description: A generic project setup (PRJ_HOME=~/projects/<PRJ>)
# Setup project environment.
# Usage: project <projectName>
# Variables set: PRJ, PRJ_HOME, ANT_HOME, PATH, JAVA_HOME
#

export PRJ
#export PRJ_NAME=<use to override liquid prompt display name
export PBRANCH=${1:-develop}

# Setup the new project
export PRJ_HOME=~/projects/$PRJ/${PBRANCH}
if [ ! -d ${PRJ_HOME} ]; then
    export PRJ_HOME=~/projects/$PRJ
    if [ ! -d ${PRJ_HOME} ]; then
        echo "NO project home found!!!!"
    fi
fi

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

