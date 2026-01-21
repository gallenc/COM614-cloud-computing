# master alma 10 (RHEL/Centos/Rocky linux 10 equivilent)

This vagrant project creates a master VM which can be used to generate a template .box which has the following installed

base box from [alma linux 10](https://portal.cloud.hashicorp.com/vagrant/discover/almalinux/10

The initial configuration is heavily modified from the Vagrant file generated using

```
vagrant init almalinux/10 --box-version 10.1.20260110
```

## Vagrantfile

The [Vagrantfile](../Vagrantfile) has the following configurations

We need to create a second host only network which operates along side the NAT connection to the Internet.

The virtual box on windows specific configuration is derived from this post [virtualbox-networking-using-vagrant](https://stackoverflow.com/questions/43203203/virtualbox-networking-using-vagrant)

The windows networking is set up here 

```
     alma10_base1.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--nic2", "hostonly"]
        vb.customize ["modifyvm", :id, "--hostonlyadapter2", "VirtualBox Host-Only Ethernet Adapter"] #use proper network name here
        vb.customize ["modifyvm", :id, "--cableconnected2", "on"]
     end
```

the virtual box name within VirtualBox is set using

```
vb.name = "alma10_base1" # name of machine in virtual box - no timestamp
```

We do not want to generate new keys in this master box so we continue to use the [insecure vagrant keys](https://github.com/hashicorp/vagrant/tree/main/keys) with the following setting:

```
     alma10_base1.ssh.insert_key = false
```

The Virtual Box Gui is started when the machine boots using

```
vb.gui = true
```

## provisioning
The provisioning happens in stages after the first boot

[provision.sh](../provision.sh) 
* install basic utils
* update to latest kernel
* add development tools to allow build of virtual box
* add docker , java, maven ,git etc
* reboot server to use the latest kernel

[provision-vboxtools.sh](provision-vboxtools.sh)
* download latest virtual box guest additions iso matching the virtual box we are running on
* mount the VBoxGuestAdditions.iso and run the build script
* reboot server to ensure latest guest additions are installed

## Building and running this master image

building the image for the first time

```
cd masterAlma10box
vagrant up
```
The image will take a long time to build and you must be connected to the Internet.

After the image is built and booted, you can connect to it using

```
vagrant ssh masterAlma10box
```

or from the VirtualBox UI or an external ssh client using `ssh username@localhost -p 2222`

|username | password |
|---------|----------|
| vagrant | vagrant  |
| ansible | minad1234|
| admin   | minad1234|

## Creating a box from this master image

This example builds a box and then packages it as new master box which can be used for development in [vbproject1](../../vbproject1)

### Useful Notes / tutorials

* https://www.engineyard.com/blog/building-a-vagrant-box-from-start-to-finish/

* https://gist.github.com/kekru/a76ba9d0592ce198f09f6ba0cefa5afb   Vagrant create local box

* https://developer.hashicorp.com/vagrant/docs/boxes/base

### to package and store a box locally

Having created a virtual machine `masterAlma10box` using vagrant, we want to use this as a base box for future work.

Export that virtual machine as a box

```
# vagrant package --base name --output name.box
# where --base name is the name used by virtualbox to reference the box

vagrant package --base alma10_base1 --output alma10_base1.box
```
(note we have included .box files in the .gitignore because we do not want to check our images into github)

To save a box in the local repository on your own machine

```
# vagrant box add --name my-new-box-name --version 0.0.1 file://my-new-box-name.box

vagrant box add --name entimoss/alma10_base1  file://alma10_base1.box
```

You can see which boxes are on your machine locally using

```
vagrant box list
```
You can remove boxes using
```
vagrant box delete machine-name
```

# Creating and running a new machine from your box

Create a new folder and initialise a new vagrant project using your image

This will create an initial Vagrantfile in your tmpproject folder

```
mkdir tmpproject
cd tmpproject
vagrant init entimoss/alma10_base1
```

Create and boot the machine using 

```
vagrant up
```

This will create a new machine base on this image with a name tmpproject_default_timestamp

You will be able to log into the machine using the credentials above.

THere is quite a good post here if you want to [change the default machine name](https://stackoverflow.com/questions/17845637/how-to-change-vagrant-default-machine-name)

Note that is was important to use the default insecure SSH keys in the base image because vagrant needs this ssh access in order to change the ssh key for your created box.

The insecure keys are here https://github.com/hashicorp/vagrant/tree/main/keys

The new machine will have these keys replaced with new generated keys found in the generated .vagrant folder

Stop the box and delete the vm using 

```
vagrant box halt

vagrant box destroy
```

Note that even though you have destroyed the VM, it is possible that it will still exist in your virtualbox_machines location so make sure it is deleted there as well.



