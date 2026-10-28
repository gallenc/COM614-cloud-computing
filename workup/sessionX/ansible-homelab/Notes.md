# notes

### Setting up the vlan1 interface

```
enable
configure terminal
interface vlan 1
ip address 192.168.1.100 255.255.255.0
no shutdown
exit
ip default-gateway 192.168.1.1
end
write memory
```

### disable timeout for remote connections

```
enable
configure terminal
line vty 0 4
exec-timeout 0 0
exit
write memory
```

### set up VLAN 1 (Management/IPMI)

Ports 3, 6, 9, 12, 15, 18, 21, 24 + Port 43 (Router uplink)

(ai Corrected ios Script)

```
enable
configure terminal
vlan 1
 exit
interface range gigabitEthernet 1/0/3, gigabitEthernet 1/0/6, gigabitEthernet 1/0/9, gigabitEthernet 1/0/12, gigabitEthernet 1/0/15
 switchport mode access
 switchport access vlan 1
 exit
interface range gigabitEthernet 1/0/18, gigabitEthernet 1/0/21, gigabitEthernet 1/0/24, gigabitEthernet 1/0/43
 switchport mode access
 switchport access vlan 1
 exit
 
end
write memory
```

### set up VLAN 10 ports

VLAN10 Ports 1, 4, 7, 10, 13, 16, 19, 22 + Port 41

Need to use separate configs because cannot include all gigabitEthernet 

```
enable
configure terminal

vlan 10
 exit

interface range gigabitEthernet 1/0/1 , gigabitEthernet 1/0/4 , gigabitEthernet 1/0/7 , gigabitEthernet 1/0/10 , gigabitEthernet 1/0/13
 switchport mode access
 switchport access vlan 10
 exit

interface range gigabitEthernet 1/0/16 , gigabitEthernet 1/0/19 , gigabitEthernet 1/0/22 , gigabitEthernet 1/0/41
 switchport mode access
 switchport access vlan 10
 exit
 
end

write memory

```

### set up VLAN 20 (Secondary)   

Ports 2, 5, 8, 11, 14, 17, 20, 23 + Port 42 (Router uplink)

```
enable
configure terminal

vlan 20
  exit

interface range gigabitEthernet 1/0/1 , gigabitEthernet 1/0/4 , gigabitEthernet 1/0/7 , gigabitEthernet 1/0/10 , gigabitEthernet 1/0/13
 switchport mode access
 switchport access vlan 20
 exit

interface range gigabitEthernet 1/0/16 , gigabitEthernet 1/0/19 , gigabitEthernet 1/0/22 , gigabitEthernet 1/0/41
 switchport mode access
 switchport access vlan 20
 exit

end

write memory

```


# show running-config after actions

