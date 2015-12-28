-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.0.27-community-nt


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema lifebook
--

CREATE DATABASE IF NOT EXISTS facebook2;
USE facebook2;

--
-- Definition of table `blogs`
--

DROP TABLE IF EXISTS `blogs`;
CREATE TABLE `blogs` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(255) default NULL,
  `content` text,
  `writeDatetime` datetime NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `isPrivate` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `blogs`
--

/*!40000 ALTER TABLE `blogs` DISABLE KEYS */;
INSERT INTO `blogs` (`id`,`title`,`content`,`writeDatetime`,`user_id`,`isPrivate`) VALUES 
 (13,'写出你的心情，写出你的生活。','写出你的心情，写出你的生活。','2007-06-04 23:20:21',1,0),
 (14,'this is a gooooood day.','<p><font face=\"Comic Sans MS\" size=\"5\">Come baby.</font></p>\r\n<p>I want it.<img alt=\"\" src=\"/javascripts/fckeditor/editor/images/smiley/msn/cry_smile.gif\" /></p>','2007-06-08 09:41:00',1,0),
 (15,'今天真不好玩啊。','<p><img alt=\"\" src=\"/javascripts/fckeditor/editor/images/smiley/msn/sad_smile.gif\" /></p>\r\n<span style=\"FONT-WEIGHT: bold\">\r\n<p>小郑又有事情去了。<br />\r\n我发现这可真难啊。<br />\r\n袁老师发生的事情都在我身上发生了。不过他也教了我很多处理事情的方法。我觉得真的有必要去大公司实习以下啊。</p>\r\n</span>','2007-06-08 13:22:12',1,0),
 (16,'我发现facebook还真是聪明啊。','<p>他们把我想的都想到了啊。哈哈。我也得加油了。准备做中国的facebook。那个什么xiaonei拉。yeedee的都做得太差了。</p>\r\n<p>怎么说呢。他们技术其实还可以拉。</p>','2007-06-08 13:32:53',1,0),
 (20,'submit 小技巧','<p><font face=\"Arial\"><img alt=\"\" src=\"/javascripts/fckeditor/editor/images/smiley/msn/regular_smile.gif\" />&nbsp;</font><font face=\"Arial\">disable_with 是一个非常不错的submit_tag的option哦</font></p>\r\n<p>按了按钮，就可以disable掉按钮。</p>','2007-06-08 13:38:32',1,1);
INSERT INTO `blogs` (`id`,`title`,`content`,`writeDatetime`,`user_id`,`isPrivate`) VALUES 
 (22,'I love friendbook.','<p>You should give you website a name.</p>\r\n<p align=\"center\"><font face=\"Tahoma\" size=\"7\">Facebook2 ???</font></p>','2007-06-08 16:49:08',1,0),
 (23,'写出我第一篇博客','<p>哈哈哈哈。我来了</p>\r\n<p>我终于来了。大家好啊。</p>','2007-06-12 19:57:18',4,0),
 (24,'我也要写博客','妈妈米亚。','2007-06-14 12:27:37',3,0),
 (25,'睡醒了。哈哈哈哈','<p>真TMD无聊啊。</p>\r\n<p>项目好难做哦</p>','2007-06-14 19:04:13',1,0),
 (26,'现在的处境好复杂啊。lifebook is so complicated.','<p><font face=\"Arial\">邮件系统<br />\r\n圈子系统<br />\r\n用户系统<br />\r\n权限系统</font></p>\r\n<font face=\"Arial\">\r\n<p><br />\r\n圈子设计:<br />\r\n需要有成员列表：成员是最重要的<br />\r\n要有论坛或者聊天板<br />\r\n圈内人的一个统计<br />\r\n圈内人建的群<br />\r\n圈内人发的blog<br />\r\n圈内人的相册<br />\r\nbirthday<br />\r\nshare thing to circle<br />\r\n圈主可以修改公告，可以赶走人，可以转交(步骤)。</p>\r\n<p><br />\r\n没有官方这个概念。就是说一进去，仅仅是让这个圈子内的人能够交流而已。<br />\r\n只是协助一下圈子里的人的交流而已。</p>\r\n<p>system log</p>\r\n</font>','2007-06-14 19:53:01',1,0),
 (28,'我的博客开始拉','大家来关注哦','2007-06-14 22:38:05',9,0);
