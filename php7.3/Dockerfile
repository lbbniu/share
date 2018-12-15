FROM ubuntu:14.04

MAINTAINER lbbniu "lbbniu@qq.com"
#添加用户和组
RUN groupadd www && useradd -g www www
#安装编译环境
RUN apt-get update 
RUN apt-get install --no-install-recommends --no-install-suggests -y \
	wget curl g++ gcc make 
RUN	apt-get install --no-install-recommends --no-install-suggests -y \
	libxml2-dev libmcrypt-dev libjpeg-dev ca-certificates \
	libpng-dev libxpm-dev libfreetype6-dev  libcurl3-openssl-dev autoconf \
	libdmtx-utils \
	&& ln -s /usr/lib/x86_64-linux-gnu/libssl.so  /usr/lib \
	&& rm -rf /var/lib/apt/lists/*
RUN mkdir -p /lnmp /data/logs /data/php7
ENV PHP_VERSION=7.3.0
WORKDIR /data
RUN wget http://cn2.php.net/get/php-${PHP_VERSION}.tar.gz/from/this/mirror  \
	&& mv mirror php-${PHP_VERSION}.tar.gz \
	&& tar zxvf  php-${PHP_VERSION}.tar.gz && cd php-${PHP_VERSION} \
	&&./configure --prefix=/lnmp/php7 --with-config-file-path=/data/php7/etc \
	--with-config-file-scan-dir=/data/php7/ext \
	--with-fpm-user=www --with-fpm-group=www \
	--sysconfdir=/data/php7/etc --with-iconv-dir --with-freetype-dir --with-jpeg-dir \
	--with-png-dir --with-zlib --enable-xml --with-curl --with-mhash --with-gd \
	--enable-gd-native-ttf --enable-zip --enable-mbstring --enable-sockets --enable-fpm  \
	--enable-soap --with-mysqli --with-pdo-mysql --enable-bcmath --enable-shmop --enable-sysvsem  \
	--enable-inline-optimization --enable-mbregex --with-mcrypt --enable-ftp --with-openssl  \
	--enable-pcntl --with-xmlrpc --without-pear --with-gettext --disable-fileinfo  \
	--enable-maintainer-zts --enable-exif --enable-fileinfo --enable-pcntl --with-mcrypt \
	&& make && make install && cd ../ && rm -rf php-*
WORKDIR /
ADD ../php.sh /
RUN chmod a+x /php.sh && /php.sh

CMD ["/bin/bash"]
