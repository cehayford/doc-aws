# view storage in the EC2 console
df -h

# creating ext3 file system on the new volume
sudo mkfs -t ext3 /dev/sdb

# create a directory to mount the new volume
sudo mkdir /mnt/data-store
# mounting the new volume
sudo mount /dev/sdb /mnt/data-store
echo "/dev/sdb   /mnt/data-store ext3 defaults,noatime 1 2" | sudo tee -a /etc/fstab

# to check configuration
cat /etc/fstab
# to check the mounted file system
df -h

# store the data in the new volume
sudo sh -c "echo some text has been written > /mnt/data-store/file.txt"

