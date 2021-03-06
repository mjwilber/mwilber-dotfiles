#!/usr/bin/env bash

pushd ${FEED_HOME:-${PRJ_HOME}/var/feeds}

[ -d "inbound/problem" ] && echo "Removing old problem feeds" && rm -rf "inbound/problem/*"
[ -d "inbound/archive" ] && echo "Removing archived feeds" && rm -rf "archive/*"

if git rev-parse --git-dir > /dev/null 2>&1; then
  echo "In a git direcotry Reverting move of checked in feeds"
  git checkout -- inbound
fi

echo "Clearing the database (feed_reject, feed_history)"
PGHOST=${PGHOST:-$(hostname)}
PGUSER=${PGUSER:-prophet}
PGDATABASE=${PGDATABASE:-$(egrep "^database.name=" ${PRJ_HOME}/etc/prophet.properties | cut -d= -f2)}
echo "${PGUSER}@${PGHOST}:/${PGDATABASE}"

psql -U $PGUSER -h $PGHOST -d ${PGDATABASE:-prophet_bps} <<SQL
-- SELECT COUNT(*) FROM sys_co_prefs;
DELETE FROM feed_reject;
DELETE FROM feed_history;
DELETE FROM feed_file_history;
SQL

popd
#
