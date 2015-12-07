#!/bin/sh
ROOT_URL="http://gis-data.oss-cn-beijing.aliyuncs.com/image_iserver"
ISERVER_TAR_URL="$ROOT_URL/supermap_iserver_7.1.2_linux64_deploy.tar.gz"
ISERVER_CONFIG_URL="$ROOT_URL/iserver-services.xml"
START_URL="$ROOT_URL/supermap_start.sh"
STOP_URL="$ROOT_URL/supermap_stop.sh"
DATA_URL="$ROOT_URL/World.tar.gz"
CLASS_CUSTOM_URL="$ROOT_URL/classes_iserver_custom.tar.gz"
ICLOUD_DIR="/etc/icloud"
ISERVER_DIRNAME="SuperMapiServer7C"
LICENCE_DRIVER_DIRNAME="aksusbd"

sudo mkdir $ICLOUD_DIR

# iServer Need
echo "libs which iServer Need: make gcc binutils perl libx11-dev xinit"
sudo apt-get update
sudo apt-get install -y make gcc binutils perl libx11-dev xinit libgomp1 libxtst6 libxi6 language-pack-zh-hans lsb-core

sudo apt-get install -y ia32-libs libc6-i386

if [ -d "$ICLOUD_DIR/$ISERVER_DIRNAME" ]; then
Clean Old Package
cd "$ICLOUD_DIR/$ISERVER_DIRNAME/bin"
sudo ./shutdown.sh
sudo cd ../
sudo rm -R "$ISERVER_DIRNAME" -f
fi

# Install New Package
echo "Install New Package"
cd /tmp
sudo rm *.tar.gz -f
wget "$ISERVER_TAR_URL" -O iserver.tar.gz
tar -zxvf iserver.tar.gz  -C "$ICLOUD_DIR"
cd "$ICLOUD_DIR/$ISERVER_DIRNAME/"
sudo cp ./support/objectsjava/bin/libmawt.so ./support/jre/lib/amd64/headless/

# license Driver
echo "Copy license Driver"
cd /tmp
sudo cp $ICLOUD_DIR/$ISERVER_DIRNAME/support/SuperMap_License/Support/aksusbd*.tar /tmp/aksusbd.tar
sudo tar -xvf aksusbd.tar
sudo mv aksusbd-* $ICLOUD_DIR/aksusbd
# 32bit lib
# echo "Install 32bit lib for license Driver"
cd $ICLOUD_DIR/$ISERVER_DIRNAME/support/SuperMap_License/Support
# sudo apt-get install -y lsb-core ,Installed in config_env.sh
sudo ./rpms_check_and_install_for_64bit.sh
sudo cd /etc/icloud/aksusbd
sudo ./dunst
sudo ./dinst
sudo echo

# default publish World Data
echo "deploy default World Data"
cd /tmp
sudo wget "$DATA_URL" -O World.tar.gz
tar -zxvf World.tar.gz  -C "$ICLOUD_DIR"
sudo wget "$ISERVER_CONFIG_URL" -O "$ICLOUD_DIR/$ISERVER_DIRNAME/webapps/iserver/WEB-INF/iserver-services.xml"

cd /etc/icloud
sudo wget "$START_URL" -O supermap_start.sh
sudo wget "$STOP_URL" -O supermap_stop.sh
sudo chmod 777 supermap_*.sh
sudo ln -s /etc/icloud/supermap_start.sh /etc/init.d/supermap
cd /etc/init.d
sudo update-rc.d supermap defaults 95
sudo mkdir /opt/SuperMap/License -p


# custome iserver classes
echo "custome iserver classes"
cd /tmp
sudo wget "$CLASS_CUSTOM_URL" -O classes.tar.gz
tar -zxvf classes.tar.gz  -C "$ICLOUD_DIR/$ISERVER_DIRNAME/webapps/iserver/WEB-INF"


# iServer Auto Start
# move rc.local content to supermap_start.sh
# echo "config iServer Auto Start"
# cd /tmp
# sudo wget "$ISERVER_RCLOCAL_URL" -O /etc/rc.local

#guyq's delthis file
cp /etc/rc.local /etc/icloud/delthis

# Clean the Disk
echo "Clean the Disk"
cd $ICLOUD_DIR/$ISERVER_DIRNAME/support/SuperMap_License/Support
sudo rm *.* -f
sudo rm * -R
cd /tmp
sudo rm *.* -f