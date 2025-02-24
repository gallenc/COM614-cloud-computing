# DrayTek2860L(sec)

## SNMP Walk

```
snmpwalk -v1 -On 192.168.105.2 -c public .1.3
```

## SNMPSIM recording

```
snmprec.py --community=public  --protocol-version=1   --agent-udpv4-endpoint=192.168.105.2 --output-file=./draytek2860-sec.snmprec
```