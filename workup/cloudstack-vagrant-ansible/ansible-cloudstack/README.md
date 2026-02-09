# Apache CloudStack 4.22 - Ansible Automation

Automated deployment of **Apache CloudStack 4.22** on **Rocky Linux 9 (RHEL family)** and **Debian 12 / Ubuntu 22.04+**.

This project executes a **Full Stack Installation** on a single server (All-in-One) or multiple nodes, managing:
- **Database:** MySQL 8.0 (Tuned for CloudStack)
- **Filesystem:** NFS Server for Primary and Secondary Storage (Optional, enabled by default)
- **Management:** CloudStack Management Server 4.22
- **Hypervisor:** KVM Agent with Libvirt (Systemd Socket Activation optimized)
- **Network:** Automatic configuration of `cloudbr0` bridge
- **Firewall:** Automatic port opening (Firewalld for RHEL / UFW for Debian)

---

## 📋 Prerequisites

- **Target OS:** Rocky Linux 9 (Validated), Debian 12, or Ubuntu 22.04+
- **Connectivity:** Target host must have Internet access.
- **Ansible:** Installed on the control machine (`sudo dnf install ansible` or `pip install ansible`).
- **Hardware:** Minimum 4GB RAM, 2 vCPUs, 50GB Disk (for a minimal All-in-One setup).

---

## 🚀 Installation Guide

### 1. Configure Inventory
Edit the `inventory` file to define your target server. Replace `<host ip>` with your server's actual IP address:

```ini
[cloudstack_management]
<host ip> ansible_user=root ansible_become_password=your_password

[cloudstack_kvm]
<host ip> ansible_user=root ansible_become_password=your_password

[cloudstack:children]
cloudstack_management
cloudstack_kvm
```

### 2. Customize Variables
Edit `group_vars/all.yml` to match your network environment.

**File:** `group_vars/all.yml`
```yaml
# Network Configuration
management_server_ip: "{{ groups['cloudstack_management'][0] }}" # Automatically picks the first IP from inventory
utility_server_ip: "{{ groups['cloudstack_management'][0] }}"
gateway: "<network gateway>"          # Ex: 10.0.0.1
dns1: "8.8.8.8"                       # Primary DNS
dns2: "8.8.4.4"                       # Secondary DNS

# CloudStack Paths (Where VMs and Templates will be stored)
secondary_storage_path: "/export/secondary"
primary_storage_path: "/export/primary"

# NFS Server Toggle
# Set to 'true' to install NFS on the Management Server (All-in-One)
# Set to 'false' if using external storage (TrueNAS, NetApp, etc.)
enable_nfs_server: true 
nfs_exports_file: "/etc/exports"

# Database Passwords
mysql_root_password: "password"       # Password for MySQL root user
mysql_cloud_password: "password"      # Password for 'cloud' DB user
```

### 3. Run Installation
Execute the playbook to start the installation:

```bash
ansible-playbook -i inventory cloudstack-install.yml
```

**The playbook performs the following actions:**
1.  **System Prep:** Installs EPEL/Repo, basic utils, enables SELinux (Permissive), configures Hostname.
2.  **Network:** Creates `cloudbr0` bridge safely (preserves connectivity).
3.  **Firewall:** Opens necessary ports (8080, 2049, 111, 5900-6100).
4.  **MySQL:** Installs MySQL 8, tuning for CloudStack, creates users.
5.  **Management Server:** Installs CloudStack, initializes DB (with encryption fix), downloads SystemVM Template.
6.  **KVM Agent:** Installs QEMU/Libvirt, configures socket activation (unmasks sockets if needed), connects to Management Server.

---

## ☁️ Zone Configuration (Post-Install)

Once the playbook finishes successfully, the CloudStack UI will be accessible at:
*   **URL:** `http://<host ip>:8080/client`
*   **Login:** `admin`
*   **Password:** `password`

📄 **Follow the Zone Setup Guide:**
Refer to the file [`ZONE_SETUP.md`](./ZONE_SETUP.md) included in this repository for a step-by-step guide on configuring the Basic Zone (Network, Pods, Storage) via the UI.

---

## 🧹 Uninstallation (Purge)

To reset the environment completely (e.g., for a fresh reinstall), run the purge playbook:

```bash
ansible-playbook -i inventory purge.yml
```

**⚠️ Safety Features:**
- **Network Preserved:** Does NOT remove `cloudbr0` to prevent SSH lockout.
- **Data Cleanup:** Removes databases, configs, logs, and package caches.

---

## 🛠️ Key Technical Fixes Included

This project includes advanced fixes for known issues in CloudStack 4.22 + RHEL 9:

### 1. HTTP 503 "Service Unavailable"
- **Problem:** `NoSuchBeanDefinitionException` on startup due to DB encryption mismatch.
- **Fix:** Forces `cloudstack-setup-databases` to use `-e file` flag.

### 2. Libvirt Socket Masking (Rocky 9)
- **Problem:** `libvirtd-tcp.socket` fails to enable because `libvirtd.socket` is masked by default.
- **Fix:** Explicitly unmasks both sockets before activation in `roles/cloudstack_agent`.

### 3. NFS Firewall Blocking
- **Problem:** SSVM cannot mount Secondary Storage because Host Firewall blocks NFS.
- **Fix:** `nfs_server` role explicitly enables `nfs`, `mountd`, and `rpc-bind` in Firewalld (RHEL) and UFW (Debian).

### 4. SSH Lockout on Network Change
- **Problem:** Configuring bridges remotely drops SSH.
- **Fix:** Network role checks existence of `cloudbr0` before modification (Idempotent).

---

## 📂 Project Structure

```text
├── ansible.cfg          # SSH optimizations
├── inventory            # Server list
├── cloudstack-install.yml             # Main Installation Playbook
├── purge.yml            # Cleanup Playbook
├── ZONE_SETUP.md        # UI Configuration Guide
├── group_vars/
│   └── all.yml          # Global Settings
└── roles/
    ├── common/          # OS Prep, Repo, Utils
    ├── network_bridge/  # Bridge Config
    ├── nfs_server/      # NFS & Firewall Rules
    ├── mysql/           # Database
    ├── cloudstack_mgmt/ # Management Server
    └── cloudstack_agent/# KVM Hypervisor & Libvirt
```
