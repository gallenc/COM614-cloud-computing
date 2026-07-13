# HP ProCurve 3400cl Configuration Guide

## Device Specifications

### HP ProCurve 3400cl Switch Specifications

| Specification | Details |
|--------------|---------|
| **Model** | HP ProCurve 3400cl |
| **Total Ports** | 48 × 10/100BASE-T Ethernet ports |
| **Uplink Ports** | 2 × 1000BASE-T/SFP ports (combo) |
| **Management** | Out-of-band Ethernet management port |
| **VLAN Support** | Up to 4094 VLANs |
| **Default VLAN** | VLAN 1 (untagged) |
| **Maximum Users** | 254 |
| **Memory** | 128 MB SDRAM, 32 MB Flash |
| **Power Consumption** | Approx. 200W |
| **Dimensions** | 1U rack mount (19") |
| **Warranty** | Limited lifetime warranty |

## Configuration Overview

This guide configures the switch with three VLANs distributed across 48 ports:

```
Port Layout:
┌─────────────────────────────────────────────┐
│ VLAN 100 (Production)     VLAN 200 (Dev)    │
│ Ports 1-20               Ports 21-40        │
│ 20 ports                 20 ports           │
└─────────────────────────────────────────────┘
│ VLAN 300 (Management)                       │
│ Ports 41-48 (8 ports)                       │
└─────────────────────────────────────────────┘
```

## Ansible Configuration Structure

### Playbook Organization

```
network-lab-example/
├── test.yml                      # Main playbook
├── procurve_vlan_config.yml      # Alternative (config module)
├── procurve_vlan_config_raw.yml  # Alternative (raw commands)
├── inventory.ini                 # Host inventory
├── requirements.txt              # Python dependencies
├── setup.sh                      # Linux/Mac setup script
├── setup.bat                     # Windows setup script
├── README.md                     # Main documentation
├── QUICK_REFERENCE.md            # Quick command reference
└── CONFIG_GUIDE.md               # This file
```

## Variable Configuration

### VLAN Variables in test.yml

```yaml
vlans:
  production:
    id: 100
    name: "Production"
    ports: "1-20"
    description: "Production network - 20 ports"
  development:
    id: 200
    name: "Development"
    ports: "21-40"
    description: "Development network - 20 ports"
  management:
    id: 300
    name: "Management"
    ports: "41-48"
    description: "Management network - 8 ports (remaining)"
```

### Modifying VLAN Configuration

To change VLAN settings, edit the `vlans` section in `test.yml`:

#### Change VLAN Name:
```yaml
vlans:
  production:
    name: "Prod-Network"  # Changed from "Production"
```

#### Change Port Assignment:
```yaml
vlans:
  production:
    ports: "1-25"  # Now uses 25 ports instead of 20
```

#### Add Additional VLAN:
```yaml
vlans:
  # ...existing vlans...
  backup:
    id: 400
    name: "Backup"
    ports: "48"
    description: "Backup network - 1 port"
```

## Connection Configuration

### Inventory File Setup (inventory.ini)

The inventory file contains three critical sections:

#### 1. Host Definition
```ini
[procurve_switches]
procurve_3400cl ansible_host=192.168.1.254 ansible_user=admin ansible_password=password
```

**Fields to modify:**
- `procurve_3400cl`: Hostname (can be any name)
- `ansible_host`: IP address of your switch
- `ansible_user`: SSH username
- `ansible_password`: SSH password

#### 2. Connection Settings
```ini
[procurve_switches:vars]
ansible_connection=network_cli
ansible_network_os=hpexcl
ansible_command_timeout=30
ansible_persistent_command_timeout=30
```

**Parameters:**
- `ansible_connection`: Must be `network_cli` for HP ProCurve
- `ansible_network_os`: Must be `hpexcl` (HP ExCel/ProCurve)
- `ansible_command_timeout`: Command execution timeout in seconds
- `ansible_persistent_command_timeout`: Persistent connection timeout

### Inventory Examples

#### Example 1: Single Switch
```ini
[procurve_switches]
switch1 ansible_host=192.168.1.254 ansible_user=admin ansible_password=mypassword
```

#### Example 2: Multiple Switches
```ini
[procurve_switches]
switch1 ansible_host=192.168.1.254 ansible_user=admin ansible_password=password1
switch2 ansible_host=192.168.1.253 ansible_user=admin ansible_password=password2
switch3 ansible_host=192.168.1.252 ansible_user=admin ansible_password=password3

[procurve_switches:vars]
ansible_connection=network_cli
ansible_network_os=hpexcl
```

#### Example 3: Using SSH Keys (Recommended)
```ini
[procurve_switches]
switch1 ansible_host=192.168.1.254 ansible_user=admin ansible_ssh_private_key_file=~/.ssh/id_rsa
```

## Playbook Execution Workflows

### Workflow 1: Initial Setup
```
1. Edit inventory.ini
   ↓
2. Run setup script (setup.sh or setup.bat)
   ↓
3. Test connectivity: ansible all -i inventory.ini -m ping
   ↓
4. Run main playbook: ansible-playbook test.yml -i inventory.ini
   ↓
5. Verify on switch: show vlan
```

### Workflow 2: Update Existing VLANs
```
1. Edit test.yml (modify VLAN variables)
   ↓
2. Run playbook: ansible-playbook test.yml -i inventory.ini
   ↓
3. Check playbook output for changes
   ↓
4. Verify: ssh admin@switch && show vlan
```

### Workflow 3: Troubleshooting
```
1. Check connectivity: ping 192.168.1.254
   ↓
2. Test SSH: ssh admin@192.168.1.254
   ↓
3. Run playbook with verbose: ansible-playbook test.yml -i inventory.ini -vvv
   ↓
4. Check switch logs: show log
   ↓
5. Revert if needed: restore startup-config (manual SSH)
```

## Module Selection Guide

### When to Use Which Playbook:

| Scenario | Recommended | Reason |
|----------|-------------|--------|
| Initial setup, latest firmware | test.yml | Most features, clearest output |
| Compatibility issues | procurve_vlan_config.yml | Cleaner YAML structure |
| Old firmware, stability needed | procurve_vlan_config_raw.yml | Raw commands work everywhere |

## Advanced Configuration Examples

### Example 1: Creating a Trunk Port

Add this to your playbook:
```yaml
- name: Create trunk port (tagged in multiple VLANs)
  community.network.hpexcl_config:
    lines:
      - "name AllVLANs"
      - "tagged 48"
    parents: "vlan 100"
```

Repeat for other VLANs:
```yaml
- name: Tag port 48 in VLAN 200
  community.network.hpexcl_config:
    lines:
      - "tagged 48"
    parents: "vlan 200"
```

### Example 2: Port Description

Add descriptions to document ports:
```yaml
- name: Add port descriptions
  community.network.hpexcl_command:
    commands:
      - "interface 1"
      - "description Server1-Production"
      - "exit"
```

### Example 3: Verify Port Configuration

Check a specific port:
```bash
ssh admin@192.168.1.254
HP3400cl# show port-config 1
```

Output:
```
Port 1 - Configuration
Name                      :
Speed/Duplex              : Auto
Flow Control              : Off
Broadcast Limit           : Disabled
Description               : Server1-Production
```

### Example 4: Access Control Lists (ACL)

Create a simple ACL (in SSH):
```
access-list 1
permit ip-source 192.168.1.0/255.255.255.0
permit ip-source 10.0.0.0/255.0.0.0
```

## Backup and Recovery

### Backup Switch Configuration

#### Via Ansible:
```bash
ansible procurve_3400cl -i inventory.ini -m hpexcl_command \
  -a "commands='show running-config'" > backup.txt
```

#### Via SSH:
```bash
ssh admin@192.168.1.254 "show running-config" > backup.txt
```

#### Via Switch CLI:
```
copy running-config startup-config
```

### Recovery Procedures

#### Restore to Startup Config:
```
ssh admin@192.168.1.254
HP3400cl# restore startup-config
Restoring startup-config will replace running config
Continue? (y/n): y
```

#### Factory Reset (CAUTION):
```
HP3400cl# factory-default
Configuration will be reset to factory defaults
Continue? (y/n): y
```

## Performance Considerations

### Port Speed Settings

Default configuration uses auto-negotiation. For better performance:

```yaml
- name: Set port speed to 100Mbps
  community.network.hpexcl_command:
    commands:
      - "interface 1"
      - "speed 100"
      - "duplex full"
      - "exit"
```

### Monitoring

Check port statistics:
```bash
ssh admin@192.168.1.254
HP3400cl# show interface 1 statistics
```

## Security Best Practices

### 1. Change Default Credentials
```bash
ansible procurve_3400cl -i inventory.ini -m hpexcl_command \
  -a "commands='password'"
```

### 2. Enable SSH Only (Disable Telnet)
```
no telnet-server
```

### 3. Create Admin User
```
username admin password hashed_password
```

### 4. Configure SNMP (optional)
```
snmp-server community public
snmp-server community private
```

## Troubleshooting Common Issues

### Issue: "Failed to connect to the host"
**Cause:** Network connectivity or SSH not enabled
**Solution:**
```bash
ping 192.168.1.254
ssh admin@192.168.1.254 "show system"
```

### Issue: "Authentication failed"
**Cause:** Wrong username/password
**Solution:**
1. Verify credentials in inventory.ini
2. Test manually: `ssh admin@192.168.1.254`
3. Reset password via serial console if locked

### Issue: "VLAN already exists"
**Cause:** VLAN already configured
**Solution:** Playbook includes `save_when: changed` - it will skip if VLAN exists

### Issue: "Port already belongs to another VLAN"
**Cause:** Port must be removed from default VLAN first
**Solution:** Playbook handles this automatically

### Issue: "Command timeout"
**Cause:** Switch is busy or network latency
**Solution:** Increase timeout in inventory.ini:
```ini
ansible_command_timeout=60
```

## Additional Resources

### Documentation
- [Ansible Network Documentation](https://docs.ansible.com/ansible/latest/network/index.html)
- [HP ProCurve Command Reference](https://support.hpe.com/)
- [VLAN Best Practices](https://en.wikipedia.org/wiki/Virtual_LAN)

### Related Commands
- Show VLAN status: `show vlan`
- Show port membership: `show vlan-membership`
- Show running config: `show running-config`
- Show startup config: `show startup-config`

## Support and Assistance

For further help:
1. Check README.md for basic setup
2. Review QUICK_REFERENCE.md for common commands
3. Check HP ProCurve documentation for switch-specific issues
4. Consult Ansible documentation for automation issues

## Version History

- **v1.0** - Initial release with 3 VLANs configuration
- **v1.1** - Added raw commands alternative, improved documentation
- **v1.2** - Added Windows support with setup.bat

---

**Last Updated:** 2026-07-13
**Created for:** HP ProCurve 3400cl
**Ansible Version:** 2.9+
**Network OS:** HPEXCL (HP ExCel)