INSERT INTO `blogs` (`id`,`title`,`content`,`writeDatetime`,`user_id`,`isPrivate`) VALUES 
 (29,'今天天气很好。昨天天气很不好，但是我们居然去拍照。','<p align=\"center\"><img height=\"232\" width=\"350\" border=\"0\" alt=\"\" src=\"http://localhost/uploads/momentView/2006-08-18/i2ty0dt1z4ww0h3k7eoy2gh1ftagqg.jpg\" /></p>\r\n<p>郁闷死了，今天拍了的照片太恶心了。看看多么残酷的情况啊。但是我们的主角还是笑得那么开心。</p>','2007-06-15 12:38:19',1,0),
 (30,'去了云南玩。好爽。哈哈','<p>在瑞丽哦。好漂亮啊。</p>\r\n<p><img height=\"285\" width=\"380\" border=\"0\" alt=\"\" src=\"http://localhost/uploads/momentView/2007-05-14/ksiny78wq4ibhjfxybphqpev0ailzt.jpg\" /></p>\r\n<p><img height=\"285\" width=\"380\" alt=\"\" src=\"http://localhost/uploads/momentView/2007-05-14/e1qvhm3lmpfl8df8czioxrh5kz8hgf.jpg\" /></p>','2007-06-15 14:13:21',3,0),
 (31,'好酷哦','<p>今天天气不好。所以心情不好。</p>','2007-06-15 14:14:38',3,0);
/*!40000 ALTER TABLE `blogs` ENABLE KEYS */;


--
-- Definition of table `diaries`
--

DROP TABLE IF EXISTS `diaries`;
CREATE TABLE `diaries` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `date` date NOT NULL,
  `title` varchar(100) default NULL,
  `content` text,
  `user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `diaries`
--

/*!40000 ALTER TABLE `diaries` DISABLE KEYS */;
INSERT INTO `diaries` (`id`,`date`,`title`,`content`,`user_id`) VALUES 
 (1,'2007-08-18',NULL,NULL,1),
 (2,'2002-01-01',NULL,NULL,1);
/*!40000 ALTER TABLE `diaries` ENABLE KEYS */;


--
-- Definition of table `groupmessages`
--

DROP TABLE IF EXISTS `groupmessages`;
CREATE TABLE `groupmessages` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `sender_id` int(10) unsigned NOT NULL,
  `group_id` int(10) unsigned NOT NULL,
  `content` text NOT NULL,
  `sendDatetime` datetime NOT NULL,
  `quote_message_id` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `groupmessages`
--

/*!40000 ALTER TABLE `groupmessages` DISABLE KEYS */;
INSERT INTO `groupmessages` (`id`,`sender_id`,`group_id`,`content`,`sendDatetime`,`quote_message_id`) VALUES 
 (1,2,23,'aaaaaaaa','2007-05-29 16:15:37',NULL),
 (2,2,23,'aaaaaaaaaaaaaa','2007-05-29 16:15:40',NULL),
 (3,1,25,'asdfasdf','2007-05-30 17:45:47',NULL),
 (4,1,25,'sadfsdf','2007-05-30 17:45:50',NULL),
 (5,1,25,'sdfsdfdf','2007-05-30 17:45:52',NULL),
 (6,1,25,'sdfsafsdfasdf','2007-05-30 17:45:55',NULL),
 (7,1,25,'asdfsadf','2007-05-30 17:45:57',NULL),
 (8,1,25,'asdf','2007-05-30 17:52:48',NULL),
 (9,1,1,'圈子兄弟','2007-05-31 20:26:08',NULL),
 (10,4,28,'大家好。我来了','2007-06-12 19:56:19',NULL),
 (11,4,28,'哈哈哈哈','2007-06-12 19:56:23',NULL),
 (12,1,29,'大家好，欢迎来到05计2.哈哈哈哈。','2007-06-13 21:18:04',NULL),
 (13,3,28,'我来拉。','2007-06-14 14:49:31',NULL),
 (14,1,28,'有没有意思拉\r\n','2007-06-14 19:17:44',NULL),
 (15,1,28,'有点无聊哦。','2007-06-14 19:17:52',NULL),
 (16,1,28,'我觉得圈子是不是应该有个概念就是share every group members\' things','2007-06-14 19:18:40',NULL),
 (17,1,28,'大家的博客，大家新交的朋友，大家的新照片。','2007-06-14 19:27:11',NULL);
INSERT INTO `groupmessages` (`id`,`sender_id`,`group_id`,`content`,`sendDatetime`,`quote_message_id`) VALUES 
 (18,1,29,'有没有什么新技术学到啊大家？？？','2007-06-14 19:47:48',NULL),
 (19,1,28,'笑什么啊。','2007-06-15 10:13:56',11),
 (20,3,33,'怪物怪物，好多怪物。','2007-06-16 10:27:40',NULL);
/*!40000 ALTER TABLE `groupmessages` ENABLE KEYS */;


--
-- Definition of table `groups`
--

DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `creator_id` int(10) unsigned NOT NULL,
  `createDatetime` datetime NOT NULL,
  `intro` varchar(255) default NULL,
  `interesting` varchar(255) default NULL,
  `bulletin` text,
  `portrait` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `groups`
--

/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` (`id`,`name`,`creator_id`,`createDatetime`,`intro`,`interesting`,`bulletin`,`portrait`) VALUES 
 (28,'宝宝圈子',3,'2007-06-11 22:09:25','我的宝宝。','宝宝','各位注意，请不要随地大小便啊。','yxhkxXBJCpWrxMneO8dJ.jpg'),
 (29,'浙江大学-05届计算机科学与技术2班',1,'2007-06-13 21:16:56','永结同心。','计算机','欢迎来到浙江大学-05届计算机科学与技术2班','B4pxSHBa2cFsEgWq5ztj.jpg'),
 (30,'浙江大学-05届计算机科学与技术1班',3,'2007-06-15 12:47:39','我们永远在一起。','计算机，浙江大学','欢迎来到浙江大学-05届计算机科学与技术1班','k468tan7j7uwx2mbijjyw6sud0g1f5.jpg'),
 (31,'飞车一族',3,'2007-06-15 12:49:06','我们都是飞车一族。车速超过300码才可以。','飞车，汽车','欢迎来到飞车一族','0um061tcplluxkhttu7a5fwx1z5y2z.jpg'),
 (32,'室内装潢',3,'2007-06-15 12:49:50','给自己的房子装潢的漂亮一点。','室内装潢','欢迎来到室内装潢','o4exl2jn5gzqxuj4mrs471ovrabq2v.jpg'),
 (33,'怪物学院',3,'2007-06-15 12:55:22','怪物一族，我们这里只有怪物。','怪物','欢迎来到怪物学院','qfntc864zzefy14y5yxe8jkn0rspuj.jpg');
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;


