echo "(prophet.be) $*"
# Description: Prophet environment
########################################################
# Setup project environment.
# Usage: project <projectName>
# Variables set: PRJ, PRJ_HOME, ANT_HOME, PATH, JAVA_HOME
#

export PRJ=alp
# Could the default of this be develop?
unset PBRANCH

[ ! -d "~/projects/pht/$PRJ" ] || echo "Could not find the root project directory ~/projects/pht/$PRJ"

# Setup the new project
export PRJ_HOME=~/projects/pht/$PRJ
echo PRJ_HOME=$PRJ_HOME

use jdk 17
# jabba use openjdk@1.17.0

mark -p phome $PRJ_HOME

cd $PRJ_HOME;
pwd
