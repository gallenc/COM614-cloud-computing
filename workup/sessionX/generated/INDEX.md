# HP ProCurve 3400cl Ansible Configuration - Complete Package

## 📦 Package Contents

### 🎯 Main Playbooks (Choose One)
```
test.yml                      ← RECOMMENDED - Main configuration with detailed output
procurve_vlan_config.yml      - Alternative using config module
procurve_vlan_config_raw.yml  - Alternative using raw CLI commands
```

### ⚙️ Configuration & Setup
```
inventory.ini                 ← EDIT THIS with your switch IP and credentials
requirements.txt              - Python package dependencies
setup.sh                      - Linux/Mac automated setup
setup.bat                     - Windows automated setup
run.ps1                       - Windows interactive menu (PowerShell)
```

### 📚 Documentation
```
README.md                     - START HERE: Basic setup and usage guide
CONFIG_GUIDE.md               - Advanced configuration reference
QUICK_REFERENCE.md            - Common commands quick lookup
PROJECT_SUMMARY.md            - Complete project overview
INDEX.md                      - This file
```

## 🚀 Quick Start (3 Steps)

### Step 1: Setup Environment
```powershell
# Windows (PowerShell)
.\setup.bat

# Linux/Mac (Bash)
bash setup.sh
```

### Step 2: Configure Inventory
Edit `inventory.ini` and replace:
- `192.168.1.254` → Your switch IP
- `admin` → Your SSH username
- `password` → Your SSH password

### Step 3: Run Playbook
```bash
ansible-playbook test.yml -i inventory.ini
```

## 📖 Documentation Guide

| Document | Purpose | Read When |
|----------|---------|-----------|
| **README.md** | Complete setup guide | Getting started |
| **CONFIG_GUIDE.md** | Detailed technical reference | Need detailed info |
| **QUICK_REFERENCE.md** | Copy-paste command examples | Need quick commands |
| **PROJECT_SUMMARY.md** | Project overview and features | Understanding structure |
| **INDEX.md** | This file - navigation guide | Finding things |

## 🎯 VLAN Configuration

```
Port Distribution (48 total ports):
┌─────────────────────────────────────┐
│ VLAN 100 - Production               │
│ Ports: 1-20 (20 ports)              │
└─────────────────────────────────────┘
┌─────────────────────────────────────┐
│ VLAN 200 - Development              │
│ Ports: 21-40 (20 ports)             │
└─────────────────────────────────────┘
┌─────────────────────────────────────┐
│ VLAN 300 - Management               │
│ Ports: 41-48 (8 ports)              │
└─────────────────────────────────────┘
```

## 🔧 File Descriptions

### Playbooks

**test.yml** (RECOMMENDED)
- Primary playbook with all features
- Includes pre-tasks, main tasks, post-tasks
- Displays plan, configures, verifies
- Best for first-time users
- Usage: `ansible-playbook test.yml -i inventory.ini`

**procurve_vlan_config.yml**
- Uses hpexcl_config module
- Cleaner YAML structure
- Good for configuration hierarchy
- Usage: `ansible-playbook procurve_vlan_config.yml -i inventory.ini`

**procurve_vlan_config_raw.yml**
- Direct CLI commands
- Best compatibility with old firmware
- Includes save to memory
- Usage: `ansible-playbook procurve_vlan_config_raw.yml -i inventory.ini`

### Configuration Files

**inventory.ini**
- Define switch host and connection details
- Must edit before running playbooks
- Contains:
  - ansible_host (switch IP)
  - ansible_user (SSH username)
  - ansible_password (SSH password)
  - Connection timeouts

**requirements.txt**
- Python package dependencies
- Install with: `pip install -r requirements.txt`
- Contains: ansible, jinja2, paramiko, netaddr

### Setup Scripts

**setup.sh** (Linux/Mac)
- Automated dependency installation
- Validates environment
- Installs Ansible collections
- Run: `bash setup.sh`

**setup.bat** (Windows CMD)
- Windows batch equivalent of setup.sh
- Same functionality as setup.sh
- Run: `setup.bat`

**run.ps1** (Windows PowerShell)
- Interactive menu system
- Multiple operation options:
  1. Test connectivity
  2. Test Ansible connectivity
  3. Preview playbook
  4. Dry-run configuration
  5. Execute configuration
  6. Verify results
  7. View documentation
- Run: `.\run.ps1`

### Documentation

**README.md** (400+ lines)
- Complete getting started guide
- Prerequisites and setup
- Execution instructions
- Troubleshooting section
- Security considerations

**CONFIG_GUIDE.md** (600+ lines)
- Device specifications
- Configuration structure details
- Variable explanations
- Advanced examples
- Workflows and procedures
- Performance optimization
- Backup and recovery

**QUICK_REFERENCE.md**
- Copy-paste ready commands
- Setup commands
- Playbook execution
- Validation commands
- SSH/CLI commands
- Ansible ad-hoc commands
- Troubleshooting commands

**PROJECT_SUMMARY.md**
- Project overview
- File descriptions
- Feature list
- Customization examples
- Version information

## 💻 Platform Support

| Platform | Setup Script | Run Script | Works |
|----------|--------------|-----------|-------|
| Windows (PowerShell) | setup.bat | run.ps1 | ✅ Yes |
| Windows (CMD) | setup.bat | - | ✅ Yes |
| Linux | setup.sh | Manual | ✅ Yes |
| macOS | setup.sh | Manual | ✅ Yes |

## 🔐 Security Checklist