--
-- Definition of table `groups_users`
--

DROP TABLE IF EXISTS `groups_users`;
CREATE TABLE `groups_users` (
  `group_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `groups_users`
--

/*!40000 ALTER TABLE `groups_users` DISABLE KEYS */;
INSERT INTO `groups_users` (`group_id`,`user_id`) VALUES 
 (28,4),
 (28,1),
 (32,1),
 (31,1),
 (33,1);
/*!40000 ALTER TABLE `groups_users` ENABLE KEYS */;


--
-- Definition of table `messages`
--

DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `sender_id` int(10) unsigned default NULL,
  `receiver_id` int(10) unsigned default NULL,
  `isPrivate` tinyint(1) default NULL,
  `sendDatetime` datetime default NULL,
  `quote_message_id` int(10) unsigned default NULL,
  `quote_diary_id` int(10) unsigned default NULL,
  `quote_photo_id` int(10) unsigned default NULL,
  `content` text,
  `quote_post_id` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`),
  KEY `FK_messages_sender` (`sender_id`),
  KEY `FK_messages_receiver` (`receiver_id`),
  CONSTRAINT `FK_messages_sender` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `messages`
--

/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` (`id`,`sender_id`,`receiver_id`,`isPrivate`,`sendDatetime`,`quote_message_id`,`quote_diary_id`,`quote_photo_id`,`content`,`quote_post_id`) VALUES 
 (1,1,1,0,'2007-05-26 23:49:25',NULL,NULL,NULL,'主角有什么用',1),
 (2,2,1,0,'2007-05-26 23:50:42',NULL,NULL,NULL,'主角好啊',1),
 (3,1,1,0,'2007-05-27 19:31:48',NULL,NULL,11,'so goooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooood.',NULL),
 (4,1,1,0,'2007-05-27 19:45:19',NULL,1,NULL,'迪斯尼乐园一游。',NULL),
 (6,1,1,0,'2007-05-28 01:00:09',NULL,NULL,21,'aaaaaaaaaaaaaaaaaaaaaa',NULL),
 (7,1,1,0,'2007-05-28 01:01:04',NULL,NULL,18,'asdfsdf',NULL),
 (8,1,1,0,'2007-05-28 01:01:21',7,NULL,NULL,'coool',NULL),
 (9,1,2,0,'2007-05-29 15:26:38',NULL,NULL,NULL,'aaaa',NULL),
 (13,3,2,0,'2007-05-29 16:58:52',NULL,NULL,NULL,'aaa',NULL),
 (17,1,1,0,'2007-05-29 21:38:39',NULL,NULL,547,'真好',NULL),
 (18,1,3,0,'2007-05-30 18:00:38',NULL,NULL,NULL,'asdfsdf',NULL),
 (25,1,3,0,'2007-05-30 18:04:54',NULL,NULL,NULL,'DDWJC-VFGHJ-7GFK6-9QK3D-PFTHW',NULL),
 (29,3,3,0,'2007-06-04 22:46:49',NULL,62,NULL,'goooooooooooooooood',NULL);
INSERT INTO `messages` (`id`,`sender_id`,`receiver_id`,`isPrivate`,`sendDatetime`,`quote_message_id`,`quote_diary_id`,`quote_photo_id`,`content`,`quote_post_id`) VALUES 
 (30,1,2,0,'2007-06-08 16:21:55',NULL,NULL,NULL,'最近有没有卖啊？',NULL),
 (31,1,2,0,'2007-06-08 16:22:01',NULL,NULL,NULL,'高什么东西啊',NULL),
 (32,1,2,0,'2007-06-08 16:23:54',NULL,NULL,NULL,'族谱好也好也 哈哈啊哈获得 ',NULL),
 (33,1,2,0,'2007-06-08 16:26:38',NULL,NULL,NULL,'邻家女孩。',NULL),
 (34,1,2,0,'2007-06-08 16:30:57',NULL,NULL,NULL,'<ol>\r\n    <li>你好啊。最近在干什么啊？？？</li>\r\n    <li>哈哈哈哈</li>\r\n    <li>你们在干什么啊</li>\r\n</ol>',NULL),
 (35,1,2,0,'2007-06-08 16:33:11',NULL,NULL,NULL,'以前什么的团员啊。我也不是很知道啊。其实我们都不去<strong>夜店</strong>的。',NULL),
 (36,1,2,0,'2007-06-08 16:33:23',NULL,NULL,NULL,'&lt;script&gt;&lt;/script&gt;',NULL),
 (37,1,2,1,'2007-06-08 16:33:59',NULL,NULL,NULL,'<p>是否应该将个人信息放到上面呢？？？？</p>',NULL),
 (38,1,1,0,'2007-06-08 16:46:53',NULL,NULL,NULL,'自己回自己总行了吧。哈哈哈哈哈哈。',6);
INSERT INTO `messages` (`id`,`sender_id`,`receiver_id`,`isPrivate`,`sendDatetime`,`quote_message_id`,`quote_diary_id`,`quote_photo_id`,`content`,`quote_post_id`) VALUES 
 (39,4,1,0,'2007-06-08 23:29:01',NULL,NULL,NULL,'十分钟发一条?\r\n我觉得是不是可以缓一下，因为，有可能以后可以收费呢？',6),
 (42,1,1,0,'2007-06-09 14:26:38',NULL,NULL,NULL,'说得好。',6),
 (49,4,4,0,'2007-06-14 13:12:09',NULL,NULL,NULL,'现在有聊天记录了吧。哈哈哈哈哈',NULL),
 (50,4,4,0,'2007-06-14 13:12:18',NULL,NULL,NULL,'大学有意思。',NULL),
 (52,1,1,0,'2007-01-18 17:43:21',NULL,NULL,NULL,'真的是好书哦。',8),
 (53,1,1,0,'2007-01-18 17:59:15',NULL,1,NULL,'<p>啊？</p>',NULL),
 (54,1,1,0,'2007-01-18 17:59:47',NULL,NULL,5,'这个好',NULL),
 (55,1,4,0,'2007-08-18 21:16:07',NULL,NULL,NULL,'<p>你在吗？</p>',NULL),
 (59,3,1,0,'2007-08-18 22:03:32',NULL,NULL,1,'美女杀人了。',NULL),
 (60,3,1,0,'2007-08-18 22:04:14',NULL,NULL,4,'<ul>\r\n    <li><strong>胖嘟嘟</strong></li>\r\n</ul>',NULL);
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;


--
-- Definition of table `photos`
--

DROP TABLE IF EXISTS `photos`;
CREATE TABLE `photos` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `takeDatetime` datetime NOT NULL,
  `description` varchar(255) default NULL,
  `filename` varchar(100) NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `filesize` float NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `photos`
--

/*!40000 ALTER TABLE `photos` DISABLE KEYS */;
INSERT INTO `photos` (`id`,`takeDatetime`,`description`,`filename`,`user_id`,`filesize`) VALUES 
 (1,'2007-08-18 13:18:09','','widgl7ypvvnesug7bkjmjcfs7yqfxc.jpg',1,60535),
 (2,'2007-08-18 13:18:10','','l8evnjkhu5an8lwljwg2aqzubklfna.jpg',1,59738),
 (3,'2007-08-18 13:18:11','','j8t5vhi1vtrueyjn34bqeylx6k12c0.jpg',1,60857),
 (4,'2007-08-18 13:18:12','','hjm73xowqb7au620iod081z314lg1l.jpg',1,39822),
 (5,'2002-01-01 00:09:33','','lt3unb3zci63xymprzv2x15qagqx2g.jpg',1,1.31706e+006);
/*!40000 ALTER TABLE `photos` ENABLE KEYS */;


--
-- Definition of table `posts`
--

DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `poster_id` int(10) unsigned NOT NULL,
  `postDatetime` datetime NOT NULL,
  `postClass` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `FK_posts_user` (`poster_id`),
  CONSTRAINT `FK_posts_user` FOREIGN KEY (`poster_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `posts`
