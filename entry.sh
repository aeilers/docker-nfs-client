#! /bin/sh -e

umount_nfs () {
  echo "Unmounting nfs..."
  umount "$MOUNTPOINT"
  exit
}

mkdir -p "$MOUNTPOINT"
chmod go+rw "$MOUNTPOINT"

if [$SERVER == ""]; then
    rpc.statd -F -p 32765 -o 32766 & rpcbind -f & echo "docker NFS client with rpcbind ENABLED... if you wish to mount the mountpoint in this container USE THE FOLLOWING SYNTAX instead:
    $ docker run -itd --privileged=true --net=host -v vol:/mnt/nfs:shared -e SERVER= X.X.X.X -e SHARE=shared_path aeilers/docker-nfs-client" & more
else
    rpc.statd -F -p 32765 -o 32766 & rpcbind -f &
    mount -t "$FSTYPE" -o "$MOUNT_OPTIONS" "$SERVER:$SHARE" "$MOUNTPOINT"
fi

mount | grep nfs

trap umount_nfs SIGHUP SIGINT SIGTERM

while true; do sleep 1000; done