```
login as: admin
Keyboard-interactive authentication prompts from server:
| Password:
End of keyboard-interactive prompts from server

lab-sw1#show running-config
Building configuration...

Current configuration : 5124 bytes
!
! Last configuration change at 01:45:23 UTC Wed Mar 30 2011 by admin
! NVRAM config last updated at 01:45:25 UTC Wed Mar 30 2011 by admin
!
version 15.0
service config
no service pad
service timestamps debug datetime msec
service timestamps log datetime msec
no service password-encryption
!
hostname lab-sw1
!
boot-start-marker
boot-end-marker
!
enable secret 4 ve3n3DnKVWHKz8wUHfNU4C/ajRxMwVTMUFXvON4wLGk
enable password minad1234
!
username admin privilege 15 secret 4 ve3n3DnKVWHKz8wUHfNU4C/ajRxMwVTMUFXvON4wLGk
no aaa new-model
switch 1 provision ws-c2960s-48ts-l
!
!
ip domain-name yourdomain.local
!
!
crypto pki trustpoint TP-self-signed-3222200320
 enrollment selfsigned
 subject-name cn=IOS-Self-Signed-Certificate-3222200320
 revocation-check none
 rsakeypair TP-self-signed-3222200320
!
!
crypto pki certificate chain TP-self-signed-3222200320
 certificate self-signed 01
  3082022B 30820194 A0030201 02020101 300D0609 2A864886 F70D0101 05050030
  31312F30 2D060355 04031326 494F532D 53656C66 2D536967 6E65642D 43657274
  69666963 6174652D 33323232 32303033 3230301E 170D3131 30333330 30313332
  35305A17 0D323030 31303130 30303030 305A3031 312F302D 06035504 03132649
  4F532D53 656C662D 5369676E 65642D43 65727469 66696361 74652D33 32323232
  30303332 3030819F 300D0609 2A864886 F70D0101 01050003 818D0030 81890281
  8100AA79 1F4C9A1B 7E9BDCEC BBE41FDF A6B649A4 C9337B06 D0DC2280 9693769F
  267316FC 92B92658 6232C8EA 7CBE3B86 8FD4D09D 616DA413 222AEE70 C651840F
  5AED4C0C 942829F3 50B5C879 07C2DFCB 90CD99CE CF4BAC0D FC5A7D90 4D099781
  49811993 19538BA3 B255FB0B FCE7CEA1 38E2B7ED BC5AF8E5 D975AD6E 9ED7EA00
  AA4F0203 010001A3 53305130 0F060355 1D130101 FF040530 030101FF 301F0603
  551D2304 18301680 149662F1 803D1925 393996DE DA61BE4B 75AF1C05 9F301D06
  03551D0E 04160414 9662F180 3D192539 3996DEDA 61BE4B75 AF1C059F 300D0609
  2A864886 F70D0101 05050003 81810099 9B5BB583 F3A131AD F35893A1 6DB20564
  C96FB578 152591AB 633C9007 B5FD9541 94AC41FD D02BAE04 B40D57D2 46E2A22E
  34798412 D5BF078C 736B6A61 03D40E91 532EFFA1 BC1092F2 9AD604F0 F92E713C
  E41BFB34 AE906C3B 776494C0 7EF0E1F2 9231FAFC 0BBF7680 38B8C014 D9081E8B
  98D33973 7050D3C1 861EAE42 4733C6
        quit
spanning-tree mode pvst
spanning-tree extend system-id
!
!
!
!
!
!
!
!
!
vlan internal allocation policy ascending
!
ip ssh version 2
!
!
!
!
!
!
!
!
!
!
interface FastEthernet0
 no ip address
 shutdown
!
interface GigabitEthernet1/0/1
 switchport access vlan 20
 switchport mode access
!
interface GigabitEthernet1/0/2
!
interface GigabitEthernet1/0/3
 switchport mode access
!
interface GigabitEthernet1/0/4
 switchport access vlan 20
 switchport mode access
!
interface GigabitEthernet1/0/5
!
interface GigabitEthernet1/0/6
 switchport mode access
!
interface GigabitEthernet1/0/7
 switchport access vlan 20
 switchport mode access
!
interface GigabitEthernet1/0/8
!
interface GigabitEthernet1/0/9
 switchport mode access
!
interface GigabitEthernet1/0/10
 switchport access vlan 20
 switchport mode access
!
interface GigabitEthernet1/0/11
!
interface GigabitEthernet1/0/12
 switchport mode access
!
interface GigabitEthernet1/0/13
 switchport access vlan 20
 switchport mode access
!
interface GigabitEthernet1/0/14
!
interface GigabitEthernet1/0/15
 switchport mode access
!
interface GigabitEthernet1/0/16
 switchport access vlan 20
 switchport mode access
!
interface GigabitEthernet1/0/17
!
interface GigabitEthernet1/0/18
 switchport mode access
!
interface GigabitEthernet1/0/19
 switchport access vlan 20
 switchport mode access
!
interface GigabitEthernet1/0/20
!
interface GigabitEthernet1/0/21
 switchport mode access
!
interface GigabitEthernet1/0/22
 switchport access vlan 20
 switchport mode access
!
interface GigabitEthernet1/0/23
!
interface GigabitEthernet1/0/24
 switchport mode access
!
interface GigabitEthernet1/0/25
!
interface GigabitEthernet1/0/26
!
interface GigabitEthernet1/0/27
!
interface GigabitEthernet1/0/28
!
interface GigabitEthernet1/0/29
!
interface GigabitEthernet1/0/30
!
interface GigabitEthernet1/0/31
!
interface GigabitEthernet1/0/32
!
interface GigabitEthernet1/0/33
!
interface GigabitEthernet1/0/34
!
interface GigabitEthernet1/0/35
!
interface GigabitEthernet1/0/36
!
interface GigabitEthernet1/0/37
!
interface GigabitEthernet1/0/38
!
interface GigabitEthernet1/0/39
!
interface GigabitEthernet1/0/40
!
interface GigabitEthernet1/0/41
 switchport access vlan 20
 switchport mode access
!
interface GigabitEthernet1/0/42
!
interface GigabitEthernet1/0/43
 switchport mode access
!
interface GigabitEthernet1/0/44
!
interface GigabitEthernet1/0/45
!
interface GigabitEthernet1/0/46
!
interface GigabitEthernet1/0/47
!
interface GigabitEthernet1/0/48
!
interface GigabitEthernet1/0/49
!
interface GigabitEthernet1/0/50
!
interface GigabitEthernet1/0/51
!
interface GigabitEthernet1/0/52
!
interface Vlan1
 ip address 192.168.1.100 255.255.255.0
!
ip http server
ip http secure-server
!
!
snmp-server community public RO
!
!
line con 0
line vty 0 4
 exec-timeout 0 0
 password minad1234
 login local
 transport input ssh
line vty 5 15
 password minad1234
 login
!
end

lab-sw1#

```