--

/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` (`id`,`title`,`content`,`poster_id`,`postDatetime`,`postClass`) VALUES 
 (4,'aaa','bbb',1,'2007-01-18 15:42:13',3),
 (5,'bbb','bbb',1,'2007-01-18 15:42:25',2),
 (6,'aa','aaa',1,'2007-01-18 15:44:51',3),
 (7,'太牛了RPG','aaaa',1,'2007-01-18 15:49:30',2),
 (8,'good book','book',1,'2007-01-18 16:02:59',5),
 (9,'最近有什么好游戏玩啊。','FF7有没有的下载啊？',1,'2007-01-18 17:36:30',2);
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;


--
-- Definition of table `programs`
--

DROP TABLE IF EXISTS `programs`;
CREATE TABLE `programs` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `icon` varchar(50) NOT NULL,
  `supportEmail` varchar(50) NOT NULL,
  `intro` text NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `programs`
--

/*!40000 ALTER TABLE `programs` DISABLE KEYS */;
/*!40000 ALTER TABLE `programs` ENABLE KEYS */;


--
-- Definition of table `schema_info`
--

DROP TABLE IF EXISTS `schema_info`;
CREATE TABLE `schema_info` (
  `version` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `schema_info`
--

/*!40000 ALTER TABLE `schema_info` DISABLE KEYS */;
INSERT INTO `schema_info` (`version`) VALUES 
 (0);
/*!40000 ALTER TABLE `schema_info` ENABLE KEYS */;


--
-- Definition of table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `session_id` varchar(255) default NULL,
  `data` text,
  `updated_at` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sessions`
