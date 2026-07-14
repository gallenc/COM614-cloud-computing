# IPMI Power Management - Quick Reference Card

## 🖥️ Servers

```
blade-1-1   ansible_host=192.168.105.107
blade-1-2   ansible_host=192.168.105.106  
blade-1-3   ansible_host=192.168.105.105
blade-1-4   ansible_host=192.168.105.104 
blade-1-5   ansible_host=192.168.105.108 
blade-1-6   ansible_host=192.168.105.103  
blade-1-7   ansible_host=192.168.105.102 
blade-1-8   ansible_host=192.168.105.101
```

## ⚡ Essential Commands

### Power Operations

```bash
# Power ON all servers
ansible-playbook -i hosts.ini ipmi_power_management_loop.yml -e "power_state=on"

# Power OFF all servers
ansible-playbook -i hosts.ini ipmi_power_management_loop.yml -e "power_state=off"

# Reboot all servers
ansible-playbook -i hosts.ini ipmi_power_management_loop.yml -e "power_state=reboot"

# Check status
ansible-playbook -i hosts.ini ipmi_power_management_loop.yml -e "power_state=status"
```

### Target Specific Server

```bash
# Power ON blade-1-1
ansible-playbook -i hosts.ini ipmi_power_management_loop.yml -e "power_state=on" -l blade-1-1

# Power OFF blade-1-2
ansible-playbook -i hosts.ini ipmi_power_management_loop.yml -e "power_state=off" -l blade-1-2

# Check blade-1-3 status
ansible-playbook -i hosts.ini ipmi_power_management_loop.yml -e "power_state=status" -l blade-1-3
```

### Using Variables File

```bash
ansible-playbook -i hosts.ini ipmi_power_management_loop.yml -e @ipmi_vars.yml -e "power_state=on"
```

### Using Vault (Secure Credentials)

```bash
ansible-playbook -i hosts.ini ipmi_power_management_loop.yml \
  -e @ipmi_vault.yml \
  -e "power_state=on" \
  --ask-vault-pass
```

## 🧪 Testing

```bash
# List all servers in inventory
ansible-inventory -i hosts.ini --graph

# Dry-run (check mode)
ansible-playbook -i hosts.ini ipmi_power_management_loop.yml -e "power_state=status" --check

# Verbose output
ansible-playbook -i hosts.ini ipmi_power_management_loop.yml -e "power_state=on" -vvv

# Test IPMI connectivity directly
ipmitool -H 192.168.105.107 -U admin -P admin power status
ipmitool -H 192.168.105.106 -U admin -P admin power status
ipmitool -H 192.168.105.103 -U admin -P admin power status
```

## 🔄 Playbook Files

| File | Use | Command |
|------|-----|---------|
| `ipmi_power_management_loop.yml` | ⭐ Recommended | Default choice |
| `ipmi_power_management.yml` | Explicit tasks | More control per server |
| `run_ipmi_playbook.sh` | Bash | `./run_ipmi_playbook.sh power-on` |
| `run_ipmi_playbook.ps1` | PowerShell | `.\run_ipmi_playbook.ps1 power-on` |

## 📋 Inventory File (hosts.ini)

```ini
[ipmi_management]
blade-1-2 ansible_host=192.168.105.107
blade-1-1 ansible_host=192.168.105.106
blade-1-3 ansible_host=192.168.105.103

[ipmi_management:vars]
ansible_user=admin
ansible_password=admin
```

## 🔐 Setup Vault

```bash
# Create vault
ansible-vault create ipmi_vault.yml

# Edit vault
ansible-vault edit ipmi_vault.yml

# Content example:
# ansible_user: actual_user
# ansible_password: actual_password
```

## 📊 Power States

| State | Description | Example |
|-------|-------------|---------|
| `on` | Power on | `-e "power_state=on"` |
| `off` | Power off | `-e "power_state=off"` |
| `reboot` | Reboot | `-e "power_state=reboot"` |
| `hard_power_off` | Hard off | `-e "power_state=hard_power_off"` |
| `status` | Check status | `-e "power_state=status"` |

## 🎯 Common Scenarios

### Morning: Power On All Servers
```bash
ansible-playbook -i hosts.ini ipmi_power_management_loop.yml -e "power_state=on"
```

### Evening: Power Off All Servers
```bash
ansible-playbook -i hosts.ini ipmi_power_management_loop.yml -e "power_state=off"
```

### Maintenance: Power Off One Server
```bash
ansible-playbook -i hosts.ini ipmi_power_management_loop.yml -e "power_state=off" -l blade-1-1
```

### Check All Servers
```bash
ansible-playbook -i hosts.ini ipmi_power_management_loop.yml -e "power_state=status"
```

### Emergency: Reboot All
```bash
ansible-playbook -i hosts.ini ipmi_power_management_loop.yml -e "power_state=reboot"
```

## 🔧 Troubleshooting

| Problem | Solution |
|---------|----------|
| Connection refused | Check IPMI IP reachable: `ping 192.168.105.107` |
| Authentication failed | Verify username/password in hosts.ini |
| Module not found | Install: `ansible-galaxy collection install community.general` |
| ipmitool not found | Install: `sudo apt-get install ipmitool` |
| Timeout | Increase timeout in playbook or check network |

## 💡 Tips & Tricks

```bash
# Add new server: edit hosts.ini
blade-1-4 ansible_host=192.168.105.104

# Run without vault prompt (if no vault)
ansible-playbook -i hosts.ini ipmi_power_management_loop.yml -e "power_state=on"

# Save output to file
ansible-playbook -i hosts.ini ipmi_power_management_loop.yml -e "power_state=on" > output.log

# Run with custom timeout
ansible-playbook -i hosts.ini ipmi_power_management_loop.yml -e "power_state=on" --timeout=30
```

## 📚 Key Files

- `hosts.ini` - Inventory (server definitions)
- `ipmi_power_management_loop.yml` - Main playbook (recommended)
- `ipmi_power_management.yml` - Explicit playbook
- `ipmi_vars.yml` - Variables (optional)
- `ipmi_vault.yml` - Encrypted credentials (recommended)

## ✅ Pre-Flight Checklist

- [ ] Ansible installed: `ansible --version`
- [ ] Collection installed: `ansible-galaxy collection list | grep community.general`
- [ ] ipmitool installed: `ipmitool --version` or `brew install ipmitool`
- [ ] Inventory file exists: `ls hosts.ini`
- [ ] IPMI IPs reachable: `ping 192.168.105.107`
- [ ] Credentials updated in hosts.ini
- [ ] Playbooks exist: `ls ipmi_power_management*.yml`

## 🚀 First Run

```bash
# 1. Verify inventory
ansible-inventory -i hosts.ini --graph

# 2. Check status (test run)
ansible-playbook -i hosts.ini ipmi_power_management_loop.yml -e "power_state=status"

# 3. Power on all
ansible-playbook -i hosts.ini ipmi_power_management_loop.yml -e "power_state=on"
```

---

**Quick ref version:** 1.0 | **Updated:** 2026-07-14
