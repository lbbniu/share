FROM ubuntu:14.04
MAINTAINER lbbniu "lbbniu@qq.com"
#添加用户和组
RUN groupadd www && useradd -g www www
#安装编译环境
RUN apt-get update \
	&& apt-get install --no-install-recommends --no-install-suggests -y \
	wget curl g++ gcc make libpcre++-dev libssl-dev ca-certificates \
	&& rm -rf /var/lib/apt/lists/*
#VOLUME ["/data","/lnmp","/data/logs"]
RUN mkdir -p /data/logs /lnmp
WORKDIR /data
#获取nginx
RUN wget http://nginx.org/download/nginx-1.11.6.tar.gz \
	&& tar zxvf nginx-1.11.6.tar.gz \
	&& cd nginx-1.11.6 \ 
	&& ./configure --prefix=/lnmp/nginx \
	--sbin-path=/sbin --user=www --group=www \
	--error-log-path=/data/logs/error.log \
	--pid-path=/data/logs/nginx.pid \
	--conf-path=/data/nginx/nginx.conf \
	--http-log-path=/data/logs/access.log \
	--with-http_ssl_module \
	--with-http_stub_status_module \
	&& make && make install \
	&& cd ../ && rm -rf nginx-*
EXPOSE 80 443
RUN mkdir /rootfs
WORKDIR /rootfs
RUN mkdir -p bin etc lib proc sys tmp dev/pts usr/lib64 usr/lib usr/bin usr/local/bin lnmp data
RUN touch etc/resolv.conf
RUN cp /etc/nsswitch.conf etc/nsswitch.conf
RUN echo root:x:0:0:root:/:/bin/sh > etc/passwd
RUN echo root:x:0: > etc/group
RUN echo www:x:1000:1000:www:/:/bin/sh >> etc/passwd
RUN echo www:x:1000: >> etc/group
RUN ln -s lib lib64
RUN ln -s bin sbin
RUN curl -o /sbin/busybox https://busybox.net/downloads/binaries/1.21.1/busybox-x86_64
RUN chmod +x /sbin/busybox
RUN cp /sbin/busybox bin
RUN busybox --install -s bin
WORKDIR /
ADD nginx.sh /
RUN chmod a+x /nginx.sh && /nginx.sh
CMD ["nginx", "-g", "daemon off;"]