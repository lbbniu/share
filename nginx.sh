#!/bin/bash
cd /rootfs
cp -rf /lnmp/* lnmp
cp -rf /data/* data
cp -f /sbin/nginx bin
rm -rf lib/*
ldd /sbin/nginx  | awk '{print $3}' | xargs -t -i cp {} lib
cp /lib64/ld-linux-x86-64.so.2 lib
cp /lib/x86_64-linux-gnu/libnsl.so.1 lib
cp /lib/x86_64-linux-gnu/libnss_compat.so.2 lib
cp /lib/x86_64-linux-gnu/libnss_dns.so.2 lib
cp /lib/x86_64-linux-gnu/libnss_nis.so.2 lib
cp /lib/x86_64-linux-gnu/libnss_files.so.2 lib
cp /lib/x86_64-linux-gnu/libnss_hesiod.so.2 lib
cp /lib/x86_64-linux-gnu/libresolv.so.2 lib
chown -R www:root lnmp/nginx
chmod -R 777  tmp
tar zcf /rootfs.tar.gz  .