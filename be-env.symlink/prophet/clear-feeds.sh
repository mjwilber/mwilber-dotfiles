#!/bin/bash

pushd $PRJ_HOME

echo "Reverting move of checked in feeds"
git checkout -- var/feeds/inbound/process
echo "Removing old problem feeds"
rm -rf var/feeds/inbound/process/problem/*

echo "Clearing the database (feed_reject, feed_history)"
PGHOST=${PGHOST:-$(hostname)} \
  PGUSER=${PGUSER:-prophet} \
  PGDATABASE=${PGDATABASE:-prophet_bps} \
  echo "${PGUSER}@${PGHOST}:/${PGDATABASE}"

psql -U prophet -h oneida -d ${1:-prophet_bps} <<SQL
DELETE FROM feed_reject;
DELETE FROM feed_history;
SQL

popd

