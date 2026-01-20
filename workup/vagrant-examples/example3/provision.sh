#!/bin/bash

set -x

dnf -y install git nano wget mkpasswd net-tools

# add admin with password minad1234   (note insecure password for ui login in vmware)

# only create admin user if doesn't exist (note inscecure password)
if getent passwd | grep -c '^admin:' > /dev/null ;
  then 
    echo "admin user already exists"; 
  else 
    echo creating admin user; 
    sudo useradd -m -s /bin/bash -U admin -u 1001 --groups wheel --password "$(mkpasswd minad1234)"
    sudo echo "%admin ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/admin
fi

# The graphical login managers do not show users with UID below 1000
# only create ansible user if doesn't exist (note insecure password - replace with ssh key)
if getent passwd | grep -c '^ansible:' > /dev/null ;
  then 
    echo "ansible user already exists"; 
  else 
    echo creating ansible user; 
    sudo useradd -m -s /bin/bash -U ansible -u 800 --groups wheel --password "$(mkpasswd minad1234)"
    sudo echo "%ansible ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ansible
fi

# epel needed for dkms (for guest additions)
dnf -y install epel-release
dnf config-manager --set-enabled crb

dnf -y update

# needed for virtual-box guest additions kernel update
dnf -y install kernel-devel kernel-headers gcc make bzip2 perl dkms

# update and install VBoxGuestAdditions
echo installing VBoxGuestAdditions. This my take some time. Ignore errors if no video drivers in image

# match the image version to your virtualbox version
# note you will need to restart your vm to use guest additions
wget -O ./VBoxGuestAdditions.iso https://download.virtualbox.org/virtualbox/7.2.4/VBoxGuestAdditions_7.2.4.iso

sudo mkdir /media/VBoxGuestAdditions
sudo mount -o loop,ro VBoxGuestAdditions.iso /media/VBoxGuestAdditions
sudo sh /media/VBoxGuestAdditions/VBoxLinuxAdditions.run
rm VBoxGuestAdditions.iso
sudo umount /media/VBoxGuestAdditions
sudo rmdir /media/VBoxGuestAdditions
echo finished installing VBoxGuestAdditions

## add docker
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo systemctl enable --now docker

## allow docker to be used without sudo for root vagrant and admin users
sudo usermod -aG docker $USER

sudo usermod -aG docker vagrant

sudo usermod -aG docker admin

sudo usermod -aG docker ansible

# add java and maven
dnf -y install java-21-openjdk-devel
dnf -y install maven