--

/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` (`id`,`session_id`,`data`,`updated_at`) VALUES 
 (194,'ec175d487d875bdc037e0c6c955af017','BAh7BzoJdXNlcm86CVVzZXIMOg1AZnJpZW5kczA6EEB1c2VyRGV0YWlsMDoM\nQGdyb3VwczA6EEBhdHRyaWJ1dGVzewsiFXJlZ2lzdGVyRGF0ZXRpbWUiGDIw\nMDctMDUtMjYgMjI6MzY6MTEiCmlzVklQIgYxIg11c2VybmFtZSIMaGx4d2Vs\nbCIHaWQiBjEiDXBhc3N3b3JkIgsxMjMzMjEiCmVtYWlsIhZobHh3ZWxsQGdt\nYWlsLmNvbToLQGJsb2dzMDoSQHNlbnRNZXNzYWdlczA6FkByZWNlaXZlZE1l\nc3NhZ2VzMCIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZs\nYXNoSGFzaHsABjoKQHVzZWR7AA==\n','2007-08-18 21:14:17'),
 (197,'9f7494cda445e68e9072f0021b34d8ff','BAh7BzoJdXNlcm86CVVzZXIMOgtAYmxvZ3MwOgxAZ3JvdXBzMDoSQHNlbnRN\nZXNzYWdlczA6EEBhdHRyaWJ1dGVzewsiCmlzVklQIgYxIhVyZWdpc3RlckRh\ndGV0aW1lIhgyMDA3LTA1LTI2IDIyOjM2OjExIg11c2VybmFtZSIMaGx4d2Vs\nbCIHaWQiBjEiDXBhc3N3b3JkIgsxMjMzMjEiCmVtYWlsIhZobHh3ZWxsQGdt\nYWlsLmNvbToNQGZyaWVuZHMwOhBAdXNlckRldGFpbDA6FkByZWNlaXZlZE1l\nc3NhZ2VzMCIKZmxhc2hJQzonQWN0aW9uQ29udHJvbGxlcjo6Rmxhc2g6OkZs\nYXNoSGFzaHsABjoKQHVzZWR7AA==\n','2007-08-18 22:06:11');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;


--
-- Definition of table `squareclasses`
--

DROP TABLE IF EXISTS `squareclasses`;
CREATE TABLE `squareclasses` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `parentClassID` int(10) unsigned default NULL,
  `icon` varchar(45) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `squareclasses`
--

/*!40000 ALTER TABLE `squareclasses` DISABLE KEYS */;
INSERT INTO `squareclasses` (`id`,`name`,`parentClassID`,`icon`) VALUES 
 (1,'PSP游戏',0,'1.gif'),
 (2,'RPG',1,''),
 (3,'SLG',1,''),
 (4,'ROR资源',0,'2.gif'),
 (5,'电子书',4,NULL),
 (6,'视频教程',4,NULL),
 (7,'常见问题',4,NULL);
/*!40000 ALTER TABLE `squareclasses` ENABLE KEYS */;


--
-- Definition of table `user_details`
--

DROP TABLE IF EXISTS `user_details`;
CREATE TABLE `user_details` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `user_id` int(10) unsigned default NULL,
  `realname` varchar(20) default NULL,
  `sex` varchar(4) default NULL,
  `birthday` date default NULL,
  `hometown` varchar(45) default NULL,
  `school` varchar(45) default NULL,
  `job` varchar(45) default NULL,
  `qq` varchar(20) default NULL,
  `sign` varchar(4) default NULL,
  `astro` varchar(9) default NULL,
  `intro` varchar(255) default NULL,
  `interest` varchar(255) default NULL,
  `portrait` varchar(100) default '',
  `profilePrivacy` varchar(10) default 'all',
  `lifebookPrivacy` varchar(10) default 'all',
  `lifebookViewType` varchar(10) default 'show',
  `friendPrivacy` varchar(10) default 'all',
  `groupPrivacy` varchar(10) default 'all',
  `messagePrivacy` varchar(10) default 'all',
  PRIMARY KEY  (`id`),
  KEY `FK_user_details_userID` (`user_id`),
  CONSTRAINT `FK_user_details_userID` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user_details`
