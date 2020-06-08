yum install -y nfs-utils

systemctl enable rpcbind
systemctl enable nfs-server
systemctl enable nfs-lock
systemctl enable nfs-idmap
systemctl start rpcbind
systemctl start nfs-server
systemctl start nfs-lock
systemctl start nfs-idmap

mkdir -p /media/nfs_share

mount -t nfs 172.0.0.35:/home/nfs/ /media/nfs_share/

echo '172.0.0.35:/home/nfs/ /media/nfs_share/ nfs rw,sync,hard,intr 0 0' >> /etc/fstab
