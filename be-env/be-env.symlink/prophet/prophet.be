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
mark -p modules $PRJ_HOME/var/databases/export/patch

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
