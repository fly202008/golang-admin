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

/*Table structure for table `go_book` */

DROP TABLE IF EXISTS `go_book`;

CREATE TABLE `go_book` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `typeid` int(10) unsigned NOT NULL COMMENT '栏目ID',
  `name` varchar(255) NOT NULL COMMENT '书名',
  `author` varchar(255) NOT NULL COMMENT '作者',
  `updatatime` varchar(255) NOT NULL COMMENT '最后更新时间',
  `endcase` varchar(255) NOT NULL COMMENT '最后章节',
  `info` varchar(500) NOT NULL COMMENT '小说简介',
  `click` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '点击量',
  `save` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏量',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `go_book` */

/*Table structure for table `go_book_case` */

DROP TABLE IF EXISTS `go_book_case`;

CREATE TABLE `go_book_case` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `book_id` int(10) unsigned NOT NULL COMMENT '书ID',
  `user_id` int(11) NOT NULL COMMENT '用户ID',
  `addtime` int(10) unsigned NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `go_book_case` */

/*Table structure for table `go_member` */

DROP TABLE IF EXISTS `go_member`;

CREATE TABLE `go_member` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `username` varchar(255) NOT NULL COMMENT '用户名',
  `email` varchar(255) NOT NULL COMMENT '邮箱',
  `password` char(32) NOT NULL COMMENT '密码',
  `addtime` int(10) unsigned NOT NULL COMMENT '注册时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `go_member` */

/*Table structure for table `go_type` */

DROP TABLE IF EXISTS `go_type`;

CREATE TABLE `go_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(155) DEFAULT NULL COMMENT '栏目名称',
  `is_navi` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '是否导航显示',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Data for the table `go_type` */

/*Table structure for table `go_user` */

DROP TABLE IF EXISTS `go_user`;

CREATE TABLE `go_user` (
  `id` tinyint(100) unsigned NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(32) NOT NULL COMMENT '用户名',
  `password` varchar(32) NOT NULL COMMENT '密码',
  `addtime` int(11) DEFAULT NULL COMMENT '注册时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '会员状态',
  `last_login_time` int(11) NOT NULL COMMENT '最后登录时间',
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COMMENT='管理员表';

/*Data for the table `go_user` */

insert  into `go_user`(`id`,`username`,`password`,`addtime`,`status`,`last_login_time`) values (1,'admin','e10adc3949ba59abbe56e057f20f883e',0,1,1561449867),(2,'dsfsa','e10adc3949ba59abbe56e057f20f883e',1561429867,1,1561429867),(3,'hgftgh','',NULL,0,0),(4,'jhgjty','',NULL,0,0),(5,'5765','',NULL,1,0),(6,'567','',NULL,1,0),(7,'u67u','',NULL,1,0),(8,'6u','',NULL,1,0),(9,'67uj','',NULL,1,0),(10,'67j','',NULL,1,0),(11,'67j','',NULL,1,0),(12,'67j','',NULL,1,0);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
