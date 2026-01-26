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

# this adds the simlinks to the compose projects in the repo

sudo mkdir -p /opt/docker/compose

sudo ln -sf $DIRECTORY/COM614-cloud-computing/workup/ansible-examples/docker-compose-services /opt/docker/compose/docker-compose-services

sudo chown -h ansible:ansible /opt/docker/compose/docker-compose-services

# set up service to start docker compose

sudo cp /vagrant/docker-compose@.service /etc/systemd/system/docker-compose@.service

sudo chmod 644 /etc/systemd/system/docker-compose@.service







