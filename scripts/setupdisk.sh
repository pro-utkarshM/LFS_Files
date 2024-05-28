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


   #  o creates a new DOS (MBR) disk label.
   #  n creates a new partition.
   #  p specifies a primary partition.
   #  1 specifies partition number 1.
   #  +100M specifies the size of the first partition.
   #  a sets the bootable flag on partition 1.
   #  n creates a new partition.
   #  p specifies a primary partition.
   #  2 specifies partition number 2.
   #  p prints the partition table (optional step, can be omitted if not needed).
   #  w writes the partition table to disk and exits.