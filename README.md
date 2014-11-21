#安装说明:
	TeamTalk整套服务提供模块部署脚本和一键部署方案，主要模块有JDK,NGINX,PHP,PERCONA(MYSQL),
	REDIS,IM_WEB,IM_DB_PROXY,IM_SERVER,其中IM_WEB,IM_DB_PROXY,IM_SERVER为自主开发模块,其余
	均为开源解决方案,各个模块需要手动改动的地方如下:
######JDK: 
	无需改动
	jdk-7u67-linux-x64.rpm包由于过大，建议手动下载
######NGINX: 
	无需改动

######PHP: 
	在conf目录下包含两个配置文件 php-fpm.conf php.ini, 可以自行进行优化配置, 也可以选择不改动
	这两个文件

######PERCONA(MYSQL): 
	在安装脚本setup.sh中默认设置了PERCONA root用户的初始密码为12345,可以修改“MYSQL_PASSWORD=12345”
	对密码进行重设,一旦对密码进行更改,需要同时在IM_WEB与IM_DB_PROXY中进行更改,详见IM_WEB和IM_DB_PROXY
	配置说明。
	如果使用的是已存在的percona或者mysql,可以直接使用"mysql -u $USER -p$PASSWORD < macim.sql"进行库与表的创建。

######REDIS: 
	在conf目录下包含了redis.conf的配置文件, 可以自行进行优化配置,也可以选择不改动这个文件
 
######IM_WEB: 
	在conf目录下包含了db.php和im.com.conf两个配置文件,其中im.com.conf为NGINX所需要的配置文件,建议不
	改动;db.php文件主要配置了链接PERCONA所需要的参数,根据自己的需求修改'connectionString','username',
	'password'这三个参数。
	如果使用的是现有的nginx+php环境,可以修改setup.sh中的 PHP_WEB_SETUP_PATH为nginx放置web代码的路径,
	并且将PHP_NGINX_CONF_PATH修改为nginx配置文件的路径然后执行setup.sh脚本即可
	
	
######IM_DB_PROXY: 
	在安装配置脚本setup.sh中, DB_PROXY的默认监听Port设置为11000,如果被更改需要同时对IM_SERVER中的配
	置进行更改，详见IM_SERVER配置说明;在conf目录下,包含了cache-online.properties,db-online.properties和common-online.properties
	三个配置文件,其中cache-online为REDIS的配置参数,db-online为PERCONA的配置参数,若PERCONA进行过更改,则改
	成对应的链接参数即可,common-online中的ip需要改成IM_SERVER中的MSFS_SERVER的可访问地址

######IM_SERVER: 
	IM_SERVER下共有5种服务器,所以也需要对这些服务器进行分别配置

	1.LOGIN_SERVER: 
	ClientListenIP为用于Client端监听的本地地址
	MsgServerListenIP为用于Msg Server端监听的本地地址

	2.MSG_SERVER: 
	ListenIP为本机监听的IP,用于Client端的消息收发; 
	HttpListenIP监听的IP、Port用于IM_WEB创建固定群通知,可以在IM_WEB配置此处监听的IP、Port
	DBServerIP用于链接DB_PROXY,此处至少填两个数据库地址,也可以是同一个实例
	LoginServerIP用于链接LoginServer
	RouteServerIP用于链接RouteServer
	FileServerIP用于链接FileServer
	IpAddr填写的是Client端可以直接访问的地址,对于需要公网访问的情况下,如果是路由器映射,则需要填路由器
	映射在公网上的地址;此处需要填写两个Client端可以访问的地址,如果只有一个,则填写相同的地址即可

	3.ROUTE_SERVER: 
	根据说明配置需要监听的对应IP Port即可

	4.FILE_SERVER: 
	Address为Client端可以直接可以访问的IP地址,对于需要公网访问的情况下,如果是路由器映射,则需要填路由器
	映射在公网上的地址

	5.MSFS_SERVER: 
	ListenIP和Port填写的是监听的本地IP, BaseDir为默认保存图片文件的路径,如有必要可以更改

###一键部署:
	"强烈建议"选择一台未安装过的NGINX,PHP,MySQL,JDK,REDIS,并且OS为CentOS 6.X,在安装之前可以先执行
	"setup.sh check"命令进行上述环境的检查。检查通过后对各个模块进行一些配置文件的设置,其中主要设置
	的为IM_SERVER中的几个服务器地址设置,设置完成后运行"setup.sh install"

###模块部署:
	TeamTalk的各模块支持安装到不同的服务器上,所以部署可以根据自己的需要进行模块安装,主要修改的地方即为
	上述各个模块中的IP地址设置。根据自己的网络拓扑在conf文件夹下的各个配置文件中预先设置正确的IP地址,
	然后执行模块内的"setup install"即可


###IM_SERVER与IM_DB_PROXY架构图如下:

![](https://raw.githubusercontent.com/mogutt/TTServer/master/docs/pics/server.jpg)
