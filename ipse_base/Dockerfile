FROM ubuntu:14.04
MAINTAINER sulele@supermap.com

ENV LICENSE_DIR=/opt/SuperMap/License

RUN apt-get update && \
apt-get install -y make gcc binutils perl libx11-dev xinit libgomp1 libxtst6 libxi6 language-pack-zh-hans lsb-core && \
apt-get install -y libc6-i386 libglu1-mesa libxcursor1 && \
apt-get install -y curl unzip libaio1 && \
apt-get clean && apt-get autoclean

# download and set oracle environment variable
RUN curl http://imanager-tool.oss-cn-beijing.aliyuncs.com/oracle_instant_client_11.2.04.tar.gz | tar -zxv -C /etc

RUN ln -s /etc/oracle_instant_client/network/admin/tnsnames.ora /opt/tnsnames.ora \
&& ln -s /etc/oracle_instant_client/libclntsh.so.*.1 /etc/oracle_instant_client/libclntsh.so.10.1
ENV ORACLE_HOME /etc/oracle_instant_client
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/etc/oracle_instant_client
ENV PATH $PATH:/etc/oracle_instant_client
ENV TNS_ADMIN $ORACLE_HOME/network/admin

# get and install aksusbd
ADD hasplm.ini /etc/hasplm/hasplm.ini
ADD init.sh /opt/init.sh
RUN curl http://imanager-tool.oss-cn-beijing.aliyuncs.com/aksusbd-2.4.1-i386.tar -o /tmp/aksusbd.tar && \
	tar -xvf /tmp/aksusbd.tar -C /opt && \
	ln -s /opt/aksusbd* /opt/aksusbd &&\
	chmod +x /opt/init.sh
RUN mkdir -p $LICENSE_DIR

CMD /opt/init.sh

