# Cardinal iMDU (Mains Distribution Unit)

## SNMP Walk

```
snmpwalk -v1 -On 192.168.105.250 -c public .1.3
```

## SNMPSIM recording

```
snmprec.py --community=public  --protocol-version=1   --agent-udpv4-endpoint=192.168.105.250 --output-file=./cardinalImdu.snmprec

```

# MIB files

Note that the original file supplied by the manufacturer (Cardinal-MIB 2008141557Z2.mib) has been corrected to allow it to compile (Cardinal-MIB 2008141557Z2-corrected.mib)