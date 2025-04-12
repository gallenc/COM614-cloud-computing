# notes

the following logs seem significant

==> provisiond.log <==
2025-04-10 11:03:17,038 WARN  [DefaultUDPTransportMapping_0.0.0.0/0] o.s.MessageDispatcherImpl: java.io.IOException: Encountered unsupported variable syntax: 43
2025-04-10 11:03:17,048 WARN  [pool-4-thread-14] o.o.n.p.d.c.r.DnsLookupClientRpcModule: Failed to retrieve the fully qualified domain name for /192.168.105.250. Using the textual representation of the IP address.
2025-04-10 11:03:27,039 WARN  [DefaultUDPTransportMapping_0.0.0.0/0] o.s.MessageDispatcherImpl: java.io.IOException: Encountered unsupported variable syntax: 43


collectd.log:

2025-04-10 11:03:37,431 DEBUG [collectd-Thread] o.o.n.c.DefaultSnmpCollectionAgent: initialize: db retrieval info: nodeid = 17, address = 192.168.105.250, primaryIfIndex = -1, isSnmpPrimary = P, sysoid = null
2025-04-10 11:03:37,431 DEBUG [collectd-Thread] o.o.n.c.DefaultSnmpCollectionAgent: initialize: db retrieval info: node 17 does not have a legitimate primaryIfIndex.  Assume node does not supply ipAddrTable and continue...
2025-04-10 11:03:37,431 INFO  [collectd-Thread] o.o.n.c.Collectd: scheduleInterface: Unable to schedule OnmsIpInterface{id=95, ipAddr=192.168.105.250, netMask=null, ipHostName=192.168.105.250, isManaged=M, snmpPrimary=P, ipLastCapsdPoll=null, nodeId=17}/SNMP, reason: System Object ID for interface 192.168.105.250 does not exist in the database.