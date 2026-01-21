# Dual machine alma linux example

This example installs 2 alma linux machines using box https://portal.cloud.hashicorp.com/vagrant/discover/almalinux/10

the initial vagrant file came from 

```
vagrant init almalinux/10 --box-version 10.1.20260110
```

Additional networking was provided to allow a private network in windows 

see https://stackoverflow.com/questions/43203203/virtualbox-networking-using-vagrant

