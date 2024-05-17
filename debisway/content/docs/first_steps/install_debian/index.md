---
title: Install debian
weight: 1
sidebar_position: 20
resources:
  - src: "deb-inst.jpg"
---

## Make Debian bootable USB using linux

1. Download [Debian installer](https://www.debian.org/devel/debian-installer)
2. Connect the USB flash drive and identify its device path. In this example, it's `/dev/sda` (determine the correct device by its size)
```bash
❯ lsblk
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sda           8:0    1   7.2G  0 disk
├─sda1        8:1    1   7.2G  0 part /media/kurotych/CCCOMA_X64FRE_EN-GB_DV9
└─sda2        8:2    1     1M  0 part /media/kurotych/UEFI_NTFS
nvme1n1     259:0    0 931.5G  0 disk
├─nvme1n1p1 259:2    0    16M  0 part
├─nvme1n1p2 259:3    0   513M  0 part /boot/efi
└─nvme1n1p3 259:4    0   931G  0 part /
nvme0n1     259:1    0 931.5G  0 disk
├─nvme0n1p1 259:5    0   128M  0 part
├─nvme0n1p2 259:6    0   100M  0 part
├─nvme0n1p3 259:7    0 197.7G  0 part
├─nvme0n1p4 259:8    0   697M  0 part
└─nvme0n1p5 259:9    0 732.9G  0 part
```
3. Copy the ISO image to the USB drive and synchronize the filesystem.
{{% alert title="Warning" color="warning" %}}
Be aware, that the methods described here will destroy anything already on the device! Make very sure that you use the correct device name for your USB stick.
{{% /alert %}}
```
❯ sudo cp debian-12.5.0-amd64-netinst.iso /dev/sda
❯ sudo sync
```
4. Your USB flash drive is now bootable. Insert the USB flash drive into the PC and access the boot menu to start the installation process.


## Install minimal deps at the beginning
{{< imgproc deb-inst Fill "786x484" >}}
During installation of image choose "standard system utilities" only
{{< /imgproc >}}

### Links
- [CreateUSBMedia](https://wiki.debian.org/DebianInstaller/CreateUSBMedia)
- [How to install debian](https://www.google.com/search?q=How+to+install+debian)
