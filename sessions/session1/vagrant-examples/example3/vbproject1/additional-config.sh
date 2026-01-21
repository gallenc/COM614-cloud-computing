#!/bin/bash

# This script could be included in initial machine configuration Vagrantfile.
# It contains some extra configurations to pull in git repo

#set -x

DIRECTORY="$HOME/devel/gitrepos"
REPO="COM614-cloud-computing"

if ! [ -d "$DIRECTORY" ]; then
  echo creating "$DIRECTORY"
  mkdir -p "$DIRECTORY"
fi

cd "$DIRECTORY"

if ! [ -d "$REPO" ]; then
  echo cloning repository
  git clone https://github.com/gallenc/COM614-cloud-computing.git 
fi

cd "$REPO"

git pull

echo updated repo in directory $DIRECTORY/$REPO

 






