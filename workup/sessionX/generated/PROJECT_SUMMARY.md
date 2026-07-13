# HP ProCurve 3400cl Ansible Configuration - Project Summary

## Overview
Complete Ansible configuration package for HP ProCurve 3400cl switch management, specifically configuring three VLANs with port distribution.

## 📋 Files Created

### Core Playbooks

#### 1. **test.yml** (Main Configuration Playbook)
- **Purpose:** Primary playbook with complete VLAN configuration
- **Features:**
  - Pre-tasks: Display configuration plan
  - Tasks: Create 3 VLANs and assign ports
  - Verification: Run show vlan command
  - Post-tasks: Display summary results
- **VLAN Configuration:**
  - VLAN 100 (Production): Ports 1-20
  - VLAN 200 (Development): Ports 21-40
  - VLAN 300 (Management): Ports 41-48

#### 2. **procurve_vlan_config.yml** (Config Module Version)
- **Purpose:** Alternative using hpexcl_config module
- **Advantages:** Clean YAML hierarchy structure
- **Use Case:** Better for nested configuration management

#### 3. **procurve_vlan_config_raw.yml** (Raw Commands Version)
- **Purpose:** Direct CLI command execution
- **Advantages:** Better compatibility with older firmware versions
- **Special Features:** Includes `write memory` for persistent save

### Configuration Files

#### 4. **inventory.ini** (Ansible Inventory)
- **Purpose:** Host and connection configuration
- **Contains:**
  - Switch hostname and IP address
  - SSH credentials (user/password)
  - Connection parameters
  - Timeout settings
- **Fields to Customize:**
  - ansible_host (IP address)
  - ansible_user (SSH username)
  - ansible_password (SSH password)

### Setup Scripts

#### 5. **setup.sh** (Linux/Mac Setup)
- **Purpose:** Automated environment setup for Unix systems
- **Checks:**
  - Python 3 installation
  - Ansible installation
  - Ansible collections
  - Configuration files
- **Installs:** Dependencies from requirements.txt

#### 6. **setup.bat** (Windows Setup)
- **Purpose:** Automated environment setup for Windows
- **Equivalent functionality** to setup.sh
- **Includes:** All validation and installation steps

### Documentation Files

#### 7. **README.md** (Main Documentation)
- **Sections:**
  - Project overview
  - File descriptions
  - Prerequisites
  - Quick start guide
  - Detailed configuration steps
  - Troubleshooting guide
  - Security considerations
- **Length:** Comprehensive, ~400 lines

#### 8. **CONFIG_GUIDE.md** (Advanced Configuration Guide)
- **Sections:**
  - Device specifications
  - Configuration structure
  - Variable configuration
  - Connection setup details
  - Workflow diagrams
  - Advanced examples
  - Backup and recovery procedures
  - Performance considerations
  - Security best practices
  - Troubleshooting guide
- **Length:** Detailed, ~600 lines

#### 9. **QUICK_REFERENCE.md** (Command Reference)
- **Sections:**
  - Setup commands
  - Playbook execution commands
  - Validation commands
  - Direct SSH commands
  - Switch CLI commands
  - Common configuration tasks
  - Ansible quick commands
  - Troubleshooting commands
  - File editing notes
  - Backup and recovery commands
  - Windows-specific notes
- **Format:** Shell script with comments for easy copy-paste

### Dependency Management

#### 10. **requirements.txt** (Python Dependencies)
- **Contents:**
  - ansible>=2.9.0
  - jinja2>=2.11.0
  - paramiko>=2.7.0
  - netaddr>=0.7.18

## 🎯 VLAN Configuration Summary

```
HP ProCurve 3400cl (48 ports total)
├── VLAN 100 - Production
│   ├── ID: 100
│   ├── Name: Production
│   └── Ports: 1-20 (20 ports)
├── VLAN 200 - Development
│   ├── ID: 200
│   ├── Name: Development
│   └── Ports: 21-40 (20 ports)
└── VLAN 300 - Management
    ├── ID: 300
    ├── Name: Management
    └── Ports: 41-48 (8 ports)
```

## 🚀 Quick Start

### 1. Initial Setup (Choose your OS)

**Linux/Mac:**
```bash
cd network-lab-example
bash setup.sh
```

**Windows (PowerShell):**
```powershell
cd network-lab-example
.\setup.bat
```

### 2. Configure Inventory

Edit `inventory.ini` with your switch details:
```ini
ansible_host=YOUR_SWITCH_IP
ansible_user=YOUR_USERNAME
ansible_password=YOUR_PASSWORD
```

### 3. Run Configuration

```bash
ansible-playbook test.yml -i inventory.ini
```

### 4. Verify

```bash
ssh admin@YOUR_SWITCH_IP
show vlan
```

## 📚 Documentation Structure

