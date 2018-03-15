# 镜像制作以国内仓库的ubuntu 14.04操作系统为基础
FROM ubuntu:14.04
MAINTAINER sulele@supermap.com
ENV IEXPRESS_VERSION 8.0
ENV iExpress true
# 安装依赖库
RUN apt-get update && apt-get install -y lsb-core
# 安装iExpress产品包
ADD http://download.supermap.com.cn/SuperMapGIS/SuperMap8C/800/iExpress/supermap_iexpress_8.0.0c_linux64.tar.gz /opt/

# 初始化许可驱动
RUN RUN ln -s /etc/icloud/supermap_iexpress* /opt/SuperMapiExpress cd /opt/SuperMapiExpress/support/SuperMap_License/Support && \
	./rpms_check_and_install_for_64bit.sh install && \
	tar xvf aksusbd_2.4.1-i386.tar && \
	cd aksusbd-2.4.1-i386 && \
	./dinst && \
	echo
ADD run.sh /opt/
# Container启动时立即运行iServer
CMD /opt/run.sh