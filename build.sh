#!/usr/bin/env bash 
set -e

#いろいろ確認
  function checksome() {
    if [[ "$1" == "$2" ]]; then
      echo "$3" 1>&2
      exit 1
    fi
  }

  function checksomenot() {
    if [[ "$1" != "$2" ]]; then
      echo "$3" 1>&2
      exit 1
    fi
  }

  function checksomein() {
    if [[ ! $("$1" | grep "$2") ]]; then
      echo "$3" 1>&2
      exit 1
    fi
  }

  #実行ユーザ確認
  checksome "$UID" "0" "You must not run this as root."
  checksomein "groups" "sudo" "Your user must in the sudo groups."
SCRIPT_DIR=$(cd $(dirname $0); pwd)
SCRIPT_DIR_NAME=${SCRIPT_DIR##*/}
cp -r $SCRIPT_DIR /tmp/${SCRIPT_DIR_NAME}

cd /tmp/$SCRIPT_DIR_NAME
sudo rm -rf .git LICENSE.md README.md build.sh
cd ..
dpkg -b $SCRIPT_DIR_NAME
cp /tmp/$SCRIPT_DIR_NAME .
