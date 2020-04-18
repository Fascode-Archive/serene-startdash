#!/bin/bash

set -e
if [[ $UID == 0 ]]; then
    echo "You must not run this as root." 1>&2
    exit 1
fi

if !(type docker >/dev/null); then
    echo "Docker is not installing on this machine." 1>&2
    exit 1
fi
WORKDIR=$(cd $(dirname $0); pwd)
NAME=serene-startdash
cd ..
sudo docker build -t build_serenestartdash ${WORKDIR}
sudo docker run -e NAME=$NAME -e UGID="${UID}:$(id -u)" -v ${WORKDIR}:/debuild/build/${NAME}-source:ro -v ${WORKDIR}/out:/deb -it build_serenestartdash
