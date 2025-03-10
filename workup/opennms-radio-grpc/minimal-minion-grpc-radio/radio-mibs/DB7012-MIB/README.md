

## DB7012 SNMP Walk

```
 snmpwalk -v1 -On 192.168.105.101 -c DEVA7012 .1.3
```

## SNMPSIM recording

```
 snmprec.py --community=DEVA7012  --protocol-version=1   --agent-udpv4-endpoint=192.168.105.101 --output-file=./DEVA7012.snmprec
```

## MIB parsing

mib file DB7012-MIB.mib has been corrected so that it compiles DB7012-MIB-corrected.mib