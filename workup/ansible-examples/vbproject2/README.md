# Setting up two virtual machines 

This configuration sets up two virtual machines based upon the [masterAlma10Box](../../example3/masterAlma10box)

Having configured the second ethnernet connection using

```
     alma_1.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--nic2", "hostonly"]
        vb.customize ["modifyvm", :id, "--hostonlyadapter2", "VirtualBox Host-Only Ethernet Adapter"] #use proper network name here
        vb.customize ["modifyvm", :id, "--cableconnected2", "on"]
     end
```

We need to change its configuration from DHCP to a static address using nmcli

```

     # set eth 1 to a static ip address below DHCP range of virtual box
     alma_1.vm.provision "shell", inline: <<-SHELL
       echo script setting static ip address 
       nmcli connection modify "Wired connection 2"  ipv4.method manual   ipv4.addresses 192.168.56.10/24
       nmcli connection down "Wired connection 2"
       nmcli connection up "Wired connection 2"
     SHELL
```

An extra script is injected into the machine which can be done to clone this repo in the machine to run as an example

The [additional-config.sh](../additional-config.sh) file should be run within the virtual machine using 

```
sh /vagrant/additional-config.sh
```

Note that `vagrant halt` may not work on these machines because of a problem with shutting down the guest additions. 
`shutdown now` may also not complete.
This is a known problem. 
You may need to manually stop the machines in the VirtualBox gui.
Make sure you backup your work to github because you may need to destroy and recreate these machines. 


## additional notes and gotchas

### virtual machine fails to restart

sometimes the virtual machines will fail shut down with

```
vagrant halt
```
This is a known problem with Virtual Box guest additions and I havent found a satisfactory answer.
In this case you will have to shutdown the machines manually using the VirtualBox gui.

It is also possible after manually shutting down as above, `vagrant up` will not complete
In this case, again you will have to shut down the machines manually and retry `vagrant up`

### wrong file endings in files imported with shared `\vagrant` folder
sometimes the /vagrant directory which is shared with a windows host may have problems with the wrong line endings on the files (windows uses new line \ carriage return while linux only uses carriage return)

if this is the case for a file you will see errors like

```
sh additional-config.sh
additional-config.sh: line 2: $'\r': command not found
```

This can be fixed in the virtual machine using sed with option -i for in-place editing, we delete the trailing \r directly in the input file.

```
sed -i 's/\r$//' filename
```




