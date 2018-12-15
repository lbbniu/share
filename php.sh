#!/bin/bash
mkdir /rootfs
cd /rootfs
mkdir -p bin etc lib proc sys tmp dev/pts usr/lib64 usr/lib usr/bin usr/local/bin lnmp data
touch etc/resolv.conf
cp /etc/nsswitch.conf etc/nsswitch.conf
echo root:x:0:0:root:/:/bin/sh > etc/passwd
echo root:x:0: > etc/group
echo www:x:1000:1000:www:/:/bin/sh >> etc/passwd
echo www:x:1000: >> etc/group
ln -s lib lib64
ln -s bin sbin
curl -o /sbin/busybox https://busybox.net/downloads/binaries/1.21.1/busybox-x86_64
chmod +x /sbin/busybox
cp /sbin/busybox bin
busybox --install -s bin
cd /rootfs
rm -rf lib/*
rm -rf usr/lib/*
ldd /lnmp/php7/bin/php | awk '{print $3}' | xargs -t -i cp {} lib
cp /lib64/ld-linux-x86-64.so.2 lib
cp /lib/x86_64-linux-gnu/librt.so.1 lib
cp /lib/x86_64-linux-gnu/libgcc_s.so.1 lib
cp /usr/lib/x86_64-linux-gnu/libstdc++.so.6 lib
cp /lib/x86_64-linux-gnu/libnsl.so.1 lib
cp /lib/x86_64-linux-gnu/libnss_compat.so.2 lib
cp /lib/x86_64-linux-gnu/libnss_dns.so.2 lib
cp /lib/x86_64-linux-gnu/libnss_nis.so.2 lib
cp /lib/x86_64-linux-gnu/libnss_nisplus.so.2 lib
cp /lib/x86_64-linux-gnu/libnss_files.so.2 lib
cp /lib/x86_64-linux-gnu/libnss_hesiod.so.2 lib
cp /lib/x86_64-linux-gnu/libresolv.so.2 lib
cp /lnmp/php7/bin/php bin
cp -rf /lnmp/* lnmp/
mv lnmp/php7/bin/php bin/
mv lnmp/php7/sbin/php-fpm bin
rm -rf lnmp/php7/include
rm -rf lnmp/php7/sbin
rm -rf lnmp/php7/bin
cp /usr/bin/git bin
ldd /usr/bin/git | awk '{print $3}' | xargs -t -i cp {} lib
cp /usr/local/bin/ffmpeg usr/local/bin/
cp -rf /etc/ssl etc/
cp -rf /etc/ssh etc/
cp /usr/bin/ssh usr/bin
ldd /usr/bin/ssh | awk '{print $3}' | xargs -t -i cp {} lib
cp -rf /usr/lib/ssl usr/lib
cp -rf /usr/lib/git-core usr/lib
ldd /usr/local/bin/ffmpeg | awk '{print $3}' | xargs -t -i cp {} lib
cp -f /usr/bin/dmtx* bin
mkdir -p usr/lib/x86_64-linux-gnu
cp -rf /usr/lib/x86_64-linux-gnu/*Magick* usr/lib/x86_64-linux-gnu
ldd /usr/bin/dmtxread | awk '{print $3}' | xargs -t -i cp -f {} lib
ldd /usr/bin/dmtxwrite | awk '{print $3}' | xargs -t -i cp -f {} lib
ldd /usr/bin/dmtxquery | awk '{print $3}' | xargs -t -i cp -f {} lib
wget http://curl.haxx.se/ca/cacert.pem
mv cacert.pem usr/lib/ssl/cert.pem
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === 'aa96f26c2b67226a324c27919f1eb05f21c248b987e6195cad9690d5c1ff713d53020a02ac8c217dbf90a7eacc9d141d') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar bin/commposer
tar zcf /rootfs.tar.gz  .
