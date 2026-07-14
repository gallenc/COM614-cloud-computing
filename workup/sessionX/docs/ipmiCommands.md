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
