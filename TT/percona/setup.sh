#!/bin/bash
# this is a setup scripts for percona
# author: luoning
# date: 08/30/2014

# setup percona

PERCONA_SHARED=Percona-Server-shared-56-5.6.21-rel70.1.el6.x86_64
PERCONA_SHARED_DOWNLOAD_PATH=http://www.percona.com/downloads/Percona-Server-5.6/LATEST/binary/redhat/6/x86_64/$PERCONA_SHARED.rpm

PERCONA_CLIENT=Percona-Server-client-56-5.6.21-rel70.1.el6.x86_64
PERCONA_CLIENT_DOWNLOAD_PATH=http://www.percona.com/downloads/Percona-Server-5.6/LATEST/binary/redhat/6/x86_64/$PERCONA_CLIENT.rpm


PERCONA_SERVER=Percona-Server-server-56-5.6.21-rel70.1.el6.x86_64
PERCONA_SERVER_DOWNLOAD_PATH=http://www.percona.com/downloads/Percona-Server-5.6/LATEST/binary/redhat/6/x86_64/$PERCONA_SERVER.rpm


MYSQL_PASSWORD=12345
IM_SQL=macim.sql
MYSQL_CONF=my.cnf

print_hello(){
	echo "==========================================="
	echo "$1 percona for TeamTalk"
	echo "==========================================="
}

check_user() {
	if [ $(id -u) != "0" ]; then
    	echo "Error: You must be root to run this script, please use root to install percona"
    	exit 1
	fi
}

check_os() {
	OS_VERSION=$(cat /etc/issue)
	OS_BIT=$(getconf LONG_BIT)
	#echo "$OS_VERSION, $OS_BIT bit..." 
	if [[ $OS_VERSION =~ "CentOS" ]]; then
		if [ $OS_BIT == 64 ]; then
			return 0
		else
			echo "Error: OS must be CentOS 64bit to run this script."
			exit 1
		fi
	else
		echo "Error: OS must be CentOS 64bit to run this script."
		exit 1
	fi
}

check_run() {
	ps -ef | grep -v 'grep' | grep mysqld
	if [ $? -eq 0 ]; then
		echo "Error: mysql is running."
		exit 1
	fi
}

clean_yum() {
	YUM_PID=/var/run/yum.pid
	if [ -f "$YUM_PID" ]; then
		set -x
		rm -f YUM_PID
		killall yum
		set +x
	fi
}

download() {
	if [ -f "$1" ]; then
		echo "$1 existed."
	else
		echo "$1 not existed, begin to download..."
		wget $2
		if [ $? -eq 0 ]; then
			echo "download $1 successed";
		else
			echo "Error: download $1 failed";
			return 1;
		fi
	fi
	return 0
}

build_ssl() {
	clean_yum
	yum -y install openssl-devel
	if [ $? -eq 0 ]; then
		echo "yum install openssl-devel successed."
	else
		echo "Error: yum install openssl-devel failed."
		return 1;
	fi
}


build_percona() {
	download $PERCONA_SERVER.rpm $PERCONA_SERVER_DOWNLOAD_PATH
	if [ $? -eq 1 ]; then
		return 1
	fi
	
	download $PERCONA_CLIENT.rpm $PERCONA_CLIENT_DOWNLOAD_PATH
	if [ $? -eq 1 ]; then
		return 1
	fi

	download $PERCONA_SHARED.rpm $PERCONA_SHARED_DOWNLOAD_PATH
	if [ $? -eq 1 ]; then
		return 1
	fi

	build_ssl 
	if [ $? -eq 0 ]; then
		echo "build ssl successed."
	else
		echo "Error: build ssl failed."
		return 1
	fi


	rpm -ivh Percona-Server-*
	RET=$?
	if [ $RET -eq 0 ]; then
		echo "install percona-server successed";
	elif [ $RET -eq 3 ]; then
		echo "percona-server has installed";
	else
		echo "Error: install percona-server failed";
		return 1;
	fi
	
	if [ -f ./conf/$MYSQL_CONF ]; then
		cp -f ./conf/$MYSQL_CONF /etc/
	else
		echo "Error: $MYSQL_CONF is not existed";
		return 1;
	fi
}

run_percona() {
	PROCESS=$(pgrep mysql)
	if [ -z "$PROCESS" ]; then 
		echo "no mysql is running..." 
		service mysql start
		if [ $? -eq 0 ]; then
			echo "start percona successed."
		else
			echo "Error: start percona failed."
			return 1
		fi
	else 
		echo "Warning: mysql is running"
	fi
}	

set_password() {
	mysqladmin -u root password $MYSQL_PASSWORD
	if [ $? -eq 0 ]; then
		echo "set percona root password successed."
	else
		echo "Error: set percona root password failed."
		return 1
	fi
}


create_database() {
	cd ./conf/
	if [ -f "$IM_SQL" ]; then
		echo "$IM_SQL existed, begin to run $IM_SQL"
	else
		echo "Error: $IM_SQL not existed."
		cd ..
		return 1
	fi

	mysql -u root -p$MYSQL_PASSWORD < macim.sql
	if [ $? -eq 0 ]; then
		echo "run macim.sql successed."
		cd ..
	else
		echo "Error: run macim.sql failed."
		cd ..
		return 1
	fi
}

build_all() {
	build_percona
	if [ $? -eq 0 ]; then
		echo "build percona successed."
	else
		echo "Error: build percona failed."
		exit 1
	fi

	run_percona
	if [ $? -eq 0 ]; then
		echo "run percona successed."
	else
		echo "Error: run percona failed."
		exit 1
	fi

	set_password
	if [ $? -eq 0 ]; then
		echo "set password successed."
	else
		echo "Error: set password failed."
		exit 1
	fi

	create_database
	if [ $? -eq 0 ]; then
		echo "create database successed."
	else
		echo "Error: create database failed."
		exit 1
	fi	
}


print_help() {
	echo "Usage: "
	echo "  $0 check --- check environment"
	echo "  $0 install --- check & run scripts to install"
}

case $1 in
	check)
		print_hello $1
		check_user
		check_os
		check_run
		;;
	install)
		print_hello $1
		check_user
		check_os
		check_run
		build_all
		;;
	*)
		print_help
		;;
esac


