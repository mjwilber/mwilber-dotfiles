#!/usr/bin/env bash

usage() {
    [ $# -gt 0 ] && echo && echo "ERROR: $@" && echo
    echo "Usage: ${self} <source> <destination> [destination...]"
    echo "    source and destination can be specified as [host:]database_name"
    echo "    if no host is provided then it will use \$(hostname)"
}

if [ $# -lt 2 ]; then
  usage "Invalid number of parameters: [$#]: $@"
  exit 2;
fi

# Dump from source database

src=$1
src_host=${src%:*}
src_database=${src#:}
if [ "$src_host" = "$src_database" ]; then
  src_host=$(hostname)
fi

export__i18n_resrc=$(mktemp)
export_i18n_resrc_l10n=$(mktemp)
echo "1 - Dump source tables from ${src}"
echo "  Dumping _i18n_resrc       .... ${export__i18n_resrc}"
pg_dump -U prophet -h $src_host -d $src_database -t _i18n_resrc > $export__i18n_resrc || exit $?
echo "  Dumping i18n_resrc_l10n   .... ${export_i18n_resrc_l10n}"
pg_dump -U prophet -h $src_host -d $src_database -t i18n_resrc_l10n > $export_i18n_resrc_l10n || exit $?
shift


transfer() {
  dest=${1}
  dest_host=${dest%:*}
  dest_database=${dest#:}

  if [ "$dest_host" = "$dest_database" ]; then
    dest_host=$(hostname)
  fi

  echo "-------------------------------------------------------------------------------------------"
  echo "Transfering i18n values from $src_host/$src_database -> $dest_host/$dest_database"

  echo "2[${dest}] - Delete i18n values from $dest_host/$dest_database"

  psql -U prophet -h $dest_host -d $dest_database <<SQL
  DELETE FROM _i18n_resrc;
  DELETE FROM i18n_resrc_l10n;
SQL
[ $? -ne 0 ] && exit $?

  echo "3[${dest}] - Import dumped i18n values"
  cat ${export__i18n_resrc} | psql -U prophet -h $dest_host -d $dest_database || exit $?
  cat ${export_i18n_resrc_l10n} | psql -U prophet -h $dest_host -d $dest_database || exit $?
}

# Cycle through each of the remaining parameters (expecting [host:]database_name
while [ $# -ne 0 ]; do
  transfer $1
  shift
done