--

/*!40000 ALTER TABLE `user_details` DISABLE KEYS */;
INSERT INTO `user_details` (`id`,`user_id`,`realname`,`sex`,`birthday`,`hometown`,`school`,`job`,`qq`,`sign`,`astro`,`intro`,`interest`,`portrait`,`profilePrivacy`,`lifebookPrivacy`,`lifebookViewType`,`friendPrivacy`,`groupPrivacy`,`messagePrivacy`) VALUES 
 (1,1,'宝宝的豆子','男','1983-04-28','杭州','浙江大学','程序员','13414902','猪','白羊座','谢谢大家观赏。','编程','ZCtwVJeVuYzR6FChLwMJ.jpg','friend','friend','show','friend','friend','friend'),
 (2,2,'aaaaaaa','男','1960-05-26','','','','','鼠','白羊座','','','','all','all','show','all','all','all'),
 (3,3,'黄媛','女','1983-12-21','江西','浙江大学','兔宝宝','123321','猪','射手座','我喜欢，我就打你骂你。o(∩_∩)o...哈哈','生气，骂人','u1xl1vwvk4q728ozpgxtlc5nckdt7y.jpg','all','all','show','all','self','all'),
 (4,4,'test','男','1960-06-08','杭州','浙大','','','鼠','白羊座','this is me.','','xSxg7PxuLKfeQjfzJFMX.jpg','all','all','show','all','all','all'),
 (5,5,'王小虎','男','1960-06-14','长春','清华','','','鼠','白羊座','哈哈我就是我','','uvydwfzi1wy1j3bmkl2brw1byin04s.jpg','all','all','show','all','all','all'),
 (6,6,'宝宝的豆子','男','1960-06-14','杭州','清华','中国人看看','123321','鼠','白羊座','我是一个人','编程','b6714gkzddce6f5oo7lg8o6wqhm7nh.jpg','all','all','show','all','all','all');
