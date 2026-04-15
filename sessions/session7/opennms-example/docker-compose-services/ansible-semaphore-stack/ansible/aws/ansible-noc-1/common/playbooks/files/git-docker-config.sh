#!/bin/bash

# This script should be run as ansible user 
# It contains some extra configurations to pull in git repo

#set -x

DIRECTORY="/home/ansible/devel/gitrepos"
REPO="COM614-cloud-computing"
REPO_URL="https://github.com/gallenc/COM614-cloud-computing.git"
RELATIVE_SERVICE_PATH="sessions/session7/opennms-example/docker-compose-services"

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

rm -f /opt/docker/compose/docker-compose-services

sudo ln -sf   $DIRECTORY/$REPO/$RELATIVE_SERVICE_PATH   /opt/docker/compose/docker-compose-services

echo "Created simlink  /opt/docker/compose/docker-compose-services to compose services in directory $DIRECTORY/$REPO/$RELATIVE_SERVICE_PATH"

sudo chown -h ansible:ansible /opt/docker/compose/docker-compose-services

# set up service to start docker compose (already done)

#sudo cp /vagrant/docker-compose@.service /etc/systemd/system/docker-compose@.service

#sudo chmod 644 /etc/systemd/system/docker-compose@.service







