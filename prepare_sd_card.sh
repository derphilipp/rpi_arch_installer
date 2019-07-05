#!/usr/bin/env bash
set -Eeuo pipefail

sudo fdisk $(ls /dev/sd? | fzf )

sudo rm -rf /tmp/sdcard 2>/dev/null || true
mkdir /tmp/sdcard

sudo mkfs.vfat $(ls /dev/sd?? | fzf --headers="Partition for vfat (usually sd?1)" )
sudo mkfs.ext4 $(ls /dev/sd?? | fzf --headers="Partition for ext4 (usually sd?2)" )

cd /tmp/sdcard
mkdir boot
mkdir root
sudo mount $(ls /dev/sd?? | fzf --headers="Partition for vfat (usually sd?1)" ) boot
sudo mount $(ls /dev/sd?? | fzf --headers="Partition for ext4 (usually sd?2)" ) root

wget http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-3-latest.tar.gz
sudo bsdtar -xpf ArchLinuxARM-rpi-3-latest.tar.gz -C root
sudo sync
sudo mv root/boot/* boot
sudo sync
sudo umount boot root

echo "All done"
sudo rm -rf /tmp/sdcard
read
