# SETUP
## Windows Server Legacy (2008-2012)
VirtIO 0.1.141 for 2008, 0.1.190 for 2012
i440fx
SeaBIOS
E1000
SCSI for main disk, IDE for others

Firefox ESR 52 (2008)
Firefox ESR 115 (2012)
Cloudbase-init 1.1.2 (2008 + 2012)
No guest agent (2008)
No disk clean utility (2012)

`Administrator:m0Nk3y!m0Nk3y!`\
`ansible:m0Nk3y!m0Nk3y!`

2012 R2 Standard + GUI, Minimal specs, NOT windows updated.

## Windows Server (2016+)
### General
Node: zirconium
VM ID: 12xx
Name: win-server20XX
Resource Pool: admin
Tags: template
### OS
Select ISO
Select Guest Version
Add drive for VirtIO drivers
### System
Machine: q35
BIOS: OVMF (UEFI)
### Disks
Bus/Device: VirtIO Block
Size: 32 (min, smaller=better clone times)
### CPU
Cores: 4
Type: x86-64-v2-AES (would use host but unsure of architecture on server)
### Memory
Memory(MiB): 8192
### Network
VirtIO (paravirtualized)
### Confirm
Check everything
### Start
Start and run installer (Press any key to install from CD or DVD)
Standard desktop experience
Load virtio driver, install

Once in: 
- Install virtio guest drivers (`virtio-win-guest-tools.exe`)
- Enable RDP (No NLA, GUI)
- Create ansible user (Administrators group + never expire) (Honestly just make in GUI, also set description: `DO NOT RESET PASSWORD`)
- enable winrm (`winrm quickconfig -force` `winrm set winrm/config/service/auth '@{Basic="true"}'` `winrm set winrm/config/service '@{AllowUnencrypted="true"}'`)
- Install firefox (https://www.mozilla.org/en-US/firefox/download/thanks/)
- Shutdown (Remove Install media + Driver CDs, add cloudinit CD, configure cloudinit)
- Install cloudinit (https://github.com/cloudbase/cloudbase-init/releases/tag/1.1.6, Administrator, No Metadata PW, LocalSystem, NO SYSPREP)
- Configure Unattend.xml (see file)
- Clean Files (disk cleanup)
- Sysprep (`C:\Windows\System32\Sysprep\sysprep.exe /oobe /generalize /shutdown /unattend:'C:\Program Files\Cloudbase Solutions\Cloudbase-Init\conf\Unattend.xml'`)
- Convert to template in proxmox and set notes:

`Administrator:m0Nk3y!m0Nk3y!`\
`ansible:m0Nk3y!m0Nk3y!`

2016 Standard + Desktop Experience, Minimal specs, NOT windows updated.
