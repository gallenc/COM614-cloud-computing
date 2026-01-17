#!/bin/bash

set -x

yum -y update

yum -y install java-21-openjdk-devel

yum -y install maven

yum -y install git

yum -y install mkpasswd

# add admin with password minad1234   (note insecure)
# only create user if doesn't exist

if getent passwd | grep -c '^admin:' > /dev/null ;
  then 
    echo "admin user already exists"; 
  else 
    echo creating admin user; 
    sudo useradd -m -s /bin/bash -U admin -u 1001 --groups wheel --password "$(mkpasswd minad1234)"
    sudo echo "%admin ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/admin
fi

## add docker
sudo yum config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo systemctl enable --now docker

## allow docker to be used without sudo
sudo usermod -aG docker $USER

sudo usermod -aG docker admin

