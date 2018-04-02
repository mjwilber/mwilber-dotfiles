#!/usr/bin/env bash
# usage: query-all[-test].sh username query | psql [dbname]

#  Make sure you end your query with a semicolon, otherwise it blows up. psql needs to be 
#  given a database to connect to, even though it won't be used for the query (which will
#  always query the "prophet" database). So you can either create a database with your username,
#  pass a valid database on your local machine as an argument, or set the PGDATABASE environment
#  variable to a valid database on your machine.


usage()
{
    echo "Usage: $(basename $0) <remote_user> \"<query>\" | psql <local_user>"
}

if [ $# -lt 2 ]; then
    usage
	exit;
fi

DBS=(odysseydb intrepiddb jupiterdb saturndb venusdb marsdb mercurydb lucentdb neptunedb earthdb republicdb infoprintdb goldendb)

set -f
for db in ${DBS[@]}; do
  echo \\connect prophet "$1" $db
  echo $2
done
