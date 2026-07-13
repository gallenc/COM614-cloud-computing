# HP ProCurve 3400cl Ansible VLAN Configuration

This directory contains Ansible playbooks to configure an HP ProCurve 3400cl switch with three VLANs, each with 20 ports.

## Overview

The HP ProCurve 3400cl is a 48-port managed switch. This configuration divides the ports into three VLANs:

| VLAN ID | Name        | Ports    | Count |
|---------|-------------|----------|-------|
| 100     | Production  | 1-20     | 20    |
| 200     | Development | 21-40    | 20    |
| 300     | Management  | 41-48    | 8*    |

*The switch has 48 ports total, so the third VLAN gets 8 ports (remaining).

## Files Included

### 1. **test.yml** (Main Configuration)
The primary playbook with pre-tasks, tasks, and post-tasks for comprehensive configuration and verification.

**Features:**
- Clear configuration plan display
- VLAN creation with proper naming
- Port assignment (untagged)
- Configuration verification with `show vlan` command
- Summary report of changes

**Usage:**
```bash
ansible-playbook test.yml -i inventory.ini
```

### 2. **procurve_vlan_config.yml** (Alternative Configuration)
Uses `hpexcl_config` module with parent hierarchy for cleaner YAML structure.

**Usage:**
```bash
ansible-playbook procurve_vlan_config.yml -i inventory.ini
```

### 3. **procurve_vlan_config_raw.yml** (Raw Commands)
Uses raw CLI commands for maximum compatibility with different firmware versions.

**Features:**
- Direct CLI command execution
- Better compatibility with older firmware
- Includes save to memory (`write memory`)
- Direct VLAN status verification

**Usage:**
```bash
ansible-playbook procurve_vlan_config_raw.yml -i inventory.ini
```

### 4. **inventory.ini** (Inventory File)
Contains connection parameters for the switch.

**Edit the following values:**
```ini
ansible_host=192.168.1.254          # Switch IP address
ansible_user=admin                  # SSH username
ansible_password=password           # SSH password
```

## Prerequisites

### 1. Ansible Installation
```bash
pip install ansible
```

### 2. Required Collections
```bash
ansible-galaxy collection install community.network
```

### 3. Switch Access
- SSH must be enabled on the switch
- You must have admin credentials
- Network connectivity to the switch IP address

### 4. Connection Configuration
Ensure the switch is reachable:
```bash
ping 192.168.1.254
```

Test SSH connection:
```bash
ssh admin@192.168.1.254
```

## Quick Start

1. **Update the inventory file:**
```bash
# Edit inventory.ini with your switch details
```

2. **Run the main playbook:**
```bash
ansible-playbook test.yml -i inventory.ini
```

3. **Verify configuration on the switch:**
```bash
ssh admin@192.168.1.254
HP3400cl# show vlan
```

## Detailed Configuration Steps

### What the Playbook Does:

1. **Pre-Tasks:** Displays configuration plan
2. **Tasks:**
   - Creates VLAN 100 and assigns ports 1-20
   - Creates VLAN 200 and assigns ports 21-40
   - Creates VLAN 300 and assigns ports 41-48
   - Verifies VLAN configuration
3. **Post-Tasks:** Displays configuration summary

### Manual CLI Equivalent:

If you prefer to configure manually, here are the equivalent CLI commands:

```
vlan 100
  name Production
  untagged 1-20
  exit

vlan 200
  name Development
  untagged 21-40
  exit

vlan 300
  name Management
  untagged 41-48
  exit

show vlan
write memory
```

## Troubleshooting

### Connection Issues

**Error: "Failed to connect to the host"**
- Verify the switch IP address in inventory.ini
- Check SSH is enabled on the switch
- Verify network connectivity: `ping 192.168.1.254`
- Check firewall rules allow SSH (port 22)

### Authentication Issues

**Error: "Authentication failed"**
- Verify username and password in inventory.ini
- Ensure the user has admin privileges
- Check the switch hasn't locked the account after failed attempts

### Module Issues

**Error: "collection not found"**
```bash
ansible-galaxy collection install community.network
```

**Error: "hpexcl_config: command not found"**
- Ensure community.network collection is installed
- Check Ansible version is 2.9+

### Configuration Not Saving

**Issue: Configuration changes don't persist after reboot**
- The playbook includes `save_when: changed` parameter
- For raw playbook, run `write memory` manually:
  ```bash
  ssh admin@192.168.1.254
  HP3400cl# write memory
  ```

## Additional Configuration Options

### To Add More Ports to a VLAN:

Edit the playbook and modify the ports:
```yaml
ports: "1-25"  # Instead of 1-20
```

### To Add Tagged/Hybrid Ports:

```yaml
- name: Add tagged port to VLAN 100
  community.network.hpexcl_config:
    lines:
      - "tagged 25"
    parents: "vlan 100"
```

### To Create Additional VLANs:

Add a new task following the existing pattern:
```yaml
- name: Create VLAN 400
  community.network.hpexcl_config:
    lines:
      - "name NewVLAN"
      - "untagged 48"
    parents: "vlan 400"
```

## Verifying Configuration

### Check VLANs on Switch:
```bash
ssh admin@192.168.1.254
HP3400cl# show vlan

VLAN ID Name                             Status
------- --------------------------------- --------
1       default                          active
100     Production                       active
200     Development                      active
300     Management                       active
```

### Check Port Assignment:
```bash
HP3400cl# show vlan 100
VLAN 100 "Production"
   Untagged Ports:    1-20
   Tagged Ports:      none
```

## Security Considerations

1. **Change Default Password:** Update switch admin password
2. **Restrict SSH Access:** Configure SSH ACLs on the switch
3. **Use SSH Keys:** Consider replacing password with SSH key authentication
4. **Audit Changes:** Keep playbook runs in version control

## Support

For issues with:
- **Ansible:** https://docs.ansible.com/
- **HP ProCurve:** https://support.hpe.com/
- **community.network collection:** https://github.com/ansible-collections/community.network

## References

- [Ansible Network Modules](https://docs.ansible.com/ansible/latest/collections/community/network/)
- [HP ProCurve 3400cl Documentation](https://support.hpe.com/)
- [VLAN Configuration Best Practices](https://en.wikipedia.org/wiki/Virtual_LAN)

## License

These playbooks are provided as examples for educational and configuration purposes.
