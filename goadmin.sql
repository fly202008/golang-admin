/*
SQLyog Ultimate v11.27 (32 bit)
MySQL - 5.5.53 : Database - goadmin
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`goadmin` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `goadmin`;

/*Table structure for table `go_user` */

DROP TABLE IF EXISTS `go_user`;

CREATE TABLE `go_user` (
  `id` tinyint(100) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(32) NOT NULL COMMENT '用户名',
  `password` varchar(32) NOT NULL COMMENT '密码',
  `nickname` varchar(32) DEFAULT NULL COMMENT '昵称',
  `sex` tinyint(1) NOT NULL DEFAULT '0' COMMENT '性别',
  `email` varchar(32) NOT NULL COMMENT '邮箱',
  `salt` char(5) NOT NULL COMMENT 'salt',
  `addtime` int(11) DEFAULT NULL COMMENT '注册时间',
  `face` varchar(200) NOT NULL DEFAULT '/static/face/boy.jpg' COMMENT '头像',
  `level` tinyint(10) NOT NULL DEFAULT '10' COMMENT '级别',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '会员状态',
  `login` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录次数',
  `role_id` varchar(255) NOT NULL COMMENT '角色名称',
  `last_login_time` int(11) DEFAULT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(60) DEFAULT NULL COMMENT '最后登录IP',
  `last_login_area` varchar(30) DEFAULT NULL COMMENT '最后登录地址',
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  KEY `status` (`status`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='管理员表';

/*Data for the table `go_user` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
