#!/bin/bash
# Setup script for HP ProCurve 3400cl Ansible Configuration
# This script sets up dependencies and validates the environment

set -e

echo "========================================"
echo "HP ProCurve 3400cl Setup Script"
echo "========================================"
echo ""

# Check if Python is installed
echo "1. Checking Python installation..."
if ! command -v python3 &> /dev/null; then
    echo "ERROR: Python 3 is not installed"
    exit 1
fi
echo "   ✓ Python 3 found: $(python3 --version)"
echo ""

# Install Python dependencies
echo "2. Installing Python dependencies..."
pip3 install -r requirements.txt
echo "   ✓ Dependencies installed"
echo ""

# Check Ansible installation
echo "3. Verifying Ansible installation..."
if ! command -v ansible &> /dev/null; then
    echo "ERROR: Ansible is not installed"
    exit 1
fi
echo "   ✓ Ansible found: $(ansible --version | head -n1)"
echo ""

# Install Ansible collections
echo "4. Installing Ansible collections..."
ansible-galaxy collection install community.network --upgrade
echo "   ✓ Collections installed"
echo ""

# Validate inventory file
echo "5. Validating configuration files..."
if [ ! -f "inventory.ini" ]; then
    echo "ERROR: inventory.ini not found"
    exit 1
fi
echo "   ✓ inventory.ini exists"

if [ ! -f "test.yml" ]; then
    echo "ERROR: test.yml not found"
    exit 1
fi
echo "   ✓ test.yml exists"
echo ""

# Display next steps
echo "========================================"
echo "Setup Complete!"
echo "========================================"
echo ""
echo "Next steps:"
echo "1. Edit inventory.ini with your switch IP and credentials"
echo "2. Test connectivity: ansible all -i inventory.ini -m ping"
echo "3. Run playbook: ansible-playbook test.yml -i inventory.ini"
echo ""
echo "For more information, see README.md"
echo ""
