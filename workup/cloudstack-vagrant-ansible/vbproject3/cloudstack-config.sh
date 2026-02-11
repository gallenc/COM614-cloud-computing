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

## add ansible modules needed
ansible-galaxy collection install ansible.posix    # fix couldn't resolve module/action 'firewalld' 
ansible-galaxy collection install community.mysql  # fix couldn't resolve module/action 'mysql_user'

## set crypto policies to allow cloudstack install
# see SHA1 policies https://github.com/apache/cloudstack/issues/10133
# see https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/security_hardening/using-the-system-wide-cryptographic-policies_security-hardening

sudo update-crypto-policies --set LEGACY

## install python firewall
sudo dnf -y install python3-firewall







