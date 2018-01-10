#!/bin/bash

if [ $# -lt 1 ]; then
  echo "Usage: $(basename ${0}) <feed dirname>"
    exit 1
fi


if [ -d "${1}.orig" ]; then
  echo "${1}.orig found"
  pushd .
elif [ -d "/home/prophet/feeds/${1}.orig" ]; then
  echo "/home/prophet/feeds/${1}.orig found"
  pushd /home/prophet/feeds
fi


[ -d "${1}" ] && rm -rf "${1}"
cp -Rv ${1}.orig ${1} | wc -l && echo ".... copied!"
popd

echo "Done."
