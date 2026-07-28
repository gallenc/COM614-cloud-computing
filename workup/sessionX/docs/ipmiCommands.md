# IPMI commands

installing IPMI

rocky linux 


check chassis

```
ipmitool -I lanplus  -H 192.168.105.107 -U ADMIN -P ADMIN chassis status
System Power         : on
Power Overload       : false
Power Interlock      : inactive
Main Power Fault     : false
Power Control Fault  : false
Power Restore Policy : always-off
Last Power Event     : 
Chassis Intrusion    : inactive
Front-Panel Lockout  : inactive
Drive Fault          : false
Cooling/Fan Fault    : false
```

check power

```
[admin@localhost ~]$ ipmitool -I lanplus  -H 192.168.105.107 -U ADMIN -P ADMIN power status
Chassis Power is on
```

turn power on

```
[admin@localhost ~]$ ipmitool -I lanplus  -H 192.168.105.107 -U ADMIN -P ADMIN power on
```

turn power off

```
[admin@localhost ~]$ ipmitool -I lanplus  -H 192.168.105.107 -U ADMIN -P ADMIN power off
```


activate sol - 

```
 ipmitool -I lanplus -H 192.168.105.107 -U ADMIN -P ADMIN sol activate
```


boot ipmi

```
ipmitool -I lanplus -H 192.168.105.102 -U ADMIN -P ADMIN chassis bootdev pxe options=efiboot
Set Boot Device to pxe

```

uefi boot

```
ipmitool -I lanplus -H 192.168.105.102 -U ADMIN -P ADMIN chassis bootdev pxe options=efiboot
Set Boot Device to pxe
```

One-time PXE boot: Run

``` 
ipmitool -I lanplus -H <ip_address> -U <username> -P <password> chassis bootdev pxe
```

Persistent PXE boot: Add the persistent flag if supported by your firmware:

```
ipmitool -I lanplus -H <ip_address> -U <username> -P <password> chassis bootdev pxe options=persistent

```