- [ ] Changed switch admin password
- [ ] Using SSH keys instead of password (optional but recommended)
- [ ] Inventory file not in public repository
- [ ] SSH-only access enabled on switch
- [ ] Telnet disabled on switch
- [ ] Configuration backup taken

## ✅ Pre-Execution Checklist

- [ ] Ansible installed (`ansible --version`)
- [ ] Switch IP address known
- [ ] SSH credentials available
- [ ] Network connectivity confirmed (ping switch)
- [ ] inventory.ini edited with correct details
- [ ] No critical network traffic (non-production environment recommended)
- [ ] Current configuration backed up

## 🎬 Execution Workflows

### Workflow 1: Windows with GUI Menu
```powershell
.\run.ps1
# Select option 5 to execute
```

### Workflow 2: Windows with Commands
```powershell
.\setup.bat
# Edit inventory.ini
ansible-playbook test.yml -i inventory.ini
```

### Workflow 3: Linux/Mac
```bash
bash setup.sh
# Edit inventory.ini
ansible-playbook test.yml -i inventory.ini
```

### Workflow 4: Dry-Run First (Safe!)
```bash
# Preview changes without making them
ansible-playbook test.yml -i inventory.ini --check -v
```

## 🚨 Troubleshooting Quick Links

| Issue | Solution |
|-------|----------|
| Python not found | Install Python 3 |
| Ansible not found | Run setup script or `pip install ansible` |
| Connection refused | Check switch IP in inventory.ini |
| Authentication failed | Verify username/password in inventory.ini |
| Module not found | Run `ansible-galaxy collection install community.network` |
| Command timeout | Increase timeout in inventory.ini |
| VLAN already exists | Playbook will skip (safe to re-run) |

## 📊 Feature Comparison Table

| Feature | Included |
|---------|----------|
| VLAN configuration | ✅ Yes (3 VLANs) |
| Port assignment | ✅ Yes (untagged ports) |
| Configuration verification | ✅ Yes (show vlan) |
| Backup/recovery guide | ✅ Yes |
| Security guide | ✅ Yes |
| Windows support | ✅ Yes |
| Linux/Mac support | ✅ Yes |
| Interactive menu | ✅ Yes (PowerShell) |
| Dry-run capability | ✅ Yes |
| Detailed documentation | ✅ Yes (1000+ lines) |
| Multiple playbook versions | ✅ Yes (3 versions) |

## 🔄 Common Tasks

### View VLAN Configuration
```bash
ssh admin@YOUR_SWITCH_IP
show vlan
```

### Add More Ports to VLAN
Edit test.yml:
```yaml
ports: "1-25"  # Instead of 1-20
```

### Create Additional VLAN
Add to vlans section in test.yml:
```yaml
vlan_400:
  id: 400
  name: "NewVLAN"
  ports: "48"
```

### Update Switch Credentials
1. SSH to switch manually
2. Change password with `password` command
3. Update inventory.ini

## 📞 Getting Help

### For Setup Issues
→ See README.md section "Prerequisites"

### For Configuration Issues
→ See CONFIG_GUIDE.md section "Troubleshooting Common Issues"

### For Command Examples
→ See QUICK_REFERENCE.md

### For Understanding Features
→ See PROJECT_SUMMARY.md

### For Using Playbooks
→ See this INDEX.md or run.ps1 interactive menu

## 🎓 Learning Path

1. **Start:** README.md (basic overview)
2. **Setup:** Run setup.sh or setup.bat
3. **Configure:** Edit inventory.ini
4. **Execute:** Run test.yml playbook
5. **Verify:** SSH to switch and check
6. **Learn More:** Read CONFIG_GUIDE.md for advanced topics

## 📦 File Organization

```
network-lab-example/
├── [PLAYBOOKS]
│   ├── test.yml                    (recommended)
│   ├── procurve_vlan_config.yml
│   └── procurve_vlan_config_raw.yml
├── [CONFIGURATION]
│   ├── inventory.ini               (EDIT THIS!)
│   ├── requirements.txt
│   ├── setup.sh
│   ├── setup.bat
│   └── run.ps1
├── [DOCUMENTATION]
│   ├── INDEX.md                    (you are here)
│   ├── README.md                   (start here)
│   ├── CONFIG_GUIDE.md
│   ├── QUICK_REFERENCE.md
│   └── PROJECT_SUMMARY.md
└── [OTHER]
    └── docker-compose-services/
```

## ⚡ Quick Commands Reference

```bash
# Setup
pip install -r requirements.txt
ansible-galaxy collection install community.network

# Test
ansible all -i inventory.ini -m ping
ansible-playbook test.yml -i inventory.ini --syntax-check

# Preview (safe)
ansible-playbook test.yml -i inventory.ini --check -v

# Execute
ansible-playbook test.yml -i inventory.ini

# Verify
ssh admin@SWITCH_IP
show vlan
```

## 📋 Version Information

- **Package Version:** 1.0
- **Target Device:** HP ProCurve 3400cl
- **Minimum Ansible:** 2.9
- **Python Version:** 3.6+
- **Created:** July 2026

## 🎉 Next Steps

1. **Read:** README.md (5-10 minutes)
2. **Setup:** Run setup script (2-5 minutes)
3. **Configure:** Edit inventory.ini (1-2 minutes)
4. **Execute:** Run playbook (1-2 minutes)
5. **Verify:** SSH to switch (2-3 minutes)

**Total Time: ~15-25 minutes**

---

**Questions?** Check the relevant documentation file or review QUICK_REFERENCE.md for examples.

**Ready?** Start with README.md or run `.\run.ps1` for interactive menu on Windows!
