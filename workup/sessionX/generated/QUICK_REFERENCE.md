#!/bin/bash
# HP ProCurve 3400cl Quick Reference Commands
# This file contains common Ansible and ProCurve commands for quick reference

# ==========================================
# SETUP COMMANDS
# ==========================================

# Install dependencies (Linux/Mac)
pip3 install -r requirements.txt

# Install dependencies (Windows)
pip install -r requirements.txt

# Install Ansible collections
ansible-galaxy collection install community.network

# ==========================================
# PLAYBOOK EXECUTION COMMANDS
# ==========================================

# Run main VLAN configuration
ansible-playbook test.yml -i inventory.ini

# Run with verbose output (helpful for debugging)
ansible-playbook test.yml -i inventory.ini -v

# Run with extra verbose output (most detailed)
ansible-playbook test.yml -i inventory.ini -vvv

# Run raw command version (for older firmware)
ansible-playbook procurve_vlan_config_raw.yml -i inventory.ini

# Run config module version
ansible-playbook procurve_vlan_config.yml -i inventory.ini

# ==========================================
# VALIDATION COMMANDS
# ==========================================

# Test connectivity to switch
ansible all -i inventory.ini -m ping

# Test with network_cli connection
ansible all -i inventory.ini -c network_cli -m hpexcl_command -a "commands='show system'"

# Run command and capture output
ansible-playbook test.yml -i inventory.ini -e "ansible_verbosity=1"

# ==========================================
# DIRECT SSH COMMANDS (Run on your workstation)
# ==========================================

# SSH to switch
ssh admin@192.168.1.254

# SCP file to switch
scp test_config.txt admin@192.168.1.254:/

# ==========================================
# SWITCH CLI COMMANDS (Run after SSH to switch)
# ==========================================

# Show VLAN configuration
show vlan

# Show specific VLAN
show vlan 100

# Show port configuration
show port-config

# Show running configuration
show running-config

# Show interface statistics
show interface

# Show interface status
show interfaces status

# Check system information
show system

# Show all VLANs with details
show vlan detailed

# Show port membership
show vlan-membership

# Exit configuration mode
exit

# Save configuration to memory
write memory

# ==========================================
# COMMON CONFIGURATION TASKS
# ==========================================

# Add a new VLAN (in SSH)
vlan 400
name Management-New
untagged 48
exit

# Remove a VLAN
no vlan 400

# Add port to existing VLAN (in VLAN config mode)
vlan 100
untagged 21
exit

# Remove port from VLAN
vlan 100
no untagged 21
exit

# Set port as tagged in VLAN
vlan 100
tagged 48
exit

# Create a port-based VLAN
vlan 500
name PortBased
untagged 1-10
tagged 24
exit

# ==========================================
# ANSIBLE-SPECIFIC QUICK COMMANDS
# ==========================================

# List all hosts in inventory
ansible-inventory -i inventory.ini --list

# Show host variables
ansible-inventory -i inventory.ini --host procurve_3400cl

# Run ad-hoc command on switch
ansible procurve_3400cl -i inventory.ini -m hpexcl_command -a "commands='show vlan'"

# Run playbook with specific tags (if tags are defined)
ansible-playbook test.yml -i inventory.ini -t vlan-creation

# Dry-run mode (check mode - doesn't make changes)
ansible-playbook test.yml -i inventory.ini --check

# Skip specific tasks
ansible-playbook test.yml -i inventory.ini --skip-tags "verification"

# ==========================================
# TROUBLESHOOTING COMMANDS
# ==========================================

# Test SSH connectivity
ssh -v admin@192.168.1.254

# Test network connectivity
ping 192.168.1.254

# Check if port is open
telnet 192.168.1.254 22

# List Ansible facts
ansible procurve_3400cl -i inventory.ini -m setup

# Run playbook with extra debugging
ansible-playbook test.yml -i inventory.ini -vvvv

# Check syntax of playbook
ansible-playbook test.yml -i inventory.ini --syntax-check

# Display what would be executed (dry-run)
ansible-playbook test.yml -i inventory.ini --check -v

# ==========================================
# FILE EDITING NOTES
# ==========================================

# Edit inventory file with your switch details
# nano inventory.ini (or use your preferred editor)
# Required changes:
#   - ansible_host: IP address of your switch
#   - ansible_user: SSH username
#   - ansible_password: SSH password

# To update VLAN configuration:
# 1. Edit test.yml
# 2. Modify the vlans dictionary section
# 3. Run: ansible-playbook test.yml -i inventory.ini

# ==========================================
# BACKUP AND RECOVERY
# ==========================================

# Backup running config (from switch via SSH)
show running-config > config_backup.txt

# Backup running config via Ansible
ansible procurve_3400cl -i inventory.ini -m hpexcl_command -a "commands='show running-config'" > config_backup.txt

# View backup
cat config_backup.txt

# ==========================================
# NOTES FOR WINDOWS USERS
# ==========================================

# Run setup script first:
setup.bat

# Then use these commands in PowerShell:
# ansible-playbook test.yml -i inventory.ini

# If you get execution policy errors, run:
# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
