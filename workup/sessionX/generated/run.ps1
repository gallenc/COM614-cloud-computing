# HP ProCurve 3400cl Ansible Configuration - Getting Started Guide
#
# This PowerShell script helps Windows users get started quickly
# Usage: .\run.ps1

Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  HP ProCurve 3400cl VLAN Configuration with Ansible           ║" -ForegroundColor Cyan
Write-Host "║  Quick Start Guide for Windows                               ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Check if setup has been run
$setupNeeded = $false
if (-not (Get-Command ansible -ErrorAction SilentlyContinue)) {
    Write-Host "⚠️  Ansible not found. Running setup first..." -ForegroundColor Yellow
    $setupNeeded = $true
}

# Run setup if needed
if ($setupNeeded) {
    Write-Host "Running setup.bat..." -ForegroundColor Green
    & ".\setup.bat"
    Write-Host ""
}

# Check inventory file
if (-not (Test-Path "inventory.ini")) {
    Write-Host "❌ ERROR: inventory.ini not found!" -ForegroundColor Red
    Write-Host "Please ensure inventory.ini exists in the current directory."
    exit 1
}

# Display menu
Write-Host "Select an option:" -ForegroundColor Cyan
Write-Host ""
Write-Host "1. Test connectivity to switch (ping)" -ForegroundColor White
Write-Host "2. Test Ansible connectivity to switch" -ForegroundColor White
Write-Host "3. Preview playbook (syntax check only)" -ForegroundColor White
Write-Host "4. Dry-run playbook (check mode)" -ForegroundColor White
Write-Host "5. Execute playbook (configure VLANs)" -ForegroundColor White
Write-Host "6. Verify configuration (show vlan)" -ForegroundColor White
Write-Host "7. View quick reference" -ForegroundColor White
Write-Host "8. View full documentation" -ForegroundColor White
Write-Host "9. Exit" -ForegroundColor White
Write-Host ""

$choice = Read-Host "Enter choice (1-9)"

