FROM alpine:3.5
MAINTAINER Adam Eilers <adam.eilers@gmail.com>

ENV FSTYPE nfs4 \
    MOUNT_OPTIONS nfsvers=4,rw \
    MOUNTPOINT /mnt/nfs

RUN apk update \
    && apk add --update nfs-utils \
    && rm -rf /var/cache/apk/* \
    && rm -f /sbin/halt /sbin/poweroff /sbin/reboot

COPY entry.sh /usr/local/bin/entry.sh

ENTRYPOINT ["/usr/local/bin/entry.sh"]
