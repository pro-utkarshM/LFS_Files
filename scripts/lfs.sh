#!/bin/bash

export LFS=/mnt/lfs
export LFS_TGT=x86_64-lfs-linux-gnu
export LFS_DISK=/dev/sda

if ! grep -q "$LFS" /proc/mounts; then
  source setupdisk.sh "$LFS_DISK"
  sudo mount "${LFS_DISK}2" "$LFS"
  sudo chown -v $USER "$LFS"
fi

# for LFS
mkdir -pv $LFS/sources 
mkdir -pv $LFS/tools

# for the chroot environment
mkdir -pv $LFS/boot
mkdir -pv $LFS/etc
mkdir -pv $LFS/bin
mkdir -pv $LFS/lib
mkdir -pv $LFS/sbin
mkdir -pv $LFS/usr
mkdir -pv $LFS/var

case $(uname -m) in
  x86_64) mkdir -pv $LFS/lib64 ;;
esac