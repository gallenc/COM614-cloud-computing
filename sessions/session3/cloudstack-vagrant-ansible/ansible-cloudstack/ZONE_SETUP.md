# CloudStack Zone Configuration Guide (UI)

This guide details how to configure the Basic Zone in CloudStack 4.22 using the Wizard.

## 1. Login
- **URL:** `http://10.0.30.251:8080/client`
- **User:** `admin`
- **Password:** `password`
- **Action:** Select "Continue with Basic Setup" (or specific Zone Wizard).

## 2. Zone Details
- **Name:** `Zone1`
- **DNS 1:** `8.8.8.8`
- **DNS 2:** `8.8.4.4`
- **Hypervisor:** `KVM`

## 3. Physical Network
- **Network Name:** `cloudbr0` (or `ManagmentNetwork`)
- **Traffic Type:** Management + Guest + Public

## 4. Public Traffic (New Step)
- **Gateway:** `10.0.30.1`
- **Netmask:** `255.255.255.0`
- **VLAN:** (Leave empty)
- **Start IP:** `10.0.30.110`
- **End IP:** `10.0.30.140`

## 5. Pod Configuration
- **Name:** `Pod1`
- **Gateway:** `10.0.30.1`
- **Netmask:** `255.255.255.0`
- **Start IP:** `10.0.30.200` (For System VMs)
- **End IP:** `10.0.30.210`

## 6. Storage Traffic
- **Gateway:** `10.0.30.1`
- **Netmask:** `255.255.255.0`
- **VLAN:** (Leave empty for same network, or specify if using dedicated storage network)
- **Start IP:** `10.0.30.141`
- **End IP:** `10.0.30.160`
- **Note:** In production, storage traffic should be on a dedicated network/VLAN for better performance

## 7. Guest Traffic
- **Gateway:** `10.0.30.1`
- **Netmask:** `255.255.255.0`
- **Start IP:** `10.0.30.50`
- **End IP:** `10.0.30.100`

## 8. Cluster
- **Name:** `Cluster1`

## 9. Host
- **Host Name:** `10.0.30.251`
- **User:** `root`
- **Password:** `password` (or your ssh key setup)

## 10. Primary Storage
- **Name:** `Primary1`
- **Protocol:** `nfs`
- **Server:** `10.0.30.251`
- **Path:** `/home/storage/primary`

## 11. Secondary Storage
- **Provider:** `NFS`
- **Server:** `10.0.30.251`
- **Path:** `/home/storage/secondary`

## 12. Launch
- Click "Launch Zone".
- Wait for all steps to turn Green.
- If "System VM Template" is missing, wait for it to download (check Management logs).
