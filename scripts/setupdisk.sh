LFS_DISK="$1"

sudo fdisk "$LFS_DISK" << EOF
o 
n
p
1

+100M
a
n
p
2


p
w
q
EOF

# sudo mkfs.ext2 "${LFS_DISK}1"
# sudo mkfs.ext2 "${LFS_DISK}2"

sudo mkfs -t ext2 -F "${LFS_DISK}1"
sudo mkfs -t ext2 -F "${LFS_DISK}2"


# -o, --output <list>           output columns
# -n, --noauto-pt               don't create default partition table on empty devices
#  p --> partition
#  a --> active directory, which will present itself on boot
# -w, --wipe <mode>             wipe signatures (auto, always or never)
#  q --> quit?