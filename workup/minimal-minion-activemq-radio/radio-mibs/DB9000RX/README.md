


## SNMP WALK DB9000RX

```
snmpwalk -v1 -On 192.168.105.99 -c DEVA9000 .1.3
```


## SNMPSIM recording

```
 snmprec.py --community=DEVA9000  --protocol-version=1   --agent-udpv4-endpoint=192.168.105.99 --output-file=./DEVA9000.snmprec
```