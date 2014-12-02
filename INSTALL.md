#常见部署方案
	假设所有服务都部署在一台机器上

###1.纯公司内网 
	安装的机器内网ip为： 192.168.1.2
	
**login_server:**

	ClientListenIP=192.168.1.2		
	ClientPort=8008
	MsgServerListenIP=192.168.1.2	
	MsgServerPort=8100
	
	
**msg_server:**
	
	ListenIP=192.168.1.2
	ListenPort=8200

	HttpListenIP=192.168.1.2
	HttpListenPort=8300

	ConcurrentDBConnCnt=2
	DBServerIP1=192.168.1.2
	DBServerPort1=11000
	DBServerIP2=192.168.1.2
	DBServerPort2=11000

	LoginServerIP1=192.168.1.2
	LoginServerPort1=8100

	RouteServerIP1=192.168.1.2
	RouteServerPort1=8400

	FileServerIP1=192.168.1.2
	FileServerPort1=8500

	IpAddr1=192.168.1.2 	
	IpAddr2=192.168.1.2		
	MaxConnCnt=100000
	
**route_server:**

	ListenIP=192.168.1.2			
	ListenMsgPort=8400
	
**msfs_server:**

	ListenIP=192.168.1.2		
	ListenPort=8600
	BaseDir=./tmp
	FileCnt=0
	FilesPerDir=30000
	GetThreadCount=32
	PostThreadCount=1
	
**file_server:**
	
	Address=192.168.1.2	
	ListenPort=8500			
	TaskTimeout=60        
	
**java_db_proxy:**
	
	common-online.properties:
	com.mogujie.ares.config.file.serverurl=http://192.168.1.2:8600/


###2.公网ip
	安装的机器为多网卡，包含内网网卡和公网网卡
	内网ip为：192.168.1.2
	公网ip为122.222.222.222


**login_server:**

	ClientListenIP=122.222.222.222		
	ClientPort=8008
	MsgServerListenIP=192.168.1.2	
	MsgServerPort=8100
	
	
**msg_server:**
	
	ListenIP=122.222.222.222
	ListenPort=8200

	HttpListenIP=192.168.1.2
	HttpListenPort=8300

	ConcurrentDBConnCnt=2
	DBServerIP1=192.168.1.2
	DBServerPort1=11000
	DBServerIP2=192.168.1.2
	DBServerPort2=11000

	LoginServerIP1=192.168.1.2
	LoginServerPort1=8100

	RouteServerIP1=192.168.1.2
	RouteServerPort1=8400

	FileServerIP1=192.168.1.2
	FileServerPort1=8500

	IpAddr1=122.222.222.222
	IpAddr2=122.222.222.222
	MaxConnCnt=100000
	
**route_server:**

	ListenIP=192.168.1.2			
	ListenMsgPort=8400
	
**msfs_server:**

	ListenIP=192.168.1.2;122.222.222.222		
	ListenPort=8600
	BaseDir=./tmp
	FileCnt=0
	FilesPerDir=30000
	GetThreadCount=32
	PostThreadCount=1
	
**file_server:**
	
	Address=122.222.222.222	
	ListenPort=8500			
	TaskTimeout=60        
	
**java_db_proxy:**
	
	common-online.properties:
	com.mogujie.ares.config.file.serverurl=http://192.168.1.2:8600/


###3.公网ip，路由器映射
######此种情况请确保在内网下可以访问路由器映射的外网ip

	安装的机器为单网卡，外网由路由器映射
	内网ip为: 192.168.1.2
	路由器映射的公网ip为: 122.222.222.222
**login_server:**

	ClientListenIP=192.168.1.2	
	ClientPort=8008
	MsgServerListenIP=192.168.1.2	
	MsgServerPort=8100
	
	
**msg_server:**
	
	ListenIP=192.168.1.2
	ListenPort=8200

	HttpListenIP=192.168.1.2
	HttpListenPort=8300

	ConcurrentDBConnCnt=2
	DBServerIP1=192.168.1.2
	DBServerPort1=11000
	DBServerIP2=192.168.1.2
	DBServerPort2=11000

	LoginServerIP1=192.168.1.2
	LoginServerPort1=8100

	RouteServerIP1=192.168.1.2
	RouteServerPort1=8400

	FileServerIP1=192.168.1.2
	FileServerPort1=8500

	IpAddr1=122.222.222.222	
	IpAddr2=122.222.222.222
	MaxConnCnt=100000
	
**route_server:**

	ListenIP=192.168.1.2			
	ListenMsgPort=8400
	
**msfs_server:**

	ListenIP=192.168.1.2		
	ListenPort=8600
	BaseDir=./tmp
	FileCnt=0
	FilesPerDir=30000
	GetThreadCount=32
	PostThreadCount=1
	
**file_server:**
	
	Address=122.222.222.222	
	ListenPort=8500			
	TaskTimeout=60        
	
**java_db_proxy:**
	
	common-online.properties:
	com.mogujie.ares.config.file.serverurl=http://192.168.1.2:8600/
	
	
#WEB使用注意
	1.TeamTalk安装成功后,登录php后台,比如：http://192.168.1.2
	默认用户名:admin, 密码:admin。
	2.目前php后台创建用户得密码为明文，需要手动设置成对应得md5值, 
	