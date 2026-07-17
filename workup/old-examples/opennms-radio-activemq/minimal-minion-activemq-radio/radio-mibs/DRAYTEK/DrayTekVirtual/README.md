# DrayTek2860  Virtual

Note this is the virtual router - and seems to respond with the Primary router if working. 

note OID .1.3.6.1.2.1.1.5.0 = STRING: "Widley_Pri"

if Widley_Sec then the secondary router is being used (assumption)

## SNMP Walk

```
snmpwalk -v1 -On 192.168.105.254 -c public .1.3
```

## SNMPSIM recording

```
 snmprec.py --community=public  --protocol-version=1   --agent-udpv4-endpoint=192.168.105.254 --output-fi
le=./draytek2860-virtual.snmprec
```