# 镜像制作以国内仓库的ubuntu 14.04操作系统为基础
FROM ubuntu:14.04
MAINTAINER sulele@supermap.com
ENV ISERVER_VERSION 7.1
ENV iServer true
# 国内的Ubuntu镜像源
# ADD iServer/sources.list_aliyun /etc/apt/sources.list
# 安装iServer
RUN apt-get update && apt-get install wget -y
RUN wget http://gis-data.oss-cn-beijing.aliyuncs.com/image_iserver/ubuntu_public_deployiServer7C.sh -O /opt/deployiserver.sh
RUN chmod 775 /opt/deployiserver.sh
RUN /opt/deployiserver.sh
# Container启动时立即运行iServer
EXPOSE 8090
ENTRYPOINT service supermap start
# CMD /etc/icloud/supermap_start.sh