#!/bin/bash

if [ $UID != 65587 ]; then
    echo "You have to run this on Docker" 1>&2
    exit 1
fi

cd /debuild/build
cp -r ${NAME}-source $NAME
cd $NAME
sudo rm -rf .git LICENSE.md README.md build.sh debuild.sh Dockerfile
cd ..
dpkg -b $NAME
sudo mv $NAME.deb /deb
sudo chown ${UGID} /deb/$NAME.deb
