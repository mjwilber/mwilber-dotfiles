#!/usr/bin/env bash

# <base_url>/<repository>/<group>/<component>/<version>/
repo_base_url="http://repo.bybaxter.com:8081/repository/%s/%s/%s/%s/"
# third-party/com/bybaxter/prophet/actuateserv-client/13.1.0/actuateserv-client-13.1.0.pom
usage() {
  echo "Usage $(basename ${0}): -r <repository name> -g <group> -c <component> -v <version> <file(s)>"
}

while getopts ":r:g:c:v:" opt; do 
  case "${opt}" in
    r) repository=$OPTARG;;
    g) group=$(echo $OPTARG | sed 's/\./\//g');;
    c) component=$OPTARG;;
    v) version=$OPTARG;;
    *)
      echo "Invalid option $OPTARG"; usage; exit 1;;
  esac
done
shift $((OPTIND-1))

if [ -z ${repository+x} ]; then
  echo "ERROR: -r <repo> is required"; usage; exit 1;
elif [ -z ${group+x} ]; then
  echo "ERROR: -g <group> is required"; usage; exit 1;
elif [ -z ${component+x} ]; then
  echo "ERROR: -c <component> is required"; usage; exit 1;
elif [ -z ${version+x} ]; then
  echo "ERROR: -v <version> is required"; usage; exit 1;
fi

url=$(printf $repo_base_url $repository $group $component $version)
echo "Writing to Nexus repo[${url}]: $*";

u() {
    local f=$1
    local component=$2
    local url=$3
    echo curl -v -u admin:admin123 --upload-file ${f} $url
    curl -v -u admin:admin123 --upload-file ${f} $url 2>&1 >> ${component}-$(date +%Y%m%d-%H%M%S)-upload.log
    [ $? -eq 0 ] && echo "Uploaded ${f} SUCCESSFUL" || echo "Failed uploading ${f}"
}

for f in $*; do
  if [ ! -r $f ]; then
    echo "Invalid file ... skipping: $f"
  elif [ ${f: -4} != ".md5" ] && [ ${f: -5} != ".sha1" ]; then
    echo "<<<<<<<<<<<<<<<<<<<<<< Processing: $f"
    echo "---- Generating checksum files:"
    if [ -e "${f}.md5" ]; then
        echo "Skip generating md5 checksum as the file exists"
    else
        echo "Generating md5 checksum for ${f}"
        if [ $(uname) == 'Darwin' ]; then
          md5 -q ${f} | tee ${f}.md5
        else
          md5sum $f | awk '{print $1}' > ${f}.md5
        fi
    fi
    if [ -e "${f}.sha1" ]; then
        echo "Skip generating sha1 checksum as the file exists"
    else
        echo "Generating md5 checksum for ${f}"
        if [ $(uname) == 'Darwin' ]; then
          shasum $f | tee ${f}.sha1
        else
          sha1sum $f | awk '{print $1}' > ${f}.sha1
        fi
    fi

    
    echo "---- Uploading: $f, ${f}.md5, ${f}.sha1"
    u $f $component $url
    u ${f}.md5 $component $url
    u ${f}.sha1 $component $url
  fi
done

