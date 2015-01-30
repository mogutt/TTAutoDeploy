/*
 Navicat MySQL Data Transfer

 Source Server         : 虚拟机
 Source Server Version : 50528
 Source Host           : 10.211.55.7
 Source Database       : macim

 Target Server Version : 50528
 File Encoding         : utf-8

 Date: 09/11/2014 13:54:59 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;


DROP DATABASE IF EXISTS macim;
CREATE DATABASE macim DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE macim;

-- ----------------------------
--  Table structure for `IMAdmin`
-- ----------------------------
DROP TABLE IF EXISTS `IMAdmin`;
CREATE TABLE `IMAdmin` (
  `id` mediumint(6) unsigned NOT NULL AUTO_INCREMENT,
  `uname` varchar(40) NOT NULL COMMENT '用户名',
  `pwd` char(32) NOT NULL COMMENT '密码',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '用户状态 0 :正常 1:删除 可扩展',
  `created` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `IMAdmin`
-- ----------------------------
BEGIN;
INSERT INTO `IMAdmin` VALUES ('2', 'admin', '21232f297a57a5a743894a0e4a801fc3', '0', '1408094820', '1408094854');
COMMIT;

-- ----------------------------
--  Table structure for `IMConfig`
-- ----------------------------
DROP TABLE IF EXISTS `IMConfig`;
CREATE TABLE `IMConfig` (
  `id` mediumint(6) unsigned NOT NULL AUTO_INCREMENT,
  `cname` varchar(40) NOT NULL COMMENT '名称',
  `value` char(15) NOT NULL COMMENT 'ip地址',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态 0:正常 , 1:删除',
  `created` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `IMConfig`
-- ----------------------------
BEGIN;
INSERT INTO `IMConfig` VALUES ('1', '1.1.2.221', '2.3.4.53', '0', '0', '0');
COMMIT;

-- ----------------------------
--  Table structure for `IMDepartment`
-- ----------------------------
DROP TABLE IF EXISTS `IMDepartment`;
CREATE TABLE `IMDepartment` (
  `id` mediumint(6) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL COMMENT '标题',
  `desc` varchar(255) NOT NULL COMMENT '描述',
  `pid` mediumint(6) unsigned NOT NULL DEFAULT '0' COMMENT '父id',
  `leader` mediumint(10) unsigned NOT NULL DEFAULT '0' COMMENT 'leader id',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '用户状态 0 :正常 1:删除 可扩展',
  `created` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `index_title` (`title`)
) ENGINE=MyISAM AUTO_INCREMENT=1011 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `IMDepartment`
-- ----------------------------
BEGIN;
INSERT INTO `IMDepartment` VALUES ('1009', '顶级管理层', '顶级管理层', '0', '10001', '0', '0', '1409816513'), ('1010', '二级部门', '二级部门', '1009', '10035', '0', '1409816822', '1409816822');
COMMIT;

-- ----------------------------
--  Table structure for `IMGroup`
-- ----------------------------
DROP TABLE IF EXISTS `IMGroup`;
CREATE TABLE `IMGroup` (
  `groupId` int(11) NOT NULL AUTO_INCREMENT,
  `groupName` varchar(256) NOT NULL DEFAULT '' COMMENT '群名称',
  `avatar` varchar(256) NOT NULL DEFAULT '' COMMENT '群头像',
  `adesc` varchar(512) NOT NULL DEFAULT '' COMMENT '群描述',
  `createUserId` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建者用户id',
  `groupType` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '群组类型，1-固定;2-临时群',
  `memberCnt` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '成员人数',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '是否删除,1-正常，0-删除',
  `updated` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `created` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`groupId`),
  KEY `idx_groupName` (`groupName`(255))
) ENGINE=MyISAM AUTO_INCREMENT=104241 DEFAULT CHARSET=utf8 COMMENT='IM群信息';

-- ----------------------------
--  Records of `IMGroup`
-- ----------------------------
BEGIN;
INSERT INTO `IMGroup` VALUES ('104240', '公司大群', 'g0/000/000/1409816408883559_140719535912.jpg', '公司大群', '0', '1', '1', '0', '1409817198', '1409816406');
COMMIT;

-- ----------------------------
--  Table structure for `IMGroupMessage`
-- ----------------------------
DROP TABLE IF EXISTS `IMGroupMessage`;
CREATE TABLE `IMGroupMessage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) unsigned NOT NULL COMMENT '用户的关系id',
  `userId` int(11) unsigned NOT NULL COMMENT '发送用户的id',
  `content` varchar(1024) NOT NULL DEFAULT '' COMMENT '消息内容',
  `status` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '预留',
  `updated` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `created` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `messageType` tinyint(3) unsigned NOT NULL DEFAULT '17' COMMENT '群消息类型,18为群语音,17为文本',
  PRIMARY KEY (`id`),
  KEY `idx_groupId_created` (`groupId`,`created`),
  KEY `idx_userId_groupId_created` (`userId`,`groupId`,`created`),
  KEY `idx_created` (`created`)
) ENGINE=MyISAM AUTO_INCREMENT=1797 DEFAULT CHARSET=utf8 COMMENT='IM群消息表';

-- ----------------------------
--  Table structure for `IMGroupRelation`
-- ----------------------------
DROP TABLE IF EXISTS `IMGroupRelation`;
CREATE TABLE `IMGroupRelation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) unsigned NOT NULL COMMENT '群Id',
  `userId` int(11) unsigned NOT NULL COMMENT '用户id',
  `title` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '群内角色，1-创建者',
  `groupType` int(4) unsigned NOT NULL DEFAULT '1' COMMENT '群组类型，1-固定;2-临时群',
  `status` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '是否退出群，1-正常，0-已退出',
  `created` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_userId_status_created` (`userId`,`status`,`created`),
  KEY `idx_groupId_status_created` (`groupId`,`status`,`created`),
  KEY `idx_groupId_userId_status` (`groupId`,`userId`,`status`),
  KEY `idx_userId_status_updated` (`userId`,`status`,`updated`)
) ENGINE=MyISAM AUTO_INCREMENT=37442 DEFAULT CHARSET=utf8 COMMENT='用户和群的关系表';

-- ----------------------------
--  Records of `IMGroupRelation`
-- ----------------------------
BEGIN;
INSERT INTO `IMGroupRelation` VALUES ('37441', '104240', '10035', '0', '1', '0', '1409816406', '0');
COMMIT;

-- ----------------------------
--  Table structure for `IMLogging`
-- ----------------------------
DROP TABLE IF EXISTS `IMLogging`;
CREATE TABLE `IMLogging` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `source` int(11) unsigned NOT NULL COMMENT '来源类型',
  `protocol` int(11) unsigned NOT NULL COMMENT '协议类型',
  `ip` int(11) unsigned NOT NULL COMMENT 'IP',
  `userId` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户',
  `os` varchar(255) NOT NULL COMMENT '操作系统',
  `userAgent` varchar(255) NOT NULL COMMENT '用户agent',
  `flash` varchar(255) NOT NULL COMMENT 'flash版本',
  `client` varchar(255) NOT NULL COMMENT 'client版本',
  `created` int(11) unsigned NOT NULL COMMENT '创建时间',
  `type` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '日志类型',
  `referer` varchar(255) NOT NULL DEFAULT '' COMMENT 'refer url',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT '来源,即web上按钮的data-from',
  PRIMARY KEY (`id`),
  KEY `idx_created` (`created`),
  KEY `idx_userId_created` (`userId`,`created`)
) ENGINE=MyISAM AUTO_INCREMENT=2542716 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `IMMessage`
-- ----------------------------
DROP TABLE IF EXISTS `IMMessage`;
CREATE TABLE `IMMessage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `relateId` int(11) unsigned NOT NULL COMMENT '用户的关系id',
  `fromUserId` int(11) unsigned NOT NULL COMMENT '发送用户的id',
  `toUserId` int(11) unsigned NOT NULL COMMENT '接收用户的id',
  `content` varchar(4095) DEFAULT '' COMMENT '消息内容',
  `type` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '消息类型，1:客服;',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0正常 1被删除',
  `updated` int(11) unsigned NOT NULL COMMENT '更新时间',
  `created` int(11) unsigned NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_relateId_status_created` (`relateId`,`status`,`created`),
  KEY `idx_fromUserId_created` (`fromUserId`,`created`),
  KEY `idx_toUserId_created` (`toUserId`,`created`),
  KEY `idx_created` (`created`)
) ENGINE=MyISAM AUTO_INCREMENT=1783657 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `IMMessageUserTalkDate`
-- ----------------------------
DROP TABLE IF EXISTS `IMMessageUserTalkDate`;
CREATE TABLE `IMMessageUserTalkDate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) unsigned NOT NULL COMMENT '用户id',
  `friendUserId` int(11) unsigned NOT NULL COMMENT '对话的用户id',
  `date` int(11) NOT NULL COMMENT '对话的日期',
  `created` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_userId_date` (`userId`,`date`),
  KEY `idx_userId_updated` (`userId`,`updated`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `IMRecentContact`
-- ----------------------------
DROP TABLE IF EXISTS `IMRecentContact`;
CREATE TABLE `IMRecentContact` (
  `relateId` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) unsigned NOT NULL COMMENT '用户A的id',
  `friendUserId` int(11) unsigned NOT NULL COMMENT '用户B的id',
  `status` tinyint(1) unsigned DEFAULT '0' COMMENT '用户A删除',
  `created` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`relateId`),
  KEY `idx_userId_friendUserId` (`userId`,`friendUserId`),
  KEY `idx_userId_updated` (`userId`,`updated`)
) ENGINE=MyISAM AUTO_INCREMENT=17857085 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Table structure for `IMTransmitFile`
-- ----------------------------
DROP TABLE IF EXISTS `IMTransmitFile`;
CREATE TABLE `IMTransmitFile` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `userId` int(10) unsigned NOT NULL COMMENT '发送者蘑菇街用户ID',
  `toUserId` int(10) unsigned NOT NULL COMMENT '接收者蘑菇街用户ID',
  `filePath` varchar(500) NOT NULL DEFAULT '' COMMENT '文件名',
  `fsize` int(10) unsigned NOT NULL COMMENT '发送者蘑菇街用户ID',
  `taskId` varchar(100) NOT NULL DEFAULT '' COMMENT '任务ID',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT '状态(1 => 等待接收, 0=> 已接收)',
  `created` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `updated` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_toUserId_created_status` (`toUserId`,`created`,`status`),
  KEY `idx_userId_created_status` (`userId`,`created`,`status`),
  KEY `idx_created` (`created`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='IM离线文件表';

-- ----------------------------
--  Table structure for `IMUsers`
-- ----------------------------
DROP TABLE IF EXISTS `IMUsers`;
CREATE TABLE `IMUsers` (
  `id` mediumint(6) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL COMMENT '用户标题',
  `uname` varchar(40) NOT NULL COMMENT '用户名',
  `pwd` char(32) NOT NULL COMMENT '用户密码md5加密',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '用户状态 0:正常 , 1:删除',
  `avatar` varchar(255) DEFAULT '/avatar/avatar_default.jpg' COMMENT '头像照片',
  `nickName` varchar(40) NOT NULL COMMENT '用户别名',
  `departId` mediumint(6) unsigned NOT NULL COMMENT '用户所属部门id',
  `sex` tinyint(1) unsigned NOT NULL COMMENT '用户性别',
  `position` varchar(255) NOT NULL COMMENT '用户地址(预留)',
  `telphone` varchar(16) NOT NULL COMMENT '用户手机',
  `mail` varchar(255) NOT NULL COMMENT '用户邮箱',
  `jobNumber` mediumint(6) unsigned NOT NULL COMMENT '用户工号',
  `created` int(11) unsigned NOT NULL COMMENT '创建时间',
  `updated` int(11) unsigned NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `index_uname` (`uname`)
) ENGINE=MyISAM AUTO_INCREMENT=10038 DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `IMAudio`;
CREATE TABLE `IMAudio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) unsigned NOT NULL COMMENT '用户的关系id',
  `toUserId` int(11) unsigned NOT NULL COMMENT '发送用户的id',
  `path` varchar(255) DEFAULT '' COMMENT '消息内容',
  `fileSize` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '发送用户的id',
  `costTime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '发送用户的id',
  `created` int(11) unsigned NOT NULL COMMENT '接收用户的id',
  PRIMARY KEY (`id`),
  KEY `idx_userId_toUserId_path` (`userId`,`toUserId`,`path`),
  KEY `idx_toUserId` (`toUserId`),
  KEY `idx_path` (`path`),
  KEY `idx_created` (`created`)
) ENGINE=InnoDB AUTO_INCREMENT=17346 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `IMUsers`
-- ----------------------------
BEGIN;
INSERT INTO `IMUsers` VALUES ('10035', '工程师', 'A', '123456', '0', 'g0/000/000/1409816667299972_140719535912.jpg', 'A', '1009', '1', '杭州', '13958633158', 'test@mail.com', '1', '0', '1409816664'), ('10036', '工程师', 'B', '123456', '0', 'g0/000/000/1409816667299972_140719535912.jpg', 'B', '1010', '1', '杭州', '13958633158', 'test@mail.com', '1', '0', '1409817528'), ('10037', '工程师', 'C', '123456', '0', 'g0/000/000/1409816667299972_140719535912.jpg', 'C', '1010', '1', '杭州', '13958633158', 'test@mail.com', '1', '0', '1409817521');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