INSERT INTO `user_details` (`id`,`user_id`,`realname`,`sex`,`birthday`,`hometown`,`school`,`job`,`qq`,`sign`,`astro`,`intro`,`interest`,`portrait`,`profilePrivacy`,`lifebookPrivacy`,`lifebookViewType`,`friendPrivacy`,`groupPrivacy`,`messagePrivacy`) VALUES 
 (7,7,'关之琳','男','1960-06-14','香港','香港大学','好人','1232123','鼠','白羊座','哈哈哈哈哈','哈哈哈','lqjrt3ucnj1ataan8tjzypf7vc08el.jpg','all','all','show','all','all','all'),
 (8,8,'陆小虎','男','1960-06-14','小强','','','','鼠','白羊座','','','gxqsneoelx1tawcx6phc4mrndx7gdr.jpg','all','all','show','all','all','all'),
 (9,9,'黄媛','男','1960-06-14','江西','好学校哦','演员','不告诉你','鼠','白羊座','我是海军妹妹','哈哈哈','yep03wzb3f8uzbm6xnege0rhvaafap.jpg','all','all','show','all','all','all');
/*!40000 ALTER TABLE `user_details` ENABLE KEYS */;


--
-- Definition of table `user_programs`
--

DROP TABLE IF EXISTS `user_programs`;
CREATE TABLE `user_programs` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `user_id` int(10) unsigned NOT NULL,
  `program_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_programs`
--

/*!40000 ALTER TABLE `user_programs` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_programs` ENABLE KEYS */;


--
-- Definition of table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `username` varchar(20) NOT NULL,
  `password` varchar(32) NOT NULL,
  `email` varchar(45) NOT NULL,
  `registerDatetime` varchar(45) NOT NULL,
  `isVIP` tinyint(1) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`,`username`,`password`,`email`,`registerDatetime`,`isVIP`) VALUES 
 (1,'hlxwell','123321','hlxwell@gmail.com','2007-05-26 22:36:11',1),
 (2,'abcd','abcd','hlxwell@gmail.com','2007-05-26 23:49:50',0),
 (3,'aaa','aaa','a@a.com','2007-05-29 16:27:09',1),
 (4,'test','test','test@test.com','2007-06-08 23:27:44',0),
 (5,'test1','123321','test1@gmail.com','2007-06-14 22:33:44',0),
 (6,'test2','123321','test2@gmail.com','2007-06-14 22:34:19',0),
 (7,'test3','123321','test3@gmail.com','2007-06-14 22:34:49',0),
 (8,'test4','123321','test4@gmail.com','2007-06-14 22:35:12',0),
 (9,'test5','123321','test5@gmail.com','2007-06-14 22:35:39',0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;


--
-- Definition of table `users_users`
--

DROP TABLE IF EXISTS `users_users`;
CREATE TABLE `users_users` (
  `user_id` int(10) unsigned NOT NULL,
  `friend_id` int(10) unsigned NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users_users`
--

/*!40000 ALTER TABLE `users_users` DISABLE KEYS */;
INSERT INTO `users_users` (`user_id`,`friend_id`) VALUES 
 (3,1),
 (1,3),
 (4,1),
 (1,4),
 (3,4),
 (2,4),
 (2,3),
 (4,3),
 (1,8);
/*!40000 ALTER TABLE `users_users` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
