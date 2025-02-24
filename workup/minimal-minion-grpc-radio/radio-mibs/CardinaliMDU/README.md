# Cardinal iMDU (Mains Distribution Unit)

## SNMP Walk

```
snmpwalk -v1 -On 192.168.105.250 -c public .1.3
```

## SNMPSIM recording

```
snmprec.py --community=public  --protocol-version=1   --agent-udpv4-endpoint=192.168.105.250 --output-file=./cardinalImdu.snmprec

```
