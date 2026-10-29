[Main Menu](../../../sessions/README.md) |[sessionX](../../sessionX/) | [Session X Notes](../docs/sessionNotes.md)

# Home notes


# supermicro

BIOS : Delete (Del) key repeatedly during the Power-On Self-Test (POST). Some models may require pressing F11 or F12 to open the boot menu OR ctrl -s 

When installing ubuntu 26.04 from usb select minimal graphical install to avoid hanging waiting for drivers.

# layer 2 switch   cisco 2960-s (uses gigabit interfaces)

http access enabled http://192.168.1.100/xhome.htm

connect serial lead and press menu switch on front while powering on. Note may need to press again to enter `switch: mode`


|         vlan         |ports |
|:---------------------|:------------|
|VLAN 10 (Production)  |  Ports 1, 4, 7, 10, 13, 16, 19, 22 + Port 41 (Router uplink) |
|VLAN 20 (Secondary)   |  Ports 2, 5, 8, 11, 14, 17, 20, 23 + Port 42 (Router uplink) |
|VLAN 1 (Management/IPMI)|  Ports 3, 6, 9, 12, 15, 18, 21, 24 + Port 43 (Router uplink) |
|Untagged/Unused|  Ports 25-40, 44 (17 ports available for future use) |

| server name       | Management<BR>IP  | Management<BR>MAC | Mangement<BR>switch port | notes             |
|:------------------|:------------------|:------------------|:-------------------------|:------------------|
| cisco switch      | 192.168.1.100     |20:BB:C0:0E:E0:40  | 43 VLAN 1 (default)      |user admin pw minad1234 | 


| server name       | ipmi<BR>IP        | ipmi<BR>MAC       | ipmi<BR>switch port |eth0 enp1s0f1<BR>IP| eth0<BR>MAC       | eth0 switch port  |eth1 enp1s0f1<BR>IP| eth1<BR>MAC       | eth1 switch port  | notes           |
|:------------------|:------------------|:------------------|:--------------------|:------------------|:------------------|:------------------|:------------------|:------------------|:------------------|:----------------|
| blade-1-1         |  248                 |  00:25:90:58:03:90   | 3                   |                   |                   | 1                 |                   |                   | 2                 |                 |
| blade-1-2         |247                  |  00:25:90:58:03:39   | 6                   |                   |                   | 4                 |                   |                   | 5                 |                 |
| blade-1-3         |   246                |                   | 9                   |                   |                   | 7                 |                   |                   | 8                 |                 |
| blade-1-4         |   245                |                   | 12                  |                   |                   | 10                |                   |                   | 11                |                 |
| blade-1-5         |  244                |                   | 15                  |                   |                   | 13                |                   |                   | 14                |                 |
| blade-1-6         | 192.168.1.243     |00-25-90-58-03-4a  | 18                  |                   |                   | 16                |                   |                   | 17                |                 |
| blade-1-7         | 192.168.1.242     |00-25-90-58-03-73  | 21                  |                   |                   | 19                |                   |                   | 20                |                 |
| blade-1-8         | 192.168.1.241     |00-25-90-54-6c-c8  | 24                  |                   |                   | 22                | 192.168.1.34      | 00:25:90:3D:0E:17 | 23                |eth1 used for internet  |           
|                   |                   |                   |                     |                   |                   |                   |                   |                   |                   |                 |

