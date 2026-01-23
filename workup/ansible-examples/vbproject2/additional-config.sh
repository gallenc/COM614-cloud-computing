#!/bin/bash

# This script could be included in initial machine configuration Vagrantfile.
# It contains some extra configurations to pull in git repo

#set -x

DIRECTORY="$HOME/devel/gitrepos"
REPO="COM614-cloud-computing"
REPO_URL="https://github.com/gallenc/COM614-cloud-computing.git"

if ! [ -d "$DIRECTORY" ]; then
  echo creating "$DIRECTORY"
  mkdir -p "$DIRECTORY"
fi

cd "$DIRECTORY"

if ! [ -d "$REPO" ]; then
  echo cloning repository
  git clone $REPO_URL
fi

cd "$REPO"

git pull

echo updated repo in directory $DIRECTORY/$REPO

# this adds the simlinks to the compose projects in the repo

sudo mkdir -p /opt/docker/compose
sudo chown -R vagrant:vagrant /opt/docker/compose

ln -sf /home/vagrant/devel/gitrepos/COM614-cloud-computing/workup/ansible-examples/docker-compose-services /opt/docker/compose/docker-compose-services

# set up service to start docker compose

sudo cp /vagrant/docker-compose@.service /etc/systemd/system/docker-compose@.service

sudo chmod 644 /etc/systemd/system/docker-compose@.service







