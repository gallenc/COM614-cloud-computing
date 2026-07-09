[Main Menu](../../../sessions/README.md) |[sessionX](../../sessionX/) | [Session X Notes](../docs/sessionNotes.md)

# Session X Notes


    8. Router Connectivity:
    9. eth0 → ProCurve Port 41 (VLAN 10 Uplink)
    10. eth1 → ProCurve Port 42 (VLAN 20 Uplink)
    11. eth2 → ProCurve Port 43 (VLAN 1 Uplink)
    12. eth3 → Untagged/Unused group

The diagram now shows the complete ProCurve switch configuration with all 44 ports accounted for:

    •  VLAN 10 (Production): Ports 1, 4, 7, 10, 13, 16, 19, 22 + Port 41 (Router uplink)
    •  VLAN 20 (Secondary): Ports 2, 5, 8, 11, 14, 17, 20, 23 + Port 42 (Router uplink)
    •  VLAN 1 (Management/IPMI): Ports 3, 6, 9, 12, 15, 18, 21, 24 + Port 43 (Router uplink)
    •  Untagged/Unused: Ports 25-40, 44 (17 ports available for future use)