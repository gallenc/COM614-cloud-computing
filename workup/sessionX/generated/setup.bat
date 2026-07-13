@echo off
REM Setup script for HP ProCurve 3400cl Ansible Configuration (Windows)
REM This script sets up dependencies and validates the environment

echo ========================================
echo HP ProCurve 3400cl Setup Script (Windows)
echo ========================================
echo.

REM Check if Python is installed
echo 1. Checking Python installation...
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python is not installed or not in PATH
    pause
    exit /b 1
)
echo    ✓ Python found:
python --version
echo.

REM Install Python dependencies
echo 2. Installing Python dependencies...
pip install -r requirements.txt
if errorlevel 1 (
    echo ERROR: Failed to install dependencies
    pause
    exit /b 1
)
echo    ✓ Dependencies installed
echo.

REM Check Ansible installation
echo 3. Verifying Ansible installation...
ansible --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Ansible is not installed
    pause
    exit /b 1
)
echo    ✓ Ansible found:
ansible --version
echo.

REM Install Ansible collections
echo 4. Installing Ansible collections...
ansible-galaxy collection install community.network --upgrade
if errorlevel 1 (
    echo WARNING: Failed to install collections, but continuing...
)
echo    ✓ Collections installed
echo.

REM Validate inventory file
echo 5. Validating configuration files...
if not exist inventory.ini (
    echo ERROR: inventory.ini not found
    pause
    exit /b 1
)
echo    ✓ inventory.ini exists

if not exist test.yml (
    echo ERROR: test.yml not found
    pause
    exit /b 1
)
echo    ✓ test.yml exists
echo.

REM Display next steps
echo ========================================
echo Setup Complete!
echo ========================================
echo.
echo Next steps:
echo 1. Edit inventory.ini with your switch IP and credentials
echo 2. Test connectivity: ansible all -i inventory.ini -m ping
echo 3. Run playbook: ansible-playbook test.yml -i inventory.ini
echo.
echo For more information, see README.md
echo.
pause
