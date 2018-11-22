#/bin/bash
#删除旧版本
sudo apt-get remove docker docker-engine docker.io
sudo apt-get update
#ubuntu 14.04需要安装虚拟化支持
sudo apt-get install \
    linux-image-extra-$(uname -r) \
    linux-image-extra-virtual

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#x86_64 / amd64 版本库 。arch其他：amd64，armhf，ppc64le，s390x
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-key fingerprint 0EBFCD88
#
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update
#安装docker
sudo apt-get install docker-ce

#安装指定版本
#apt-cache madison docker-ce
#sudo apt-get install docker-ce=<VERSION>
sudo docker run hello-world