switch ($choice) {
    "1" {
        Write-Host ""
        Write-Host "Testing network connectivity..." -ForegroundColor Green
        # Get switch IP from inventory
        $switchIP = (Select-String -Path "inventory.ini" -Pattern "ansible_host=(.+)" | ForEach-Object { $_.Matches[0].Groups[1].Value }) | Select-Object -First 1
        
        if ($switchIP) {
            Write-Host "Pinging $switchIP..." -ForegroundColor Cyan
            ping $switchIP
        } else {
            Write-Host "Could not find switch IP in inventory.ini" -ForegroundColor Red
        }
    }
    
    "2" {
        Write-Host ""
        Write-Host "Testing Ansible connectivity to switch..." -ForegroundColor Green
        Write-Host "Command: ansible all -i inventory.ini -m ping" -ForegroundColor Cyan
        Write-Host ""
        & ansible all -i inventory.ini -m ping
    }
    
    "3" {
        Write-Host ""
        Write-Host "Running syntax check on playbook..." -ForegroundColor Green
        Write-Host "Command: ansible-playbook test.yml -i inventory.ini --syntax-check" -ForegroundColor Cyan
        Write-Host ""
        & ansible-playbook test.yml -i inventory.ini --syntax-check
    }
    
    "4" {
        Write-Host ""
        Write-Host "Running playbook in check mode (dry-run)..." -ForegroundColor Yellow
        Write-Host "Command: ansible-playbook test.yml -i inventory.ini --check -v" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "NOTE: This shows what WOULD be changed without actually changing anything." -ForegroundColor Yellow
        Write-Host ""
        & ansible-playbook test.yml -i inventory.ini --check -v
    }
    
    "5" {
        Write-Host ""
        Write-Host "⚠️  WARNING: This will configure VLANs on your switch!" -ForegroundColor Yellow
        Write-Host ""
        $confirm = Read-Host "Are you sure? (type 'yes' to continue)"
        
        if ($confirm -eq "yes") {
            Write-Host ""
            Write-Host "Executing playbook..." -ForegroundColor Green
            Write-Host "Command: ansible-playbook test.yml -i inventory.ini" -ForegroundColor Cyan
            Write-Host ""
            & ansible-playbook test.yml -i inventory.ini
            
            if ($LASTEXITCODE -eq 0) {
                Write-Host ""
                Write-Host "✅ Configuration completed successfully!" -ForegroundColor Green
                Write-Host "Next step: SSH to your switch and run 'show vlan' to verify." -ForegroundColor Cyan
            } else {
                Write-Host ""
                Write-Host "❌ Playbook execution failed. Check the output above for errors." -ForegroundColor Red
            }
        } else {
            Write-Host "Configuration cancelled." -ForegroundColor Yellow
        }
    }
    
    "6" {
        Write-Host ""
        Write-Host "To verify the configuration, SSH to your switch:" -ForegroundColor Green
        Write-Host ""
        
        # Get switch IP from inventory
        $switchIP = (Select-String -Path "inventory.ini" -Pattern "ansible_host=(.+)" | ForEach-Object { $_.Matches[0].Groups[1].Value }) | Select-Object -First 1
        $switchUser = (Select-String -Path "inventory.ini" -Pattern "ansible_user=(.+)" | ForEach-Object { $_.Matches[0].Groups[1].Value }) | Select-Object -First 1
        
        if ($switchIP -and $switchUser) {
            Write-Host "Command: ssh $switchUser@$switchIP" -ForegroundColor Cyan
            Write-Host ""
            Write-Host "Then on the switch, run:" -ForegroundColor Cyan
            Write-Host "HP3400cl# show vlan" -ForegroundColor White
            Write-Host ""
            Write-Host "You should see:" -ForegroundColor Cyan
            Write-Host "  VLAN 100 'Production' with ports 1-20" -ForegroundColor White
            Write-Host "  VLAN 200 'Development' with ports 21-40" -ForegroundColor White
            Write-Host "  VLAN 300 'Management' with ports 41-48" -ForegroundColor White
        } else {
            Write-Host "Could not find switch details in inventory.ini" -ForegroundColor Red
        }
    }
    
    "7" {
        Write-Host ""
        Write-Host "Opening QUICK_REFERENCE.md in default text editor..." -ForegroundColor Green
        if (Test-Path "QUICK_REFERENCE.md") {
            & notepad QUICK_REFERENCE.md
        } else {
            Write-Host "❌ QUICK_REFERENCE.md not found!" -ForegroundColor Red
        }
    }
    
    "8" {
        Write-Host ""
        Write-Host "Available documentation:" -ForegroundColor Green
        Write-Host ""
        Write-Host "1. README.md - Basic setup and usage" -ForegroundColor Cyan
        Write-Host "2. CONFIG_GUIDE.md - Detailed configuration guide" -ForegroundColor Cyan
        Write-Host "3. QUICK_REFERENCE.md - Command reference" -ForegroundColor Cyan
        Write-Host "4. PROJECT_SUMMARY.md - Project overview" -ForegroundColor Cyan
        Write-Host ""
        
        $docChoice = Read-Host "Which documentation to view? (1-4)"
        
        $docMap = @{
            "1" = "README.md"
            "2" = "CONFIG_GUIDE.md"
            "3" = "QUICK_REFERENCE.md"
            "4" = "PROJECT_SUMMARY.md"
        }
        
        if ($docMap[$docChoice]) {
            $docFile = $docMap[$docChoice]
            Write-Host "Opening $docFile..." -ForegroundColor Green
            & notepad $docFile
        }
    }
    
    "9" {
        Write-Host ""
        Write-Host "Exiting..." -ForegroundColor Yellow
        exit 0
    }
    
    default {
        Write-Host ""
        Write-Host "Invalid choice. Please try again." -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Done!" -ForegroundColor Green
