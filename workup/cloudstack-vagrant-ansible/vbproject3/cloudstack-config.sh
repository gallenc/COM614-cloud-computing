#!/bin/bash

# This script should be run as ansible user
# It contains some extra configurations to pull in git repo

#set -x

DIRECTORY="$HOME/devel/gitrepos"
REPO="COM614-cloud-computing"
REPO_URL="https://github.com/gallenc/COM614-cloud-computing.git"

if ! [ -d "$DIRECTORY" ]; then
  echo creating "$DIRECTORY"
  mkdir -p "$DIRECTORY"
else
  echo $DIRECTORY already exists
fi

cd "$DIRECTORY"

if ! [ -d "$REPO" ]; then
  echo cloning repository $REPO_URL
  git clone $REPO_URL
else
  echo repo "$REPO" already exists
fi

cd "$REPO"

git pull

echo updated repo in directory $DIRECTORY/$REPO