```
network-lab-example/
├── README.md              ← Start here (basic setup)
├── CONFIG_GUIDE.md        ← Detailed configuration
├── QUICK_REFERENCE.md     ← Command reference
├── test.yml               ← Main playbook
├── procurve_vlan_config.yml
├── procurve_vlan_config_raw.yml
├── inventory.ini          ← Customize with your switch details
├── requirements.txt
├── setup.sh
└── setup.bat
```

## ✨ Key Features

✅ Three pre-configured playbooks (choose based on your needs)
✅ Complete documentation (800+ lines)
✅ Setup automation for both Linux and Windows
✅ Inventory template with clear instructions
✅ Comprehensive troubleshooting guides
✅ Advanced examples and configurations
✅ Security best practices included
✅ Backup and recovery procedures
✅ Performance optimization tips
✅ Support for multiple connection methods

## 🔧 Customization Examples

### Change VLAN Ports
Edit `test.yml` vars section:
```yaml
vlans:
  production:
    ports: "1-25"  # Instead of 1-20
```

### Add Another VLAN
Add to `vlans` dictionary in `test.yml`:
```yaml
vlan_400:
  id: 400
  name: "Security"
  ports: "24-48"
```

### Use SSH Keys Instead of Password
Edit `inventory.ini`:
```ini
ansible_ssh_private_key_file=~/.ssh/id_rsa
```

## 📊 Playbook Comparison

| Feature | test.yml | config.yml | raw.yml |
|---------|----------|------------|---------|
| Module Type | Config | Config | Command |
| Compatibility | Latest | Latest | All versions |
| Complexity | Medium | Low | Low |
| Output Clarity | High | High | Medium |
| Configuration Save | Automatic | Automatic | Manual (write memory) |
| Debugging | Easy | Easy | Moderate |

## 🛡️ Security Notes

- Default inventory uses passwords in plain text
- Recommended: Use SSH keys instead
- Recommended: Use Ansible vault for sensitive data
- Change default switch credentials after setup
- Enable SSH-only access (disable Telnet)

## 📞 Support Resources

### Included Documentation
- README.md - Basic setup and usage
- CONFIG_GUIDE.md - Detailed configuration reference
- QUICK_REFERENCE.md - Common commands
- Inline comments in playbooks

### External Resources
- [Ansible Network Documentation](https://docs.ansible.com/ansible/latest/network/)
- [HP ProCurve Documentation](https://support.hpe.com/)
- [Network VLAN Guide](https://en.wikipedia.org/wiki/Virtual_LAN)

## 📝 Workflow Examples

### Workflow 1: First-Time Setup
```
1. Extract files to work directory
2. Run setup script (setup.sh or setup.bat)
3. Edit inventory.ini with your switch IP and credentials
4. Test: ansible all -i inventory.ini -m ping
5. Deploy: ansible-playbook test.yml -i inventory.ini
6. Verify: SSH to switch and run 'show vlan'
```

### Workflow 2: Update Configuration
```
1. Edit test.yml (modify VLAN variables)
2. Run playbook: ansible-playbook test.yml -i inventory.ini
3. Review changes in output
4. Verify on switch: show vlan
5. Test connectivity from clients
```

### Workflow 3: Troubleshooting
```
1. Check connectivity: ping and SSH to switch
2. Run playbook with verbose: ansible-playbook test.yml -i inventory.ini -vvv
3. Review error messages carefully
4. Check switch logs: show log
5. If needed, restore: restore startup-config
```

## 🎓 Learning Path

1. **Beginners:** Start with README.md and test.yml
2. **Intermediate:** Read CONFIG_GUIDE.md for deeper understanding
3. **Advanced:** Customize playbooks using QUICK_REFERENCE.md examples

## ✅ Testing Checklist

- [ ] Python 3 installed
- [ ] Setup script ran without errors
- [ ] inventory.ini updated with correct IP/credentials
- [ ] Connectivity test passed: `ansible all -i inventory.ini -m ping`
- [ ] Playbook syntax check passed: `ansible-playbook test.yml --syntax-check`
- [ ] Playbook executed successfully: `ansible-playbook test.yml -i inventory.ini`
- [ ] VLANs visible on switch: `show vlan`
- [ ] Ports assigned correctly: `show vlan 100/200/300`
- [ ] Configuration saved: `show startup-config` (should show VLANs)

## 🔄 Version Information

- **Package Version:** 1.0
- **Created Date:** July 2026
- **Target Device:** HP ProCurve 3400cl
- **Minimum Ansible Version:** 2.9
- **Network OS:** hpexcl (HP ExCel/ProCurve)

## 📄 License

These playbooks and documentation are provided as educational and configuration examples for HP ProCurve 3400cl network switch management using Ansible automation.

---

**Ready to get started?** Begin with README.md and run setup.sh or setup.bat!
