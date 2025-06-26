# SETUP
## Generic Instructions
Legacy ones may need some extra tweaking*
### VM Creation
**General**
- Node: zirconium
- Resource Pool: admin
- VM VMID: 11XX
- Name: win-serverXXXX
- Tags: template

**OS**
- CD/DVD iso: bac -> XXXX.ISO
- Guest OS: OS_TYPE -> XX/XX/XX
- Additional drive for VirtIO: bac -> virtioX.X.X.iso (0.1.271 for new; 2016+)

**System**
- Graphic card: Default
- SCSI Controller: VirtIO SCSI signle
- Machine: i440fx for old, q35 for new (2016+)
- BIOS: BIOS for old UEFI for new (2016+)
- EFI DISK: bac -> QEMU image format (qcow2)

**Disks**
- Bus/Device: SCSI0
- Storage: bac
- Disk Size (GiB): 32
- Format: QEMU image format (qcow2)

**CPU**
- Sockets: 1
- Cores: 4
- Type: x86-64-v2-AES

**Memory**
- Memory (MiB): 8192

**Network**
- Model: VirtIO (paravirtualized)
### Installation
1. Start machine, press any key to boot from CD/DVD
2. Start installer, standard + desktop
3. Load virtio scsi driver, install onto disk
### Setup
1. Create Administrator password `m0Nk3y!m0Nk3y!` and sign in
2. Install virtio guest drivers `virtio-win-guest-tools.exe`
3. Enable RDP (No NLA, set in GUI)
4. Create `ansible` user (Administrators group + never expire) (Make in GUI, set description: `DO NOT RESET PASSWORD`)
5. Enable winrm (`winrm quickconfig -force`)
6. Install firefox `https://www.mozilla.org/en-US/firefox/download/thanks/` OR copy installer via rdp etc.
- Run windows updates and reboot as many times as needed.
7. Shutdown (Remove Install media + Driver CDs, add + configure cloudinit CD, enable QEMU Guest Agent)
8. Install cloudbase-init (`https://cloudbase.it/downloads/CloudbaseInitSetup_x64.msi`, Administrator, Use Metadata PW, LocalSystem, NO SYSPREP)
9. Move & Run script FixUserService.ps1 (see file)
10. Configure cloudbase-init config (conf/\*.conf, conf/Unattend.xml, localscripts/\*.py; see files)
11. Disable cloudbase startup: `sc.exe config cloudbase-init start= disabled`
- Clean Files (disk cleanup)
- Optional: Snapshot here (pre-sysprep)
12. Sysprep `cd "C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf"; C:\Windows\System32\sysprep\sysprep.exe /generalize /oobe /unattend:Unattend.xml`
13. Convert to template in proxmox and set notes:
```
`Administrator:m0Nk3y!m0Nk3y!`\
`ansible:m0Nk3y!m0Nk3y!`

20XX Standard + Type, Windows updated.\
Template Created `06/26/2025`
```

## Windows NT Server 3.51
NT 3.51 Based
Not offically supported, not gonna be easy
## Windows NT Server 4.0
NT 4.0 Based\
Not offically supported, but probably doable
## Windows 2000 Server (SP4)
Windows 2000 Based (NT 5.0)
- VMID: 1100
- Name: win-2000server-sp4
- i440fx + BIOS

## Windows Server 2003 (SP2)
Windows XP Based
- VMID: 1101
- Name: win-server2003-sp2
- i440fx + BIOS

## Windows Server 2008
Vista SP1 Based
- VMID: 1102

## Windows Server 2008 (R2)
Windows 7 Based
- VMID: 1103
- Name: win-server2008-r2
- i440fx + BIOS
- VirtIO 0.1.141
  - No Guest Agent
- Intel E1000
- NOTE: Windows Server 2008 R2 specifically has a quirk with WinRM (delayed start) for the service, manually switch to automatic w/o delay.
- Firefox ESR 52
- Cloudbase-init 1.1.2
- No Disk Clean Utility
- No Windows Updates
## Windows Server 2012
Windows 8 Based
- VMID: 1104

## Windows Server 2012 (R2)
Windows 8.1 Based
- VMID: 1105
- Name: win-server2012-r2
- i440fx + BIOS
- VirtIO 0.1.190
- Intel E1000
- NOTE: Windows Server 2012 R2 specifically has much tighter firewall rules by default on public profiles. Set RDP public profiles on as well as winrm if not auto configured.
- Firefox ESR 115
- Cloudbase-init 1.1.2
- No Disk Clean Utility
- No Windows Updates
## Windows Server 2016
Windows 10 1607 Based
- VMID: 1106
- Name: win-server2016
- q35 + UEFI
- VirtIO 0.1.271 (latest)
- Latest Firefox
- Cloudbase-init 1.1.6 (latest stable)
## Windows Server 2019
Windows 10 1809 Based
- VMID: 1107
- Name: win-server2019
- q35 + UEFI
- VirtIO 0.1.271 (latest)
- Latest Firefox
- Cloudbase-init 1.1.6 (latest stable)
## Windows Server 2022
Windows 10 21H2 Based
- VMID: 1108
- Name: win-server2022
- q35 + UEFI
- VirtIO 0.1.271 (latest)
- Latest Firefox
- Cloudbase-init 1.1.6 (latest stable)
- NOTE: DO NOT OPEN EDGE OR OTHER APPX, use Invoke-WebRequest or RDP clipboard to download files, or else sysprep will fail due to appx changes.
  - IF APPX ISSUES ARISE: Remove-AppxPackage -Package 'package_name' (Ex. had to remove Microsoft.Edge.GameAssist_1.0.3336.0_x64__8wekyb3d8bbwe because of win updates)
## Windows Server 2025
Windows 11 24H2 Based
- VMID: 1109
- Name: win-server2025
- q35 + UEFI
- VirtIO 0.1.271 (latest)
- Latest Firefox
- Cloudbase-init 1.1.6 (latest stable)
- NOTE: DO NOT OPEN EDGE OR OTHER APPX, use Invoke-WebRequest or RDP clipboard to download files, or else sysprep will fail due to appx changes.
