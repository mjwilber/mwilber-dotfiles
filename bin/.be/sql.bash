sql () 
{ 
	echo Start
	username=`id -un`
	propfile="$PRJ_HOME/etc/prophet/${username}.properties"
    if [ ! -e "$propfile" ]; then
        echo "Unable to determine environment: Cannot find [$propfile]";
        return 1;
	else
	    . $propfile
    fi;
    echo psql -U prophet -h ${database.host:-localhost} -d ${database.name:-prophet}
}
