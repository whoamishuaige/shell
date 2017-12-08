#!/bin/bash
INFO=`cat '/etc/issue'`
SYSTEM=`echo $INFO | awk '{print $1}'`
VERSION=`echo $INFO | awk '{print $2}' | awk -F "." '{print $1}'`
IP=`ifconfig eth0|grep 'inet addr'|awk -F ":" '{print $2}'|awk '{print $1}'`
#ubuntu 安装zabbbix，这是因为zabbix不同的系统导入不同的包
function zInstall(){
	if [[ $VERSION = 14 ]]; then
		#statements
		wget http://repo.zabbix.com/zabbix/2.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_2.2-1+trusty_all.deb  
		sudo dpkg -i zabbix-release_2.2-1+trusty_all.deb  
	elif [[ $VERSION = 12 ]]; then
			#statements
			# echo $VERSION;
	
		wget http://repo.zabbix.com/zabbix/2.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_2.2-1+precise_all.deb  
		sudo dpkg -i zabbix-release_2.2-1+precise_all.deb  
	fi
	if [[ $? = 0 ]]; then
		#statements
        echo "安装准备完毕"
        sudo apt-get update
		sudo apt-get install zabbix-agent
	fi
    if [ $? = 0 ];then
        echo "zabbix agentd 安装成功"
        rm zabbix* 
    fi
}
#简单配置
function zConfig(){
	CONF=/etc/zabbix/zabbix_agentd.conf
	sudo sed -i '/^# StartAgents=3/c StartAgents=0' $CONF
	sudo sed -i 's/^Server=/#&/' /etc/zabbix/zabbix_agentd.conf $CONF
	sudo sed -i 's/ServerActive=127.0.0.1/ServerActive=120.24.51.20/' $CONF
	sudo sed -i "/^Hostname/cHostname=$IP" $CONF
    if [ $? = 0 ];then
        echo "配置完毕"
    fi
}
function zRestart(){
	sudo /etc/init.d/zabbix-agent stop
	if [[ $? = 0 ]]; then
		#statements
		echo "服务已经被关闭"
	fi
	sudo zabbix_agentd
	if [[ $? = 0 ]]; then
		#statements
		echo "重启成功"
	fi
}
#
function main(){
		zInstall
		zConfig
		zRestart
}
main 2>error.log



