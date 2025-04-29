# SNMP SIM

This configuration has been built using real data for the radio site devices.

## SNMP Walk of SNMPSIM

Get inside snmpsim container

```
docker compose exec snmpsim bash

```

the option `-On` returns the mib without translating OID's


```
snmpwalk -v1 -On localhost -c DEVA7012 .1.3
```

```
snmpwalk -v1 -On localhost -c DEVA8008 .1.3
```

```
snmpwalk -v1 -On localhost -c DEVA9000 .1.3
```

```
snmpwalk -v1 -On localhost -c draytek2860-pri .1.3
```

```
snmpwalk -v1 -On localhost -c draytek2860-sec .1.3
```

```
snmpwalk -v1 -On localhost -c draytek2860-virtual .1.3
```

```
snmpwalk -v1 -On localhost -c cardinalImdu .1.3
```