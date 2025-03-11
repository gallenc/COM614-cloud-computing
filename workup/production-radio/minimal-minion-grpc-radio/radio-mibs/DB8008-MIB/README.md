# Deva Silence Switcher  DB8008

https://www.deva-broadcast-tools.com/products/db8008

## SNMP WALK

```
snmpwalk -v1 -On 192.168.105.100 -c DEVA8008 .1.3
```


## SNMPSIM recording

```
 snmprec.py --community=DEVA8008  --protocol-version=1   --agent-udpv4-endpoint=192.168.105.100 --output-file=./DEVA8008.snmprec
```