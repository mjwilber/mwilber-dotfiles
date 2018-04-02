#!/usr/bin/env bash

self=$(basename $0)

usage() {
  echo "Usage: $self [options]"
  echo "    -t   Test run - no operations, just output"
  echo "    -s   Source directory of files to organize (Default: ./)"
  echo "    -d   Destination directory of directories to organize into (Default ../)"
}

debug=
debug_cmd=
sourceDirectory=.
destinationDirectory=..

while getopts ":ts:d:" opt; do
  case $opt in
  t)  debug=TRUE
      ;;
  s)  sourceDirectory="$OPTARG"
      ;;
  d)  destinationDirectory="$OPTARG"
      ;;
  *)  echo "Unknown option: $opt"
      usage
      exit 2
      ;;
  esac
done
shift $(expr $OPTIND - 1)

if [ ! -d "${sourceDirectory}" ]; then
  echo "ERROR: source directory doesn't exist: [$sourceDirectory]"
  usage
  exit 1
elif [ ! -d "${destinationDirectory}" ]; then
  echo "ERROR: destination directory doesn't exist: [$destinationDirectory]"
  usage
  exit 1
fi

if [ "$debug" ]; then
  echo "$self debug/testing output"
  echo
  debug_cmd=echo
fi

[ "$debug" ] && echo +++++++++++++++++++++ Document Directory [$sourceDirectory]
#ls -l $workingDir
[ "$debug" ] && echo +++++++++++++++++ Archive of Directories [$destinationDirectory]
#ls -l $currentArchiveDir

for archiveDir in $(find $destinationDirectory -type d); do
  [ "$debug" ] && echo "Archivedir - $archiveDir"
  for f in $(find $sourceDirectory -maxdepth 1 -a -iname "*${archiveDir}*"); do
    [ "$debug" ] && echo "  Move $f -> $archiveDir/."
    $debug_cmd mv "$f" "$archiveDir"
  done
done
