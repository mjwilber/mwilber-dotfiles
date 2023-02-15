echo "(anvil.be) $*"
# Description: Anvil environment
########################################################
# Setup project environment.
# Usage: project <projectName>
# Variables set: PRJ, PRJ_HOME, ANT_HOME, PATH, JAVA_HOME
#

export PRJ=anvil
# Could the default of this be develop?
export PBRANCH=${1:-develop}

[ ! -d "~/projects/$PRJ" ] || echo "Could not find the root project directory ~/projects/$PRJ"

export PRJ_HOME=~/projects/pht/$PRJ
echo PRJ_HOME=$PRJ_HOME

# use jdk 17
jabba use openjdk@1.17.0

mark -p phome $PRJ_HOME

cd $PRJ_HOME;
pwd