show running-config (before actions)

```
login as: admin
Keyboard-interactive authentication prompts from server:
| Password:
End of keyboard-interactive prompts from server

lab-sw1#show running config
                     ^
% Invalid input detected at '^' marker.

lab-sw1#sho running-config
Building configuration...

Current configuration : 4398 bytes
!
! No configuration change since last restart
! NVRAM config last updated at 01:32:51 UTC Wed Mar 30 2011
!
version 15.0
service config
no service pad
service timestamps debug datetime msec
service timestamps log datetime msec
no service password-encryption
!
hostname lab-sw1
!
boot-start-marker
boot-end-marker
!
enable secret 4 ve3n3DnKVWHKz8wUHfNU4C/ajRxMwVTMUFXvON4wLGk
enable password minad1234
!
username admin privilege 15 secret 4 ve3n3DnKVWHKz8wUHfNU4C/ajRxMwVTMUFXvON4wLGk
no aaa new-model
switch 1 provision ws-c2960s-48ts-l
!
!
ip domain-name yourdomain.local
!
!
crypto pki trustpoint TP-self-signed-3222200320
 enrollment selfsigned
 subject-name cn=IOS-Self-Signed-Certificate-3222200320
 revocation-check none
 rsakeypair TP-self-signed-3222200320
!
!
crypto pki certificate chain TP-self-signed-3222200320
 certificate self-signed 01
  3082022B 30820194 A0030201 02020101 300D0609 2A864886 F70D0101 05050030
  31312F30 2D060355 04031326 494F532D 53656C66 2D536967 6E65642D 43657274
  69666963 6174652D 33323232 32303033 3230301E 170D3131 30333330 30313332
  35305A17 0D323030 31303130 30303030 305A3031 312F302D 06035504 03132649
  4F532D53 656C662D 5369676E 65642D43 65727469 66696361 74652D33 32323232
  30303332 3030819F 300D0609 2A864886 F70D0101 01050003 818D0030 81890281
  8100AA79 1F4C9A1B 7E9BDCEC BBE41FDF A6B649A4 C9337B06 D0DC2280 9693769F
  267316FC 92B92658 6232C8EA 7CBE3B86 8FD4D09D 616DA413 222AEE70 C651840F
  5AED4C0C 942829F3 50B5C879 07C2DFCB 90CD99CE CF4BAC0D FC5A7D90 4D099781
  49811993 19538BA3 B255FB0B FCE7CEA1 38E2B7ED BC5AF8E5 D975AD6E 9ED7EA00
  AA4F0203 010001A3 53305130 0F060355 1D130101 FF040530 030101FF 301F0603
  551D2304 18301680 149662F1 803D1925 393996DE DA61BE4B 75AF1C05 9F301D06
  03551D0E 04160414 9662F180 3D192539 3996DEDA 61BE4B75 AF1C059F 300D0609
  2A864886 F70D0101 05050003 81810099 9B5BB583 F3A131AD F35893A1 6DB20564
  C96FB578 152591AB 633C9007 B5FD9541 94AC41FD D02BAE04 B40D57D2 46E2A22E
  34798412 D5BF078C 736B6A61 03D40E91 532EFFA1 BC1092F2 9AD604F0 F92E713C
  E41BFB34 AE906C3B 776494C0 7EF0E1F2 9231FAFC 0BBF7680 38B8C014 D9081E8B
  98D33973 7050D3C1 861EAE42 4733C6
        quit
spanning-tree mode pvst
spanning-tree extend system-id
!
!
!
!
!
!
!
!
!
vlan internal allocation policy ascending
!
ip ssh version 2
!
!
!
!
!
!
!
!
!
!
interface FastEthernet0
 no ip address
 shutdown
!
interface GigabitEthernet1/0/1
!
interface GigabitEthernet1/0/2
!
interface GigabitEthernet1/0/3
!
interface GigabitEthernet1/0/4
!
interface GigabitEthernet1/0/5
!
interface GigabitEthernet1/0/6
!
interface GigabitEthernet1/0/7
!
interface GigabitEthernet1/0/8
!
interface GigabitEthernet1/0/9
!
interface GigabitEthernet1/0/10
!
interface GigabitEthernet1/0/11
!
interface GigabitEthernet1/0/12
!
interface GigabitEthernet1/0/13
!
interface GigabitEthernet1/0/14
!
interface GigabitEthernet1/0/15
!
interface GigabitEthernet1/0/16
!
interface GigabitEthernet1/0/17
!
interface GigabitEthernet1/0/18
!
interface GigabitEthernet1/0/19
!
interface GigabitEthernet1/0/20
!
interface GigabitEthernet1/0/21
!
interface GigabitEthernet1/0/22
!
interface GigabitEthernet1/0/23
!
interface GigabitEthernet1/0/24
!
interface GigabitEthernet1/0/25
!
interface GigabitEthernet1/0/26
!
interface GigabitEthernet1/0/27
!
interface GigabitEthernet1/0/28
!
interface GigabitEthernet1/0/29
!
interface GigabitEthernet1/0/30
!
interface GigabitEthernet1/0/31
!
interface GigabitEthernet1/0/32
!
interface GigabitEthernet1/0/33
!
interface GigabitEthernet1/0/34
!
interface GigabitEthernet1/0/35
!
interface GigabitEthernet1/0/36
!
interface GigabitEthernet1/0/37
!
interface GigabitEthernet1/0/38
!
interface GigabitEthernet1/0/39
!
interface GigabitEthernet1/0/40
!
interface GigabitEthernet1/0/41
!
interface GigabitEthernet1/0/42
!
interface GigabitEthernet1/0/43
!
interface GigabitEthernet1/0/44
!
interface GigabitEthernet1/0/45
!
interface GigabitEthernet1/0/46
!
interface GigabitEthernet1/0/47
!
interface GigabitEthernet1/0/48
!
interface GigabitEthernet1/0/49
!
interface GigabitEthernet1/0/50
!
interface GigabitEthernet1/0/51
!
interface GigabitEthernet1/0/52
!
interface Vlan1
 ip address 192.168.1.100 255.255.255.0
!
ip http server
ip http secure-server
!
!
snmp-server community public RO
!
!
line con 0
line vty 0 4
 password minad1234
 login local
 transport input ssh
line vty 5 15
 password minad1234
 login
!
end

```

# Notes

```
Note does the switch use fastEthernet or gig
Switch> enable
Switch# configure terminal
Switch(config)# interface range GigabitEthernet1/0/1 , fastEthernet 0/5 , fastEthernet 0/8
Switch(config-if-range)# switchport mode access
Switch(config-if-range)# switchport access vlan 10
Switch(config-if-range)# end
Switch# copy running-config startup-config
```

Notes assign multiple random ports

```
Switch> enable
Switch# configure terminal
Switch(config)# interface range fastEthernet 0/3 , fastEthernet 0/5 , fastEthernet 0/8
Switch(config-if-range)# switchport mode access
Switch(config-if-range)# switchport access vlan 10
Switch(config-if-range)# end
Switch# copy running-config startup-config
```

