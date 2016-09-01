echo "(prophet-ant-dbloader.be) $*"
# Description: Prophet environment
########################################################
# Setup project environment.
# Usage: project <projectName>
# Variables set: PRJ, PRJ_HOME, ANT_HOME, PATH, JAVA_HOME
#

export PRJ=prophet-ant-dbloader
export PRJ_NAME=ant-dbloader
export PBRANCH=${1:-develop}

# Setup the new project
export PRJ_HOME=~/projects/$PRJ
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

# Extract the cmd-client tar file to the current directory
function extractCmdClient() {
    local outputDir=${1:-.}
    local tarfile=$(find ${PRJ_HOME}/cmd-client/build/distributions -name "prophet-analytics-cmd-client-*.tar")
    [ ! -e "$tarfile" ] && echo "No tar file present" && return 3

    echo "Untarring: $tarfile"
    echo "       to: $outputDir"
    echo "tar xvf $tarfile -C $outputDir"
    tar xvf "$tarfile" -C $outputDir
}

function loaddbprops() {
    pfile="$PRJ_HOME/etc/prophet/$USER.properties" 
    echo $pfile
    if [ ! -e $pfile ]
    then
       echo "Unable to determine environment: Cannot find [$pfile]";
       return 1;
    fi
    # Pull properties from the environement files
    tmpSrcfile=`mktemp`
    #debug echo $tmpSrcfile
    grep -e "^database" "$PRJ_HOME/etc/prophet/$USER.properties"  | sed 's/^/export /' | sed 's/\./_/g' > $tmpSrcfile
    [ -e $PRJ_HOME/etc/prophet/$(hostname).properties ] && grep -e "^database" "$PRJ_HOME/etc/prophet/$(hostname).properties"  | sed 's/^/export /' | sed 's/\./_/g' >> $tmpSrcfile
    unset database_username database_host database_name database_test_username database_test_host database_test_name
    echo "Catting $tmpSrcfile"
    cat $tmpSrcfile
    . $tmpSrcfile
    rm $tmpSrcfile
}

# Open a psql prompt to the current database
function sql() {
    loaddbprops
    echo "psql -U ${database_username:-prophet} -h ${database_host:-localhost} -d ${database_name:-prophet}"
    psql -U ${database_username:-prophet} -h ${database_host:-localhost} -d ${database_name:-prophet}
}

# Open a psql prompt to the current test database
function sqltest() {
    loaddbprops
    echo "psql -U ${database_test_username:-${database_username:-prophet}} -h ${database_test_host:-${database_host:-localhost}} -d ${database_test_name:-${database_name:-prophet}_test}"
    psql -U ${database_test_username:-${database_username:-prophet}} -h ${database_test_host:-${database_host:-localhost}} -d ${database_test_name:-${database_name:-prophet}_test}
}

function svn13merge() {
    svn merge $* http://svn.bybaxter.com/repos/prophet/branches/prophet-13.1.0 .
}

cd $PRJ_HOME;
pwd
