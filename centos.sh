#/bin/bash
#删除旧版本
sudo yum remove docker \
  	docker-client \
  	docker-client-latest \
  	docker-common \
  	docker-latest \
  	docker-latest-logrotate \
  	docker-logrotate \
  	docker-selinux \
  	docker-engine-selinux \
  	docker-engine

sudo yum install -y yum-utils \
  	device-mapper-persistent-data \
  	lvm2
#默认稳定版本  	
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
#稳定版本    
#sudo yum-config-manager --enable docker-ce-stable
#启用边缘版本
#sudo yum-config-manager --enable docker-ce-edge
#启用测试版本
#sudo yum-config-manager --enable docker-ce-test
#关闭边缘版本
#sudo yum-config-manager --disable docker-ce-edge
#安装
sudo yum install docker-ce
#启动docker
sudo systemctl start docker
#测试
sudo docker run hello-world
#增加一个用户到docker组
sudo usermod -aG docker your-user