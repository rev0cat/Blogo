-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: blogdb
-- ------------------------------------------------------
-- Server version	8.0.32-0ubuntu0.20.04.2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `about`
--

DROP TABLE IF EXISTS `about`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `about`
(
  `id`           int      NOT NULL AUTO_INCREMENT,
  `qr_code`      varchar(50) DEFAULT NULL,
  `team_img`     varchar(50) DEFAULT NULL,
  `frontend_id`  varchar(30) DEFAULT NULL,
  `backend_id`   varchar(30) DEFAULT NULL,
  `frontend_img` varchar(50) DEFAULT NULL,
  `backend_img`  varchar(50) DEFAULT NULL,
  `introduction` text,
  `show`         varchar(80) DEFAULT NULL,
  `location`     varchar(50) DEFAULT NULL,
  `email`        varchar(50) DEFAULT NULL,
  `created_time` datetime NOT NULL,
  `updated_time` datetime NOT NULL,
  `showing`      tinyint(1) NOT NULL,
  `dictum_id`    int         DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY            `about_dictum` (`dictum_id`),
  CONSTRAINT `about_dictum` FOREIGN KEY (`dictum_id`) REFERENCES `dictum` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `about`
--

/*!40000 ALTER TABLE `about` DISABLE KEYS */;
INSERT INTO `about`
VALUES (1, 'http://www.revocat.tech/img/articleImg.jpg', 'http://www.revocat.tech/img/articleImg.jpg', 'dinner', '你爹',
        'http://www.revocat.tech/img/articleImg.jpg', 'http://www.revocat.tech/img/articleImg.jpg',
        'We can travel the whole world through the Internet.', 'We can travel the whole world through the Internet.',
        'San Diego,CA,U.S.', '114514@tokyohot.jp', '2023-01-23 22:11:18', '2023-01-23 22:11:19', 1, 1);
/*!40000 ALTER TABLE `about` ENABLE KEYS */;

--
-- Table structure for table `article`
--

DROP TABLE IF EXISTS `article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article`
(
  `id`            bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at`    datetime                                                               DEFAULT NULL,
  `updated_at`    datetime                                                               DEFAULT NULL,
  `title`         varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文章标题',
  `category_id`   bigint                                                        NOT NULL COMMENT '分类 ID',
  `desc`          varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci          DEFAULT NULL COMMENT '文章描述',
  `content`       longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '文章内容',
  `img`           varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci          DEFAULT NULL COMMENT '封面图片地址',
  `comment_count` bigint                                                        NOT NULL DEFAULT '0',
  `read_count`    bigint                                                        NOT NULL DEFAULT '0',
  `is_top`        tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否置顶(False否 True是)',
  `original_url`  varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci          DEFAULT NULL COMMENT '源链接',
  `type`          tinyint(1) DEFAULT NULL COMMENT '类型(True原创 False转载)',
  `status`        tinyint(1) DEFAULT NULL COMMENT '状态(True公开 False私密)',
  `is_delete`     tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否放到回收站(False否 True是)',
  `user_id`       bigint                                                        NOT NULL COMMENT '用户 ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article`
--

/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article`
VALUES (1, '2022-12-03 22:07:02', '2022-12-24 12:05:13', '项目介绍', 1, '',
        '* 1. [构造镜像](#)\n	* 1.1. [说明](#-1)\n* 2. [创建容器](#-1)\n* 3. [运行Dockerfile](#Dockerfile)\n\n# Docker\n\n镜像的本质就是一种文件储存形式，可以被特定的硬件或软件识别。容器是通过镜像生成的，是一个套在程序外面的外壳，，它接触到的各种资源都是虚拟的，这有点类似虚拟机，但是容器并不模拟一个完整的操作系统。容器相当于一个进程，并不模拟内核，而虚拟机是模拟了一个完整的操作系统。容器相对于虚拟机，其占用资源更少，资源利用率更高（容器之间可以共享资源），运行速度快（虚拟机性能折损较大，而容器几乎没有性能折损）。用maven把聊天室打包成war文件\n\n##  1. 构造镜像\n\n```dockerfile\nFROM openjdk:8-jdk-alpine\nMAINTAINER \"revocat\"\nWORKDIR /chatroom\nADD Chatroom.war /chatroom\nEXPOSE 8080\nENTRYPOINT [\"java\", \"-jar\", \"Chatroom.war\"]\ndocker build -t chatroom:v1 .\n```\n\n###  1.1. 说明\n\n上传到docker hub，得把tag改成用户名/chatroom:v1，否则会报错。\n\n##  2. 创建容器\n```go\n// GET is a shortcut for router.Handle(\"GET\", path, handle).\nfunc (group *RouterGroup) GET(relativePath string, handlers ...app.HandlerFunc) IRoutes {\n	return group.handle(consts.MethodGet, relativePath, handlers)\n}\n```\n\n##  3. 运行Dockerfile\n```go\n// GET is a shortcut for router.Handle(\"GET\", path, handle).\nfunc (group *RouterGroup) GET(relativePath string, handlers ...app.HandlerFunc) IRoutes {\n	return group.handle(consts.MethodGet, relativePath, handlers)\n}\n```\n傻逼编译原理，周尔强wcnm\n',
        'http://www.revocat.tech:81/img/articleImg.jpg', 1, 114514, 1, '', 1, 1, 0, 1),
       (2, '2022-12-16 11:56:41', '2022-12-16 12:36:42', '项目运行成功', 2, '', 'Hello!I am from 2023/1/19 23:55',
        'http://www.revocat.tech:81/img/articleImg.jpg', 0, 24, 0, 'https://www.mihoyo.com', 1, 1, 0, 1),
       (3, '2022-12-24 12:07:29', '2022-12-24 12:08:31', '学习有捷径', 2, '', '有nima捷径',
        'http://www.revocat.tech:81/img/articleImg.jpg', 0, 810, 0, 'https://www.mihoyo.com', 2, 1, 0, 1),
       (4, '2023-01-20 19:25:26', '2023-01-20 19:25:27', '别急', 1, NULL,
        '别急是一种态度，一种张弛有度，一种不急不躁，一种泰然自若。遇到羞辱急于还击，是莽夫，“别急”教我们谦让三分、以理服人；遇到挫折羞愤不已，是愚夫，“别急”教我们另辟蹊径、以智取胜。“别急”体现的是中华儒家的中庸之道，体现的是虚怀若谷、谦逊祥和的人生哲理，所谓“心静即声淡，其间无古今”，学会“别急”，方能成长，方能成熟，方能于世间百态中左右逢源、处变不惊.',
        'http://www.revocat.tech:81/img/articleImg.jpg', 0, 1919, 0, NULL, 1, 1, 0, 1),
       (5, '2023-01-20 19:27:36', '2023-01-20 19:27:34', '我超O', 1, NULL,
        '你说的对，但是《原神》是由米哈游自主研发的一款全新开放世界冒险游戏。游戏发生在一个被称作「提瓦特」的幻想世界，在这里，被神选中的人将被授予「神之眼」，导引元素之力。你将扮演一位名为「旅行者」的神秘角色，在自由的旅行中邂逅性格各异、能力独特的同伴们，和他们一起击败强敌，找回失散的亲人——同时，逐步发掘「原神」的真相。因为你的素养很差，我现在每天玩原神都能赚150原石，每个月差不多5000原石的收入， 也就是现实生活中每个月5000美元的收入水平，换算过来最少也30000人民币，虽然我 只有14岁，但是已经超越了中国绝大多数人(包括你)的水平，这便是原神给我的骄傲的资本。',
        'http://www.revocat.tech:81/img/articleImg.jpg', 0, 514, 0, NULL, 1, 1, 0, 1),
       (6, '2023-01-20 19:29:17', '2023-01-20 19:29:14', 'o神', 1, NULL,
        '你说对，但原神，米自研，冒险游，提瓦特，神选中，授神眼，引元素。扮角色，邂同伴，击强敌，找亲人，掘真相',
        'http://www.revocat.tech:81/img/articleImg.jpg', 0, 114, 0, NULL, 1, 1, 0, 1),
       (8, '2023-01-27 15:56:02', '2023-01-27 15:56:02', '原神', 1, '原神',
        '《原神》整体的玩法架构可圈可点，基于行业成熟设计经验打造的内容虽算不上太惊艳，但也多少有些自己的想法，玩起来不失乐趣 [71]  。（17173 评）\n随着游戏体验的深入，《塞尔达》的既视感逐渐消失，取而代之的是浓厚的\"米哈游\"味道，经由《崩坏3》锤炼的3D动作设计在《原神》中有着完善的展现，角色的塑造和剧情对白中的桥段也有些《崩坏》系列的影子 [72]  。（游侠网 评）\n与同世代的一线大作相比，《原神》和米哈游还有很长的路要走，但项目本身至少让国产游戏行业看到了一丝追逐的光芒 [73]  。（网易爱玩 评）\n游戏整体的可玩性非常值得认可，玩家永远不必担心，在《原神》的世界里会无事可做，不必担心内容更新的匮乏，在七大国的疆土上，永远会有新的冒险在等待着玩家去发现 [74]  。（3DM 评）\n《原神》用无与伦比的画面把一场场战斗变成了一次次视觉奇观。无论你是在搜索食材、飞越山峰，还是与其他玩家联手对抗强大 BOSS，这片大陆的每一寸空间都精雕细琢，让你感觉不虚此行 [64]  。（App Store 评）\n《原神》是一款惊人的开放世界冒险游戏，它吸收了大量的《塞尔达：荒野之息》和动画的灵感来创造出一些真正特别的东西。虽然有一些抽卡微交易模型存在一些不佳的氪金体验，但出色的战斗和令人上瘾的探索以及这美丽的世界让这款游戏成为IGN编辑一整年玩过的最令人兴奋的游戏之一 [75]  。（IGN 评）\n《原神》是一款扎实的游戏，略微受到免费模式限制妨碍。游戏总体价值很高，核心玩法没问题，尤其是元素互动系统非常有趣，个性很鲜明 [76]  。（Gamespot 评）\n《原神》是一款国产精品游戏，有着高维媒介效应，实现了新世纪以来传统媒介苦苦追求的文化“走出去”效果 [310]  。（环球网 评）',
        'http://www.revocat.tech:81/img/articleImg.jpg', 0, 0, 0, NULL, 1, 1, 0, 1),
       (9, '2023-01-27 16:01:28', '2023-01-27 16:01:29', '原神2', 1, '原神',
        '可操控角色\n角色获取\n常驻\n常驻\n游戏中拥有许多可操控角色，开局的默认角色可以选择男女，此外的角色性别固定。除旅行者外的角色，可以通过剧情、祈愿和活动获取 [8]  。如安柏是游戏中除主角外，玩家可通过剧情激活的第一个角色 [9]  。大部分角色都需要通过祈愿获取，祈愿分为常驻祈愿和活动祈愿，祈愿需要消耗相遇之缘或纠缠之缘 [8]  。\n体力值\n游戏中的角色拥有体力值的设定，在飞行、奔跑、游泳和蓄力攻击（除弓箭角色外）会消耗，体力为0时会使角色进入步行（奔跑）、坠落（滑翔与攀爬）、溺水死亡（游泳）和无法进行蓄力攻击的状态。体力可以通过体力恢复的料理和休息恢复。在动作进行的时候也可以通过呼出面板食用料理进行恢复 [10]  。',
        'http://www.revocat.tech:81/img/articleImg.jpg', 0, 0, 0, NULL, 1, 1, 0, 1),
       (10, '2023-01-28 20:41:52', '2023-01-28 20:41:54', '测试', 1, '测试',
        '你说得对，但是秦始皇派蒙恬十点钟离开琉璃月台，去北胡桃林园砍一颗长安柏树和冷凝光线用来雕刻晴天娃娃放在郁金香菱形盆栽里，来还原神仙用银行秋天收的账去瞎蒙德克萨斯州的体重云端数据，才能查到的宋襄公子孙带领的一个整编旅行者孙，最后硬是造出奔腾讯速的一座如梦似幻塔楼，而且塔楼的本原石头是绰号叫蹦迪卢克的人用小米哈游戏玩家得到的，别的石头容易裂开崩坏三次。',
        'http://www.revocat.tech:81/img/articleImg.jpg', 0, 0, 0, 'https://www.mihoyo.com', 2, 1, 0, 1);
/*!40000 ALTER TABLE `article` ENABLE KEYS */;

--
-- Table structure for table `article_tag`
--

DROP TABLE IF EXISTS `article_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article_tag`
(
  `article_id` bigint unsigned NOT NULL,
  `tag_id`     bigint unsigned NOT NULL,
  PRIMARY KEY (`article_id`, `tag_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article_tag`
--

/*!40000 ALTER TABLE `article_tag` DISABLE KEYS */;
INSERT INTO `article_tag`
VALUES (1, 1),
       (1, 2),
       (2, 1),
       (2, 2),
       (3, 3);
/*!40000 ALTER TABLE `article_tag` ENABLE KEYS */;

--
-- Table structure for table `banner`
--

DROP TABLE IF EXISTS `banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `banner`
(
  `content` varchar(30) NOT NULL,
  `id`      int         NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `banner`
--

/*!40000 ALTER TABLE `banner` DISABLE KEYS */;
INSERT INTO `banner`
VALUES ('这是一个横幅', 1),
       ('唯有死亡是责任的尾声', 2),
       ('钢铁之国，伤心之地', 3);
/*!40000 ALTER TABLE `banner` ENABLE KEYS */;

--
-- Table structure for table `blog_config`
--

DROP TABLE IF EXISTS `blog_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `blog_config`
(
  `id`         bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime                                                       DEFAULT NULL,
  `updated_at` datetime                                                       DEFAULT NULL,
  `config`     varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '配置信息',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_config`
--

/*!40000 ALTER TABLE `blog_config` DISABLE KEYS */;
INSERT INTO `blog_config`
VALUES (1, '2022-10-30 14:57:38', '2022-12-17 00:02:41',
        '{\n    \"website_avatar\": \"https://img-blog.csdnimg.cn/9e1832a8817d4344901f2e476cc74c16.jpeg\",\n    \"website_name\": \"拾穗\",\n    \"website_author\": \"拾穗\",\n    \"website_intro\": \"伟大是一种诅咒，立于尸骸之上。\",\n    \"website_notice\": \"我英语不好，但是我会读genshin。我英语不好，但是我会读genshin。我英语不好，但是我会读genshin。我英语不好，但是我会读genshin。\",\n    \"website_createtime\": \"2022-11-01\",\n    \"website_record\": \"闽ICP备1919810114号\",\n    \"record_info_url\": \"https://www.baidu.com\",\n    \"social_login_list\": [],\n    \"social_url_list\": [],\n    \"qq\": \"123456\",\n    \"github\": \"https://github.com/szluyu99\",\n    \"gitee\": \"https://gitee.com/szluyu99\",\n    \"tourist_avatar\": \"https://static.talkxj.com/photos/0bca52afdb2b9998132355d716390c9f.png\",\n    \"user_avatar\": \"https://static.talkxj.com/avatar/user.png\",\n    \"article_cover\": \"https://static.talkxj.com/config/e587c4651154e4da49b5a54f865baaed.jpg\",\n    \"is_comment_review\": 1,\n    \"is_message_review\": 1,\n    \"is_email_notice\": 0,\n    \"is_reward\": 0,\n    \"wechat_qrcode\": \"http://dummyimage.com/100x100\",\n    \"alipay_ode\": \"http://dummyimage.com/100x100\",\n    \"author_bk_img\": \"http://www.revocat.tech/img/authorBk.jpeg\",\n    \"bk_img\": \"http://www.revocat.tech:81/img/bkimg.jpg\",\n    \"example_url\": \"http://www.revocat.tech\",\n    \"example_intro\": \"这是我的个人网站。\"\n}');
/*!40000 ALTER TABLE `blog_config` ENABLE KEYS */;

--
-- Table structure for table `casbin_rule`
--

DROP TABLE IF EXISTS `casbin_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `casbin_rule`
(
  `id`    bigint unsigned NOT NULL AUTO_INCREMENT,
  `ptype` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `v0`    varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `v1`    varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `v2`    varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `v3`    varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `v4`    varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `v5`    varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idx_casbin_rule` (`ptype`,`v0`,`v1`,`v2`,`v3`,`v4`,`v5`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2497 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `casbin_rule`
--

/*!40000 ALTER TABLE `casbin_rule` DISABLE KEYS */;
INSERT INTO `casbin_rule`
VALUES (1416, 'g', 'admin', 'anonymous', NULL, NULL, NULL, NULL),
       (1418, 'g', 'admin', 'logout', NULL, NULL, NULL, NULL),
       (1420, 'g', 'test', 'anonymous', NULL, NULL, NULL, NULL),
       (1421, 'g', 'test', 'logout', NULL, NULL, NULL, NULL),
       (1417, 'g', 'user', 'anonymous', NULL, NULL, NULL, NULL),
       (1419, 'g', 'user', 'logout', NULL, NULL, NULL, NULL),
       (2453, 'p', 'admin', '/article', 'DELETE', '', '', ''),
       (2451, 'p', 'admin', '/article', 'POST', '', '', ''),
       (2450, 'p', 'admin', '/article/:id', 'GET', '', '', ''),
       (2495, 'p', 'admin', '/article/export', 'POST', '', '', ''),
       (2496, 'p', 'admin', '/article/import', 'POST', '', '', ''),
       (2449, 'p', 'admin', '/article/list', 'GET', '', '', ''),
       (2452, 'p', 'admin', '/article/soft-delete', 'PUT', '', '', ''),
       (2454, 'p', 'admin', '/article/top', 'PUT', '', '', ''),
       (2457, 'p', 'admin', '/category', 'DELETE', '', '', ''),
       (2456, 'p', 'admin', '/category', 'POST', '', '', ''),
       (2455, 'p', 'admin', '/category/list', 'GET', '', '', ''),
       (2458, 'p', 'admin', '/category/option', 'GET', '', '', ''),
       (2467, 'p', 'admin', '/comment', 'DELETE', '', '', ''),
       (2466, 'p', 'admin', '/comment/list', 'GET', '', '', ''),
       (2468, 'p', 'admin', '/comment/review', 'PUT', '', '', ''),
       (2486, 'p', 'admin', '/home', 'GET', '', '', ''),
       (2475, 'p', 'admin', '/link', 'DELETE', '', '', ''),
       (2474, 'p', 'admin', '/link', 'POST', '', '', ''),
       (2473, 'p', 'admin', '/link/list', 'GET', '', '', ''),
       (2445, 'p', 'admin', '/menu', 'POST', '', '', ''),
       (2446, 'p', 'admin', '/menu/:id', 'DELETE', '', '', ''),
       (2444, 'p', 'admin', '/menu/list', 'GET', '', '', ''),
       (2447, 'p', 'admin', '/menu/option', 'GET', '', '', ''),
       (2448, 'p', 'admin', '/menu/user/list', 'GET', '', '', ''),
       (2464, 'p', 'admin', '/message', 'DELETE', '', '', ''),
       (2463, 'p', 'admin', '/message/list', 'GET', '', '', ''),
       (2465, 'p', 'admin', '/message/review', 'PUT', '', '', ''),
       (2485, 'p', 'admin', '/operation/log', 'DELETE', '', '', ''),
       (2484, 'p', 'admin', '/operation/log/list', 'GET', '', '', ''),
       (2493, 'p', 'admin', '/page', 'DELETE', '', '', ''),
       (2492, 'p', 'admin', '/page', 'POST', '', '', ''),
       (2491, 'p', 'admin', '/page/list', 'GET', '', '', ''),
       (2440, 'p', 'admin', '/resource', 'POST', '', '', ''),
       (2443, 'p', 'admin', '/resource/:id', 'DELETE', '', '', ''),
       (2439, 'p', 'admin', '/resource/anonymous', 'PUT', '', '', ''),
       (2441, 'p', 'admin', '/resource/list', 'GET', '', '', ''),
       (2442, 'p', 'admin', '/resource/option', 'GET', '', '', ''),
       (2471, 'p', 'admin', '/role', 'DELETE', '', '', ''),
       (2470, 'p', 'admin', '/role', 'POST', '', '', ''),
       (2469, 'p', 'admin', '/role/list', 'GET', '', '', ''),
       (2472, 'p', 'admin', '/role/option', 'GET', '', '', ''),
       (2478, 'p', 'admin', '/setting/about', 'GET', '', '', ''),
       (2482, 'p', 'admin', '/setting/about', 'PUT', '', '', ''),
       (2477, 'p', 'admin', '/setting/blog-config', 'GET', '', '', ''),
       (2479, 'p', 'admin', '/setting/blog-config', 'PUT', '', '', ''),
       (2461, 'p', 'admin', '/tag', 'DELETE', '', '', ''),
       (2460, 'p', 'admin', '/tag', 'POST', '', '', ''),
       (2459, 'p', 'admin', '/tag/list', 'GET', '', '', ''),
       (2462, 'p', 'admin', '/tag/option', 'GET', '', '', ''),
       (2494, 'p', 'admin', '/upload', 'POST', '', '', ''),
       (2481, 'p', 'admin', '/user', 'PUT', '', '', ''),
       (2489, 'p', 'admin', '/user/current', 'PUT', '', '', ''),
       (2488, 'p', 'admin', '/user/current/password', 'PUT', '', '', ''),
       (2490, 'p', 'admin', '/user/disable', 'PUT', '', '', ''),
       (2480, 'p', 'admin', '/user/info', 'GET', '', '', ''),
       (2476, 'p', 'admin', '/user/list', 'GET', '', '', ''),
       (2487, 'p', 'admin', '/user/offline', 'DELETE', '', '', ''),
       (2483, 'p', 'admin', '/user/online', 'GET', '', '', ''),
       (1488, 'p', 'logout', '/logout', 'GET', NULL, NULL, NULL),
       (2365, 'p', 'test', '/article/:id', 'GET', '', '', ''),
       (2364, 'p', 'test', '/article/list', 'GET', '', '', ''),
       (2366, 'p', 'test', '/category/list', 'GET', '', '', ''),
       (2367, 'p', 'test', '/category/option', 'GET', '', '', ''),
       (2371, 'p', 'test', '/comment/list', 'GET', '', '', ''),
       (2381, 'p', 'test', '/home', 'GET', '', '', ''),
       (2374, 'p', 'test', '/link/list', 'GET', '', '', ''),
       (2361, 'p', 'test', '/menu/list', 'GET', '', '', ''),
       (2362, 'p', 'test', '/menu/option', 'GET', '', '', ''),
       (2363, 'p', 'test', '/menu/user/list', 'GET', '', '', ''),
       (2370, 'p', 'test', '/message/list', 'GET', '', '', ''),
       (2380, 'p', 'test', '/operation/log/list', 'GET', '', '', ''),
       (2382, 'p', 'test', '/page/list', 'GET', '', '', ''),
       (2359, 'p', 'test', '/resource/list', 'GET', '', '', ''),
       (2360, 'p', 'test', '/resource/option', 'GET', '', '', ''),
       (2372, 'p', 'test', '/role/list', 'GET', '', '', ''),
       (2373, 'p', 'test', '/role/option', 'GET', '', '', ''),
       (2377, 'p', 'test', '/setting/about', 'GET', '', '', ''),
       (2376, 'p', 'test', '/setting/blog-config', 'GET', '', '', ''),
       (2368, 'p', 'test', '/tag/list', 'GET', '', '', ''),
       (2369, 'p', 'test', '/tag/option', 'GET', '', '', ''),
       (2378, 'p', 'test', '/user/info', 'GET', '', '', ''),
       (2375, 'p', 'test', '/user/list', 'GET', '', '', ''),
       (2379, 'p', 'test', '/user/online', 'GET', '', '', ''),
       (2341, 'p', 'user', '/article/:id', 'GET', '', '', ''),
       (2340, 'p', 'user', '/article/list', 'GET', '', '', ''),
       (2342, 'p', 'user', '/category/list', 'GET', '', '', ''),
       (2343, 'p', 'user', '/category/option', 'GET', '', '', ''),
       (2347, 'p', 'user', '/comment/list', 'GET', '', '', ''),
       (2357, 'p', 'user', '/home', 'GET', '', '', ''),
       (2350, 'p', 'user', '/link/list', 'GET', '', '', ''),
       (2337, 'p', 'user', '/menu/list', 'GET', '', '', ''),
       (2338, 'p', 'user', '/menu/option', 'GET', '', '', ''),
       (2339, 'p', 'user', '/menu/user/list', 'GET', '', '', ''),
       (2346, 'p', 'user', '/message/list', 'GET', '', '', ''),
       (2356, 'p', 'user', '/operation/log/list', 'GET', '', '', ''),
       (2358, 'p', 'user', '/page/list', 'GET', '', '', ''),
       (2335, 'p', 'user', '/resource/list', 'GET', '', '', ''),
       (2336, 'p', 'user', '/resource/option', 'GET', '', '', ''),
       (2348, 'p', 'user', '/role/list', 'GET', '', '', ''),
       (2349, 'p', 'user', '/role/option', 'GET', '', '', ''),
       (2353, 'p', 'user', '/setting/about', 'GET', '', '', ''),
       (2352, 'p', 'user', '/setting/blog-config', 'GET', '', '', ''),
       (2344, 'p', 'user', '/tag/list', 'GET', '', '', ''),
       (2345, 'p', 'user', '/tag/option', 'GET', '', '', ''),
       (2354, 'p', 'user', '/user/info', 'GET', '', '', ''),
       (2351, 'p', 'user', '/user/list', 'GET', '', '', ''),
       (2355, 'p', 'user', '/user/online', 'GET', '', '', '');
/*!40000 ALTER TABLE `casbin_rule` ENABLE KEYS */;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category`
(
  `id`         bigint unsigned NOT NULL AUTO_INCREMENT,
  `name`       varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '分类名称',
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category`
VALUES (1, '后端', '2022-12-03 22:01:29', '2022-12-03 22:01:29'),
       (2, '前端', '2022-12-03 22:01:33', '2022-12-03 22:01:33');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment`
(
  `id`            bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at`    datetime DEFAULT NULL,
  `updated_at`    datetime DEFAULT NULL,
  `user_id`       bigint   DEFAULT NULL COMMENT '评论用户id',
  `content`       varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论内容',
  `reply_user_id` bigint   DEFAULT NULL COMMENT '回复用户id',
  `topic_id`      bigint   DEFAULT NULL COMMENT '评论主题id',
  `parent_id`     bigint   DEFAULT NULL COMMENT '父评论id',
  `is_delete`     tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否删除(0.否 1.是)',
  `is_review`     tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否审核(0.否 1.是)',
  `ip_source`     varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  NOT NULL,
  `ip_address`    varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment`
VALUES (4, '2023-01-20 14:45:49', '2023-01-20 14:45:53', 12, '我去，这人我同学', 0, 1, 0, 0, 1, '日本', '114.514.19.19'),
       (5, '2023-01-24 14:55:04', '2023-01-24 14:55:05', 12, 'C语言大佬', 12, 1, 1, 0, 1, '下北泽', '1919.810'),
       (10, '2023-01-26 22:29:47', '2023-01-26 22:29:47', 12, 'ping', 0, 1, 0, 0, 1, '福建省南平市 电信',
        '27.157.231.154'),
       (11, '2023-01-28 16:44:03', '2023-01-28 16:44:03', 12, 'pong', 0, 1, 10, 0, 1, ' 移动', '39.144.250.212'),
       (12, '2023-01-28 16:48:05', '2023-01-28 16:48:05', 12, 'pong', 12, 1, 10, 0, 1, ' 移动', '39.144.250.212'),
       (13, '2023-01-30 13:43:25', '2023-01-30 13:43:25', 12, 'pang', 12, 1, 12, 0, 1, '福建省南平市 电信',
        '110.87.214.11'),
       (14, '2023-01-30 19:47:11', '2023-01-30 19:47:11', 12,
        'go语言将struct Marshal()序列化成json，默认按照一定格式进行转换。可以实现Marshaler接口的MarshalJSON()方法，实现自定义序列化。反序列化实现Unmarshaler接口。go语言将struct Marshal()序列化成json，默认按照一定格式进行转换。可以实现Marshaler接口的MarshalJSON()方法，实现自定义序列化。反序列化实现Unmarshaler接口。go语言将struct Marshal()序列化成json，默认按照一定格式进行转换。可以实现Marshaler接口的MarshalJSON()方法，实现自定义序列化。反序列化实现Unmarshaler接口。go语言将struct Marshal()序列化成json，默认按照一定格式进行转换。可以实现Marshaler接口的MarshalJSON()方法，实现自定义序列化。反序列化实现Unmarshaler接口。',
        0, 1, 0, 0, 1, '福建省南平市 电信', '110.87.214.11'),
       (15, '2023-01-30 19:47:56', '2023-01-30 19:47:56', 1,
        'I know dark clouds will gather round me.I know my way is rough and steep.', 12, 1, 14, 0, 1,
        '福建省南平市 电信', '110.87.214.11'),
       (16, '2023-01-30 19:50:58', '2023-01-30 19:50:58', 2, 'But beuteous fields arise before me', 12, 1, 14, 0, 1,
        '福建省南平市 电信', '110.87.214.11'),
       (17, '2023-01-30 19:51:32', '2023-01-30 19:51:32', 3, 'Where God\'s redeemed,
        their vigils keep',12,1,14,0,1,'福建省南平市 电信','110.87.214.11'),(18,'2023-01-30 19:57:43','2023-01-30 19:57:43',11,'Where God\'s redeemed, their vigils keep',
        12, 1, 14, 0, 1, '福建省南平市 电信', '110.87.214.11'),
       (19, '2023-01-30 19:58:21', '2023-01-30 19:58:21', 12,
        '你说得对，但是秦始皇派蒙恬十点钟离开琉璃月台，去北胡桃林园砍一颗长安柏树和冷凝光线用来雕刻晴天娃娃放在郁金香菱形盆栽里，来还原神仙用银行秋天收的账去瞎蒙德克萨斯州的体重云端数据，才能查到的宋襄公子孙带领的一个整编旅行者孙，最后硬是造出奔腾讯速的一座如梦似幻塔楼，而且塔楼的本原石头是绰号叫蹦迪卢克的人用小米哈游戏玩家得到的，别的石头容易裂开崩坏三次。',
        12, 1, 14, 0, 1, '福建省南平市 电信', '110.87.214.11'),
       (20, '2023-01-30 20:03:15', '2023-01-30 20:03:15', 12,
        '你说得对，但是秦始皇派蒙恬十点钟离开琉璃月台，去北胡桃林园砍一颗长安柏树和冷凝光线用来雕刻晴天娃娃放在郁金香菱形盆栽里，来还原神仙用银行秋天收的账去瞎蒙德克萨斯州的体重云端数据，才能查到的宋襄公子孙带领的一个整编旅行者孙，最后硬是造出奔腾讯速的一座如梦似幻塔楼，而且塔楼的本原石头是绰号叫蹦迪卢克的人用小米哈游戏玩家得到的，别的石头容易裂开崩坏三次。',
        1, 1, 15, 0, 1, '福建省南平市 电信', '110.87.214.11'),
       (21, '2023-01-30 20:23:17', '2023-01-30 20:23:17', 12,
        '你说得对，但是秦始皇派蒙恬十点钟离开琉璃月台，去北胡桃林园砍一颗长安柏树和冷凝光线用来雕刻晴天娃娃放在郁金香菱形盆栽里，来还原神仙用银行秋天收的账去瞎蒙德克萨斯州的体重云端数据，才能查到的宋襄公子孙带领的一个整编旅行者孙，最后硬是造出奔腾讯速的一座如梦似幻塔楼，而且塔楼的本原石头是绰号叫蹦迪卢克的人用小米哈游戏玩家得到的，别的石头容易裂开崩坏三次。',
        12, 1, 15, 0, 1, '福建省南平市', '110.87.214.11'),
       (22, '2023-01-30 20:35:28', '2023-01-30 20:35:28', 12,
        '你说得对，但是秦始皇派蒙恬十点钟离开琉璃月台，去北胡桃林园砍一颗长安柏树和冷凝光线用来雕刻晴天娃娃放在郁金香菱形盆栽里，来还原神仙用银行秋天收的账去瞎蒙德克萨斯州的体重云端数据，才能查到的宋襄公子孙带领的一个整编旅行者孙，最后硬是造出奔腾讯速的一座如梦似幻塔楼，而且塔楼的本原石头是绰号叫蹦迪卢克的人用小米哈游戏玩家得到的，别的石头容易裂开崩坏三次。',
        12, 1, 15, 0, 1, '福建省南平市', '110.87.214.11'),
       (23, '2023-01-30 20:40:58', '2023-01-30 20:40:58', 12,
        '你说得对，但是秦始皇派蒙恬十点钟离开琉璃月台，去北胡桃林园砍一颗长安柏树和冷凝光线用来雕刻晴天娃娃放在郁金香菱形盆栽里，来还原神仙用银行秋天收的账去瞎蒙德克萨斯州的体重云端数据，才能查到的宋襄公子孙带领的一个整编旅行者孙，最后硬是造出奔腾讯速的一座如梦似幻塔楼，而且塔楼的本原石头是绰号叫蹦迪卢克的人用小米哈游戏玩家得到的，别的石头容易裂开崩坏三次。',
        12, 1, 15, 0, 1, '福建省南平市', '110.87.214.11'),
       (24, '2023-01-30 20:44:45', '2023-01-30 20:44:45', 12, 'In the Soviet Union, Summer 1943。', 12, 1, 15, 0, 1,
        '福建省南平市', '110.87.214.11'),
       (25, '2023-01-30 20:48:54', '2023-01-30 20:48:54', 12, 'Arriba Espana!。', 12, 1, 15, 0, 1, '福建省南平市',
        '110.87.214.11'),
       (26, '2023-01-30 21:13:00', '2023-01-30 21:13:00', 12, 'My heart will go on.', 0, 1, 0, 0, 1, '福建南平',
        '110.87.214.11'),
       (27, '2023-01-30 21:14:49', '2023-01-30 21:14:49', 12, 'My heart will go on.', 12, 1, 26, 0, 1, '福建南平',
        '110.87.214.11'),
       (28, '2023-01-30 21:19:48', '2023-01-30 21:19:48', 11, '1234', 0, 1, 0, 0, 1, '福建南平', '183.251.192.245'),
       (29, '2023-01-30 21:24:23', '2023-01-30 21:24:23', 11, '我是你霸霸', 0, 1, 0, 0, 1, '福建南平',
        '183.251.192.245'),
       (30, '2023-01-30 21:25:47', '2023-01-30 21:25:47', 11, '吃我鸡巴毛', 0, 1, 0, 0, 1, '福建南平',
        '183.251.192.245'),
       (31, '2023-01-30 21:45:49', '2023-01-30 21:45:49', 12, '***', 12, 1, 26, 0, 1, '福建南平', '110.87.214.11'),
       (32, '2023-01-30 23:08:11', '2023-01-30 23:08:11', 11, '**毛', 0, 1, 0, 0, 1, '福建南平', '183.251.192.245'),
       (33, '2023-01-30 23:13:52', '2023-01-30 23:13:52', 11, '1', 0, 1, 0, 0, 1, '福建南平', '183.251.192.245'),
       (34, '2023-01-30 23:17:38', '2023-01-30 23:17:38', 11, '', 0, 1, 0, 0, 1, '福建南平', '183.251.192.245'),
       (35, '2023-01-30 23:17:42', '2023-01-30 23:17:42', 11, '', 0, 1, 0, 0, 1, '福建南平', '183.251.192.245'),
       (36, '2023-01-30 23:17:45', '2023-01-30 23:17:45', 11, '', 0, 1, 0, 0, 1, '福建南平', '183.251.192.245'),
       (37, '2023-01-30 23:17:46', '2023-01-30 23:17:46', 11, '', 0, 1, 0, 0, 1, '福建南平', '183.251.192.245'),
       (38, '2023-01-30 23:17:48', '2023-01-30 23:17:48', 11, '', 0, 1, 0, 0, 1, '福建南平', '183.251.192.245'),
       (39, '2023-01-30 23:17:51', '2023-01-30 23:17:51', 11, '', 0, 1, 0, 0, 1, '福建南平', '183.251.192.245'),
       (40, '2023-01-30 23:18:01', '2023-01-30 23:18:01', 11, '', 0, 1, 0, 0, 1, '福建南平', '183.251.192.245'),
       (41, '2023-01-30 23:26:34', '2023-01-30 23:26:34', 11, '', 11, 1, 40, 0, 1, '福建南平', '183.251.192.245'),
       (42, '2023-01-30 23:27:10', '2023-01-30 23:27:10', 11, '', 11, 1, 40, 0, 1, '福建南平', '183.251.192.245'),
       (43, '2023-01-30 23:27:38', '2023-01-30 23:27:38', 11, '错了啦', 11, 1, 40, 0, 1, '福建南平', '183.251.192.245'),
       (44, '2023-01-30 23:28:20', '2023-01-30 23:28:20', 11, '不要发敏感词', 11, 1, 32, 0, 1, '福建南平',
        '183.251.192.245'),
       (45, '2023-01-30 23:39:52', '2023-01-30 23:39:52', 11, '对对对', 11, 1, 29, 0, 1, '福建南平', '183.251.192.245'),
       (46, '2023-01-30 23:47:12', '2023-01-30 23:47:12', 11, '品海伦', 11, 1, 40, 0, 1, '福建南平', '183.251.192.245'),
       (47, '2023-01-30 23:51:24', '2023-01-30 23:51:24', 11, '不对', 11, 1, 29, 0, 1, '福建南平', '183.251.192.245'),
       (48, '2023-01-30 23:58:49', '2023-01-30 23:58:49', 11, '什么**', 11, 1, 40, 0, 1, '福建南平', '183.251.192.245'),
       (49, '2023-01-31 15:36:51', '2023-01-31 15:36:51', 11, '我去', 12, 1, 4, 0, 1, '福建南平', '183.251.192.245'),
       (50, '2023-01-31 15:37:00', '2023-01-31 15:37:00', 11, '*的假的', 12, 1, 4, 0, 1, '福建南平', '183.251.192.245'),
       (51, '2023-01-31 15:37:55', '2023-01-31 15:37:55', 11, '*的假的', 12, 1, 4, 0, 1, '福建南平', '183.251.192.245'),
       (52, '2023-01-31 15:41:01', '2023-01-31 15:41:01', 11, '**', 12, 1, 4, 0, 1, '福建南平', '183.251.192.245'),
       (53, '2023-01-31 15:43:51', '2023-01-31 15:43:51', 11, '我的', 11, 1, 40, 0, 1, '福建南平', '183.251.192.245'),
       (54, '2023-01-31 15:45:53', '2023-01-31 15:45:53', 11, '我的', 11, 1, 40, 0, 1, '福建南平', '183.251.192.245'),
       (55, '2023-01-31 16:07:33', '2023-01-31 16:07:33', 12, '**一下', 11, 1, 54, 0, 1, '福建南平', '110.87.214.11'),
       (56, '2023-01-31 16:21:18', '2023-01-31 16:21:18', 12, '**一下', 11, 1, 54, 0, 1, '福建南平', '110.87.214.11'),
       (57, '2023-01-31 17:02:26', '2023-01-31 17:02:26', 12, '**一下', 11, 1, 54, 0, 1, '福建南平', '110.87.214.11'),
       (58, '2023-01-31 19:23:14', '2023-01-31 19:23:14', 11, '你是什么**', 11, 1, 54, 0, 1, '福建南平',
        '183.251.192.245'),
       (59, '2023-01-31 19:26:17', '2023-01-31 19:26:17', 13, '**一下', 0, 2, 0, 0, 1, '福建南平', '110.87.214.11'),
       (60, '2023-01-31 19:26:27', '2023-01-31 19:26:27', 13, '***', 13, 2, 59, 0, 1, '福建南平', '110.87.214.11'),
       (61, '2023-01-31 19:26:39', '2023-01-31 19:26:39', 13, '***', 13, 2, 60, 0, 1, '福建南平', '110.87.214.11'),
       (62, '2023-01-31 19:27:59', '2023-01-31 19:27:59', 13, '测试', 13, 2, 59, 0, 1, '福建南平', '110.87.214.11'),
       (63, '2023-01-31 19:28:12', '2023-01-31 19:28:12', 13, '测试一下', 13, 2, 62, 0, 1, '福建南平', '110.87.214.11'),
       (64, '2023-01-31 19:28:46', '2023-01-31 19:28:46', 13, '测一下', 0, 2, 0, 0, 1, '福建南平', '110.87.214.11'),
       (65, '2023-01-31 19:28:57', '2023-01-31 19:28:57', 13, '测试一下', 13, 2, 64, 0, 1, '福建南平', '110.87.214.11'),
       (66, '2023-01-31 19:30:05', '2023-01-31 19:30:05', 13, '我去，这人我同学', 0, 2, 0, 0, 1, '美国',
        '96.126.102.62'),
       (67, '2023-01-31 19:30:58', '2023-01-31 19:30:58', 13, '怎么证明', 13, 2, 66, 0, 1, '英国', '52.56.32.245'),
       (68, '2023-01-31 21:18:08', '2023-01-31 21:18:08', 11, '你是傻狗吧还ip是英国*dinner', 13, 3, 67, 0, 1,
        '福建南平', '183.251.192.245'),
       (69, '2023-01-31 21:20:23', '2023-01-31 21:20:23', 11, '******', 13, 3, 67, 0, 1, '福建南平', '183.251.192.245'),
       (70, '2023-01-31 21:20:46', '2023-01-31 21:20:46', 11, '***死你的**', 13, 3, 67, 0, 1, '福建南平',
        '183.251.192.245'),
       (71, '2023-01-31 21:21:04', '2023-01-31 21:21:04', 11, '**死*', 13, 3, 67, 0, 1, '福建南平', '183.251.192.245'),
       (72, '2023-02-01 19:03:51', '2023-02-01 19:03:51', 11, '乱说', 11, 1, 44, 0, 1, '福建南平', '183.251.192.245'),
       (73, '2023-02-05 14:45:41', '2023-02-05 14:45:41', 12, '测试一下IP', 0, 1, 0, 0, 1, '湖北', '223.104.123.51'),
       (74, '2023-02-07 00:21:09', '2023-02-07 00:21:09', 12, '饿饿', 0, 1, 0, 0, 1, '四川成都', '210.41.98.156'),
       (75, '2023-02-19 12:03:55', '2023-02-19 12:03:55', 12, '***已经迁移到天翼云，*****：西安。2023.02.19', 0, 1, 0, 0,
        1, '四川成都', '210.41.98.156'),
       (76, '2023-02-26 14:09:36', '2023-02-26 14:09:36', 12, '*ug太多了', 0, 1, 0, 0, 1, '四川成都', '113.54.231.217');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;

--
-- Table structure for table `dictum`
--

DROP TABLE IF EXISTS `dictum`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dictum`
(
  `id`      int NOT NULL AUTO_INCREMENT,
  `content` varchar(50) DEFAULT NULL,
  `author`  varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `dictum_about_fk` FOREIGN KEY (`id`) REFERENCES `about` (`dictum_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dictum`
--

/*!40000 ALTER TABLE `dictum` DISABLE KEYS */;
INSERT INTO `dictum`
VALUES (1, '我去，这人我同学', 'C语言大佬');
/*!40000 ALTER TABLE `dictum` ENABLE KEYS */;

--
-- Table structure for table `experience`
--

DROP TABLE IF EXISTS `experience`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `experience`
(
  `id`       int NOT NULL AUTO_INCREMENT,
  `pic`      varchar(50) DEFAULT NULL,
  `title`    varchar(20) DEFAULT NULL,
  `content`  text,
  `about_id` int         DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `experience`
--

/*!40000 ALTER TABLE `experience` DISABLE KEYS */;
INSERT INTO `experience`
VALUES (1, 'http://www.revocat.tech/img/articleImg.jpg', '2023寒假',
        '无知时诋毁原神，懂事时理解原神，成熟时追随原神，幻想中成为原神！信仰原神就会把它当作黑夜一望无际的大海上给迷途的船只指引的灯塔，在烈日炎炎的夏天吹来的一股清风，在寒风刺骨的冬天里燃起的阵阵篝火！米门🙏\n我语文不好，但我会写原神；我英语不好，但我会读genshin；我数学不好，但我会开机关；我体育不好，但我会打丘丘人；我地理不好，但我能熟记原神的地图。\n原神最亮的月叫璃月，原神最美的雨叫甘雨，原神最甜的桃叫胡桃，原神最可爱的叫可莉，原神最帅的男人叫钟离。',
        1),
       (2, 'http://www.revocat.tech/img/articleImg.jpg', '114514',
        '玩游戏不玩原神，就像追星不追肖战，上大学不上新东方，打篮球不学蔡徐坤，玩b站不关注陈睿，跳舞区不看dǎng妹，生活区不看lex，科普区不看回形针，玩3A不玩2077，看小说不看唐家三少，看虚拟主播不看holo，看漫画不看进击的巨人，追番剧不追国王排名，买汽车不去买奔驰，吃雪糕不去吃梦龙。说明这个人文学造诣和自我修养不足，他理解不了这种内在的阳春白雪般的高雅艺术，他只能看到外表的辞藻堆砌，参不透其中深奥的精神内核，他整个人的层次就卡在这里了，只能度过一个相对失败的人生。',
        1),
       (3, 'http://www.revocat.tech/img/articleImg.jpg', '1919810',
        '说过原神坏话的人，天堂将会唾弃他，恶魔会把他从人间拽向地狱，他的子子孙孙将会被神明遗弃，他的灵魂将会在炼狱的油锅中饱受煎熬。而赞扬原神的人，即使他犯下了滔天罪行，神明也会原谅他，天堂的大门永远会向他敞开，人间的一切美好都会属于他。说过原神坏话的人，天堂将会唾弃他，恶魔会把他从人间拽向地狱，他的子子孙孙将会被神明遗弃，他的灵魂将会在炼狱的油锅中饱受煎熬。而赞扬原神的人，即使他犯下了滔天罪行，神明也会原谅他，天堂的大门永远会向他敞开，人间的一切美好都会属于他。',
        1);
/*!40000 ALTER TABLE `experience` ENABLE KEYS */;

--
-- Table structure for table `friend_link`
--

DROP TABLE IF EXISTS `friend_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `friend_link`
(
  `id`         bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime                                                      DEFAULT NULL,
  `updated_at` datetime                                                      DEFAULT NULL,
  `name`       varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  DEFAULT NULL,
  `avatar`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `intro`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_review`  tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friend_link`
--

/*!40000 ALTER TABLE `friend_link` DISABLE KEYS */;
INSERT INTO `friend_link`
VALUES (5, '2023-01-25 20:03:20', '2023-01-25 20:03:20', '百度', 'http://www.revocat.tech/img/bkimg.jpg',
        'https://www.baidu.com', 'He is too lazy to leave anything.', 1),
       (6, '2023-01-26 15:09:00', '2023-01-26 15:08:58', 'pilipili', 'http://www.revocat.tech/img/bkimg.jpg',
        'https://www.bilibili.com', '你所热爱的，就是你的生活。', 1),
       (8, '2023-01-26 15:28:58', '2023-01-26 15:28:58', 'Google', 'https://dummyimage.com/100x100',
        'https://www.google.com', 'The Biggest Search Engine in the world.', 1),
       (9, '2023-01-26 15:31:31', '2023-01-26 15:31:31', 'Google HK', 'https://dummyimage.com/100x100',
        'https://www.google.hk', 'The Biggest Search Engine in the world.', 0);
/*!40000 ALTER TABLE `friend_link` ENABLE KEYS */;

--
-- Table structure for table `friendlink_requirement`
--

DROP TABLE IF EXISTS `friendlink_requirement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `friendlink_requirement`
(
  `id`      int          NOT NULL AUTO_INCREMENT,
  `content` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `friendlink_requirement`
--

/*!40000 ALTER TABLE `friendlink_requirement` DISABLE KEYS */;
INSERT INTO `friendlink_requirement`
VALUES (1, '不得含有色情、反动等一切违反宪法和法律的内容。'),
       (2, '必须填写网站名称、网站链接、网站头像、网站简介。'),
       (3, '申请友链将在审核通过后展示。');
/*!40000 ALTER TABLE `friendlink_requirement` ENABLE KEYS */;

--
-- Table structure for table `menu`
--

DROP TABLE IF EXISTS `menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu`
(
  `id`         bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime                                                     DEFAULT NULL,
  `updated_at` datetime                                                     DEFAULT NULL,
  `name`       varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '菜单名',
  `path`       varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '菜单路径',
  `component`  varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '组件',
  `icon`       varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '菜单图标',
  `order_num`  tinyint                                                      DEFAULT '0' COMMENT '显示排序',
  `parent_id`  bigint                                                       DEFAULT NULL COMMENT '父菜单id',
  `is_hidden`  tinyint(1) DEFAULT '0' COMMENT '是否隐藏(0-否 1-是)',
  `keep_alive` tinyint(1) DEFAULT '1',
  `redirect`   varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '跳转路径',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu`
--

/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu`
VALUES (2, '2022-10-31 09:41:03', '2022-11-01 01:14:01', '文章管理', '/article', 'Layout', 'ic:twotone-article', 1, 0,
        0, 1, '/article/list'),
       (3, '2022-10-31 09:41:03', '2022-11-01 10:11:07', '消息管理', '/message', 'Layout', 'ic:twotone-email', 2, 0, 0,
        1, '/message/comment	'),
       (4, '2022-10-31 09:41:03', '2022-11-01 10:11:32', '用户管理', '/user', 'Layout', 'ph:user-list-bold', 4, 0, 0, 1,
        '/user/list'),
       (5, '2022-10-31 09:41:03', '2022-11-01 10:11:46', '系统管理', '/setting', 'Layout', 'ion:md-settings', 5, 0, 0,
        1, '/setting/website'),
       (6, '2022-10-31 09:41:03', '2022-11-05 14:21:38', '发布文章', 'write', '/article/write',
        'icon-park-outline:write', 1, 2, 0, 1, ''),
       (8, '2022-10-31 09:41:03', '2022-11-01 01:18:26', '文章列表', 'list', '/article/list',
        'material-symbols:format-list-bulleted', 2, 2, 0, 1, ''),
       (9, '2022-10-31 09:41:03', '2022-11-01 01:18:31', '分类管理', 'category', '/article/category', 'tabler:category',
        3, 2, 0, 1, ''),
       (10, '2022-10-31 09:41:03', '2022-11-01 01:18:36', '标签管理', 'tag', '/article/tag', 'tabler:tag', 4, 2, 0, 1,
        ''),
       (16, '2022-10-31 09:41:03', '2022-11-01 10:11:23', '权限管理', '/auth', 'Layout', 'cib:adguard', 3, 0, 0, 1,
        '/auth/menu'),
       (17, '2022-10-31 09:41:03', NULL, '菜单管理', 'menu', '/auth/menu', 'ic:twotone-menu-book', 1, 16, 0, 1, NULL),
       (23, '2022-10-31 09:41:03', NULL, '接口管理', 'resource', '/auth/resource', 'mdi:api', 2, 16, 0, 1, NULL),
       (24, '2022-10-31 09:41:03', '2022-10-31 10:09:19', '角色管理', 'role', '/auth/role', 'carbon:user-role', 3, 16,
        0, 1, NULL),
       (25, '2022-10-31 10:11:09', '2022-11-01 01:29:49', '评论管理', 'comment', '/message/comment',
        'ic:twotone-comment', 1, 3, 0, 1, ''),
       (26, '2022-10-31 10:12:02', '2022-11-01 01:29:54', '留言管理', 'leave-msg', '/message/leave-msg',
        'ic:twotone-message', 2, 3, 0, 1, ''),
       (27, '2022-10-31 10:54:03', '2022-11-01 01:30:07', '用户列表', 'list', '/user/list', 'mdi:account', 1, 4, 0, 1,
        ''),
       (28, '2022-10-31 10:54:34', '2022-11-01 01:30:13', '在线用户', 'online', '/user/online',
        'ic:outline-online-prediction', 2, 4, 0, 1, ''),
       (29, '2022-10-31 10:59:33', '2022-11-01 01:30:21', '网站管理', 'website', '/setting/website', 'el:website', 1, 5,
        0, 1, ''),
       (30, '2022-10-31 11:00:10', '2022-11-01 01:30:24', '页面管理', 'page', '/setting/page', 'iconoir:journal-page',
        2, 5, 0, 1, ''),
       (31, '2022-10-31 11:00:34', '2022-11-01 01:30:28', '友链管理', 'link', '/setting/link', 'mdi:telegram', 3, 5, 0,
        1, ''),
       (32, '2022-10-31 11:01:00', '2022-11-01 01:30:33', '关于我', 'about', '/setting/about', 'cib:about-me', 4, 5, 0,
        1, ''),
       (33, '2022-11-01 01:43:10', '2022-12-07 20:53:27', '首页', '/home', '/home', 'ic:sharp-home', 0, 0, 0, 1, ''),
       (34, '2022-11-01 09:54:36', '2022-11-01 10:07:00', '修改文章', 'write/:id', '/article/write',
        'icon-park-outline:write', 1, 2, 1, 1, ''),
       (36, '2022-11-04 15:50:46', '2022-11-04 15:58:14', '日志管理', '/log', 'Layout',
        'material-symbols:receipt-long-outline-rounded', 6, 0, 0, 1, '/log/operation'),
       (37, '2022-11-04 15:53:00', '2022-11-04 15:58:37', '操作日志', 'operation', '/log/operation',
        'mdi:book-open-page-variant-outline', 1, 36, 0, 1, ''),
       (38, '2022-11-04 16:02:42', '2022-11-04 16:05:36', '登录日志', 'login', '/log/login', 'material-symbols:login',
        2, 36, 0, 1, ''),
       (39, '2022-12-07 20:47:08', '2022-12-07 20:53:34', '个人中心', '/profile', '/profile', 'mdi:account', 7, 0, 0, 1,
        '');
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `message`
(
  `id`          bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at`  datetime                                                      DEFAULT NULL,
  `updated_at`  datetime                                                      DEFAULT NULL,
  `nickname`    varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  DEFAULT NULL COMMENT '昵称',
  `avatar`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '头像地址',
  `content`     varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '留言内容',
  `ip_address`  varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  DEFAULT NULL COMMENT 'IP 地址',
  `ip_source`   varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'IP 来源',
  `is_review`   tinyint(1) NOT NULL DEFAULT '0' COMMENT '审核状态(0-未审核,1-审核通过)',
  `bulletspeed` tinyint(1) DEFAULT NULL COMMENT '弹幕速度',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message`
VALUES (1, '2022-12-03 22:36:43', '2022-12-03 22:36:43', '测试用户',
        'https://www.bing.com/rp/ar_9isCNU2Q-VG1yEDDHnx8HAFQ.png', '留言测试！', '[::1]:53442', '未知', 1, 0);
/*!40000 ALTER TABLE `message` ENABLE KEYS */;

--
-- Table structure for table `netdisk`
--

DROP TABLE IF EXISTS `netdisk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `netdisk`
(
  `id`        int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `create_at` datetime     DEFAULT NULL COMMENT 'Create Time',
  `update_at` datetime     DEFAULT NULL COMMENT 'Update Time',
  `title`     varchar(255) DEFAULT NULL,
  `size`      float(5, 2
) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `netdisk`
--

/*!40000 ALTER TABLE `netdisk` DISABLE KEYS */;
/*!40000 ALTER TABLE `netdisk` ENABLE KEYS */;

--
-- Table structure for table `operation_log`
--

DROP TABLE IF EXISTS `operation_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operation_log`
(
  `id`             bigint NOT NULL AUTO_INCREMENT,
  `created_at`     datetime                                                      DEFAULT NULL,
  `updated_at`     datetime                                                      DEFAULT NULL,
  `opt_module`     varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  DEFAULT NULL COMMENT '操作模块',
  `opt_type`       varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  DEFAULT NULL COMMENT '操作类型',
  `opt_method`     varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '操作方法',
  `opt_url`        varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '操作URL',
  `opt_desc`       varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '操作描述',
  `request_param`  longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '请求参数',
  `request_method` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '请求方法',
  `response_data`  longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '响应数据',
  `user_id`        bigint                                                        DEFAULT NULL COMMENT '用户ID',
  `nickname`       longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '用户昵称',
  `ip_address`     longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '操作IP',
  `ip_source`      longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '操作地址',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operation_log`
--

/*!40000 ALTER TABLE `operation_log` DISABLE KEYS */;
INSERT INTO `operation_log`
VALUES (1, '2022-12-03 21:53:49', '2022-12-03 21:53:49', '角色', '新增或修改',
        'gin-blog/api/v1.(*Role).SaveOrUpdate-fm', '/api/role', '新增或修改角色',
        '{\"id\":1,\"name\":\"管理员\",\"label\":\"admin\",\"created_at\":\"2022-10-20T21:24:28+08:00\",\"is_disable\":0,\"resource_ids\":[3,43,44,45,46,47,48,6,59,60,61,7,38,39,40,41,42,8,65,66,67,68,9,62,63,64,10,23,34,35,36,37,79,80,81,85,49,51,52,53,54,50,55,56,57,58,69,70,71,72,91,92,93,74,78,82,84,86,98,95,11],\"menu_ids\":[2,3,4,5,6,7,8,9,16,17,23,24,25,26,27,28,29,30,31,32,33,36,37,38,34,10]}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:58096', '未知'),
       (2, '2022-12-03 22:01:29', '2022-12-03 22:01:29', '分类', '新增或修改',
        'gin-blog/api/v1.(*Category).SaveOrUpdate-fm', '/api/category', '新增或修改分类', '{\"name\":\"后端\"}', 'POST',
        '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:58096', '未知'),
       (3, '2022-12-03 22:01:33', '2022-12-03 22:01:33', '分类', '新增或修改',
        'gin-blog/api/v1.(*Category).SaveOrUpdate-fm', '/api/category', '新增或修改分类', '{\"name\":\"前端\"}', 'POST',
        '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:58096', '未知'),
       (4, '2022-12-03 22:01:52', '2022-12-03 22:01:52', '标签', '新增或修改', 'gin-blog/api/v1.(*Tag).SaveOrUpdate-fm',
        '/api/tag', '新增或修改标签', '{\"name\":\"Golang\"}', 'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}',
        1, '管理员', '127.0.0.1:58096', '未知'),
       (5, '2022-12-03 22:01:57', '2022-12-03 22:01:57', '标签', '新增或修改', 'gin-blog/api/v1.(*Tag).SaveOrUpdate-fm',
        '/api/tag', '新增或修改标签', '{\"name\":\"Vue\"}', 'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1,
        '管理员', '127.0.0.1:58096', '未知'),
       (6, '2022-12-03 22:07:02', '2022-12-03 22:07:02', '文章', '新增或修改',
        'gin-blog/api/v1.(*Article).SaveOrUpdate-fm', '/api/article', '新增或修改文章',
        '{\"status\":1,\"title\":\"测试文章\",\"content\":\"这是一篇测试文章\",\"category_name\":\"后端\",\"tag_names\":[\"Golang\",\"Vue\"],\"type\":1,\"img\":\"\",\"is_top\":0}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:58096', '未知'),
       (7, '2022-12-03 22:19:52', '2022-12-03 22:19:52', '文章', '新增或修改',
        'gin-blog/api/v1.(*Article).SaveOrUpdate-fm', '/api/article', '新增或修改文章',
        '{\"id\":1,\"title\":\"测试文章\",\"desc\":\"\",\"content\":\"这是一篇测试文章\",\"img\":\"public/uploaded//1cba77c39b4d0a81024a7aada3655a28_20221203221949.jpg\",\"category_name\":\"后端\",\"tag_names\":[\"Golang\",\"Vue\"],\"type\":1,\"original_url\":\"\",\"is_top\":0,\"status\":1}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:58096', '未知'),
       (8, '2022-12-04 00:38:21', '2022-12-04 00:38:21', '文章', '新增或修改',
        'gin-blog/api/v1.(*Article).SaveOrUpdate-fm', '/api/article', '新增或修改文章',
        '{\"id\":1,\"title\":\"测试文章\",\"desc\":\"\",\"content\":\"## 博客介绍\\n\\n<p  align=center>\\n<a  href=\\\"http://www.hahacode.cn\\\">\\n<img  src=\\\"https://img-blog.csdnimg.cn/fe2f1034cf7c4bd795552d47373ee405.jpeg\\\"  width=\\\"200\\\"  hight=\\\"200\\\"  alt=\\\"阵、雨的个人博客\\\"  style=\\\"border-radius: 50%\\\">\\n</a>\\n</p>\\n\\n<p align=\\\"center\\\">\\n   <a target=\\\"_blank\\\" href=\\\"#\\\">\\n      <img src=\\\"https://img.shields.io/badge/Go-1.19-blue\\\"/>\\n      <img src=\\\"https://img.shields.io/badge/Gin-v1.8.1-blue\\\"/>\\n      <img src=\\\"https://img.shields.io/badge/Casbin-v2.56.0-blue\\\"/>\\n      <img src=\\\"https://img.shields.io/badge/mysql-8.0-blue\\\"/>\\n      <img src=\\\"https://img.shields.io/badge/GORM-v1.24.0-blue\\\"/>\\n      <img src=\\\"https://img.shields.io/badge/redis-7.0-red\\\"/>\\n      <img src=\\\"https://img.shields.io/badge/vue-v3.X-green\\\"/>\\n    </a>\\n</p>\\n\\n[在线地址](#在线地址) | [目录结构](#目录结构) | [技术介绍](#技术介绍) | [运行环境](#运行环境) | [开发环境](#开发环境) | [快速开始](#快速开始) | [项目总结](#项目总结) \\n\\n因最近忙于学业，本项目开发周期不是很长且断断续续，可能会存在不少 BUG，但是我会逐步修复的。\\n\\n您的 star 是我坚持的动力，感谢大家的支持，欢迎提交 pr 共同改进项目。\\n\\n\\nGithub地址：[https://github.com/szluyu99/gin-vue-blog](https://github.com/szluyu99/gin-vue-blog)\\n\\nGitee地址：[https://github.com/szluyu99/gin-vue-blog](https://github.com/szluyu99/gin-vue-blog)\\n\\n## 在线地址\\n\\n博客前台链接：[www.hahacode.cn](http://www.hahacode.cn)\\n\\n博客后台链接：[www.hahacode.cn/blog-admin](http://www.hahacode.cn/blog-admin)\\n\\n测试账号：test@qq.com，密码：11111，前后台都可用这个账号登录\\n\\n在线接口文档地址：[https://is68368smh.apifox.cn/](https://is68368smh.apifox.cn/)\\n\\n> 本项目在线接口文档由 Apifox 生成，由于项目架构调整，有些接口待完善和修改\\n\\n## 目录结构\\n\\n代码仓库目录：\\n\\n```bash\\ngin-vue-blog\\n├── gin-blog-admin      -- 博客后台前端\\n├── gin-blog-front      -- 博客前台前端\\n├── gin-blog-server     -- 博客后端\\n```\\n\\n需要先运行后端服务，再运行前端项目，因为很多前端配置由后端动态加载（如菜单等）。\\n\\n> 项目运行参考：[快速开始](#快速开始)\\n\\n后端目录：\\n\\n```bash\\ngin-blog-server\\n├── api             -- API\\n│   ├── front       -- 前台接口\\n│   └── v1          -- 后台接口\\n├── dao             -- 数据库操作模块\\n├── service         -- 服务模块\\n├── model           -- 数据模型\\n│   ├── req             -- 请求 VO 模型\\n│   ├── resp            -- 响应 VO 模型\\n│   ├── dto             -- 内部传输 DTO 模型\\n│   └── ...             -- 数据库模型对象 PO 模型\\n├── routes          -- 路由模块\\n│   └── middleware      -- 路由中间件\\n├── utils           -- 工具模块\\n│   ├── r               -- 响应封装\\n│   ├── upload          -- 文件上传\\n│   └── ...\\n├── routes          -- 路由模块\\n├── config          -- 配置文件\\n├── test            -- 测试模块\\n├── log             -- 日志文件\\n├── Dockerfile\\n└── main.go\\n```\\n\\n## 项目介绍\\n\\n前台：\\n- 前台界面设计参考 Hexo 的 Butterfly 设计，美观简洁\\n- 实现点赞，统计用户等功能 (Redis)\\n- 评论 + 回复评论功能\\n- 留言采用弹幕墙，效果炫酷\\n- 文章详情页有文章目录、推荐文章等功能，优化用户体验\\n\\n后台：\\n- 鉴权使用 JWT\\n- 权限管理使用 CASBIN，实现基于 RBAC 的权限管理\\n- 支持动态权限修改，前端菜单由后端生成\\n- 文章编辑使用 Markdown 编辑器\\n- 常规后台功能齐全：侧边栏、面包屑、标签栏等\\n\\n其他：\\n- 前后端分离部署，前端使用 Nginx，后端使用 Docker\\n- 代码整洁层次清晰，利于开发者学习\\n\\n## 技术介绍\\n\\n> 这里只写一些主流的通用技术，详细第三方库: 前端参考 `package.json` 文件，后端参考 `go.mod` 文件\\n\\n前台前端：使用 pnpm 包管理工具\\n- 基于 TypeScript\\n- Vue3\\n- Unocss: 原子化 CSS\\n- Pinia\\n- Vue Router \\n- Axios \\n- Naive UI\\n- Vuetify\\n- ...\\n\\n后台前端：使用 pnpm 包管理工具\\n- 基于 JavaSciprt \\n- pnpm: 包管理工具\\n- Vue3\\n- Unocss: 原子化 CSS\\n- Pinia \\n- Vue Router \\n- Axios \\n- Naive UI\\n- ...\\n\\n后端技术栈：\\n- 基于 Golang\\n- Docker\\n- Gin\\n- GORM\\n- Viper: 使用 TOML 作为配置文件\\n- Zap\\n- MySQL\\n- Redis\\n- Nginx: 部署静态资源 + 反向代理\\n- ...\\n\\n其他：\\n- 腾讯云人机验证\\n- 七牛云对象存储\\n- ...\\n\\n## 运行环境\\n\\n服务器：腾讯云 2核 4G Ubuntu 22.04 LTS\\n\\n对象存储：七牛云\\n\\n## 开发环境\\n\\n| 开发工具                      | 说明                    |\\n| ----------------------------- | ----------------------- |\\n| Vscode                        | Golang 后端 +  Vue 前端 |\\n| Navicat                       | MySQL 远程连接工具      |\\n| Another Redis Desktop Manager | Redis 远程连接工具      |\\n| MobaXterm                     | Linux 远程工具          |\\n| Apifox                        | 接口调试 + 文档生成     |\\n\\n\\n| 开发环境 | 版本 |\\n| -------- | ---- |\\n| Golang   | 1.19 |\\n| MySQL    | 8.x  |\\n| Redis    | 7.x  |\\n\\n## 快速开始\\n\\n### 本地运行\\n\\n> 自行安装 Golang、Node、MySQL、Redis 环境\\n\\n拉取项目到本地：\\n\\n```bash\\ngit clone https://github.com/szluyu99/gin-vue-blog.git\\n```\\n\\n后端项目运行：\\n\\n```bash\\n# 1、进入后端项目根目录 \\ncd gin-blog-server\\n\\n# 2、修改项目运行的配置文件，默认加载 config/config.toml \\n\\n# 3、MySQL 导入 ginblog.sql\\n\\n# 4、启动 Redis \\n\\n# 5、运行项目\\ngo mod tidy\\ngo run main.go\\n```\\n\\n前端项目运行： 本项目使用 pnpm 进行包管理，建议全局安装 pnpm\\n\\n```bash\\nnpm install -g pnpm\\n```\\n\\n前台前端：\\n\\n```bash\\n# 1、进入前台前端项目根目录\\ncd gin-blog-front\\n\\n# 2、安装依赖\\npnpm install\\n\\n# 3、运行项目\\npnpm run dev\\n```\\n\\n后台前端：\\n\\n```bash\\n# 1、进入后台前端项目根目录\\ncd gin-blog-admin\\n\\n# 2、安装依赖\\npnpm install\\n\\n# 3、运行项目\\npnpm run dev\\n```\\n\\n### 项目部署\\n\\n目前暂时不推荐将本博客部署上生产环境，因为还有太多功能未完善。\\n\\n但是相信本项目对于 Golang 学习者绝对是个合适的项目！\\n\\n等功能开发的差不多了，再专门针对部署写一篇文章。\\n\\n---\\n\\n这里简单介绍一下，有基础的同学可以自行折腾。\\n\\n本项目前端采用 Nginx 部署静态资源，后端使用 Docker 部署。\\n\\n后端 Docker 部署参考 `Dockerfile`，Docker 运行对应的配置文件是 `config/config.docker.toml`\\n\\nDocker 打包成镜像指令：\\n\\n```bash\\ndocker build -t ginblog .\\n```\\n\\n> 以上只是简单说明，等功能大致完成，会从 `安装 Docker`、`Docker 安装运行环境`、`Docker 部署项目` 等多个角度写几篇关于部署的教程。\\n\\n## 项目总结\\n\\n这个项目不管是前端，还是后端，都是花了比较大心血去架构的，并且从技术选型上，都是选择了目前最火 + 最新的技术栈。当然，这也是个人的学习之作，很多知识点都是边学边开发的（例如 Casbin），这个过程中也参考了很多优秀的开源项目，感谢大家的开源让程序员的世界更加美好，这也是开源本项目的目的之一。本项目中仍有很多不足，后续会继续更新。\\n\\n最后，项目整体代码风格很优秀，注释完善，适合 Golang 后端开发者、前端开发者学习。\\n\\n## 后续计划\\n\\n高优先级: \\n\\n- 完善图片上传功能, 目前文件上传还没怎么处理\\n- 后台首页重新设计（目前没放什么内容）\\n- 重写单元测试，目前的单元测试是早期版本，项目架构更改后，无法跑通\\n- 前台首页搜索文章（ElasticSearch 搜索）\\n- 博客文章导入导出 (.md 文件)\\n- 权限管理中菜单编辑时选择图标（现在只能输入图标字符串）\\n- 后端日志切割\\n- 后台修改背景图片，博客配置等\\n- 相册\\n\\n后续有空安排上：\\n- 适配移动端\\n- 黑夜模式\\n- 前台收缩侧边信息功能\\n- 说说\\n- 音乐播放器\\n- 鼠标左击特效\\n- 看板娘\\n- 文章目录锚点跟随\\n- 第三方登录\\n- 评论时支持选择表情，参考 Valine\\n- 若干细节需要完善...\\n\",\"img\":\"https://static.talkxj.com/articles/771941739cbc70fbe40e10cf441e02e5.jpg\",\"category_name\":\"后端\",\"tag_names\":[\"Golang\",\"Vue\"],\"type\":1,\"original_url\":\"\",\"is_top\":0,\"status\":1}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:58096', '未知'),
       (9, '2022-12-04 00:45:54', '2022-12-04 00:45:54', '文章', '新增或修改',
        'gin-blog/api/v1.(*Article).SaveOrUpdate-fm', '/api/article', '新增或修改文章',
        '{\"id\":1,\"title\":\"测试文章\",\"desc\":\"\",\"content\":\"## 博客介绍\\n\\n<p  align=center>\\n<a  href=\\\"http://www.hahacode.cn\\\">\\n<img  src=\\\"https://img-blog.csdnimg.cn/fe2f1034cf7c4bd795552d47373ee405.jpeg\\\"  width=\\\"200\\\"  hight=\\\"200\\\"  alt=\\\"阵、雨的个人博客\\\"  style=\\\"border-radius: 50%\\\">\\n</a>\\n</p>\\n\\n[在线地址](#在线地址) | [目录结构](#目录结构) | [技术介绍](#技术介绍) | [运行环境](#运行环境) | [开发环境](#开发环境) | [快速开始](#快速开始) | [项目总结](#项目总结) \\n\\n因最近忙于学业，本项目开发周期不是很长且断断续续，可能会存在不少 BUG，但是我会逐步修复的。\\n\\n您的 star 是我坚持的动力，感谢大家的支持，欢迎提交 pr 共同改进项目。\\n\\n\\nGithub地址：[https://github.com/szluyu99/gin-vue-blog](https://github.com/szluyu99/gin-vue-blog)\\n\\nGitee地址：[https://github.com/szluyu99/gin-vue-blog](https://github.com/szluyu99/gin-vue-blog)\\n\\n## 在线地址\\n\\n博客前台链接：[www.hahacode.cn](http://www.hahacode.cn)\\n\\n博客后台链接：[www.hahacode.cn/blog-admin](http://www.hahacode.cn/blog-admin)\\n\\n测试账号：test@qq.com，密码：11111，前后台都可用这个账号登录\\n\\n在线接口文档地址：[https://is68368smh.apifox.cn/](https://is68368smh.apifox.cn/)\\n\\n> 本项目在线接口文档由 Apifox 生成，由于项目架构调整，有些接口待完善和修改\\n\\n## 目录结构\\n\\n代码仓库目录：\\n\\n```bash\\ngin-vue-blog\\n├── gin-blog-admin      -- 博客后台前端\\n├── gin-blog-front      -- 博客前台前端\\n├── gin-blog-server     -- 博客后端\\n```\\n\\n需要先运行后端服务，再运行前端项目，因为很多前端配置由后端动态加载（如菜单等）。\\n\\n> 项目运行参考：[快速开始](#快速开始)\\n\\n后端目录：\\n\\n```bash\\ngin-blog-server\\n├── api             -- API\\n│   ├── front       -- 前台接口\\n│   └── v1          -- 后台接口\\n├── dao             -- 数据库操作模块\\n├── service         -- 服务模块\\n├── model           -- 数据模型\\n│   ├── req             -- 请求 VO 模型\\n│   ├── resp            -- 响应 VO 模型\\n│   ├── dto             -- 内部传输 DTO 模型\\n│   └── ...             -- 数据库模型对象 PO 模型\\n├── routes          -- 路由模块\\n│   └── middleware      -- 路由中间件\\n├── utils           -- 工具模块\\n│   ├── r               -- 响应封装\\n│   ├── upload          -- 文件上传\\n│   └── ...\\n├── routes          -- 路由模块\\n├── config          -- 配置文件\\n├── test            -- 测试模块\\n├── log             -- 日志文件\\n├── Dockerfile\\n└── main.go\\n```\\n\\n## 项目介绍\\n\\n前台：\\n- 前台界面设计参考 Hexo 的 Butterfly 设计，美观简洁\\n- 实现点赞，统计用户等功能 (Redis)\\n- 评论 + 回复评论功能\\n- 留言采用弹幕墙，效果炫酷\\n- 文章详情页有文章目录、推荐文章等功能，优化用户体验\\n\\n后台：\\n- 鉴权使用 JWT\\n- 权限管理使用 CASBIN，实现基于 RBAC 的权限管理\\n- 支持动态权限修改，前端菜单由后端生成\\n- 文章编辑使用 Markdown 编辑器\\n- 常规后台功能齐全：侧边栏、面包屑、标签栏等\\n\\n其他：\\n- 前后端分离部署，前端使用 Nginx，后端使用 Docker\\n- 代码整洁层次清晰，利于开发者学习\\n\\n## 技术介绍\\n\\n> 这里只写一些主流的通用技术，详细第三方库: 前端参考 `package.json` 文件，后端参考 `go.mod` 文件\\n\\n前台前端：使用 pnpm 包管理工具\\n- 基于 TypeScript\\n- Vue3\\n- Unocss: 原子化 CSS\\n- Pinia\\n- Vue Router \\n- Axios \\n- Naive UI\\n- Vuetify\\n- ...\\n\\n后台前端：使用 pnpm 包管理工具\\n- 基于 JavaSciprt \\n- pnpm: 包管理工具\\n- Vue3\\n- Unocss: 原子化 CSS\\n- Pinia \\n- Vue Router \\n- Axios \\n- Naive UI\\n- ...\\n\\n后端技术栈：\\n- 基于 Golang\\n- Docker\\n- Gin\\n- GORM\\n- Viper: 使用 TOML 作为配置文件\\n- Zap\\n- MySQL\\n- Redis\\n- Nginx: 部署静态资源 + 反向代理\\n- ...\\n\\n其他：\\n- 腾讯云人机验证\\n- 七牛云对象存储\\n- ...\\n\\n## 运行环境\\n\\n服务器：腾讯云 2核 4G Ubuntu 22.04 LTS\\n\\n对象存储：七牛云\\n\\n## 开发环境\\n\\n| 开发工具                      | 说明                    |\\n| ----------------------------- | ----------------------- |\\n| Vscode                        | Golang 后端 +  Vue 前端 |\\n| Navicat                       | MySQL 远程连接工具      |\\n| Another Redis Desktop Manager | Redis 远程连接工具      |\\n| MobaXterm                     | Linux 远程工具          |\\n| Apifox                        | 接口调试 + 文档生成     |\\n\\n\\n| 开发环境 | 版本 |\\n| -------- | ---- |\\n| Golang   | 1.19 |\\n| MySQL    | 8.x  |\\n| Redis    | 7.x  |\\n\\n## 快速开始\\n\\n### 本地运行\\n\\n> 自行安装 Golang、Node、MySQL、Redis 环境\\n\\n拉取项目到本地：\\n\\n```bash\\ngit clone https://github.com/szluyu99/gin-vue-blog.git\\n```\\n\\n后端项目运行：\\n\\n```bash\\n# 1、进入后端项目根目录 \\ncd gin-blog-server\\n\\n# 2、修改项目运行的配置文件，默认加载 config/config.toml \\n\\n# 3、MySQL 导入 ginblog.sql\\n\\n# 4、启动 Redis \\n\\n# 5、运行项目\\ngo mod tidy\\ngo run main.go\\n```\\n\\n前端项目运行： 本项目使用 pnpm 进行包管理，建议全局安装 pnpm\\n\\n```bash\\nnpm install -g pnpm\\n```\\n\\n前台前端：\\n\\n```bash\\n# 1、进入前台前端项目根目录\\ncd gin-blog-front\\n\\n# 2、安装依赖\\npnpm install\\n\\n# 3、运行项目\\npnpm run dev\\n```\\n\\n后台前端：\\n\\n```bash\\n# 1、进入后台前端项目根目录\\ncd gin-blog-admin\\n\\n# 2、安装依赖\\npnpm install\\n\\n# 3、运行项目\\npnpm run dev\\n```\\n\\n### 项目部署\\n\\n目前暂时不推荐将本博客部署上生产环境，因为还有太多功能未完善。\\n\\n但是相信本项目对于 Golang 学习者绝对是个合适的项目！\\n\\n等功能开发的差不多了，再专门针对部署写一篇文章。\\n\\n---\\n\\n这里简单介绍一下，有基础的同学可以自行折腾。\\n\\n本项目前端采用 Nginx 部署静态资源，后端使用 Docker 部署。\\n\\n后端 Docker 部署参考 `Dockerfile`，Docker 运行对应的配置文件是 `config/config.docker.toml`\\n\\nDocker 打包成镜像指令：\\n\\n```bash\\ndocker build -t ginblog .\\n```\\n\\n> 以上只是简单说明，等功能大致完成，会从 `安装 Docker`、`Docker 安装运行环境`、`Docker 部署项目` 等多个角度写几篇关于部署的教程。\\n\\n## 项目总结\\n\\n这个项目不管是前端，还是后端，都是花了比较大心血去架构的，并且从技术选型上，都是选择了目前最火 + 最新的技术栈。当然，这也是个人的学习之作，很多知识点都是边学边开发的（例如 Casbin），这个过程中也参考了很多优秀的开源项目，感谢大家的开源让程序员的世界更加美好，这也是开源本项目的目的之一。本项目中仍有很多不足，后续会继续更新。\\n\\n最后，项目整体代码风格很优秀，注释完善，适合 Golang 后端开发者、前端开发者学习。\\n\\n## 后续计划\\n\\n高优先级: \\n\\n- 完善图片上传功能, 目前文件上传还没怎么处理\\n- 后台首页重新设计（目前没放什么内容）\\n- 重写单元测试，目前的单元测试是早期版本，项目架构更改后，无法跑通\\n- 前台首页搜索文章（ElasticSearch 搜索）\\n- 博客文章导入导出 (.md 文件)\\n- 权限管理中菜单编辑时选择图标（现在只能输入图标字符串）\\n- 后端日志切割\\n- 后台修改背景图片，博客配置等\\n- 相册\\n\\n后续有空安排上：\\n- 适配移动端\\n- 黑夜模式\\n- 前台收缩侧边信息功能\\n- 说说\\n- 音乐播放器\\n- 鼠标左击特效\\n- 看板娘\\n- 文章目录锚点跟随\\n- 第三方登录\\n- 评论时支持选择表情，参考 Valine\\n- 若干细节需要完善...\\n\",\"img\":\"https://static.talkxj.com/articles/771941739cbc70fbe40e10cf441e02e5.jpg\",\"category_name\":\"后端\",\"tag_names\":[\"Golang\",\"Vue\"],\"type\":1,\"original_url\":\"\",\"is_top\":0,\"status\":1}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:58096', '未知'),
       (10, '2022-12-04 00:46:14', '2022-12-04 00:46:14', '文章', '新增或修改',
        'gin-blog/api/v1.(*Article).SaveOrUpdate-fm', '/api/article', '新增或修改文章',
        '{\"id\":1,\"title\":\"测试文章\",\"desc\":\"\",\"content\":\"## 博客介绍\\n\\n<p  align=center>\\n<a  href=\\\"http://www.hahacode.cn\\\">\\n<img  src=\\\"https://img-blog.csdnimg.cn/fe2f1034cf7c4bd795552d47373ee405.jpeg\\\"  width=\\\"200\\\"  hight=\\\"200\\\"  alt=\\\"阵、雨的个人博客\\\"  style=\\\"border-radius: 50%\\\">\\n</a>\\n</p>\\n\\n因最近忙于学业，本项目开发周期不是很长且断断续续，可能会存在不少 BUG，但是我会逐步修复的。\\n\\n您的 star 是我坚持的动力，感谢大家的支持，欢迎提交 pr 共同改进项目。\\n\\n\\nGithub地址：[https://github.com/szluyu99/gin-vue-blog](https://github.com/szluyu99/gin-vue-blog)\\n\\nGitee地址：[https://github.com/szluyu99/gin-vue-blog](https://github.com/szluyu99/gin-vue-blog)\\n\\n## 在线地址\\n\\n博客前台链接：[www.hahacode.cn](http://www.hahacode.cn)\\n\\n博客后台链接：[www.hahacode.cn/blog-admin](http://www.hahacode.cn/blog-admin)\\n\\n测试账号：test@qq.com，密码：11111，前后台都可用这个账号登录\\n\\n在线接口文档地址：[https://is68368smh.apifox.cn/](https://is68368smh.apifox.cn/)\\n\\n> 本项目在线接口文档由 Apifox 生成，由于项目架构调整，有些接口待完善和修改\\n\\n## 目录结构\\n\\n代码仓库目录：\\n\\n```bash\\ngin-vue-blog\\n├── gin-blog-admin      -- 博客后台前端\\n├── gin-blog-front      -- 博客前台前端\\n├── gin-blog-server     -- 博客后端\\n```\\n\\n需要先运行后端服务，再运行前端项目，因为很多前端配置由后端动态加载（如菜单等）。\\n\\n> 项目运行参考：[快速开始](#快速开始)\\n\\n后端目录：\\n\\n```bash\\ngin-blog-server\\n├── api             -- API\\n│   ├── front       -- 前台接口\\n│   └── v1          -- 后台接口\\n├── dao             -- 数据库操作模块\\n├── service         -- 服务模块\\n├── model           -- 数据模型\\n│   ├── req             -- 请求 VO 模型\\n│   ├── resp            -- 响应 VO 模型\\n│   ├── dto             -- 内部传输 DTO 模型\\n│   └── ...             -- 数据库模型对象 PO 模型\\n├── routes          -- 路由模块\\n│   └── middleware      -- 路由中间件\\n├── utils           -- 工具模块\\n│   ├── r               -- 响应封装\\n│   ├── upload          -- 文件上传\\n│   └── ...\\n├── routes          -- 路由模块\\n├── config          -- 配置文件\\n├── test            -- 测试模块\\n├── log             -- 日志文件\\n├── Dockerfile\\n└── main.go\\n```\\n\\n## 项目介绍\\n\\n前台：\\n- 前台界面设计参考 Hexo 的 Butterfly 设计，美观简洁\\n- 实现点赞，统计用户等功能 (Redis)\\n- 评论 + 回复评论功能\\n- 留言采用弹幕墙，效果炫酷\\n- 文章详情页有文章目录、推荐文章等功能，优化用户体验\\n\\n后台：\\n- 鉴权使用 JWT\\n- 权限管理使用 CASBIN，实现基于 RBAC 的权限管理\\n- 支持动态权限修改，前端菜单由后端生成\\n- 文章编辑使用 Markdown 编辑器\\n- 常规后台功能齐全：侧边栏、面包屑、标签栏等\\n\\n其他：\\n- 前后端分离部署，前端使用 Nginx，后端使用 Docker\\n- 代码整洁层次清晰，利于开发者学习\\n\\n## 技术介绍\\n\\n> 这里只写一些主流的通用技术，详细第三方库: 前端参考 `package.json` 文件，后端参考 `go.mod` 文件\\n\\n前台前端：使用 pnpm 包管理工具\\n- 基于 TypeScript\\n- Vue3\\n- Unocss: 原子化 CSS\\n- Pinia\\n- Vue Router \\n- Axios \\n- Naive UI\\n- Vuetify\\n- ...\\n\\n后台前端：使用 pnpm 包管理工具\\n- 基于 JavaSciprt \\n- pnpm: 包管理工具\\n- Vue3\\n- Unocss: 原子化 CSS\\n- Pinia \\n- Vue Router \\n- Axios \\n- Naive UI\\n- ...\\n\\n后端技术栈：\\n- 基于 Golang\\n- Docker\\n- Gin\\n- GORM\\n- Viper: 使用 TOML 作为配置文件\\n- Zap\\n- MySQL\\n- Redis\\n- Nginx: 部署静态资源 + 反向代理\\n- ...\\n\\n其他：\\n- 腾讯云人机验证\\n- 七牛云对象存储\\n- ...\\n\\n## 运行环境\\n\\n服务器：腾讯云 2核 4G Ubuntu 22.04 LTS\\n\\n对象存储：七牛云\\n\\n## 开发环境\\n\\n| 开发工具                      | 说明                    |\\n| ----------------------------- | ----------------------- |\\n| Vscode                        | Golang 后端 +  Vue 前端 |\\n| Navicat                       | MySQL 远程连接工具      |\\n| Another Redis Desktop Manager | Redis 远程连接工具      |\\n| MobaXterm                     | Linux 远程工具          |\\n| Apifox                        | 接口调试 + 文档生成     |\\n\\n\\n| 开发环境 | 版本 |\\n| -------- | ---- |\\n| Golang   | 1.19 |\\n| MySQL    | 8.x  |\\n| Redis    | 7.x  |\\n\\n## 快速开始\\n\\n### 本地运行\\n\\n> 自行安装 Golang、Node、MySQL、Redis 环境\\n\\n拉取项目到本地：\\n\\n```bash\\ngit clone https://github.com/szluyu99/gin-vue-blog.git\\n```\\n\\n后端项目运行：\\n\\n```bash\\n# 1、进入后端项目根目录 \\ncd gin-blog-server\\n\\n# 2、修改项目运行的配置文件，默认加载 config/config.toml \\n\\n# 3、MySQL 导入 ginblog.sql\\n\\n# 4、启动 Redis \\n\\n# 5、运行项目\\ngo mod tidy\\ngo run main.go\\n```\\n\\n前端项目运行： 本项目使用 pnpm 进行包管理，建议全局安装 pnpm\\n\\n```bash\\nnpm install -g pnpm\\n```\\n\\n前台前端：\\n\\n```bash\\n# 1、进入前台前端项目根目录\\ncd gin-blog-front\\n\\n# 2、安装依赖\\npnpm install\\n\\n# 3、运行项目\\npnpm run dev\\n```\\n\\n后台前端：\\n\\n```bash\\n# 1、进入后台前端项目根目录\\ncd gin-blog-admin\\n\\n# 2、安装依赖\\npnpm install\\n\\n# 3、运行项目\\npnpm run dev\\n```\\n\\n### 项目部署\\n\\n目前暂时不推荐将本博客部署上生产环境，因为还有太多功能未完善。\\n\\n但是相信本项目对于 Golang 学习者绝对是个合适的项目！\\n\\n等功能开发的差不多了，再专门针对部署写一篇文章。\\n\\n---\\n\\n这里简单介绍一下，有基础的同学可以自行折腾。\\n\\n本项目前端采用 Nginx 部署静态资源，后端使用 Docker 部署。\\n\\n后端 Docker 部署参考 `Dockerfile`，Docker 运行对应的配置文件是 `config/config.docker.toml`\\n\\nDocker 打包成镜像指令：\\n\\n```bash\\ndocker build -t ginblog .\\n```\\n\\n> 以上只是简单说明，等功能大致完成，会从 `安装 Docker`、`Docker 安装运行环境`、`Docker 部署项目` 等多个角度写几篇关于部署的教程。\\n\\n## 项目总结\\n\\n这个项目不管是前端，还是后端，都是花了比较大心血去架构的，并且从技术选型上，都是选择了目前最火 + 最新的技术栈。当然，这也是个人的学习之作，很多知识点都是边学边开发的（例如 Casbin），这个过程中也参考了很多优秀的开源项目，感谢大家的开源让程序员的世界更加美好，这也是开源本项目的目的之一。本项目中仍有很多不足，后续会继续更新。\\n\\n最后，项目整体代码风格很优秀，注释完善，适合 Golang 后端开发者、前端开发者学习。\\n\\n## 后续计划\\n\\n高优先级: \\n\\n- 完善图片上传功能, 目前文件上传还没怎么处理\\n- 后台首页重新设计（目前没放什么内容）\\n- 重写单元测试，目前的单元测试是早期版本，项目架构更改后，无法跑通\\n- 前台首页搜索文章（ElasticSearch 搜索）\\n- 博客文章导入导出 (.md 文件)\\n- 权限管理中菜单编辑时选择图标（现在只能输入图标字符串）\\n- 后端日志切割\\n- 后台修改背景图片，博客配置等\\n- 相册\\n\\n后续有空安排上：\\n- 适配移动端\\n- 黑夜模式\\n- 前台收缩侧边信息功能\\n- 说说\\n- 音乐播放器\\n- 鼠标左击特效\\n- 看板娘\\n- 文章目录锚点跟随\\n- 第三方登录\\n- 评论时支持选择表情，参考 Valine\\n- 若干细节需要完善...\\n\",\"img\":\"https://static.talkxj.com/articles/771941739cbc70fbe40e10cf441e02e5.jpg\",\"category_name\":\"后端\",\"tag_names\":[\"Golang\",\"Vue\"],\"type\":1,\"original_url\":\"\",\"is_top\":0,\"status\":1}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:58096', '未知'),
       (11, '2022-12-07 20:47:08', '2022-12-07 20:47:08', '菜单', '新增或修改',
        'gin-blog/api/v1.(*Menu).SaveOrUpdate-fm', '/api/menu', '新增或修改菜单',
        '{\"order_num\":7,\"is_hidden\":0,\"is_catelogue\":false,\"component\":\"/profile\",\"parent_id\":0,\"name\":\"个人中心\",\"icon\":\"mdi:account\",\"path\":\"/profile\",\"keep_alive\":1}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:58630', '未知'),
       (12, '2022-12-07 20:47:21', '2022-12-07 20:47:21', '角色', '新增或修改',
        'gin-blog/api/v1.(*Role).SaveOrUpdate-fm', '/api/role', '新增或修改角色',
        '{\"id\":1,\"name\":\"管理员\",\"label\":\"admin\",\"created_at\":\"2022-10-20T21:24:28+08:00\",\"is_disable\":0,\"resource_ids\":[3,43,44,45,46,47,48,6,59,60,61,7,38,39,40,41,42,8,65,66,67,68,9,62,63,64,10,23,34,35,36,37,79,80,81,85,49,51,52,53,54,50,55,56,57,58,69,70,71,72,91,92,93,74,78,82,84,86,98,95,11],\"menu_ids\":[2,3,4,5,6,7,8,9,16,17,23,24,25,26,27,28,29,30,31,32,33,36,37,38,34,10,39]}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:58630', '未知'),
       (13, '2022-12-07 20:47:23', '2022-12-07 20:47:23', '角色', '新增或修改',
        'gin-blog/api/v1.(*Role).SaveOrUpdate-fm', '/api/role', '新增或修改角色',
        '{\"id\":2,\"name\":\"用户\",\"label\":\"user\",\"created_at\":\"2022-10-20T21:25:07+08:00\",\"is_disable\":0,\"resource_ids\":[43,44,59,38,42,65,68,62,35,36,51,54,55,58,70,78,82,79,80,86,92,95,41],\"menu_ids\":[1,2,6,8,9,10,3,25,26,16,17,23,24,4,27,28,29,5,30,32,31,33,34,36,37,38,39]}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:58630', '未知'),
       (14, '2022-12-07 20:47:26', '2022-12-07 20:47:26', '角色', '新增或修改',
        'gin-blog/api/v1.(*Role).SaveOrUpdate-fm', '/api/role', '新增或修改角色',
        '{\"id\":3,\"name\":\"测试\",\"label\":\"test\",\"created_at\":\"2022-10-20T21:25:09+08:00\",\"is_disable\":0,\"resource_ids\":[43,44,59,38,41,42,65,68,62,35,36,79,80,51,54,55,58,70,78,82,92,95,86],\"menu_ids\":[1,2,3,4,33,6,34,8,9,10,25,26,16,17,23,24,5,29,30,32,31,27,28,36,37,38,39]}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:58630', '未知'),
       (15, '2022-12-07 20:48:06', '2022-12-07 20:48:06', '资源权限', '新增或修改',
        'gin-blog/api/v1.(*Resource).SaveOrUpdate-fm', '/api/resource', '新增或修改资源权限',
        '{\"parent_id\":74,\"name\":\"修改当前用户密码\",\"url\":\"/user/current/password\",\"request_method\":\"PUT\"}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:58630', '未知'),
       (16, '2022-12-07 20:48:36', '2022-12-07 20:48:36', '资源权限', '新增或修改',
        'gin-blog/api/v1.(*Resource).SaveOrUpdate-fm', '/api/resource', '新增或修改资源权限',
        '{\"parent_id\":74,\"name\":\"修改当前用户信息\",\"url\":\"/user/current\",\"request_method\":\"PUT\"}', 'POST',
        '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:58630', '未知'),
       (17, '2022-12-07 20:48:56', '2022-12-07 20:48:56', '角色', '新增或修改',
        'gin-blog/api/v1.(*Role).SaveOrUpdate-fm', '/api/role', '新增或修改角色',
        '{\"id\":1,\"name\":\"管理员\",\"label\":\"admin\",\"created_at\":\"2022-10-20T21:24:28+08:00\",\"is_disable\":0,\"resource_ids\":[3,43,44,45,46,47,48,6,59,60,61,7,38,39,40,41,42,8,65,66,67,68,9,62,63,64,10,23,34,35,36,37,79,80,81,85,49,51,52,53,54,50,55,56,57,58,69,70,71,72,91,92,93,78,82,84,86,98,95,11,99,100,74],\"menu_ids\":[2,3,4,5,6,7,8,9,16,17,23,24,25,26,27,28,29,30,31,32,33,36,37,38,34,10,39]}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:58630', '未知'),
       (18, '2022-12-07 20:49:10', '2022-12-07 20:49:10', '用户', '修改', 'gin-blog/api/v1.(*User).UpdateCurrent-fm',
        '/api/user/current', '修改用户',
        '{\"avatar\":\"https://www.bing.com/rp/ar_9isCNU2Q-VG1yEDDHnx8HAFQ.png\",\"nickname\":\"管理员\",\"intro\":\"我是管理员用户！\",\"website\":\"https://www.baidu.com\"}',
        'PUT', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:58630', '未知'),
       (19, '2022-12-07 20:49:21', '2022-12-07 20:49:21', '用户', '修改',
        'gin-blog/api/v1.(*User).UpdateCurrentPassword-fm', '/api/user/current/password', '修改用户',
        '{\"old_password\":\"1234567\",\"new_password\":\"1234567\",\"confirm_password\":\"1234567\"}', 'PUT',
        '{\"code\":1010,\"message\":\"旧密码不正确\",\"data\":null}', 1, '管理员', '127.0.0.1:58630', '未知'),
       (20, '2022-12-07 20:53:17', '2022-12-07 20:53:17', '文章', '修改', 'gin-blog/api/v1.(*Article).UpdateTop-fm',
        '/api/article/top', '修改文章',
        '{\"id\":1,\"created_at\":\"2022-12-03T22:07:01.638+08:00\",\"updated_at\":\"2022-12-04T00:46:13.94+08:00\",\"category_id\":1,\"category\":{\"id\":1,\"created_at\":\"2022-12-03T22:01:29.106+08:00\",\"updated_at\":\"2022-12-03T22:01:29.106+08:00\",\"name\":\"后端\",\"Articles\":null},\"tags\":[{\"id\":1,\"created_at\":\"2022-12-03T22:01:51.624+08:00\",\"updated_at\":\"2022-12-03T22:01:51.624+08:00\",\"articles\":null,\"name\":\"Golang\"},{\"id\":2,\"created_at\":\"2022-12-03T22:01:56.984+08:00\",\"updated_at\":\"2022-12-03T22:01:56.984+08:00\",\"articles\":null,\"name\":\"Vue\"}],\"user_id\":1,\"title\":\"测试文章\",\"desc\":\"\",\"content\":\"## 博客介绍\\n\\n<p  align=center>\\n<a  href=\\\"http://www.hahacode.cn\\\">\\n<img  src=\\\"https://img-blog.csdnimg.cn/fe2f1034cf7c4bd795552d47373ee405.jpeg\\\"  width=\\\"200\\\"  hight=\\\"200\\\"  alt=\\\"阵、雨的个人博客\\\"  style=\\\"border-radius: 50%\\\">\\n</a>\\n</p>\\n\\n因最近忙于学业，本项目开发周期不是很长且断断续续，可能会存在不少 BUG，但是我会逐步修复的。\\n\\n您的 star 是我坚持的动力，感谢大家的支持，欢迎提交 pr 共同改进项目。\\n\\n\\nGithub地址：[https://github.com/szluyu99/gin-vue-blog](https://github.com/szluyu99/gin-vue-blog)\\n\\nGitee地址：[https://github.com/szluyu99/gin-vue-blog](https://github.com/szluyu99/gin-vue-blog)\\n\\n## 在线地址\\n\\n博客前台链接：[www.hahacode.cn](http://www.hahacode.cn)\\n\\n博客后台链接：[www.hahacode.cn/blog-admin](http://www.hahacode.cn/blog-admin)\\n\\n测试账号：test@qq.com，密码：11111，前后台都可用这个账号登录\\n\\n在线接口文档地址：[https://is68368smh.apifox.cn/](https://is68368smh.apifox.cn/)\\n\\n> 本项目在线接口文档由 Apifox 生成，由于项目架构调整，有些接口待完善和修改\\n\\n## 目录结构\\n\\n代码仓库目录：\\n\\n```bash\\ngin-vue-blog\\n├── gin-blog-admin      -- 博客后台前端\\n├── gin-blog-front      -- 博客前台前端\\n├── gin-blog-server     -- 博客后端\\n```\\n\\n需要先运行后端服务，再运行前端项目，因为很多前端配置由后端动态加载（如菜单等）。\\n\\n> 项目运行参考：[快速开始](#快速开始)\\n\\n后端目录：\\n\\n```bash\\ngin-blog-server\\n├── api             -- API\\n│   ├── front       -- 前台接口\\n│   └── v1          -- 后台接口\\n├── dao             -- 数据库操作模块\\n├── service         -- 服务模块\\n├── model           -- 数据模型\\n│   ├── req             -- 请求 VO 模型\\n│   ├── resp            -- 响应 VO 模型\\n│   ├── dto             -- 内部传输 DTO 模型\\n│   └── ...             -- 数据库模型对象 PO 模型\\n├── routes          -- 路由模块\\n│   └── middleware      -- 路由中间件\\n├── utils           -- 工具模块\\n│   ├── r               -- 响应封装\\n│   ├── upload          -- 文件上传\\n│   └── ...\\n├── routes          -- 路由模块\\n├── config          -- 配置文件\\n├── test            -- 测试模块\\n├── log             -- 日志文件\\n├── Dockerfile\\n└── main.go\\n```\\n\\n## 项目介绍\\n\\n前台：\\n- 前台界面设计参考 Hexo 的 Butterfly 设计，美观简洁\\n- 实现点赞，统计用户等功能 (Redis)\\n- 评论 + 回复评论功能\\n- 留言采用弹幕墙，效果炫酷\\n- 文章详情页有文章目录、推荐文章等功能，优化用户体验\\n\\n后台：\\n- 鉴权使用 JWT\\n- 权限管理使用 CASBIN，实现基于 RBAC 的权限管理\\n- 支持动态权限修改，前端菜单由后端生成\\n- 文章编辑使用 Markdown 编辑器\\n- 常规后台功能齐全：侧边栏、面包屑、标签栏等\\n\\n其他：\\n- 前后端分离部署，前端使用 Nginx，后端使用 Docker\\n- 代码整洁层次清晰，利于开发者学习\\n\\n## 技术介绍\\n\\n> 这里只写一些主流的通用技术，详细第三方库: 前端参考 `package.json` 文件，后端参考 `go.mod` 文件\\n\\n前台前端：使用 pnpm 包管理工具\\n- 基于 TypeScript\\n- Vue3\\n- Unocss: 原子化 CSS\\n- Pinia\\n- Vue Router \\n- Axios \\n- Naive UI\\n- Vuetify\\n- ...\\n\\n后台前端：使用 pnpm 包管理工具\\n- 基于 JavaSciprt \\n- pnpm: 包管理工具\\n- Vue3\\n- Unocss: 原子化 CSS\\n- Pinia \\n- Vue Router \\n- Axios \\n- Naive UI\\n- ...\\n\\n后端技术栈：\\n- 基于 Golang\\n- Docker\\n- Gin\\n- GORM\\n- Viper: 使用 TOML 作为配置文件\\n- Zap\\n- MySQL\\n- Redis\\n- Nginx: 部署静态资源 + 反向代理\\n- ...\\n\\n其他：\\n- 腾讯云人机验证\\n- 七牛云对象存储\\n- ...\\n\\n## 运行环境\\n\\n服务器：腾讯云 2核 4G Ubuntu 22.04 LTS\\n\\n对象存储：七牛云\\n\\n## 开发环境\\n\\n| 开发工具                      | 说明                    |\\n| ----------------------------- | ----------------------- |\\n| Vscode                        | Golang 后端 +  Vue 前端 |\\n| Navicat                       | MySQL 远程连接工具      |\\n| Another Redis Desktop Manager | Redis 远程连接工具      |\\n| MobaXterm                     | Linux 远程工具          |\\n| Apifox                        | 接口调试 + 文档生成     |\\n\\n\\n| 开发环境 | 版本 |\\n| -------- | ---- |\\n| Golang   | 1.19 |\\n| MySQL    | 8.x  |\\n| Redis    | 7.x  |\\n\\n## 快速开始\\n\\n### 本地运行\\n\\n> 自行安装 Golang、Node、MySQL、Redis 环境\\n\\n拉取项目到本地：\\n\\n```bash\\ngit clone https://github.com/szluyu99/gin-vue-blog.git\\n```\\n\\n后端项目运行：\\n\\n```bash\\n# 1、进入后端项目根目录 \\ncd gin-blog-server\\n\\n# 2、修改项目运行的配置文件，默认加载 config/config.toml \\n\\n# 3、MySQL 导入 ginblog.sql\\n\\n# 4、启动 Redis \\n\\n# 5、运行项目\\ngo mod tidy\\ngo run main.go\\n```\\n\\n前端项目运行： 本项目使用 pnpm 进行包管理，建议全局安装 pnpm\\n\\n```bash\\nnpm install -g pnpm\\n```\\n\\n前台前端：\\n\\n```bash\\n# 1、进入前台前端项目根目录\\ncd gin-blog-front\\n\\n# 2、安装依赖\\npnpm install\\n\\n# 3、运行项目\\npnpm run dev\\n```\\n\\n后台前端：\\n\\n```bash\\n# 1、进入后台前端项目根目录\\ncd gin-blog-admin\\n\\n# 2、安装依赖\\npnpm install\\n\\n# 3、运行项目\\npnpm run dev\\n```\\n\\n### 项目部署\\n\\n目前暂时不推荐将本博客部署上生产环境，因为还有太多功能未完善。\\n\\n但是相信本项目对于 Golang 学习者绝对是个合适的项目！\\n\\n等功能开发的差不多了，再专门针对部署写一篇文章。\\n\\n---\\n\\n这里简单介绍一下，有基础的同学可以自行折腾。\\n\\n本项目前端采用 Nginx 部署静态资源，后端使用 Docker 部署。\\n\\n后端 Docker 部署参考 `Dockerfile`，Docker 运行对应的配置文件是 `config/config.docker.toml`\\n\\nDocker 打包成镜像指令：\\n\\n```bash\\ndocker build -t ginblog .\\n```\\n\\n> 以上只是简单说明，等功能大致完成，会从 `安装 Docker`、`Docker 安装运行环境`、`Docker 部署项目` 等多个角度写几篇关于部署的教程。\\n\\n## 项目总结\\n\\n这个项目不管是前端，还是后端，都是花了比较大心血去架构的，并且从技术选型上，都是选择了目前最火 + 最新的技术栈。当然，这也是个人的学习之作，很多知识点都是边学边开发的（例如 Casbin），这个过程中也参考了很多优秀的开源项目，感谢大家的开源让程序员的世界更加美好，这也是开源本项目的目的之一。本项目中仍有很多不足，后续会继续更新。\\n\\n最后，项目整体代码风格很优秀，注释完善，适合 Golang 后端开发者、前端开发者学习。\\n\\n## 后续计划\\n\\n高优先级: \\n\\n- 完善图片上传功能, 目前文件上传还没怎么处理\\n- 后台首页重新设计（目前没放什么内容）\\n- 重写单元测试，目前的单元测试是早期版本，项目架构更改后，无法跑通\\n- 前台首页搜索文章（ElasticSearch 搜索）\\n- 博客文章导入导出 (.md 文件)\\n- 权限管理中菜单编辑时选择图标（现在只能输入图标字符串）\\n- 后端日志切割\\n- 后台修改背景图片，博客配置等\\n- 相册\\n\\n后续有空安排上：\\n- 适配移动端\\n- 黑夜模式\\n- 前台收缩侧边信息功能\\n- 说说\\n- 音乐播放器\\n- 鼠标左击特效\\n- 看板娘\\n- 文章目录锚点跟随\\n- 第三方登录\\n- 评论时支持选择表情，参考 Valine\\n- 若干细节需要完善...\\n\",\"img\":\"https://static.talkxj.com/articles/771941739cbc70fbe40e10cf441e02e5.jpg\",\"type\":1,\"status\":1,\"is_top\":1,\"is_delete\":0,\"original_url\":\"\",\"comment_count\":0,\"read_count\":0,\"publishing\":true}',
        'PUT', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:58630', '未知'),
       (21, '2022-12-07 20:53:18', '2022-12-07 20:53:18', '文章', '修改', 'gin-blog/api/v1.(*Article).UpdateTop-fm',
        '/api/article/top', '修改文章',
        '{\"id\":1,\"created_at\":\"2022-12-03T22:07:01.638+08:00\",\"updated_at\":\"2022-12-07T20:53:16.635+08:00\",\"category_id\":1,\"category\":{\"id\":1,\"created_at\":\"2022-12-03T22:01:29.106+08:00\",\"updated_at\":\"2022-12-03T22:01:29.106+08:00\",\"name\":\"后端\",\"Articles\":null},\"tags\":[{\"id\":1,\"created_at\":\"2022-12-03T22:01:51.624+08:00\",\"updated_at\":\"2022-12-03T22:01:51.624+08:00\",\"articles\":null,\"name\":\"Golang\"},{\"id\":2,\"created_at\":\"2022-12-03T22:01:56.984+08:00\",\"updated_at\":\"2022-12-03T22:01:56.984+08:00\",\"articles\":null,\"name\":\"Vue\"}],\"user_id\":1,\"title\":\"测试文章\",\"desc\":\"\",\"content\":\"## 博客介绍\\n\\n<p  align=center>\\n<a  href=\\\"http://www.hahacode.cn\\\">\\n<img  src=\\\"https://img-blog.csdnimg.cn/fe2f1034cf7c4bd795552d47373ee405.jpeg\\\"  width=\\\"200\\\"  hight=\\\"200\\\"  alt=\\\"阵、雨的个人博客\\\"  style=\\\"border-radius: 50%\\\">\\n</a>\\n</p>\\n\\n因最近忙于学业，本项目开发周期不是很长且断断续续，可能会存在不少 BUG，但是我会逐步修复的。\\n\\n您的 star 是我坚持的动力，感谢大家的支持，欢迎提交 pr 共同改进项目。\\n\\n\\nGithub地址：[https://github.com/szluyu99/gin-vue-blog](https://github.com/szluyu99/gin-vue-blog)\\n\\nGitee地址：[https://github.com/szluyu99/gin-vue-blog](https://github.com/szluyu99/gin-vue-blog)\\n\\n## 在线地址\\n\\n博客前台链接：[www.hahacode.cn](http://www.hahacode.cn)\\n\\n博客后台链接：[www.hahacode.cn/blog-admin](http://www.hahacode.cn/blog-admin)\\n\\n测试账号：test@qq.com，密码：11111，前后台都可用这个账号登录\\n\\n在线接口文档地址：[https://is68368smh.apifox.cn/](https://is68368smh.apifox.cn/)\\n\\n> 本项目在线接口文档由 Apifox 生成，由于项目架构调整，有些接口待完善和修改\\n\\n## 目录结构\\n\\n代码仓库目录：\\n\\n```bash\\ngin-vue-blog\\n├── gin-blog-admin      -- 博客后台前端\\n├── gin-blog-front      -- 博客前台前端\\n├── gin-blog-server     -- 博客后端\\n```\\n\\n需要先运行后端服务，再运行前端项目，因为很多前端配置由后端动态加载（如菜单等）。\\n\\n> 项目运行参考：[快速开始](#快速开始)\\n\\n后端目录：\\n\\n```bash\\ngin-blog-server\\n├── api             -- API\\n│   ├── front       -- 前台接口\\n│   └── v1          -- 后台接口\\n├── dao             -- 数据库操作模块\\n├── service         -- 服务模块\\n├── model           -- 数据模型\\n│   ├── req             -- 请求 VO 模型\\n│   ├── resp            -- 响应 VO 模型\\n│   ├── dto             -- 内部传输 DTO 模型\\n│   └── ...             -- 数据库模型对象 PO 模型\\n├── routes          -- 路由模块\\n│   └── middleware      -- 路由中间件\\n├── utils           -- 工具模块\\n│   ├── r               -- 响应封装\\n│   ├── upload          -- 文件上传\\n│   └── ...\\n├── routes          -- 路由模块\\n├── config          -- 配置文件\\n├── test            -- 测试模块\\n├── log             -- 日志文件\\n├── Dockerfile\\n└── main.go\\n```\\n\\n## 项目介绍\\n\\n前台：\\n- 前台界面设计参考 Hexo 的 Butterfly 设计，美观简洁\\n- 实现点赞，统计用户等功能 (Redis)\\n- 评论 + 回复评论功能\\n- 留言采用弹幕墙，效果炫酷\\n- 文章详情页有文章目录、推荐文章等功能，优化用户体验\\n\\n后台：\\n- 鉴权使用 JWT\\n- 权限管理使用 CASBIN，实现基于 RBAC 的权限管理\\n- 支持动态权限修改，前端菜单由后端生成\\n- 文章编辑使用 Markdown 编辑器\\n- 常规后台功能齐全：侧边栏、面包屑、标签栏等\\n\\n其他：\\n- 前后端分离部署，前端使用 Nginx，后端使用 Docker\\n- 代码整洁层次清晰，利于开发者学习\\n\\n## 技术介绍\\n\\n> 这里只写一些主流的通用技术，详细第三方库: 前端参考 `package.json` 文件，后端参考 `go.mod` 文件\\n\\n前台前端：使用 pnpm 包管理工具\\n- 基于 TypeScript\\n- Vue3\\n- Unocss: 原子化 CSS\\n- Pinia\\n- Vue Router \\n- Axios \\n- Naive UI\\n- Vuetify\\n- ...\\n\\n后台前端：使用 pnpm 包管理工具\\n- 基于 JavaSciprt \\n- pnpm: 包管理工具\\n- Vue3\\n- Unocss: 原子化 CSS\\n- Pinia \\n- Vue Router \\n- Axios \\n- Naive UI\\n- ...\\n\\n后端技术栈：\\n- 基于 Golang\\n- Docker\\n- Gin\\n- GORM\\n- Viper: 使用 TOML 作为配置文件\\n- Zap\\n- MySQL\\n- Redis\\n- Nginx: 部署静态资源 + 反向代理\\n- ...\\n\\n其他：\\n- 腾讯云人机验证\\n- 七牛云对象存储\\n- ...\\n\\n## 运行环境\\n\\n服务器：腾讯云 2核 4G Ubuntu 22.04 LTS\\n\\n对象存储：七牛云\\n\\n## 开发环境\\n\\n| 开发工具                      | 说明                    |\\n| ----------------------------- | ----------------------- |\\n| Vscode                        | Golang 后端 +  Vue 前端 |\\n| Navicat                       | MySQL 远程连接工具      |\\n| Another Redis Desktop Manager | Redis 远程连接工具      |\\n| MobaXterm                     | Linux 远程工具          |\\n| Apifox                        | 接口调试 + 文档生成     |\\n\\n\\n| 开发环境 | 版本 |\\n| -------- | ---- |\\n| Golang   | 1.19 |\\n| MySQL    | 8.x  |\\n| Redis    | 7.x  |\\n\\n## 快速开始\\n\\n### 本地运行\\n\\n> 自行安装 Golang、Node、MySQL、Redis 环境\\n\\n拉取项目到本地：\\n\\n```bash\\ngit clone https://github.com/szluyu99/gin-vue-blog.git\\n```\\n\\n后端项目运行：\\n\\n```bash\\n# 1、进入后端项目根目录 \\ncd gin-blog-server\\n\\n# 2、修改项目运行的配置文件，默认加载 config/config.toml \\n\\n# 3、MySQL 导入 ginblog.sql\\n\\n# 4、启动 Redis \\n\\n# 5、运行项目\\ngo mod tidy\\ngo run main.go\\n```\\n\\n前端项目运行： 本项目使用 pnpm 进行包管理，建议全局安装 pnpm\\n\\n```bash\\nnpm install -g pnpm\\n```\\n\\n前台前端：\\n\\n```bash\\n# 1、进入前台前端项目根目录\\ncd gin-blog-front\\n\\n# 2、安装依赖\\npnpm install\\n\\n# 3、运行项目\\npnpm run dev\\n```\\n\\n后台前端：\\n\\n```bash\\n# 1、进入后台前端项目根目录\\ncd gin-blog-admin\\n\\n# 2、安装依赖\\npnpm install\\n\\n# 3、运行项目\\npnpm run dev\\n```\\n\\n### 项目部署\\n\\n目前暂时不推荐将本博客部署上生产环境，因为还有太多功能未完善。\\n\\n但是相信本项目对于 Golang 学习者绝对是个合适的项目！\\n\\n等功能开发的差不多了，再专门针对部署写一篇文章。\\n\\n---\\n\\n这里简单介绍一下，有基础的同学可以自行折腾。\\n\\n本项目前端采用 Nginx 部署静态资源，后端使用 Docker 部署。\\n\\n后端 Docker 部署参考 `Dockerfile`，Docker 运行对应的配置文件是 `config/config.docker.toml`\\n\\nDocker 打包成镜像指令：\\n\\n```bash\\ndocker build -t ginblog .\\n```\\n\\n> 以上只是简单说明，等功能大致完成，会从 `安装 Docker`、`Docker 安装运行环境`、`Docker 部署项目` 等多个角度写几篇关于部署的教程。\\n\\n## 项目总结\\n\\n这个项目不管是前端，还是后端，都是花了比较大心血去架构的，并且从技术选型上，都是选择了目前最火 + 最新的技术栈。当然，这也是个人的学习之作，很多知识点都是边学边开发的（例如 Casbin），这个过程中也参考了很多优秀的开源项目，感谢大家的开源让程序员的世界更加美好，这也是开源本项目的目的之一。本项目中仍有很多不足，后续会继续更新。\\n\\n最后，项目整体代码风格很优秀，注释完善，适合 Golang 后端开发者、前端开发者学习。\\n\\n## 后续计划\\n\\n高优先级: \\n\\n- 完善图片上传功能, 目前文件上传还没怎么处理\\n- 后台首页重新设计（目前没放什么内容）\\n- 重写单元测试，目前的单元测试是早期版本，项目架构更改后，无法跑通\\n- 前台首页搜索文章（ElasticSearch 搜索）\\n- 博客文章导入导出 (.md 文件)\\n- 权限管理中菜单编辑时选择图标（现在只能输入图标字符串）\\n- 后端日志切割\\n- 后台修改背景图片，博客配置等\\n- 相册\\n\\n后续有空安排上：\\n- 适配移动端\\n- 黑夜模式\\n- 前台收缩侧边信息功能\\n- 说说\\n- 音乐播放器\\n- 鼠标左击特效\\n- 看板娘\\n- 文章目录锚点跟随\\n- 第三方登录\\n- 评论时支持选择表情，参考 Valine\\n- 若干细节需要完善...\\n\",\"img\":\"https://static.talkxj.com/articles/771941739cbc70fbe40e10cf441e02e5.jpg\",\"type\":1,\"status\":1,\"is_top\":0,\"is_delete\":0,\"original_url\":\"\",\"comment_count\":0,\"read_count\":0,\"publishing\":true}',
        'PUT', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:58630', '未知'),
       (22, '2022-12-07 20:53:27', '2022-12-07 20:53:27', '菜单', '新增或修改',
        'gin-blog/api/v1.(*Menu).SaveOrUpdate-fm', '/api/menu', '新增或修改菜单',
        '{\"id\":33,\"name\":\"首页\",\"path\":\"/home\",\"component\":\"/home\",\"icon\":\"ic:sharp-home\",\"created_at\":\"2022-11-01T01:43:10.142+08:00\",\"order_num\":0,\"children\":[],\"parent_id\":0,\"is_hidden\":1,\"keep_alive\":1,\"redirect\":\"\",\"publishing\":true}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:58630', '未知'),
       (23, '2022-12-07 20:53:27', '2022-12-07 20:53:27', '菜单', '新增或修改',
        'gin-blog/api/v1.(*Menu).SaveOrUpdate-fm', '/api/menu', '新增或修改菜单',
        '{\"id\":33,\"name\":\"首页\",\"path\":\"/home\",\"component\":\"/home\",\"icon\":\"ic:sharp-home\",\"created_at\":\"2022-11-01T01:43:10.142+08:00\",\"order_num\":0,\"children\":[],\"parent_id\":0,\"is_hidden\":0,\"keep_alive\":1,\"redirect\":\"\",\"publishing\":true}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:58630', '未知'),
       (24, '2022-12-07 20:53:31', '2022-12-07 20:53:31', '菜单', '新增或修改',
        'gin-blog/api/v1.(*Menu).SaveOrUpdate-fm', '/api/menu', '新增或修改菜单',
        '{\"id\":39,\"name\":\"个人中心\",\"path\":\"/profile\",\"component\":\"/profile\",\"icon\":\"mdi:account\",\"created_at\":\"2022-12-07T20:47:08.349+08:00\",\"order_num\":7,\"children\":[],\"parent_id\":0,\"is_hidden\":1,\"keep_alive\":1,\"redirect\":\"\",\"publishing\":true}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:58630', '未知'),
       (25, '2022-12-07 20:53:34', '2022-12-07 20:53:34', '菜单', '新增或修改',
        'gin-blog/api/v1.(*Menu).SaveOrUpdate-fm', '/api/menu', '新增或修改菜单',
        '{\"id\":39,\"name\":\"个人中心\",\"path\":\"/profile\",\"component\":\"/profile\",\"icon\":\"mdi:account\",\"created_at\":\"2022-12-07T20:47:08.349+08:00\",\"order_num\":7,\"children\":[],\"parent_id\":0,\"is_hidden\":0,\"keep_alive\":1,\"redirect\":\"\",\"publishing\":true}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:58630', '未知'),
       (26, '2022-12-07 20:55:08', '2022-12-07 20:55:08', '资源权限', '新增或修改',
        'gin-blog/api/v1.(*Resource).SaveOrUpdate-fm', '/api/resource', '新增或修改资源权限',
        '{\"parent_id\":74,\"name\":\"修改用户禁用\",\"url\":\"/user/disable\",\"request_method\":\"PUT\"}', 'POST',
        '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:58630', '未知'),
       (27, '2022-12-07 20:55:22', '2022-12-07 20:55:22', '角色', '新增或修改',
        'gin-blog/api/v1.(*Role).SaveOrUpdate-fm', '/api/role', '新增或修改角色',
        '{\"id\":1,\"name\":\"管理员\",\"label\":\"admin\",\"created_at\":\"2022-10-20T21:24:28+08:00\",\"is_disable\":0,\"resource_ids\":[3,43,44,45,46,47,48,6,59,60,61,7,38,39,40,41,42,8,65,66,67,68,9,62,63,64,10,23,34,35,36,37,79,80,81,85,49,51,52,53,54,50,55,56,57,58,69,70,71,72,91,92,93,78,82,84,86,98,95,11,99,100,101,74],\"menu_ids\":[2,3,4,5,6,7,8,9,16,17,23,24,25,26,27,28,29,30,31,32,33,36,37,38,34,10,39]}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:58630', '未知'),
       (28, '2022-12-07 20:55:29', '2022-12-07 20:55:29', '用户', '修改', 'gin-blog/api/v1.(*User).UpdateDisable-fm',
        '/api/user/disable', '修改用户',
        '{\"id\":2,\"user_info_id\":2,\"avatar\":\"https://www.bing.com/rp/ar_9isCNU2Q-VG1yEDDHnx8HAFQ.png\",\"nickname\":\"普通用户\",\"roles\":[{\"id\":2,\"created_at\":\"2022-10-20T21:25:07+08:00\",\"updated_at\":\"2022-12-07T20:47:23.344+08:00\",\"name\":\"用户\",\"label\":\"user\",\"is_disable\":0}],\"login_type\":1,\"ip_address\":\"172.17.0.1:40280\",\"ip_source\":\"未知\",\"created_at\":\"2022-10-19T22:31:26.805+08:00\",\"last_login_time\":\"2022-12-03T12:20:36.539+08:00\",\"is_disable\":1,\"publishing\":true}',
        'PUT', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:58630', '未知'),
       (29, '2022-12-07 20:55:30', '2022-12-07 20:55:30', '用户', '修改', 'gin-blog/api/v1.(*User).UpdateDisable-fm',
        '/api/user/disable', '修改用户',
        '{\"id\":2,\"user_info_id\":2,\"avatar\":\"https://www.bing.com/rp/ar_9isCNU2Q-VG1yEDDHnx8HAFQ.png\",\"nickname\":\"普通用户\",\"roles\":[{\"id\":2,\"created_at\":\"2022-10-20T21:25:07+08:00\",\"updated_at\":\"2022-12-07T20:47:23.344+08:00\",\"name\":\"用户\",\"label\":\"user\",\"is_disable\":0}],\"login_type\":1,\"ip_address\":\"172.17.0.1:40280\",\"ip_source\":\"未知\",\"created_at\":\"2022-10-19T22:31:26.805+08:00\",\"last_login_time\":\"2022-12-03T12:20:36.539+08:00\",\"is_disable\":0,\"publishing\":true}',
        'PUT', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:58630', '未知'),
       (30, '2022-12-08 15:43:15', '2022-12-08 15:43:15', '资源权限', '新增或修改',
        'gin-blog/api/v1.(*Resource).SaveOrUpdate-fm', '/api/resource', '新增或修改资源权限', '{\"name\":\"页面模块\"}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:38804', '未知'),
       (31, '2022-12-08 15:43:26', '2022-12-08 15:43:26', '资源权限', '新增或修改',
        'gin-blog/api/v1.(*Resource).SaveOrUpdate-fm', '/api/resource', '新增或修改资源权限',
        '{\"parent_id\":102,\"name\":\"页面列表\",\"url\":\"/page/list\",\"request_method\":\"GET\"}', 'POST',
        '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:38804', '未知'),
       (32, '2022-12-08 15:43:39', '2022-12-08 15:43:39', '资源权限', '新增或修改',
        'gin-blog/api/v1.(*Resource).SaveOrUpdate-fm', '/api/resource', '新增或修改资源权限',
        '{\"parent_id\":102,\"name\":\"新增/编辑页面\",\"url\":\"/page\",\"request_method\":\"POST\"}', 'POST',
        '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:38804', '未知'),
       (33, '2022-12-08 15:43:51', '2022-12-08 15:43:51', '资源权限', '新增或修改',
        'gin-blog/api/v1.(*Resource).SaveOrUpdate-fm', '/api/resource', '新增或修改资源权限',
        '{\"parent_id\":102,\"name\":\"删除页面\",\"url\":\"/page\",\"request_method\":\"DELETE\"}', 'POST',
        '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:38804', '未知'),
       (34, '2022-12-08 15:44:04', '2022-12-08 15:44:04', '角色', '新增或修改',
        'gin-blog/api/v1.(*Role).SaveOrUpdate-fm', '/api/role', '新增或修改角色',
        '{\"id\":1,\"name\":\"管理员\",\"label\":\"admin\",\"created_at\":\"2022-10-20T21:24:28+08:00\",\"is_disable\":0,\"resource_ids\":[3,43,44,45,46,47,48,6,59,60,61,7,38,39,40,41,42,8,65,66,67,68,9,62,63,64,10,23,34,35,36,37,79,80,81,85,49,51,52,53,54,50,55,56,57,58,69,70,71,72,91,92,93,78,82,84,86,98,95,11,99,100,101,74,102,103,104,105],\"menu_ids\":[2,3,4,5,6,7,8,9,16,17,23,24,25,26,27,28,29,30,31,32,33,36,37,38,34,10,39]}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:38804', '未知'),
       (35, '2022-12-08 15:44:09', '2022-12-08 15:44:09', '角色', '新增或修改',
        'gin-blog/api/v1.(*Role).SaveOrUpdate-fm', '/api/role', '新增或修改角色',
        '{\"id\":2,\"name\":\"用户\",\"label\":\"user\",\"created_at\":\"2022-10-20T21:25:07+08:00\",\"is_disable\":0,\"resource_ids\":[43,44,59,38,42,65,68,62,35,36,51,54,55,58,70,78,82,79,80,86,92,95,41,103],\"menu_ids\":[1,2,6,8,9,10,3,25,26,16,17,23,24,4,27,28,29,5,30,32,31,33,34,36,37,38,39]}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:38804', '未知'),
       (36, '2022-12-08 15:44:14', '2022-12-08 15:44:14', '角色', '新增或修改',
        'gin-blog/api/v1.(*Role).SaveOrUpdate-fm', '/api/role', '新增或修改角色',
        '{\"id\":3,\"name\":\"测试\",\"label\":\"test\",\"created_at\":\"2022-10-20T21:25:09+08:00\",\"is_disable\":0,\"resource_ids\":[43,44,59,38,41,42,65,68,62,35,36,79,80,51,54,55,58,70,78,82,92,95,86,103],\"menu_ids\":[1,2,3,4,33,6,34,8,9,10,25,26,16,17,23,24,5,29,30,32,31,27,28,36,37,38,39]}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:38804', '未知'),
       (37, '2022-12-16 11:51:54', '2022-12-16 11:51:54', '文章', '新增或修改',
        'gin-blog/api/v1.(*Article).SaveOrUpdate-fm', '/api/article', '新增或修改文章',
        '{\"id\":1,\"title\":\"测试文章\",\"desc\":\"\",\"content\":\"## 博客介绍\\n\\n<p  align=center>\\n<a  href=\\\"http://www.hahacode.cn\\\">\\n<img  src=\\\"https://img-blog.csdnimg.cn/fe2f1034cf7c4bd795552d47373ee405.jpeg\\\"  width=\\\"200\\\"  hight=\\\"200\\\"  alt=\\\"阵、雨的个人博客\\\"  style=\\\"border-radius: 50%\\\">\\n</a>\\n</p>\\n\\n因最近忙于学业，本项目开发周期不是很长且断断续续，可能会存在不少 BUG，但是我会逐步修复的。\\n\\n您的 star 是我坚持的动力，感谢大家的支持，欢迎提交 pr 共同改进项目。\\n\\n\\nGithub地址：[https://github.com/szluyu99/gin-vue-blog](https://github.com/szluyu99/gin-vue-blog)\\n\\nGitee地址：[https://github.com/szluyu99/gin-vue-blog](https://github.com/szluyu99/gin-vue-blog)\\n\\n## 在线地址\\n\\n博客前台链接：[www.hahacode.cn](http://www.hahacode.cn)\\n\\n博客后台链接：[www.hahacode.cn/blog-admin](http://www.hahacode.cn/blog-admin)\\n\\n测试账号：test@qq.com，密码：11111，前后台都可用这个账号登录\\n\\n在线接口文档地址：[https://is68368smh.apifox.cn/](https://is68368smh.apifox.cn/)\\n\\n> 本项目在线接口文档由 Apifox 生成，由于项目架构调整，有些接口待完善和修改\\n\\n## 目录结构\\n\\n代码仓库目录：\\n\\n```bash\\ngin-vue-blog\\n├── gin-blog-admin      -- 博客后台前端\\n├── gin-blog-front      -- 博客前台前端\\n├── gin-blog-server     -- 博客后端\\n```\\n\\n需要先运行后端服务，再运行前端项目，因为很多前端配置由后端动态加载（如菜单等）。\\n\\n> 项目运行参考：[快速开始](#快速开始)\\n\\n后端目录：\\n\\n```bash\\ngin-blog-server\\n├── api             -- API\\n│   ├── front       -- 前台接口\\n│   └── v1          -- 后台接口\\n├── dao             -- 数据库操作模块\\n├── service         -- 服务模块\\n├── model           -- 数据模型\\n│   ├── req             -- 请求 VO 模型\\n│   ├── resp            -- 响应 VO 模型\\n│   ├── dto             -- 内部传输 DTO 模型\\n│   └── ...             -- 数据库模型对象 PO 模型\\n├── routes          -- 路由模块\\n│   └── middleware      -- 路由中间件\\n├── utils           -- 工具模块\\n│   ├── r               -- 响应封装\\n│   ├── upload          -- 文件上传\\n│   └── ...\\n├── routes          -- 路由模块\\n├── config          -- 配置文件\\n├── test            -- 测试模块\\n├── log             -- 日志文件\\n├── Dockerfile\\n└── main.go\\n```\\n\\n## 项目介绍\\n\\n前台：\\n- 前台界面设计参考 Hexo 的 Butterfly 设计，美观简洁\\n- 实现点赞，统计用户等功能 (Redis)\\n- 评论 + 回复评论功能\\n- 留言采用弹幕墙，效果炫酷\\n- 文章详情页有文章目录、推荐文章等功能，优化用户体验\\n\\n后台：\\n- 鉴权使用 JWT\\n- 权限管理使用 CASBIN，实现基于 RBAC 的权限管理\\n- 支持动态权限修改，前端菜单由后端生成\\n- 文章编辑使用 Markdown 编辑器\\n- 常规后台功能齐全：侧边栏、面包屑、标签栏等\\n\\n其他：\\n- 前后端分离部署，前端使用 Nginx，后端使用 Docker\\n- 代码整洁层次清晰，利于开发者学习\\n\\n## 技术介绍\\n\\n> 这里只写一些主流的通用技术，详细第三方库: 前端参考 `package.json` 文件，后端参考 `go.mod` 文件\\n\\n前台前端：使用 pnpm 包管理工具\\n- 基于 TypeScript\\n- Vue3\\n- Unocss: 原子化 CSS\\n- Pinia\\n- Vue Router \\n- Axios \\n- Naive UI\\n- Vuetify\\n- ...\\n\\n后台前端：使用 pnpm 包管理工具\\n- 基于 JavaSciprt \\n- pnpm: 包管理工具\\n- Vue3\\n- Unocss: 原子化 CSS\\n- Pinia \\n- Vue Router \\n- Axios \\n- Naive UI\\n- ...\\n\\n后端技术栈：\\n- 基于 Golang\\n- Docker\\n- Gin\\n- GORM\\n- Viper: 使用 TOML 作为配置文件\\n- Zap\\n- MySQL\\n- Redis\\n- Nginx: 部署静态资源 + 反向代理\\n- ...\\n\\n其他：\\n- 腾讯云人机验证\\n- 七牛云对象存储\\n- ...\\n\\n## 运行环境\\n\\n服务器：腾讯云 2核 4G Ubuntu 22.04 LTS\\n\\n对象存储：七牛云\\n\\n## 开发环境\\n\\n| 开发工具                      | 说明                    |\\n| ----------------------------- | ----------------------- |\\n| Vscode                        | Golang 后端 +  Vue 前端 |\\n| Navicat                       | MySQL 远程连接工具      |\\n| Another Redis Desktop Manager | Redis 远程连接工具      |\\n| MobaXterm                     | Linux 远程工具          |\\n| Apifox                        | 接口调试 + 文档生成     |\\n\\n\\n| 开发环境 | 版本 |\\n| -------- | ---- |\\n| Golang   | 1.19 |\\n| MySQL    | 8.x  |\\n| Redis    | 7.x  |\\n\\n## 快速开始\\n\\n### 本地运行\\n\\n> 自行安装 Golang、Node、MySQL、Redis 环境\\n\\n拉取项目到本地：\\n\\n```bash\\ngit clone https://github.com/szluyu99/gin-vue-blog.git\\n```\\n\\n后端项目运行：\\n\\n```bash\\n# 1、进入后端项目根目录 \\ncd gin-blog-server\\n\\n# 2、修改项目运行的配置文件，默认加载 config/config.toml \\n\\n# 3、MySQL 导入 ginblog.sql\\n\\n# 4、启动 Redis \\n\\n# 5、运行项目\\ngo mod tidy\\ngo run main.go\\n```\\n\\n前端项目运行： 本项目使用 pnpm 进行包管理，建议全局安装 pnpm\\n\\n```bash\\nnpm install -g pnpm\\n```\\n\\n前台前端：\\n\\n```bash\\n# 1、进入前台前端项目根目录\\ncd gin-blog-front\\n\\n# 2、安装依赖\\npnpm install\\n\\n# 3、运行项目\\npnpm run dev\\n```\\n\\n后台前端：\\n\\n```bash\\n# 1、进入后台前端项目根目录\\ncd gin-blog-admin\\n\\n# 2、安装依赖\\npnpm install\\n\\n# 3、运行项目\\npnpm run dev\\n```\\n\\n### 项目部署\\n\\n目前暂时不推荐将本博客部署上生产环境，因为还有太多功能未完善。\\n\\n但是相信本项目对于 Golang 学习者绝对是个合适的项目！\\n\\n等功能开发的差不多了，再专门针对部署写一篇文章。\\n\\n---\\n\\n这里简单介绍一下，有基础的同学可以自行折腾。\\n\\n本项目前端采用 Nginx 部署静态资源，后端使用 Docker 部署。\\n\\n后端 Docker 部署参考 `Dockerfile`，Docker 运行对应的配置文件是 `config/config.docker.toml`\\n\\nDocker 打包成镜像指令：\\n\\n```bash\\ndocker build -t ginblog .\\n```\\n\\n> 以上只是简单说明，等功能大致完成，会从 `安装 Docker`、`Docker 安装运行环境`、`Docker 部署项目` 等多个角度写几篇关于部署的教程。\\n\\n## 项目总结\\n\\n这个项目不管是前端，还是后端，都是花了比较大心血去架构的，并且从技术选型上，都是选择了目前最火 + 最新的技术栈。当然，这也是个人的学习之作，很多知识点都是边学边开发的（例如 Casbin），这个过程中也参考了很多优秀的开源项目，感谢大家的开源让程序员的世界更加美好，这也是开源本项目的目的之一。本项目中仍有很多不足，后续会继续更新。\\n\\n最后，项目整体代码风格很优秀，注释完善，适合 Golang 后端开发者、前端开发者学习。\\n\\n## 后续计划\\n\\n高优先级: \\n\\n- 完善图片上传功能, 目前文件上传还没怎么处理\\n- 后台首页重新设计（目前没放什么内容）\\n- 重写单元测试，目前的单元测试是早期版本，项目架构更改后，无法跑通\\n- 前台首页搜索文章（ElasticSearch 搜索）\\n- 博客文章导入导出 (.md 文件)\\n- 权限管理中菜单编辑时选择图标（现在只能输入图标字符串）\\n- 后端日志切割\\n- 后台修改背景图片，博客配置等\\n- 相册\\n\\n后续有空安排上：\\n- 适配移动端\\n- 黑夜模式\\n- 前台收缩侧边信息功能\\n- 说说\\n- 音乐播放器\\n- 鼠标左击特效\\n- 看板娘\\n- 文章目录锚点跟随\\n- 第三方登录\\n- 评论时支持选择表情，参考 Valine\\n- 若干细节需要完善...\\n\",\"img\":\"https://static.talkxj.com/articles/771941739cbc70fbe40e10cf441e02e5.jpg\",\"category_name\":\"后端\",\"tag_names\":[\"Golang\",\"Vue\"],\"type\":1,\"original_url\":\"\",\"is_top\":0,\"status\":1}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:35424', '未知'),
       (38, '2022-12-16 11:52:39', '2022-12-16 11:52:39', '文章', '新增或修改',
        'gin-blog/api/v1.(*Article).SaveOrUpdate-fm', '/api/article', '新增或修改文章',
        '{\"id\":1,\"title\":\"测试文章\",\"desc\":\"\",\"content\":\"## 博客介绍\\n\\n<p  align=center>\\n<a  href=\\\"http://www.hahacode.cn\\\">\\n<img  src=\\\"https://img-blog.csdnimg.cn/fe2f1034cf7c4bd795552d47373ee405.jpeg\\\"  width=\\\"200\\\"  hight=\\\"200\\\"  alt=\\\"阵、雨的个人博客\\\"  style=\\\"border-radius: 50%\\\">\\n</a>\\n</p>\\n\\n因最近忙于学业，本项目开发周期不是很长且断断续续，可能会存在不少 BUG，但是我会逐步修复的。\\n\\n您的 star 是我坚持的动力，感谢大家的支持，欢迎提交 pr 共同改进项目。\\n\\n\\nGithub地址：[https://github.com/szluyu99/gin-vue-blog](https://github.com/szluyu99/gin-vue-blog)\\n\\nGitee地址：[https://github.com/szluyu99/gin-vue-blog](https://github.com/szluyu99/gin-vue-blog)\\n\\n## 在线地址\\n\\n博客前台链接：[www.hahacode.cn](http://www.hahacode.cn)\\n\\n博客后台链接：[www.hahacode.cn/blog-admin](http://www.hahacode.cn/blog-admin)\\n\\n测试账号：test@qq.com，密码：11111，前后台都可用这个账号登录\\n\\n在线接口文档地址：[https://is68368smh.apifox.cn/](https://is68368smh.apifox.cn/)\\n\\n> 本项目在线接口文档由 Apifox 生成，由于项目架构调整，有些接口待完善和修改\\n\\n## 目录结构\\n\\n代码仓库目录：\\n\\n```bash\\ngin-vue-blog\\n├── gin-blog-admin      -- 博客后台前端\\n├── gin-blog-front      -- 博客前台前端\\n├── gin-blog-server     -- 博客后端\\n```\\n\\n需要先运行后端服务，再运行前端项目，因为很多前端配置由后端动态加载（如菜单等）。\\n\\n> 项目运行参考：[快速开始](#快速开始)\\n\\n后端目录：\\n\\n```bash\\ngin-blog-server\\n├── api             -- API\\n│   ├── front       -- 前台接口\\n│   └── v1          -- 后台接口\\n├── dao             -- 数据库操作模块\\n├── service         -- 服务模块\\n├── model           -- 数据模型\\n│   ├── req             -- 请求 VO 模型\\n│   ├── resp            -- 响应 VO 模型\\n│   ├── dto             -- 内部传输 DTO 模型\\n│   └── ...             -- 数据库模型对象 PO 模型\\n├── routes          -- 路由模块\\n│   └── middleware      -- 路由中间件\\n├── utils           -- 工具模块\\n│   ├── r               -- 响应封装\\n│   ├── upload          -- 文件上传\\n│   └── ...\\n├── routes          -- 路由模块\\n├── config          -- 配置文件\\n├── test            -- 测试模块\\n├── log             -- 日志文件\\n├── Dockerfile\\n└── main.go\\n```\\n\\n## 项目介绍\\n\\n前台：\\n- 前台界面设计参考 Hexo 的 Butterfly 设计，美观简洁\\n- 实现点赞，统计用户等功能 (Redis)\\n- 评论 + 回复评论功能\\n- 留言采用弹幕墙，效果炫酷\\n- 文章详情页有文章目录、推荐文章等功能，优化用户体验\\n\\n后台：\\n- 鉴权使用 JWT\\n- 权限管理使用 CASBIN，实现基于 RBAC 的权限管理\\n- 支持动态权限修改，前端菜单由后端生成\\n- 文章编辑使用 Markdown 编辑器\\n- 常规后台功能齐全：侧边栏、面包屑、标签栏等\\n\\n其他：\\n- 前后端分离部署，前端使用 Nginx，后端使用 Docker\\n- 代码整洁层次清晰，利于开发者学习\\n\\n## 技术介绍\\n\\n> 这里只写一些主流的通用技术，详细第三方库: 前端参考 `package.json` 文件，后端参考 `go.mod` 文件\\n\\n前台前端：使用 pnpm 包管理工具\\n- 基于 TypeScript\\n- Vue3\\n- Unocss: 原子化 CSS\\n- Pinia\\n- Vue Router \\n- Axios \\n- Naive UI\\n- Vuetify\\n- ...\\n\\n后台前端：使用 pnpm 包管理工具\\n- 基于 JavaSciprt \\n- pnpm: 包管理工具\\n- Vue3\\n- Unocss: 原子化 CSS\\n- Pinia \\n- Vue Router \\n- Axios \\n- Naive UI\\n- ...\\n\\n后端技术栈：\\n- 基于 Golang\\n- Docker\\n- Gin\\n- GORM\\n- Viper: 使用 TOML 作为配置文件\\n- Zap\\n- MySQL\\n- Redis\\n- Nginx: 部署静态资源 + 反向代理\\n- ...\\n\\n其他：\\n- 腾讯云人机验证\\n- 七牛云对象存储\\n- ...\\n\\n## 运行环境\\n\\n服务器：腾讯云 2核 4G Ubuntu 22.04 LTS\\n\\n对象存储：七牛云\\n\\n## 开发环境\\n\\n| 开发工具                      | 说明                    |\\n| ----------------------------- | ----------------------- |\\n| Vscode                        | Golang 后端 +  Vue 前端 |\\n| Navicat                       | MySQL 远程连接工具      |\\n| Another Redis Desktop Manager | Redis 远程连接工具      |\\n| MobaXterm                     | Linux 远程工具          |\\n| Apifox                        | 接口调试 + 文档生成     |\\n\\n\\n| 开发环境 | 版本 |\\n| -------- | ---- |\\n| Golang   | 1.19 |\\n| MySQL    | 8.x  |\\n| Redis    | 7.x  |\\n\\n## 快速开始\\n\\n### 本地运行\\n\\n> 自行安装 Golang、Node、MySQL、Redis 环境\\n\\n拉取项目到本地：\\n\\n```bash\\ngit clone https://github.com/szluyu99/gin-vue-blog.git\\n```\\n\\n后端项目运行：\\n\\n```bash\\n# 1、进入后端项目根目录 \\ncd gin-blog-server\\n\\n# 2、修改项目运行的配置文件，默认加载 config/config.toml \\n\\n# 3、MySQL 导入 ginblog.sql\\n\\n# 4、启动 Redis \\n\\n# 5、运行项目\\ngo mod tidy\\ngo run main.go\\n```\\n\\n前端项目运行： 本项目使用 pnpm 进行包管理，建议全局安装 pnpm\\n\\n```bash\\nnpm install -g pnpm\\n```\\n\\n前台前端：\\n\\n```bash\\n# 1、进入前台前端项目根目录\\ncd gin-blog-front\\n\\n# 2、安装依赖\\npnpm install\\n\\n# 3、运行项目\\npnpm run dev\\n```\\n\\n后台前端：\\n\\n```bash\\n# 1、进入后台前端项目根目录\\ncd gin-blog-admin\\n\\n# 2、安装依赖\\npnpm install\\n\\n# 3、运行项目\\npnpm run dev\\n```\\n\\n### 项目部署\\n\\n目前暂时不推荐将本博客部署上生产环境，因为还有太多功能未完善。\\n\\n但是相信本项目对于 Golang 学习者绝对是个合适的项目！\\n\\n等功能开发的差不多了，再专门针对部署写一篇文章。\\n\\n---\\n\\n这里简单介绍一下，有基础的同学可以自行折腾。\\n\\n本项目前端采用 Nginx 部署静态资源，后端使用 Docker 部署。\\n\\n后端 Docker 部署参考 `Dockerfile`，Docker 运行对应的配置文件是 `config/config.docker.toml`\\n\\nDocker 打包成镜像指令：\\n\\n```bash\\ndocker build -t ginblog .\\n```\\n\\n> 以上只是简单说明，等功能大致完成，会从 `安装 Docker`、`Docker 安装运行环境`、`Docker 部署项目` 等多个角度写几篇关于部署的教程。\\n\\n## 项目总结\\n\\n这个项目不管是前端，还是后端，都是花了比较大心血去架构的，并且从技术选型上，都是选择了目前最火 + 最新的技术栈。当然，这也是个人的学习之作，很多知识点都是边学边开发的（例如 Casbin），这个过程中也参考了很多优秀的开源项目，感谢大家的开源让程序员的世界更加美好，这也是开源本项目的目的之一。本项目中仍有很多不足，后续会继续更新。\\n\\n最后，项目整体代码风格很优秀，注释完善，适合 Golang 后端开发者、前端开发者学习。\\n\\n## 后续计划\\n\\n高优先级: \\n\\n- 完善图片上传功能, 目前文件上传还没怎么处理\\n- 后台首页重新设计（目前没放什么内容）\\n- 重写单元测试，目前的单元测试是早期版本，项目架构更改后，无法跑通\\n- 前台首页搜索文章（ElasticSearch 搜索）\\n- 博客文章导入导出 (.md 文件)\\n- 权限管理中菜单编辑时选择图标（现在只能输入图标字符串）\\n- 后端日志切割\\n- 后台修改背景图片，博客配置等\\n- 相册\\n\\n后续有空安排上：\\n- 适配移动端\\n- 黑夜模式\\n- 前台收缩侧边信息功能\\n- 说说\\n- 音乐播放器\\n- 鼠标左击特效\\n- 看板娘\\n- 文章目录锚点跟随\\n- 第三方登录\\n- 评论时支持选择表情，参考 Valine\\n- 若干细节需要完善...\\n\\n## 更新日志\\n\\n描述规范定义，有以下几种行为 ACTION:\\n- `FIX`: 修复\\n- `REFINE`: 优化\\n- `COMPLETE`: 完善\\n- `ADD`: 新增\\n\\n---\\n\\n2022-12-15:\\n\\n博客后台：\\n- 优化 菜单栏和标签栏，点击标签自动展开对应菜单，点击菜单自动滚动到显示对应标签 ⭐\\n- 优化 使用响应式语法糖重构代码\\n- 优化 代码结构 + 注释\\n\\n---\\n\\n2022-12-14:\\n\\n博客前台：\\n- 优化 代码，去除 n-card 组件，使用自定义 css 实现卡片视图\\n- 优化 对滚动的监听操作，添加节流函数，提升性能 ⭐\\n- 优化 文章目录，根据当前滚动条自动高亮锚点 ⭐⭐\\n- 新增 vite 打包优化相关插件\\n\\n---\\n\\n2022-12-13:\\n\\n项目部署：\\n- 新增 Nginx 配置 https 访问域名 (http 自动跳转到 https) ⭐\\n- 新增 七牛云添加加速域名访问图片资源\\n\\n博客后端：\\n- 新增 文章搜索接口（数据库模糊查询）\\n\\n博客前台：\\n- 新增 导航栏的文章搜索\\n\\n---\\n\\n2022-12-12:\\n\\n博客前台：\\n- 新增 适配移动端 ⭐⭐\\n- 优化 删除 Vuetify 相关组件及依赖 (css 样式存在冲突)，统一使用 naive-ui\\n- 优化 使用 `$ref` 语法糖功能重构页面\\n\\n---\\n\\n2022-12-09:\\n\\n博客前台：\\n- 完善 个人中心的头像上传（注意头像上传需要 Token）\\n- 优化 重构通用页面的代码 ⭐\\n\\n---\\n\\n2022-12-08:\\n\\n博客后端：\\n- 新增 页面模块 的接口 ⭐\\n- 修复 单元测试无法初始化全局变量（flag 包冲突）问题\\n\\n博客后台：\\n- 新增 pinia 数据持久化，防止刷新丢失数据 ⭐\\n- 新增 页面管理页面，动态配置前台显示的封面 ⭐\\n\\n博客前台：\\n- 新增 页面根据 `label` 从后端数据中加载封面 ⭐\\n- 优化 尝试性使用 `$ref` 语法糖功能\\n\\n---\\n\\n2022-12-07:\\n\\n博客后台：\\n- 修复 博客后台，动态加载路由模块导致的热加载失效问题 ⭐⭐\\n- 完善 文件上传，抽取出单独的组件 ⭐⭐\\n- 新增 个人信息页面 ⭐\\n- 优化 发布文章/查看文章 时的文章标签选择、分类选择\\n- 修复 发布文章/查看文章 页面数据加载错误\\n\",\"img\":\"https://static.talkxj.com/articles/771941739cbc70fbe40e10cf441e02e5.jpg\",\"category_name\":\"后端\",\"tag_names\":[\"Golang\",\"Vue\"],\"type\":1,\"original_url\":\"\",\"is_top\":0,\"status\":1}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:35424', '未知'),
       (39, '2022-12-16 11:53:37', '2022-12-16 11:53:37', '文章', '新增或修改',
        'gin-blog/api/v1.(*Article).SaveOrUpdate-fm', '/api/article', '新增或修改文章',
        '{\"id\":1,\"title\":\"测试文章\",\"desc\":\"\",\"content\":\"## 博客介绍\\n\\n<p  align=center>\\n<a  href=\\\"http://www.hahacode.cn\\\">\\n<img  src=\\\"https://img-blog.csdnimg.cn/fe2f1034cf7c4bd795552d47373ee405.jpeg\\\"  width=\\\"200\\\"  hight=\\\"200\\\"  alt=\\\"阵、雨的个人博客\\\"  style=\\\"border-radius: 50%\\\">\\n</a>\\n</p>\\n\\n因最近忙于学业，本项目开发周期不是很长且断断续续，可能会存在不少 BUG，但是我会逐步修复的。\\n\\n您的 Star 是我坚持的动力，感谢大家的支持，欢迎提交 Pr 共同改进项目。\\n\\nGithub 地址：[https://github.com/szluyu99/gin-vue-blog](https://github.com/szluyu99/gin-vue-blog)\\n\\nGitee 地址：[https://gitee.com/szluyu99/gin-vue-blog](https://gitee.com/szluyu99/gin-vue-blog)\\n\\n## 在线预览\\n\\n博客前台链接：[hahacode.cn](https://www.hahacode.cn)\\n\\n博客后台链接：[hahacode.cn/blog-admin](https://www.hahacode.cn/blog-admin)\\n\\n> 博客已备案通过，且配置 SSL，可通过 https 访问\\n\\n测试账号：test@qq.com，密码：11111，前后台都可用这个账号登录\\n\\n在线接口文档地址：[doc.hahacode.cn](http://doc.hahacode.cn/)\\n\\n> 本项目在线接口文档由 Apifox 生成，由于项目架构调整，有些接口待完善和修改\\n>\\n> 并且由于一开始不会用 Apifox，接口文档生成的信息不全（如返回响应、响应示例），抽空完善一下\\n\\n## 目录结构\\n\\n代码仓库目录：\\n\\n```bash\\ngin-vue-blog\\n├── gin-blog-admin      -- 博客后台前端\\n├── gin-blog-front      -- 博客前台前端\\n├── gin-blog-server     -- 博客后端\\n```\\n\\n> 项目运行参考：[快速开始](#快速开始)\\n\\n后端目录：\\n\\n```bash\\ngin-blog-server\\n├── api             -- API\\n│   ├── front       -- 前台接口\\n│   └── v1          -- 后台接口\\n├── dao             -- 数据库操作模块\\n├── service         -- 服务模块\\n├── model           -- 数据模型\\n│   ├── req             -- 请求 VO 模型\\n│   ├── resp            -- 响应 VO 模型\\n│   ├── dto             -- 内部传输 DTO 模型\\n│   └── ...             -- 数据库模型对象 PO 模型\\n├── routes          -- 路由模块\\n│   └── middleware      -- 路由中间件\\n├── utils           -- 工具模块\\n│   ├── r               -- 响应封装\\n│   ├── upload          -- 文件上传\\n│   └── ...\\n├── routes          -- 路由模块\\n├── config          -- 配置文件\\n├── test            -- 测试模块\\n├── log             -- 日志文件\\n├── Dockerfile\\n└── main.go\\n```\\n\\n前端目录：自行参考代码文件\\n\\n## 项目介绍\\n\\n市面上有太多优秀的前后台框架，本项目也是参考了很多开源项目，但是大多项目过于重量级（并非坏处），如果从学习的角度来看对初学者并不是很友好。本项目在以**博客**这个业务为主的前提下，提供一个完整的全栈项目代码（前台前端 + 后台前端 + 后端），技术点基本都是最新 + 最火的技术，代码轻量级，注释完善，适合学习。\\n\\n前台：\\n- 前台界面设计参考 Hexo 的 Butterfly 设计，美观简洁\\n- 响应式布局，适配了移动端\\n- 实现点赞，统计用户等功能 (Redis)\\n- 评论 + 回复评论功能\\n- 留言采用弹幕墙，效果炫酷\\n- 文章详情页有文章目录、推荐文章等功能，优化用户体验\\n\\n后台：\\n- 鉴权使用 JWT\\n- 权限管理使用 CASBIN，实现基于 RBAC 的权限管理\\n- 支持动态权限修改，前端菜单由后端生成（动态路由）\\n- 文章编辑使用 Markdown 编辑器\\n- 常规后台功能齐全：侧边栏、面包屑、标签栏等\\n- 实现记录操作日志功能（GET 不记录）\\n- 实现监听在线用户、强制下线功能\\n- 文件上传支持七牛云、本地（后续计划支持更多）\\n- 对 CRUD 操作封装了通用 Hook\\n\\n其他：\\n- 采用 Restful 风格的 API\\n- 前后端分离部署，前端使用 Nginx，后端使用 Docker\\n- 代码整洁层次清晰，利于开发者学习\\n- 技术点新颖，代码轻量级，适度封装\\n\\n## 技术介绍\\n\\n> 这里只写一些主流的通用技术，详细第三方库：前端参考 `package.json` 文件，后端参考 `go.mod` 文件\\n\\n前台前端：使用 pnpm 包管理工具\\n- 基于 TypeScript\\n- Vue3\\n- VueUse: 服务于 Vue Composition API 的工具集\\n- Unocss: 原子化 CSS\\n- Pinia\\n- Vue Router \\n- Axios \\n- Naive UI\\n- ...\\n\\n后台前端：使用 pnpm 包管理工具\\n- 基于 JavaSciprt \\n- Vue3\\n- VueUse: 服务于 Vue Composition API 的工具集\\n- Unocss: 原子化 CSS\\n- Pinia \\n- Vue Router \\n- Axios \\n- Naive UI\\n- ...\\n\\n后端技术栈：\\n- 基于 Golang\\n- Docker\\n- Gin\\n- GORM\\n- Viper: 使用 TOML 作为配置文件\\n- Casbin\\n- Zap\\n- MySQL\\n- Redis\\n- Nginx: 部署静态资源 + 反向代理\\n- ...\\n\\n其他：\\n- 腾讯云人机验证\\n- 七牛云对象存储\\n- ...\\n\\n## 运行环境\\n\\n服务器：腾讯云 2核 4G Ubuntu 22.04 LTS\\n\\n对象存储：七牛云\\n\\n## 开发环境\\n\\n| 开发工具                      | 说明                    |\\n| ----------------------------- | ----------------------- |\\n| Vscode                        | Golang 后端 +  Vue 前端 |\\n| Navicat                       | MySQL 远程连接工具      |\\n| Another Redis Desktop Manager | Redis 远程连接工具      |\\n| MobaXterm                     | Linux 远程工具          |\\n| Apifox                        | 接口调试 + 文档生成     |\\n\\n| 开发环境 | 版本 |\\n| -------- | ---- |\\n| Golang   | 1.19 |\\n| MySQL    | 8.x  |\\n| Redis    | 7.x  |\\n\\n\\n### Vscode 插件\\n\\n如果使用 Vscode 开发，推荐安装一下以下插件。\\n\\n> 前后端相关插件属于**开发必须插件**，还有很多提升开发效果的插件后面推荐一下\\n\\n前端开发插件：\\n\\n| 插件 | 作用 |\\n| -------- | ---- |\\n| Volar   | Vue 官方插件 |\\n| UnoCSS | Unocss 官方插件 |\\n| Tailwind CSS IntelliSense | Tailwind 官方插件 |\\n| Iconify IntelliSense | Iconify 提示插件 |\\n\\n后端开发插件：\\n\\n| 插件 | 作用 |\\n| -------- | ---- |\\n| Go | Golang 官方插件 |\\n\\n\\n通用插件：（非开发必须，个人推荐）\\n\\n| 名称 | 作用 |\\n| -------- | ---- |\\n| Better Comments   | 优化代码注释显示效果 |\\n| TODO Highlight | 高亮 TODO |\\n| Highlight Matching Tag | 高亮匹配的标签 | \\n\\n\\n## 快速开始\\n\\n### 本地运行\\n\\n> 目前需要自行安装 Golang、Node、MySQL、Redis 环境\\n>\\n> TODO: 完全基于 Docker 的运行教程（Docker 实在太好用了！）\\n\\n\\n需要先运行后端服务，再运行前端项目，因为很多前端配置由后端动态加载（如菜单等）。\\n\\n拉取项目到本地：\\n\\n```bash\\ngit clone https://github.com/szluyu99/gin-vue-blog.git\\n```\\n\\n后端项目运行：\\n\\n```bash\\n# 1、进入后端项目根目录 \\ncd gin-blog-server\\n\\n# 2、修改项目运行的配置文件，默认加载位于 config/config.toml \\n\\n# 3、MySQL 导入 ginblog.sql\\n\\n# 4、启动 Redis \\n\\n# 5、运行项目\\ngo mod tidy\\ngo run main.go\\n```\\n\\n数据库中的默认用户：\\n- 管理员 admin 123456\\n- 普通用户 user 123456\\n- 测试用户 test 123456\\n\\n前端项目运行： 本项目使用 pnpm 进行包管理，建议全局安装 pnpm\\n\\n```bash\\nnpm install -g pnpm\\n```\\n\\n前台前端：\\n\\n```bash\\n# 1、进入前台前端项目根目录\\ncd gin-blog-front\\n\\n# 2、安装依赖\\npnpm install\\n\\n# 3、运行项目\\npnpm run dev\\n```\\n\\n后台前端：\\n\\n```bash\\n# 1、进入后台前端项目根目录\\ncd gin-blog-admin\\n\\n# 2、安装依赖\\npnpm install\\n\\n# 3、运行项目\\npnpm run dev\\n```\\n\\n\\n### 项目部署\\n\\n**目前暂时不推荐将本博客部署上生产环境，因为还有很多功能未完善**。\\n\\n但是相信本项目对于 Golang 学习者绝对是个合适的项目！\\n\\n等功能开发的差不多了，再专门针对部署写一篇文章。\\n\\n---\\n\\n这里简单介绍一下，有基础的同学可以自行折腾。\\n\\n本项目前端采用 Nginx 部署静态资源，后端使用 Docker 部署。\\n\\n后端 Docker 部署参考 `Dockerfile`，Docker 运行对应的配置文件是 `config/config.docker.toml`\\n\\nDocker 打包成镜像指令：\\n\\n```bash\\ndocker build -t ginblog .\\n```\\n\\n> 以上只是简单说明，等功能全部完成，会从 `安装 Docker`、`Docker 安装运行环境`、`Docker 部署项目` 等多个角度写几篇关于部署的教程。\\n\\n## 项目总结\\n\\n这个项目不管是前端，还是后端，都是花了比较大心血去架构的，并且从技术选型上，都是选择了目前最火 + 最新的技术栈。当然，这也是个人的学习之作，很多知识点都是边学边开发的（例如 Casbin），这个过程中也参考了很多优秀的开源项目，感谢大家的开源让程序员的世界更加美好，这也是开源本项目的目的之一。本项目中仍有很多不足，后续会继续更新。\\n\\n最后，项目整体代码风格很优秀，注释完善，适合 Golang 后端开发者、前端开发者学习。\\n\\n## 鸣谢项目\\n\\n- [https://butterfly.js.org/](https://butterfly.js.org/)\\n- [https://github.com/flipped-aurora/gin-vue-admin](https://github.com/flipped-aurora/gin-vue-admin)\\n- [https://github.com/qifengzhang007/GinSkeleton](https://github.com/qifengzhang007/GinSkeleton)\\n- [https://github.com/X1192176811/blog](https://github.com/X1192176811/blog)\\n- [https://github.com/zclzone/vue-naive-admin](https://github.com/zclzone/vue-naive-admin)\\n- [https://github.com/antfu/vitesse](https://github.com/antfu/vitesse)\\n- ...\\n\\n> 需要感谢的绝不止以上这些开源项目，但是一时难以全部列出，后面会慢慢补上。\\n\\n## 后续计划\\n\\n高优先级: \\n\\n- ~~完善图片上传功能, 目前文件上传还没怎么处理~~\\n- 后台首页重新设计（目前没放什么内容）\\n- ~~前台首页搜索文章（目前使用数据库模糊搜索）~~\\n- 博客文章导入导出 (.md 文件)\\n- 权限管理中菜单编辑时选择图标（现在只能输入图标字符串）\\n- 后端日志切割\\n- ~~后台修改背景图片，博客配置等~~ \\n- 后端的 IP 地址检测 BUG 待修复\\n- ~~博客前台适配移动端~~ \\n- ~~文章详情, 目录锚点跟随~~ \\n\\n后续有空安排上：\\n- 黑夜模式\\n- 前台收缩侧边信息功能\\n- 说说\\n- 相册\\n- 音乐播放器\\n- 鼠标左击特效\\n- 看板娘\\n- 第三方登录\\n- 评论时支持选择表情，参考 Valine\\n- 一键部署：使用 docker compose 单机一键部署整个项目（前后端 + 环境）\\n- 单独部署：前后端 + 环境\\n- 重写单元测试，目前的单元测试是早期版本，项目架构更改后，无法跑通\\n- 前台首页搜索集成 ElasticSearch\\n\\n其他：\\n- 写一份好的文档\\n- 补全 README.md\\n- 完善 Apifox 生成的接口文档\\n\\n## 更新日志\\n\\n描述规范定义，有以下几种行为 ACTION:\\n- `FIX`: 修复\\n- `REFINE`: 优化\\n- `COMPLETE`: 完善\\n- `ADD`: 新增\\n\\n---\\n\\n2022-12-15:\\n\\n博客后台：\\n- 优化 菜单栏和标签栏，点击标签自动展开对应菜单，点击菜单自动滚动到显示对应标签 ⭐\\n- 优化 使用响应式语法糖重构代码\\n- 优化 代码结构 + 注释\\n\\n---\\n\\n2022-12-14:\\n\\n博客前台：\\n- 优化 代码，去除 n-card 组件，使用自定义 css 实现卡片视图\\n- 优化 对滚动的监听操作，添加节流函数，提升性能 ⭐\\n- 优化 文章目录，根据当前滚动条自动高亮锚点 ⭐⭐\\n- 新增 vite 打包优化相关插件\\n\\n---\\n\\n2022-12-13:\\n\\n项目部署：\\n- 新增 Nginx 配置 https 访问域名 (http 自动跳转到 https) ⭐\\n- 新增 七牛云添加加速域名访问图片资源\\n\\n博客后端：\\n- 新增 文章搜索接口（数据库模糊查询）\\n\\n博客前台：\\n- 新增 导航栏的文章搜索\\n\\n---\\n\\n2022-12-12:\\n\\n博客前台：\\n- 新增 适配移动端 ⭐⭐\\n- 优化 删除 Vuetify 相关组件及依赖 (css 样式存在冲突)，统一使用 naive-ui\\n- 优化 使用 `$ref` 语法糖功能重构页面\\n\\n---\\n\\n2022-12-09:\\n\\n博客前台：\\n- 完善 个人中心的头像上传（注意头像上传需要 Token）\\n- 优化 重构通用页面的代码 ⭐\\n\\n---\\n\\n2022-12-08:\\n\\n博客后端：\\n- 新增 页面模块 的接口 ⭐\\n- 修复 单元测试无法初始化全局变量（flag 包冲突）问题\\n\\n博客后台：\\n- 新增 pinia 数据持久化，防止刷新丢失数据 ⭐\\n- 新增 页面管理页面，动态配置前台显示的封面 ⭐\\n\\n博客前台：\\n- 新增 页面根据 `label` 从后端数据中加载封面 ⭐\\n- 优化 尝试性使用 `$ref` 语法糖功能\\n\\n---\\n\\n2022-12-07:\\n\\n博客后台：\\n- 修复 博客后台，动态加载路由模块导致的热加载失效问题 ⭐⭐\\n- 完善 文件上传，抽取出单独的组件 ⭐⭐\\n- 新增 个人信息页面 ⭐\\n- 优化 发布文章/查看文章 时的文章标签选择、分类选择\\n- 修复 发布文章/查看文章 页面数据加载错误\",\"img\":\"https://static.talkxj.com/articles/771941739cbc70fbe40e10cf441e02e5.jpg\",\"category_name\":\"后端\",\"tag_names\":[\"Golang\",\"Vue\"],\"type\":1,\"original_url\":\"\",\"is_top\":0,\"status\":1}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:35424', '未知'),
       (40, '2022-12-16 11:53:58', '2022-12-16 11:53:58', '资源权限', '新增或修改',
        'gin-blog/api/v1.(*Resource).SaveOrUpdate-fm', '/api/resource', '新增或修改资源权限', '{\"name\":\"文件模块\"}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:35424', '未知'),
       (41, '2022-12-16 11:54:21', '2022-12-16 11:54:21', '资源权限', '新增或修改',
        'gin-blog/api/v1.(*Resource).SaveOrUpdate-fm', '/api/resource', '新增或修改资源权限',
        '{\"parent_id\":106,\"name\":\"文件上传\",\"url\":\"/upload\",\"request_method\":\"POST\"}', 'POST',
        '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:35424', '未知'),
       (42, '2022-12-16 11:54:28', '2022-12-16 11:54:28', '角色', '新增或修改',
        'gin-blog/api/v1.(*Role).SaveOrUpdate-fm', '/api/role', '新增或修改角色',
        '{\"id\":1,\"name\":\"管理员\",\"label\":\"admin\",\"created_at\":\"2022-10-20T21:24:28+08:00\",\"is_disable\":0,\"resource_ids\":[3,43,44,45,46,47,48,6,59,60,61,7,38,39,40,41,42,8,65,66,67,68,9,62,63,64,10,23,34,35,36,37,79,80,81,85,49,51,52,53,54,50,55,56,57,58,69,70,71,72,91,92,93,78,82,84,86,98,95,11,99,100,101,74,102,103,104,105,106,107],\"menu_ids\":[2,3,4,5,6,7,8,9,16,17,23,24,25,26,27,28,29,30,31,32,33,36,37,38,34,10,39]}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:35424', '未知'),
       (43, '2022-12-16 11:56:41', '2022-12-16 11:56:41', '文章', '新增或修改',
        'gin-blog/api/v1.(*Article).SaveOrUpdate-fm', '/api/article', '新增或修改文章',
        '{\"status\":1,\"is_top\":0,\"title\":\"项目运行成功\",\"content\":\"恭喜你，项目已经成功运行起来了！\\n\\n```go\\nfmt.Println(\\\"恭喜！\\\")\\n```\\n\\n```js\\nconsole.log(\\\"恭喜！\\\")\\n```\",\"category_name\":\"前端\",\"tag_names\":[\"Golang\",\"Vue\"],\"type\":1}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:35424', '未知'),
       (44, '2022-12-16 12:36:42', '2022-12-16 12:36:42', '文章', '新增或修改',
        'gin-blog/api/v1.(*Article).SaveOrUpdate-fm', '/api/article', '新增或修改文章',
        '{\"id\":2,\"title\":\"项目运行成功\",\"desc\":\"\",\"content\":\"恭喜你，项目已经成功运行起来了！\\n\\n```go\\nfmt.Println(\\\"恭喜！\\\")\\n```\\n\\n```js\\nconsole.log(\\\"恭喜！\\\")\\n```\\n\\n🆗😋\",\"img\":\"https://static.talkxj.com/articles/1395642324821741569.png\",\"category_name\":\"前端\",\"tag_names\":[\"Golang\",\"Vue\"],\"type\":1,\"original_url\":\"\",\"is_top\":0,\"status\":1}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:35424', '未知'),
       (45, '2022-12-16 23:39:06', '2022-12-16 23:39:06', '博客信息', '修改',
        'gin-blog/api/v1.(*BlogInfo).UpdateBlogConfig-fm', '/api/setting/blog-config', '修改博客信息',
        '{\"website_avatar\":\"public/uploaded/d0b80b7abde6b30fae6e950eb1ebf11a_20221216171019.png\",\"website_name\":\"阵、雨的个人博客\",\"website_author\":\"阵、雨\",\"website_intro\":\"往事随风而去\",\"website_notice\":\"博客后端基于 gin、gorm 开发\\n博客前端基于 Vue3、TS、NaiveUI 开发\\n努力开发中...冲冲冲！加油！\",\"website_createtime\":\"2022-11-01\",\"website_record\":\"qui aute sint ea dolor\",\"social_login_list\":[],\"social_url_list\":[],\"qq\":\"123456\",\"github\":\"https://github.com/szluyu99\",\"gitee\":\"https://gitee.com/szluyu99\",\"tourist_avatar\":\"https://static.talkxj.com/photos/0bca52afdb2b9998132355d716390c9f.png\",\"user_avatar\":\"https://static.talkxj.com/config/2cd793c8744199053323546875655f32.jpg\",\"article_cover\":\"https://static.talkxj.com/config/e587c4651154e4da49b5a54f865baaed.jpg\",\"is_comment_review\":1,\"is_message_review\":1,\"is_email_notice\":0,\"is_reward\":0,\"wechat_qrcode\":\"http://dummyimage.com/100x100\",\"alipay_ode\":\"http://dummyimage.com/100x100\"}',
        'PUT', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:41990', '未知'),
       (46, '2022-12-16 23:39:31', '2022-12-16 23:39:31', '博客信息', '修改',
        'gin-blog/api/v1.(*BlogInfo).UpdateBlogConfig-fm', '/api/setting/blog-config', '修改博客信息',
        '{\"website_avatar\":\"public/uploaded/d0b80b7abde6b30fae6e950eb1ebf11a_20221216171019.png\",\"website_name\":\"阵、雨的个人博客\",\"website_author\":\"阵、雨\",\"website_intro\":\"往事随风而去\",\"website_notice\":\"博客后端基于 gin、gorm 开发\\n博客前端基于 Vue3、TS、NaiveUI 开发\\n努力开发中...冲冲冲！加油！\",\"website_createtime\":\"2022-11-01\",\"website_record\":\"鲁ICP备2022040119号\",\"social_login_list\":[],\"social_url_list\":[],\"qq\":\"123456\",\"github\":\"https://github.com/szluyu99\",\"gitee\":\"https://gitee.com/szluyu99\",\"tourist_avatar\":\"https://static.talkxj.com/photos/0bca52afdb2b9998132355d716390c9f.png\",\"user_avatar\":\"https://static.talkxj.com/config/2cd793c8744199053323546875655f32.jpg\",\"article_cover\":\"https://static.talkxj.com/config/e587c4651154e4da49b5a54f865baaed.jpg\",\"is_comment_review\":1,\"is_message_review\":1,\"is_email_notice\":0,\"is_reward\":0,\"wechat_qrcode\":\"http://dummyimage.com/100x100\",\"alipay_ode\":\"http://dummyimage.com/100x100\"}',
        'PUT', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:41990', '未知'),
       (47, '2022-12-16 23:42:32', '2022-12-16 23:42:32', '用户', '修改', 'gin-blog/api/v1.(*User).UpdateCurrent-fm',
        '/api/user/current', '修改用户',
        '{\"avatar\":\"https://www.bing.com/rp/ar_9isCNU2Q-VG1yEDDHnx8HAFQ.png\",\"nickname\":\"管理员\",\"intro\":\"我是管理员用户！\",\"website\":\"https://www.hahacode.cn\"}',
        'PUT', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:41990', '未知'),
       (48, '2022-12-16 23:46:51', '2022-12-16 23:46:51', '页面', '新增或修改',
        'gin-blog/api/v1.(*Page).SaveOrUpdate-fm', '/api/page', '新增或修改页面',
        '{\"id\":7,\"created_at\":\"2022-12-08T13:53:17.707+08:00\",\"updated_at\":\"2022-12-08T13:53:17.707+08:00\",\"name\":\"留言\",\"label\":\"message\",\"cover\":\"https://img-blog.csdnimg.cn/50e0ec7fde824633b2cd7870028670b2.jpeg\"}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:41990', '未知'),
       (49, '2022-12-16 23:52:38', '2022-12-16 23:52:38', '博客信息', '修改',
        'gin-blog/api/v1.(*BlogInfo).UpdateBlogConfig-fm', '/api/setting/blog-config', '修改博客信息',
        '{\"website_avatar\":\"public/uploaded/d0b80b7abde6b30fae6e950eb1ebf11a_20221216171019.png\",\"website_name\":\"阵、雨的个人博客\",\"website_author\":\"阵、雨\",\"website_intro\":\"往事随风而去\",\"website_notice\":\"博客后端基于 gin、gorm 开发\\n博客前端基于 Vue3、TS、NaiveUI 开发\\n努力开发中...冲冲冲！加油！\",\"website_createtime\":\"2022-11-01\",\"website_record\":\"鲁ICP备2022040119号\",\"social_login_list\":[],\"social_url_list\":[],\"qq\":\"123456\",\"github\":\"https://github.com/szluyu99\",\"gitee\":\"https://gitee.com/szluyu99\",\"tourist_avatar\":\"https://static.talkxj.com/photos/0bca52afdb2b9998132355d716390c9f.png\",\"user_avatar\":\"https://static.talkxj.com/config/2cd793c8744199053323546875655f32.jpg\",\"article_cover\":\"https://static.talkxj.com/config/e587c4651154e4da49b5a54f865baaed.jpg\",\"is_comment_review\":1,\"is_message_review\":1,\"is_email_notice\":0,\"is_reward\":0,\"wechat_qrcode\":\"http://dummyimage.com/100x100\",\"alipay_ode\":\"http://dummyimage.com/100x100\"}',
        'PUT', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:41990', '未知'),
       (50, '2022-12-16 23:54:53', '2022-12-16 23:54:53', '页面', '新增或修改',
        'gin-blog/api/v1.(*Page).SaveOrUpdate-fm', '/api/page', '新增或修改页面',
        '{\"name\":\"相册\",\"label\":\"album\",\"cover\":\"https://static.talkxj.com/config/e587c4651154e4da49b5a54f865baaed.jpg\"}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:41990', '未知'),
       (51, '2022-12-16 23:55:36', '2022-12-16 23:55:36', '页面', '新增或修改',
        'gin-blog/api/v1.(*Page).SaveOrUpdate-fm', '/api/page', '新增或修改页面',
        '{\"cover\":\"https://img-blog.csdnimg.cn/2c0e923329974daabb91373d0834359f.jpeg\",\"name\":\"错误页面\",\"label\":\"404\"}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:41990', '未知'),
       (52, '2022-12-16 23:56:18', '2022-12-16 23:56:18', '页面', '新增或修改',
        'gin-blog/api/v1.(*Page).SaveOrUpdate-fm', '/api/page', '新增或修改页面',
        '{\"name\":\"文章列表\",\"label\":\"article_list\",\"cover\":\"https://static.talkxj.com/config/924d65cc8312e6cdad2160eb8fce6831.jpg\"}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:41990', '未知'),
       (53, '2022-12-17 00:02:41', '2022-12-17 00:02:41', '博客信息', '修改',
        'gin-blog/api/v1.(*BlogInfo).UpdateBlogConfig-fm', '/api/setting/blog-config', '修改博客信息',
        '{\"website_avatar\":\"https://img-blog.csdnimg.cn/9e1832a8817d4344901f2e476cc74c16.jpeg\",\"website_name\":\"阵、雨的个人博客\",\"website_author\":\"阵、雨\",\"website_intro\":\"往事随风而去\",\"website_notice\":\"博客后端基于 gin、gorm 开发\\n博客前端基于 Vue3、TS、NaiveUI 开发\\n努力开发中...冲冲冲！加油！\",\"website_createtime\":\"2022-11-01\",\"website_record\":\"鲁ICP备2022040119号\",\"social_login_list\":[],\"social_url_list\":[],\"qq\":\"123456\",\"github\":\"https://github.com/szluyu99\",\"gitee\":\"https://gitee.com/szluyu99\",\"tourist_avatar\":\"https://static.talkxj.com/photos/0bca52afdb2b9998132355d716390c9f.png\",\"user_avatar\":\"https://static.talkxj.com/avatar/user.png\",\"article_cover\":\"https://static.talkxj.com/config/e587c4651154e4da49b5a54f865baaed.jpg\",\"is_comment_review\":1,\"is_message_review\":1,\"is_email_notice\":0,\"is_reward\":0,\"wechat_qrcode\":\"http://dummyimage.com/100x100\",\"alipay_ode\":\"http://dummyimage.com/100x100\"}',
        'PUT', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:41990', '未知'),
       (54, '2022-12-18 01:34:48', '2022-12-18 01:34:48', '资源权限', '新增或修改',
        'gin-blog/api/v1.(*Resource).SaveOrUpdate-fm', '/api/resource', '新增或修改资源权限',
        '{\"parent_id\":3,\"name\":\"导出文章\",\"url\":\"/article/export\",\"request_method\":\"POST\"}', 'POST',
        '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:51610', '未知'),
       (55, '2022-12-18 01:34:59', '2022-12-18 01:34:59', '资源权限', '新增或修改',
        'gin-blog/api/v1.(*Resource).SaveOrUpdate-fm', '/api/resource', '新增或修改资源权限',
        '{\"parent_id\":3,\"name\":\"导入文章\",\"url\":\"/article/import\",\"request_method\":\"POST\"}', 'POST',
        '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:51610', '未知'),
       (56, '2022-12-18 01:35:08', '2022-12-18 01:35:08', '角色', '新增或修改',
        'gin-blog/api/v1.(*Role).SaveOrUpdate-fm', '/api/role', '新增或修改角色',
        '{\"id\":1,\"name\":\"管理员\",\"label\":\"admin\",\"created_at\":\"2022-10-20T21:24:28+08:00\",\"is_disable\":0,\"resource_ids\":[43,44,45,46,47,48,6,59,60,61,7,38,39,40,41,42,8,65,66,67,68,9,62,63,64,10,23,34,35,36,37,79,80,81,85,49,51,52,53,54,50,55,56,57,58,69,70,71,72,91,92,93,78,82,84,86,98,95,11,99,100,101,74,102,103,104,105,106,107,109,108,3],\"menu_ids\":[2,3,4,5,6,7,8,9,16,17,23,24,25,26,27,28,29,30,31,32,33,36,37,38,34,10,39]}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '127.0.0.1:51610', '未知'),
       (57, '2022-12-24 12:01:44', '2022-12-24 12:01:44', '文章', '新增或修改',
        'gin-blog/api/v1.(*Article).SaveOrUpdate-fm', '/api/article', '新增或修改文章',
        '{\"id\":1,\"title\":\"博客介绍\",\"desc\":\"\",\"content\":\"## 博客介绍\\n\\n<p align=center>\\n<a href=\\\"http://www.hahacode.cn\\\">\\n<img src=\\\"https://img-blog.csdnimg.cn/fe2f1034cf7c4bd795552d47373ee405.jpeg\\\"  width=\\\"200\\\" hight=\\\"200\\\" alt=\\\"阵、雨的个人博客\\\" style=\\\"border-radius: 50%\\\">\\n</a>\\n</p>\\n\\n<p align=\\\"center\\\">\\n   <a target=\\\"_blank\\\" href=\\\"#\\\">\\n      <img src=\\\"https://img.shields.io/badge/Go-1.19-blue\\\"/>\\n      <img src=\\\"https://img.shields.io/badge/Gin-v1.8.1-blue\\\"/>\\n      <img src=\\\"https://img.shields.io/badge/Casbin-v2.56.0-blue\\\"/>\\n      <img src=\\\"https://img.shields.io/badge/mysql-8.0-blue\\\"/>\\n      <img src=\\\"https://img.shields.io/badge/GORM-v1.24.0-blue\\\"/>\\n      <img src=\\\"https://img.shields.io/badge/redis-7.0-red\\\"/>\\n      <img src=\\\"https://img.shields.io/badge/vue-v3.X-green\\\"/>\\n    </a>\\n</p>\\n\\n[在线预览](#在线预览) | [项目介绍](#项目介绍) | [技术介绍](#技术介绍) | [目录结构](#目录结构) | [环境介绍](#环境介绍) | [快速开始](#快速开始) | [总结&鸣谢](#总结鸣谢)  | [后续计划](#后续计划) | [更新日志](#更新日志)\\n\\n您的 Star 是我坚持的动力，感谢大家的支持，欢迎提交 Pr 共同改进项目。\\n\\nGithub 地址：[https://github.com/szluyu99/gin-vue-blog](https://github.com/szluyu99/gin-vue-blog)\\n\\nGitee 地址：[https://gitee.com/szluyu99/gin-vue-blog](https://gitee.com/szluyu99/gin-vue-blog)\\n\\n\\n## 在线预览\\n\\n博客前台链接：[hahacode.cn](https://www.hahacode.cn)（已适配移动端）\\n\\n博客后台链接：[hahacode.cn/blog-admin](https://www.hahacode.cn/blog-admin)（暂未专门适配移动端）\\n\\n> 博客域名已通过备案，且配置 SSL，通过 https 访问\\n\\n测试账号：test@qq.com，密码：11111，前后台都可用这个账号登录\\n\\n在线接口文档地址：[doc.hahacode.cn](http://doc.hahacode.cn/)\\n\\n> 本项目在线接口文档由 Apifox 生成，由于项目架构调整，有些接口待完善和修改\\n>\\n> 由于一开始不会用，接口文档生成的信息不全（如返回响应、响应示例），后续完善\\n\\n以下放几张简单的预览图，强烈建议点击上面的[预览链接](#在线预览)进去体验下：\\n\\n![前台首页图片](https://img-blog.csdnimg.cn/fd25f0e52cdc467893925a48d0d66662.png)\\n\\n![前台首页文章列表](https://img-blog.csdnimg.cn/005cee463d3c4e729a1dd7bbee41e963.png)\\n\\n![后台文章列表](https://img-blog.csdnimg.cn/18c39f63b7b64f7bbd2a4ab764552d13.png)\\n\\n\\n## 项目介绍\\n\\nGithub 上有很多优秀的前后台框架，本项目也参考了许多开源项目，但是大多项目都比较重量级（并非坏处），如果从学习的角度来看对初学者并不是很友好。本项目在以**博客**这个业务为主的前提下，提供一个完整的全栈项目代码（前台前端 + 后台前端 + 后端），技术点基本都是最新 + 最火的技术，代码轻量级，注释完善，适合学习。\\n\\n同时，本项目可用于一键搭建动态博客（参考 [快速开始](#快速开始)），会尽可能多的将前端许多栏目做成后台可动态配置的形式。\\n\\n前台：\\n- 前台界面设计参考 Hexo 的 Butterfly 设计，美观简洁\\n- 响应式布局，适配了移动端\\n- 实现点赞，统计用户等功能 (Redis)\\n- 评论 + 回复评论功能\\n- 留言采用弹幕墙，效果炫酷\\n- 文章详情页有文章目录、推荐文章等功能，优化用户体验\\n\\n后台：\\n- 鉴权使用 JWT\\n- 权限管理使用 CASBIN，实现基于 RBAC 的权限管理\\n- 支持动态权限修改，前端菜单由后端生成（动态路由）\\n- 文章编辑使用 Markdown 编辑器\\n- 常规后台功能齐全：侧边栏、面包屑、标签栏等\\n- 实现记录操作日志功能（GET 不记录）\\n- 实现监听在线用户、强制下线功能\\n- 文件上传支持七牛云、本地（后续计划支持更多）\\n- 对 CRUD 操作封装了通用 Hook\\n\\n其他：\\n- 采用 Restful 风格的 API\\n- 前后端分离部署，前端使用 Nginx，后端使用 Docker\\n- 代码整洁层次清晰，利于开发者学习\\n- 技术点新颖，代码轻量级，适度封装\\n- Docker Compose 一键运行，轻松搭建在线博客\\n\\n### 技术介绍\\n\\n> 这里只写一些主流的通用技术，详细第三方库：前端参考 `package.json` 文件，后端参考 `go.mod` 文件\\n\\n前端技术栈: 使用 pnpm 包管理工具\\n- 基于 TypeScript\\n- Vue3\\n- VueUse: 服务于 Vue Composition API 的工具集\\n- Unocss: 原子化 CSS\\n- Pinia\\n- Vue Router \\n- Axios \\n- Naive UI\\n- ...\\n\\n后端技术栈:\\n- Golang\\n- Docker\\n- Gin\\n- GORM\\n- Viper: 支持 TOML (默认)、YAML 等常用格式作为配置文件\\n- Casbin\\n- Zap\\n- MySQL\\n- Redis\\n- Nginx: 部署静态资源 + 反向代理\\n- ...\\n\\n其他:\\n- 腾讯云人机验证\\n- 七牛云对象存储\\n- ...\\n\\n### 目录结构\\n\\n> 这里简单列出目录结构，具体可以查看源码\\n\\n代码仓库目录：\\n\\n```bash\\ngin-vue-blog\\n├── gin-blog-admin      -- 博客后台前端\\n├── gin-blog-front      -- 博客前台前端\\n├── gin-blog-server     -- 博客后端\\n├── deploy              -- 部署\\n\\n```\\n\\n> 项目运行参考：[快速开始](#快速开始)\\n\\n后端目录：简略版\\n\\n```bash\\ngin-blog-server\\n├── api             -- API\\n│   ├── front       -- 前台接口\\n│   └── v1          -- 后台接口\\n├── dao             -- 数据库操作模块\\n├── service         -- 服务模块\\n├── model           -- 数据模型\\n│   ├── req             -- 请求 VO 模型\\n│   ├── resp            -- 响应 VO 模型\\n│   ├── dto             -- 内部传输 DTO 模型\\n│   └── ...             -- 数据库模型对象 PO 模型\\n├── routes          -- 路由模块\\n│   └── middleware      -- 路由中间件\\n├── utils           -- 工具模块\\n│   ├── r               -- 响应封装\\n│   ├── upload          -- 文件上传\\n│   └── ...\\n├── routes          -- 路由模块\\n├── config          -- 配置文件\\n├── test            -- 测试模块\\n├── assets          -- 资源文件\\n├── log             -- 存放日志的目录\\n├── public          -- 外部访问的静态资源\\n│   └── uploaded    -- 本地文件上传目录\\n├── Dockerfile\\n└── main.go\\n```\\n\\n前端目录：简略版\\n\\n```\\ngin-vue-admin / gin-vue-front 通用目录结构\\n├── src              \\n│   ├── api             -- 接口\\n│   ├── assets          -- 静态资源\\n│   ├── styles          -- 样式\\n│   ├── components      -- 组件\\n│   ├── composables     -- 组合式函数\\n│   ├── router          -- 路由\\n│   ├── store           -- 状态管理\\n│   ├── utils           -- 工具方法\\n│   ├── views           -- 页面\\n│   ├── App.vue\\n│   └── main.ts\\n├── settings         -- 项目配置\\n├── build            -- 构建相关的配置\\n├── public           -- 公共资源, 在打包后会被加到 dist 根目录\\n├── package.json \\n├── package-lock.json\\n├── index.html\\n├── tsconfig.json\\n├── unocss.config.ts -- unocss 配置\\n└── vite.config.ts   -- vite 配置\\n├── .env             -- 通用环境变量\\n├── .env.development -- 开发环境变量\\n├── .env.production  -- 线上环境变量\\n├── .gitignore\\n├── .editorconfig    -- 编辑器配置\\n```\\n\\n部署目录：简略版\\n\\n```\\ndeploy\\n├── build      -- 镜像构建\\n│   ├── mysql  -- mysql 镜像构建\\n│   ├── server -- 后端镜像构建 (基于 gin-blog-server 目录)\\n│   └── web    -- 前端镜像构建 (基于前端项目打包的静态资源)\\n└── start\\n    ├── docker-compose.yml    -- 多容器管理\\n    └── .env                  -- 环境变量\\n    └── ...\\n```\\n\\n## 环境介绍\\n\\n### 线上环境\\n\\n服务器：腾讯云 2核 4G Ubuntu 22.04 LTS\\n\\n对象存储：七牛云\\n\\n### 开发环境\\n\\n| 开发工具                      | 说明                    |\\n| ----------------------------- | ----------------------- |\\n| Vscode                        | Golang 后端 +  Vue 前端 |\\n| Navicat                       | MySQL 远程连接工具      |\\n| Another Redis Desktop Manager | Redis 远程连接工具      |\\n| MobaXterm                     | Linux 远程工具          |\\n| Apifox                        | 接口调试 + 文档生成     |\\n\\n| 开发环境 | 版本 |\\n| -------- | ---- |\\n| Golang   | 1.19 |\\n| MySQL    | 8.x  |\\n| Redis    | 7.x  |\\n\\n### VsCode 插件\\n\\nTODO: 直接写到 .vscode 文件中, 用 VsCode 打开后自动推荐安装\\n\\n如果使用 Vscode 开发，推荐安装以下插件。\\n\\n前端开发插件：（必备）\\n\\n| 插件 | 作用 |\\n| -------- | ---- |\\n| Volar   | Vue 官方插件 |\\n| UnoCSS | Unocss 官方插件 |\\n| Iconify IntelliSense | Iconify 提示插件 |\\n\\n后端开发插件：（必备）\\n\\n| 插件 | 作用 |\\n| -------- | ---- |\\n| Go | Golang 官方插件 |\\n\\n\\n其他插件：（个人推荐，用于提升开发体验）\\n\\n| 名称 | 作用 |\\n| -------- | ---- |\\n| Better Comments   | 优化代码注释显示效果 |\\n| TODO Highlight | 高亮 TODO |\\n| Highlight Matching Tag | 高亮匹配的标签 | \\n\\n## 快速开始\\n\\n建议下载本项目后，先一键运行起来，查看本项目在本地的运行效果。\\n\\n需要修改源码的话，参考常规运行，前后端分开运行。\\n\\n### 方式一：Docker Compose 一键运行\\n\\n需要安装 Docker 和 Docker Compose, 环境准备可参考 [deploy](https://github.com/szluyu99/gin-vue-blog/tree/main/deploy)\\n\\n```\\n# 拉取项目\\ngit clone https://github.com/szluyu99/gin-vue-blog\\n\\n# 进入 docker-compose 目录\\ncd deploy/start\\n\\n# 一键运行\\ndocker-compose up -d\\n```\\n\\n默认用户：\\n- 管理员 admin 123456\\n- 普通用户 user 123456\\n- 测试用户 test 123456\\n\\n### 方式二：常规运行\\n\\n> 自行安装 Golang、Node、MySQL、Redis 环境\\n\\n需要先运行后端服务，再运行前端项目，因为很多前端配置由后端动态加载（如菜单等）。\\n\\n拉取项目到本地：\\n\\n```bash\\ngit clone https://github.com/szluyu99/gin-vue-blog.git\\n```\\n\\n后端项目运行：\\n\\n```bash\\n# 1、进入后端项目根目录 \\ncd gin-blog-server\\n\\n# 2、修改项目运行的配置文件，默认加载位于 config/config.toml \\n\\n# 3、MySQL 导入 gvb.sql\\n\\n# 4、启动 Redis \\n\\n# 5、运行项目\\ngo mod tidy\\ngo run main.go\\n```\\n\\n数据库中的默认用户：\\n- 管理员 admin 123456\\n- 普通用户 user 123456\\n- 测试用户 test 123456\\n\\n前端项目运行： 本项目使用 pnpm 进行包管理，建议全局安装 pnpm\\n\\n```bash\\nnpm install -g pnpm\\n```\\n\\n前台前端：\\n\\n```bash\\n# 1、进入前台前端项目根目录\\ncd gin-blog-front\\n\\n# 2、安装依赖\\npnpm install\\n\\n# 3、运行项目\\npnpm dev\\n```\\n\\n后台前端：\\n\\n```bash\\n# 1、进入后台前端项目根目录\\ncd gin-blog-admin\\n\\n# 2、安装依赖\\npnpm install\\n\\n# 3、运行项目\\npnpm dev\\n```\\n\\n### 项目部署\\n\\n> 很快就来。保证简单。\\n\\n## 总结鸣谢\\n\\n这个项目不管是前端，还是后端，都是花了比较大心血去架构的，并且从技术选型上，都是选择了目前最火 + 最新的技术栈。当然，这也是个人的学习之作，很多知识点都是边学边开发的（例如 Casbin），这个过程中也参考了很多优秀的开源项目，感谢大家的开源让程序员的世界更加美好，这也是开源本项目的目的之一。本项目中仍有很多不足，后续会继续更新。\\n\\n最后，项目整体代码风格很优秀，注释完善，适合 Golang 后端开发者、前端开发者学习。\\n\\n 鸣谢项目：\\n\\n- [https://butterfly.js.org/](https://butterfly.js.org/)\\n- [https://github.com/flipped-aurora/gin-vue-admin](https://github.com/flipped-aurora/gin-vue-admin)\\n- [https://github.com/qifengzhang007/GinSkeleton](https://github.com/qifengzhang007/GinSkeleton)\\n- [https://github.com/X1192176811/blog](https://github.com/X1192176811/blog)\\n- [https://github.com/zclzone/vue-naive-admin](https://github.com/zclzone/vue-naive-admin)\\n- [https://github.com/antfu/vitesse](https://github.com/antfu/vitesse)\\n- ...\\n\\n> 需要感谢的绝不止以上这些开源项目，但是一时难以全部列出，后面会慢慢补上。\\n\\n## 后续计划\\n\\n高优先级: \\n\\n- ~~完善图片上传功能, 目前文件上传还没怎么处理~~ 🆗\\n- 后台首页重新设计（目前没放什么内容）\\n- ~~前台首页搜索文章（目前使用数据库模糊搜索）~~ 🆗\\n- ~~博客文章导入导出 (.md 文件)~~ 🆗\\n- ~~权限管理中菜单编辑时选择图标（现在只能输入图标字符串）~~ 🆗\\n- 后端日志切割\\n- ~~后台修改背景图片，博客配置等~~ 🆗\\n- ~~后端的 IP 地址检测 BUG 待修复~~ 🆗\\n- ~~博客前台适配移动端~~ 🆗\\n- ~~文章详情, 目录锚点跟随~~ 🆗\\n- 邮箱注册 + 邮件发送验证码\\n\\n后续有空安排上：\\n- 黑夜模式\\n- 前台收缩侧边信息功能\\n- 说说\\n- 相册\\n- 音乐播放器\\n- 鼠标左击特效\\n- 看板娘\\n- 第三方登录: QQ、微信、Github ...\\n- 评论时支持选择表情，参考 Valine\\n- 单独部署：前后端 + 环境\\n- 重写单元测试，目前的单元测试是早期版本，项目架构更改后，无法跑通\\n- 前台首页搜索集成 ElasticSearch\\n- 国际化?\\n\\n其他：\\n- 写一份好的文档\\n- 补全 README.md\\n- 完善 Apifox 生成的接口文档\\n- ~~一键部署：使用 docker compose 单机一键部署整个项目（前后端 + 环境）~~ 🆗\\n\\n## 更新日志\\n\\n描述规范定义，有以下几种行为 ACTION:\\n- `FIX`: 修复\\n- `REFINE`: 优化\\n- `COMPLETE`: 完善\\n- `ADD`: 新增\\n\\n---\\n\\n2022-12-23:\\n\\n博客部署:\\n- 新增 deploy 子模块, 使用 docker-compose 一键运行前后端 ⭐⭐\\n\\n---\\n\\n2022-12-22:\\n\\n博客部署:\\n- 修复 线上图片上传问题, 本地上传则采用 Nginx 反向代理 Gin 的静态服务资源, 也可采用七牛云存储\\n\\n---\\n\\n2022-12-21:\\n\\n博客后台:\\n- 新增 图标选择组件, 选择范围为自定义图标数组 ⭐\\n\\n---\\n\\n2022-12-20:\\n\\n博客后台: \\n- 完善 IP 检测工具 ⭐\\n- 修复 Nginx 获取的客户端 IP 是服务器 IP (docker 部署 Nginx 的问题, 修改 Nginx 配置文件即可)\\n\\n---\\n\\n2022-12-19:\\n\\n博客后台:\\n- 添加简易版黑夜模式 (一行 CSS 实现)\\n\\n---\\n\\n2022-12-17:\\n\\n博客后台:\\n- 新增 文章导入、导出 ⭐\\n\\n---\\n\\n2022-12-16:\\n\\n博客后台:\\n- 修复 MySQL 无法存储 emoji 的问题，设置 utf8mb4 字符集编码，更新 SQL \\n- 完善 添加文章时选择标签的逻辑\\n- 新增 全屏水印 功能\\n\\n---\\n\\n2022-12-15:\\n\\n博客后台：\\n- 优化 菜单栏和标签栏，点击标签自动展开对应菜单，点击菜单自动滚动到显示对应标签 ⭐\\n- 优化 使用响应式语法糖重构代码\\n- 优化 代码结构 + 注释\\n\\n---\\n\\n2022-12-14:\\n\\n博客前台：\\n- 优化 代码，去除 n-card 组件，使用自定义 css 实现卡片视图\\n- 优化 对滚动的监听操作，添加节流函数，提升性能 ⭐\\n- 优化 文章目录，根据当前滚动条自动高亮锚点 ⭐⭐\\n- 新增 vite 打包优化相关插件\\n\\n---\\n\\n2022-12-13:\\n\\n项目部署：\\n- 新增 Nginx 配置 https 访问域名 (http 自动跳转到 https) ⭐\\n- 新增 七牛云添加加速域名访问图片资源\\n\\n博客后端：\\n- 新增 文章搜索接口（数据库模糊查询）\\n\\n博客前台：\\n- 新增 导航栏的文章搜索\\n\\n---\\n\\n2022-12-12:\\n\\n博客前台：\\n- 新增 适配移动端 ⭐⭐\\n- 优化 删除 Vuetify 相关组件及依赖 (css 样式存在冲突)，统一使用 naive-ui\\n- 优化 使用 `$ref` 语法糖功能重构页面\\n\\n---\\n\\n2022-12-09:\\n\\n博客前台：\\n- 完善 个人中心的头像上传（注意头像上传需要 Token）\\n- 优化 重构通用页面的代码 ⭐\\n\\n---\\n\\n2022-12-08:\\n\\n博客后端：\\n- 新增 页面模块 的接口 ⭐\\n- 修复 单元测试无法初始化全局变量（flag 包冲突）问题\\n\\n博客后台：\\n- 新增 pinia 数据持久化，防止刷新丢失数据 ⭐\\n- 新增 页面管理页面，动态配置前台显示的封面 ⭐\\n\\n博客前台：\\n- 新增 页面根据 `label` 从后端数据中加载封面 ⭐\\n- 优化 尝试性使用 `$ref` 语法糖功能\\n\\n---\\n\\n2022-12-07:\\n\\n博客后台：\\n- 修复 博客后台，动态加载路由模块导致的热加载失效问题 ⭐⭐\\n- 完善 文件上传，抽取出单独的组件 ⭐⭐\\n- 新增 个人信息页面 ⭐\\n- 优化 发布文章/查看文章 时的文章标签选择、分类选择\\n- 修复 发布文章/查看文章 页面数据加载错误\",\"img\":\"https://static.talkxj.com/articles/771941739cbc70fbe40e10cf441e02e5.jpg\",\"category_name\":\"后端\",\"tag_names\":[\"Golang\",\"Vue\"],\"type\":1,\"original_url\":\"\",\"is_top\":0,\"status\":1}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '172.12.0.1', '美国'),
       (58, '2022-12-24 12:03:13', '2022-12-24 12:03:13', '文章', '新增或修改',
        'gin-blog/api/v1.(*Article).SaveOrUpdate-fm', '/api/article', '新增或修改文章',
        '{\"id\":1,\"title\":\"博客介绍\",\"desc\":\"\",\"content\":\"## 博客介绍\\n\\n<p align=center>\\n<a href=\\\"http://www.hahacode.cn\\\">\\n<img src=\\\"https://img-blog.csdnimg.cn/fe2f1034cf7c4bd795552d47373ee405.jpeg\\\"  width=\\\"200\\\" hight=\\\"200\\\" alt=\\\"阵、雨的个人博客\\\" style=\\\"border-radius: 50%\\\">\\n</a>\\n</p>\\n\\n<p align=\\\"center\\\">\\n   <a target=\\\"_blank\\\" href=\\\"#\\\">\\n      <ims style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/Go-1.19-blue\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/Gin-v1.8.1-blue\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/Casbin-v2.56.0-blue\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/mysql-8.0-blue\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/GORM-v1.24.0-blue\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/redis-7.0-red\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/vue-v3.X-green\\\"/>\\n    </a>\\n</p>\\n\\n[在线预览](#在线预览) | [项目介绍](#项目介绍) | [技术介绍](#技术介绍) | [目录结构](#目录结构) | [环境介绍](#环境介绍) | [快速开始](#快速开始) | [总结&鸣谢](#总结鸣谢)  | [后续计划](#后续计划) | [更新日志](#更新日志)\\n\\n您的 Star 是我坚持的动力，感谢大家的支持，欢迎提交 Pr 共同改进项目。\\n\\nGithub 地址：[https://github.com/szluyu99/gin-vue-blog](https://github.com/szluyu99/gin-vue-blog)\\n\\nGitee 地址：[https://gitee.com/szluyu99/gin-vue-blog](https://gitee.com/szluyu99/gin-vue-blog)\\n\\n\\n## 在线预览\\n\\n博客前台链接：[hahacode.cn](https://www.hahacode.cn)（已适配移动端）\\n\\n博客后台链接：[hahacode.cn/blog-admin](https://www.hahacode.cn/blog-admin)（暂未专门适配移动端）\\n\\n> 博客域名已通过备案，且配置 SSL，通过 https 访问\\n\\n测试账号：test@qq.com，密码：11111，前后台都可用这个账号登录\\n\\n在线接口文档地址：[doc.hahacode.cn](http://doc.hahacode.cn/)\\n\\n> 本项目在线接口文档由 Apifox 生成，由于项目架构调整，有些接口待完善和修改\\n>\\n> 由于一开始不会用，接口文档生成的信息不全（如返回响应、响应示例），后续完善\\n\\n以下放几张简单的预览图，强烈建议点击上面的[预览链接](#在线预览)进去体验下：\\n\\n![前台首页图片](https://img-blog.csdnimg.cn/fd25f0e52cdc467893925a48d0d66662.png)\\n\\n![前台首页文章列表](https://img-blog.csdnimg.cn/005cee463d3c4e729a1dd7bbee41e963.png)\\n\\n![后台文章列表](https://img-blog.csdnimg.cn/18c39f63b7b64f7bbd2a4ab764552d13.png)\\n\\n\\n## 项目介绍\\n\\nGithub 上有很多优秀的前后台框架，本项目也参考了许多开源项目，但是大多项目都比较重量级（并非坏处），如果从学习的角度来看对初学者并不是很友好。本项目在以**博客**这个业务为主的前提下，提供一个完整的全栈项目代码（前台前端 + 后台前端 + 后端），技术点基本都是最新 + 最火的技术，代码轻量级，注释完善，适合学习。\\n\\n同时，本项目可用于一键搭建动态博客（参考 [快速开始](#快速开始)），会尽可能多的将前端许多栏目做成后台可动态配置的形式。\\n\\n前台：\\n- 前台界面设计参考 Hexo 的 Butterfly 设计，美观简洁\\n- 响应式布局，适配了移动端\\n- 实现点赞，统计用户等功能 (Redis)\\n- 评论 + 回复评论功能\\n- 留言采用弹幕墙，效果炫酷\\n- 文章详情页有文章目录、推荐文章等功能，优化用户体验\\n\\n后台：\\n- 鉴权使用 JWT\\n- 权限管理使用 CASBIN，实现基于 RBAC 的权限管理\\n- 支持动态权限修改，前端菜单由后端生成（动态路由）\\n- 文章编辑使用 Markdown 编辑器\\n- 常规后台功能齐全：侧边栏、面包屑、标签栏等\\n- 实现记录操作日志功能（GET 不记录）\\n- 实现监听在线用户、强制下线功能\\n- 文件上传支持七牛云、本地（后续计划支持更多）\\n- 对 CRUD 操作封装了通用 Hook\\n\\n其他：\\n- 采用 Restful 风格的 API\\n- 前后端分离部署，前端使用 Nginx，后端使用 Docker\\n- 代码整洁层次清晰，利于开发者学习\\n- 技术点新颖，代码轻量级，适度封装\\n- Docker Compose 一键运行，轻松搭建在线博客\\n\\n### 技术介绍\\n\\n> 这里只写一些主流的通用技术，详细第三方库：前端参考 `package.json` 文件，后端参考 `go.mod` 文件\\n\\n前端技术栈: 使用 pnpm 包管理工具\\n- 基于 TypeScript\\n- Vue3\\n- VueUse: 服务于 Vue Composition API 的工具集\\n- Unocss: 原子化 CSS\\n- Pinia\\n- Vue Router \\n- Axios \\n- Naive UI\\n- ...\\n\\n后端技术栈:\\n- Golang\\n- Docker\\n- Gin\\n- GORM\\n- Viper: 支持 TOML (默认)、YAML 等常用格式作为配置文件\\n- Casbin\\n- Zap\\n- MySQL\\n- Redis\\n- Nginx: 部署静态资源 + 反向代理\\n- ...\\n\\n其他:\\n- 腾讯云人机验证\\n- 七牛云对象存储\\n- ...\\n\\n### 目录结构\\n\\n> 这里简单列出目录结构，具体可以查看源码\\n\\n代码仓库目录：\\n\\n```bash\\ngin-vue-blog\\n├── gin-blog-admin      -- 博客后台前端\\n├── gin-blog-front      -- 博客前台前端\\n├── gin-blog-server     -- 博客后端\\n├── deploy              -- 部署\\n\\n```\\n\\n> 项目运行参考：[快速开始](#快速开始)\\n\\n后端目录：简略版\\n\\n```bash\\ngin-blog-server\\n├── api             -- API\\n│   ├── front       -- 前台接口\\n│   └── v1          -- 后台接口\\n├── dao             -- 数据库操作模块\\n├── service         -- 服务模块\\n├── model           -- 数据模型\\n│   ├── req             -- 请求 VO 模型\\n│   ├── resp            -- 响应 VO 模型\\n│   ├── dto             -- 内部传输 DTO 模型\\n│   └── ...             -- 数据库模型对象 PO 模型\\n├── routes          -- 路由模块\\n│   └── middleware      -- 路由中间件\\n├── utils           -- 工具模块\\n│   ├── r               -- 响应封装\\n│   ├── upload          -- 文件上传\\n│   └── ...\\n├── routes          -- 路由模块\\n├── config          -- 配置文件\\n├── test            -- 测试模块\\n├── assets          -- 资源文件\\n├── log             -- 存放日志的目录\\n├── public          -- 外部访问的静态资源\\n│   └── uploaded    -- 本地文件上传目录\\n├── Dockerfile\\n└── main.go\\n```\\n\\n前端目录：简略版\\n\\n```\\ngin-vue-admin / gin-vue-front 通用目录结构\\n├── src              \\n│   ├── api             -- 接口\\n│   ├── assets          -- 静态资源\\n│   ├── styles          -- 样式\\n│   ├── components      -- 组件\\n│   ├── composables     -- 组合式函数\\n│   ├── router          -- 路由\\n│   ├── store           -- 状态管理\\n│   ├── utils           -- 工具方法\\n│   ├── views           -- 页面\\n│   ├── App.vue\\n│   └── main.ts\\n├── settings         -- 项目配置\\n├── build            -- 构建相关的配置\\n├── public           -- 公共资源, 在打包后会被加到 dist 根目录\\n├── package.json \\n├── package-lock.json\\n├── index.html\\n├── tsconfig.json\\n├── unocss.config.ts -- unocss 配置\\n└── vite.config.ts   -- vite 配置\\n├── .env             -- 通用环境变量\\n├── .env.development -- 开发环境变量\\n├── .env.production  -- 线上环境变量\\n├── .gitignore\\n├── .editorconfig    -- 编辑器配置\\n```\\n\\n部署目录：简略版\\n\\n```\\ndeploy\\n├── build      -- 镜像构建\\n│   ├── mysql  -- mysql 镜像构建\\n│   ├── server -- 后端镜像构建 (基于 gin-blog-server 目录)\\n│   └── web    -- 前端镜像构建 (基于前端项目打包的静态资源)\\n└── start\\n    ├── docker-compose.yml    -- 多容器管理\\n    └── .env                  -- 环境变量\\n    └── ...\\n```\\n\\n## 环境介绍\\n\\n### 线上环境\\n\\n服务器：腾讯云 2核 4G Ubuntu 22.04 LTS\\n\\n对象存储：七牛云\\n\\n### 开发环境\\n\\n| 开发工具                      | 说明                    |\\n| ----------------------------- | ----------------------- |\\n| Vscode                        | Golang 后端 +  Vue 前端 |\\n| Navicat                       | MySQL 远程连接工具      |\\n| Another Redis Desktop Manager | Redis 远程连接工具      |\\n| MobaXterm                     | Linux 远程工具          |\\n| Apifox                        | 接口调试 + 文档生成     |\\n\\n| 开发环境 | 版本 |\\n| -------- | ---- |\\n| Golang   | 1.19 |\\n| MySQL    | 8.x  |\\n| Redis    | 7.x  |\\n\\n### VsCode 插件\\n\\nTODO: 直接写到 .vscode 文件中, 用 VsCode 打开后自动推荐安装\\n\\n如果使用 Vscode 开发，推荐安装以下插件。\\n\\n前端开发插件：（必备）\\n\\n| 插件 | 作用 |\\n| -------- | ---- |\\n| Volar   | Vue 官方插件 |\\n| UnoCSS | Unocss 官方插件 |\\n| Iconify IntelliSense | Iconify 提示插件 |\\n\\n后端开发插件：（必备）\\n\\n| 插件 | 作用 |\\n| -------- | ---- |\\n| Go | Golang 官方插件 |\\n\\n\\n其他插件：（个人推荐，用于提升开发体验）\\n\\n| 名称 | 作用 |\\n| -------- | ---- |\\n| Better Comments   | 优化代码注释显示效果 |\\n| TODO Highlight | 高亮 TODO |\\n| Highlight Matching Tag | 高亮匹配的标签 | \\n\\n## 快速开始\\n\\n建议下载本项目后，先一键运行起来，查看本项目在本地的运行效果。\\n\\n需要修改源码的话，参考常规运行，前后端分开运行。\\n\\n### 方式一：Docker Compose 一键运行\\n\\n需要安装 Docker 和 Docker Compose, 环境准备可参考 [deploy](https://github.com/szluyu99/gin-vue-blog/tree/main/deploy)\\n\\n```\\n# 拉取项目\\ngit clone https://github.com/szluyu99/gin-vue-blog\\n\\n# 进入 docker-compose 目录\\ncd deploy/start\\n\\n# 一键运行\\ndocker-compose up -d\\n```\\n\\n默认用户：\\n- 管理员 admin 123456\\n- 普通用户 user 123456\\n- 测试用户 test 123456\\n\\n### 方式二：常规运行\\n\\n> 自行安装 Golang、Node、MySQL、Redis 环境\\n\\n需要先运行后端服务，再运行前端项目，因为很多前端配置由后端动态加载（如菜单等）。\\n\\n拉取项目到本地：\\n\\n```bash\\ngit clone https://github.com/szluyu99/gin-vue-blog.git\\n```\\n\\n后端项目运行：\\n\\n```bash\\n# 1、进入后端项目根目录 \\ncd gin-blog-server\\n\\n# 2、修改项目运行的配置文件，默认加载位于 config/config.toml \\n\\n# 3、MySQL 导入 gvb.sql\\n\\n# 4、启动 Redis \\n\\n# 5、运行项目\\ngo mod tidy\\ngo run main.go\\n```\\n\\n数据库中的默认用户：\\n- 管理员 admin 123456\\n- 普通用户 user 123456\\n- 测试用户 test 123456\\n\\n前端项目运行： 本项目使用 pnpm 进行包管理，建议全局安装 pnpm\\n\\n```bash\\nnpm install -g pnpm\\n```\\n\\n前台前端：\\n\\n```bash\\n# 1、进入前台前端项目根目录\\ncd gin-blog-front\\n\\n# 2、安装依赖\\npnpm install\\n\\n# 3、运行项目\\npnpm dev\\n```\\n\\n后台前端：\\n\\n```bash\\n# 1、进入后台前端项目根目录\\ncd gin-blog-admin\\n\\n# 2、安装依赖\\npnpm install\\n\\n# 3、运行项目\\npnpm dev\\n```\\n\\n### 项目部署\\n\\n> 很快就来。保证简单。\\n\\n## 总结鸣谢\\n\\n这个项目不管是前端，还是后端，都是花了比较大心血去架构的，并且从技术选型上，都是选择了目前最火 + 最新的技术栈。当然，这也是个人的学习之作，很多知识点都是边学边开发的（例如 Casbin），这个过程中也参考了很多优秀的开源项目，感谢大家的开源让程序员的世界更加美好，这也是开源本项目的目的之一。本项目中仍有很多不足，后续会继续更新。\\n\\n最后，项目整体代码风格很优秀，注释完善，适合 Golang 后端开发者、前端开发者学习。\\n\\n 鸣谢项目：\\n\\n- [https://butterfly.js.org/](https://butterfly.js.org/)\\n- [https://github.com/flipped-aurora/gin-vue-admin](https://github.com/flipped-aurora/gin-vue-admin)\\n- [https://github.com/qifengzhang007/GinSkeleton](https://github.com/qifengzhang007/GinSkeleton)\\n- [https://github.com/X1192176811/blog](https://github.com/X1192176811/blog)\\n- [https://github.com/zclzone/vue-naive-admin](https://github.com/zclzone/vue-naive-admin)\\n- [https://github.com/antfu/vitesse](https://github.com/antfu/vitesse)\\n- ...\\n\\n> 需要感谢的绝不止以上这些开源项目，但是一时难以全部列出，后面会慢慢补上。\\n\\n## 后续计划\\n\\n高优先级: \\n\\n- ~~完善图片上传功能, 目前文件上传还没怎么处理~~ 🆗\\n- 后台首页重新设计（目前没放什么内容）\\n- ~~前台首页搜索文章（目前使用数据库模糊搜索）~~ 🆗\\n- ~~博客文章导入导出 (.md 文件)~~ 🆗\\n- ~~权限管理中菜单编辑时选择图标（现在只能输入图标字符串）~~ 🆗\\n- 后端日志切割\\n- ~~后台修改背景图片，博客配置等~~ 🆗\\n- ~~后端的 IP 地址检测 BUG 待修复~~ 🆗\\n- ~~博客前台适配移动端~~ 🆗\\n- ~~文章详情, 目录锚点跟随~~ 🆗\\n- 邮箱注册 + 邮件发送验证码\\n\\n后续有空安排上：\\n- 黑夜模式\\n- 前台收缩侧边信息功能\\n- 说说\\n- 相册\\n- 音乐播放器\\n- 鼠标左击特效\\n- 看板娘\\n- 第三方登录: QQ、微信、Github ...\\n- 评论时支持选择表情，参考 Valine\\n- 单独部署：前后端 + 环境\\n- 重写单元测试，目前的单元测试是早期版本，项目架构更改后，无法跑通\\n- 前台首页搜索集成 ElasticSearch\\n- 国际化?\\n\\n其他：\\n- 写一份好的文档\\n- 补全 README.md\\n- 完善 Apifox 生成的接口文档\\n- ~~一键部署：使用 docker compose 单机一键部署整个项目（前后端 + 环境）~~ 🆗\\n\\n## 更新日志\\n\\n描述规范定义，有以下几种行为 ACTION:\\n- `FIX`: 修复\\n- `REFINE`: 优化\\n- `COMPLETE`: 完善\\n- `ADD`: 新增\\n\\n---\\n\\n2022-12-23:\\n\\n博客部署:\\n- 新增 deploy 子模块, 使用 docker-compose 一键运行前后端 ⭐⭐\\n\\n---\\n\\n2022-12-22:\\n\\n博客部署:\\n- 修复 线上图片上传问题, 本地上传则采用 Nginx 反向代理 Gin 的静态服务资源, 也可采用七牛云存储\\n\\n---\\n\\n2022-12-21:\\n\\n博客后台:\\n- 新增 图标选择组件, 选择范围为自定义图标数组 ⭐\\n\\n---\\n\\n2022-12-20:\\n\\n博客后台: \\n- 完善 IP 检测工具 ⭐\\n- 修复 Nginx 获取的客户端 IP 是服务器 IP (docker 部署 Nginx 的问题, 修改 Nginx 配置文件即可)\\n\\n---\\n\\n2022-12-19:\\n\\n博客后台:\\n- 添加简易版黑夜模式 (一行 CSS 实现)\\n\\n---\\n\\n2022-12-17:\\n\\n博客后台:\\n- 新增 文章导入、导出 ⭐\\n\\n---\\n\\n2022-12-16:\\n\\n博客后台:\\n- 修复 MySQL 无法存储 emoji 的问题，设置 utf8mb4 字符集编码，更新 SQL \\n- 完善 添加文章时选择标签的逻辑\\n- 新增 全屏水印 功能\\n\\n---\\n\\n2022-12-15:\\n\\n博客后台：\\n- 优化 菜单栏和标签栏，点击标签自动展开对应菜单，点击菜单自动滚动到显示对应标签 ⭐\\n- 优化 使用响应式语法糖重构代码\\n- 优化 代码结构 + 注释\\n\\n---\\n\\n2022-12-14:\\n\\n博客前台：\\n- 优化 代码，去除 n-card 组件，使用自定义 css 实现卡片视图\\n- 优化 对滚动的监听操作，添加节流函数，提升性能 ⭐\\n- 优化 文章目录，根据当前滚动条自动高亮锚点 ⭐⭐\\n- 新增 vite 打包优化相关插件\\n\\n---\\n\\n2022-12-13:\\n\\n项目部署：\\n- 新增 Nginx 配置 https 访问域名 (http 自动跳转到 https) ⭐\\n- 新增 七牛云添加加速域名访问图片资源\\n\\n博客后端：\\n- 新增 文章搜索接口（数据库模糊查询）\\n\\n博客前台：\\n- 新增 导航栏的文章搜索\\n\\n---\\n\\n2022-12-12:\\n\\n博客前台：\\n- 新增 适配移动端 ⭐⭐\\n- 优化 删除 Vuetify 相关组件及依赖 (css 样式存在冲突)，统一使用 naive-ui\\n- 优化 使用 `$ref` 语法糖功能重构页面\\n\\n---\\n\\n2022-12-09:\\n\\n博客前台：\\n- 完善 个人中心的头像上传（注意头像上传需要 Token）\\n- 优化 重构通用页面的代码 ⭐\\n\\n---\\n\\n2022-12-08:\\n\\n博客后端：\\n- 新增 页面模块 的接口 ⭐\\n- 修复 单元测试无法初始化全局变量（flag 包冲突）问题\\n\\n博客后台：\\n- 新增 pinia 数据持久化，防止刷新丢失数据 ⭐\\n- 新增 页面管理页面，动态配置前台显示的封面 ⭐\\n\\n博客前台：\\n- 新增 页面根据 `label` 从后端数据中加载封面 ⭐\\n- 优化 尝试性使用 `$ref` 语法糖功能\\n\\n---\\n\\n2022-12-07:\\n\\n博客后台：\\n- 修复 博客后台，动态加载路由模块导致的热加载失效问题 ⭐⭐\\n- 完善 文件上传，抽取出单独的组件 ⭐⭐\\n- 新增 个人信息页面 ⭐\\n- 优化 发布文章/查看文章 时的文章标签选择、分类选择\\n- 修复 发布文章/查看文章 页面数据加载错误\",\"img\":\"https://static.talkxj.com/articles/771941739cbc70fbe40e10cf441e02e5.jpg\",\"category_name\":\"后端\",\"tag_names\":[\"Golang\",\"Vue\"],\"type\":1,\"original_url\":\"\",\"is_top\":0,\"status\":1}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '172.12.0.1', '美国'),
       (59, '2022-12-24 12:03:44', '2022-12-24 12:03:44', '文章', '新增或修改',
        'gin-blog/api/v1.(*Article).SaveOrUpdate-fm', '/api/article', '新增或修改文章',
        '{\"id\":1,\"title\":\"博客介绍\",\"desc\":\"\",\"content\":\"## 博客介绍\\n\\n<p align=center>\\n<a href=\\\"http://www.hahacode.cn\\\">\\n<img src=\\\"https://img-blog.csdnimg.cn/fe2f1034cf7c4bd795552d47373ee405.jpeg\\\"  width=\\\"200\\\" hight=\\\"200\\\" alt=\\\"阵、雨的个人博客\\\" style=\\\"border-radius: 50%\\\">\\n</a>\\n</p>\\n\\n<p align=\\\"center\\\">\\n   <a target=\\\"_blank\\\" href=\\\"#\\\">\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/Go-1.19-blue\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/Gin-v1.8.1-blue\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/Casbin-v2.56.0-blue\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/mysql-8.0-blue\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/GORM-v1.24.0-blue\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/redis-7.0-red\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/vue-v3.X-green\\\"/>\\n    </a>\\n</p>\\n\\n[在线预览](#在线预览) | [项目介绍](#项目介绍) | [技术介绍](#技术介绍) | [目录结构](#目录结构) | [环境介绍](#环境介绍) | [快速开始](#快速开始) | [总结&鸣谢](#总结鸣谢)  | [后续计划](#后续计划) | [更新日志](#更新日志)\\n\\n您的 Star 是我坚持的动力，感谢大家的支持，欢迎提交 Pr 共同改进项目。\\n\\nGithub 地址：[https://github.com/szluyu99/gin-vue-blog](https://github.com/szluyu99/gin-vue-blog)\\n\\nGitee 地址：[https://gitee.com/szluyu99/gin-vue-blog](https://gitee.com/szluyu99/gin-vue-blog)\\n\\n\\n## 在线预览\\n\\n博客前台链接：[hahacode.cn](https://www.hahacode.cn)（已适配移动端）\\n\\n博客后台链接：[hahacode.cn/blog-admin](https://www.hahacode.cn/blog-admin)（暂未专门适配移动端）\\n\\n> 博客域名已通过备案，且配置 SSL，通过 https 访问\\n\\n测试账号：test@qq.com，密码：11111，前后台都可用这个账号登录\\n\\n在线接口文档地址：[doc.hahacode.cn](http://doc.hahacode.cn/)\\n\\n> 本项目在线接口文档由 Apifox 生成，由于项目架构调整，有些接口待完善和修改\\n>\\n> 由于一开始不会用，接口文档生成的信息不全（如返回响应、响应示例），后续完善\\n\\n以下放几张简单的预览图，强烈建议点击上面的[预览链接](#在线预览)进去体验下：\\n\\n![前台首页图片](https://img-blog.csdnimg.cn/fd25f0e52cdc467893925a48d0d66662.png)\\n\\n![前台首页文章列表](https://img-blog.csdnimg.cn/005cee463d3c4e729a1dd7bbee41e963.png)\\n\\n![后台文章列表](https://img-blog.csdnimg.cn/18c39f63b7b64f7bbd2a4ab764552d13.png)\\n\\n\\n## 项目介绍\\n\\nGithub 上有很多优秀的前后台框架，本项目也参考了许多开源项目，但是大多项目都比较重量级（并非坏处），如果从学习的角度来看对初学者并不是很友好。本项目在以**博客**这个业务为主的前提下，提供一个完整的全栈项目代码（前台前端 + 后台前端 + 后端），技术点基本都是最新 + 最火的技术，代码轻量级，注释完善，适合学习。\\n\\n同时，本项目可用于一键搭建动态博客（参考 [快速开始](#快速开始)），会尽可能多的将前端许多栏目做成后台可动态配置的形式。\\n\\n前台：\\n- 前台界面设计参考 Hexo 的 Butterfly 设计，美观简洁\\n- 响应式布局，适配了移动端\\n- 实现点赞，统计用户等功能 (Redis)\\n- 评论 + 回复评论功能\\n- 留言采用弹幕墙，效果炫酷\\n- 文章详情页有文章目录、推荐文章等功能，优化用户体验\\n\\n后台：\\n- 鉴权使用 JWT\\n- 权限管理使用 CASBIN，实现基于 RBAC 的权限管理\\n- 支持动态权限修改，前端菜单由后端生成（动态路由）\\n- 文章编辑使用 Markdown 编辑器\\n- 常规后台功能齐全：侧边栏、面包屑、标签栏等\\n- 实现记录操作日志功能（GET 不记录）\\n- 实现监听在线用户、强制下线功能\\n- 文件上传支持七牛云、本地（后续计划支持更多）\\n- 对 CRUD 操作封装了通用 Hook\\n\\n其他：\\n- 采用 Restful 风格的 API\\n- 前后端分离部署，前端使用 Nginx，后端使用 Docker\\n- 代码整洁层次清晰，利于开发者学习\\n- 技术点新颖，代码轻量级，适度封装\\n- Docker Compose 一键运行，轻松搭建在线博客\\n\\n### 技术介绍\\n\\n> 这里只写一些主流的通用技术，详细第三方库：前端参考 `package.json` 文件，后端参考 `go.mod` 文件\\n\\n前端技术栈: 使用 pnpm 包管理工具\\n- 基于 TypeScript\\n- Vue3\\n- VueUse: 服务于 Vue Composition API 的工具集\\n- Unocss: 原子化 CSS\\n- Pinia\\n- Vue Router \\n- Axios \\n- Naive UI\\n- ...\\n\\n后端技术栈:\\n- Golang\\n- Docker\\n- Gin\\n- GORM\\n- Viper: 支持 TOML (默认)、YAML 等常用格式作为配置文件\\n- Casbin\\n- Zap\\n- MySQL\\n- Redis\\n- Nginx: 部署静态资源 + 反向代理\\n- ...\\n\\n其他:\\n- 腾讯云人机验证\\n- 七牛云对象存储\\n- ...\\n\\n### 目录结构\\n\\n> 这里简单列出目录结构，具体可以查看源码\\n\\n代码仓库目录：\\n\\n```bash\\ngin-vue-blog\\n├── gin-blog-admin      -- 博客后台前端\\n├── gin-blog-front      -- 博客前台前端\\n├── gin-blog-server     -- 博客后端\\n├── deploy              -- 部署\\n\\n```\\n\\n> 项目运行参考：[快速开始](#快速开始)\\n\\n后端目录：简略版\\n\\n```bash\\ngin-blog-server\\n├── api             -- API\\n│   ├── front       -- 前台接口\\n│   └── v1          -- 后台接口\\n├── dao             -- 数据库操作模块\\n├── service         -- 服务模块\\n├── model           -- 数据模型\\n│   ├── req             -- 请求 VO 模型\\n│   ├── resp            -- 响应 VO 模型\\n│   ├── dto             -- 内部传输 DTO 模型\\n│   └── ...             -- 数据库模型对象 PO 模型\\n├── routes          -- 路由模块\\n│   └── middleware      -- 路由中间件\\n├── utils           -- 工具模块\\n│   ├── r               -- 响应封装\\n│   ├── upload          -- 文件上传\\n│   └── ...\\n├── routes          -- 路由模块\\n├── config          -- 配置文件\\n├── test            -- 测试模块\\n├── assets          -- 资源文件\\n├── log             -- 存放日志的目录\\n├── public          -- 外部访问的静态资源\\n│   └── uploaded    -- 本地文件上传目录\\n├── Dockerfile\\n└── main.go\\n```\\n\\n前端目录：简略版\\n\\n```\\ngin-vue-admin / gin-vue-front 通用目录结构\\n├── src              \\n│   ├── api             -- 接口\\n│   ├── assets          -- 静态资源\\n│   ├── styles          -- 样式\\n│   ├── components      -- 组件\\n│   ├── composables     -- 组合式函数\\n│   ├── router          -- 路由\\n│   ├── store           -- 状态管理\\n│   ├── utils           -- 工具方法\\n│   ├── views           -- 页面\\n│   ├── App.vue\\n│   └── main.ts\\n├── settings         -- 项目配置\\n├── build            -- 构建相关的配置\\n├── public           -- 公共资源, 在打包后会被加到 dist 根目录\\n├── package.json \\n├── package-lock.json\\n├── index.html\\n├── tsconfig.json\\n├── unocss.config.ts -- unocss 配置\\n└── vite.config.ts   -- vite 配置\\n├── .env             -- 通用环境变量\\n├── .env.development -- 开发环境变量\\n├── .env.production  -- 线上环境变量\\n├── .gitignore\\n├── .editorconfig    -- 编辑器配置\\n```\\n\\n部署目录：简略版\\n\\n```\\ndeploy\\n├── build      -- 镜像构建\\n│   ├── mysql  -- mysql 镜像构建\\n│   ├── server -- 后端镜像构建 (基于 gin-blog-server 目录)\\n│   └── web    -- 前端镜像构建 (基于前端项目打包的静态资源)\\n└── start\\n    ├── docker-compose.yml    -- 多容器管理\\n    └── .env                  -- 环境变量\\n    └── ...\\n```\\n\\n## 环境介绍\\n\\n### 线上环境\\n\\n服务器：腾讯云 2核 4G Ubuntu 22.04 LTS\\n\\n对象存储：七牛云\\n\\n### 开发环境\\n\\n| 开发工具                      | 说明                    |\\n| ----------------------------- | ----------------------- |\\n| Vscode                        | Golang 后端 +  Vue 前端 |\\n| Navicat                       | MySQL 远程连接工具      |\\n| Another Redis Desktop Manager | Redis 远程连接工具      |\\n| MobaXterm                     | Linux 远程工具          |\\n| Apifox                        | 接口调试 + 文档生成     |\\n\\n| 开发环境 | 版本 |\\n| -------- | ---- |\\n| Golang   | 1.19 |\\n| MySQL    | 8.x  |\\n| Redis    | 7.x  |\\n\\n### VsCode 插件\\n\\nTODO: 直接写到 .vscode 文件中, 用 VsCode 打开后自动推荐安装\\n\\n如果使用 Vscode 开发，推荐安装以下插件。\\n\\n前端开发插件：（必备）\\n\\n| 插件 | 作用 |\\n| -------- | ---- |\\n| Volar   | Vue 官方插件 |\\n| UnoCSS | Unocss 官方插件 |\\n| Iconify IntelliSense | Iconify 提示插件 |\\n\\n后端开发插件：（必备）\\n\\n| 插件 | 作用 |\\n| -------- | ---- |\\n| Go | Golang 官方插件 |\\n\\n\\n其他插件：（个人推荐，用于提升开发体验）\\n\\n| 名称 | 作用 |\\n| -------- | ---- |\\n| Better Comments   | 优化代码注释显示效果 |\\n| TODO Highlight | 高亮 TODO |\\n| Highlight Matching Tag | 高亮匹配的标签 | \\n\\n## 快速开始\\n\\n建议下载本项目后，先一键运行起来，查看本项目在本地的运行效果。\\n\\n需要修改源码的话，参考常规运行，前后端分开运行。\\n\\n### 方式一：Docker Compose 一键运行\\n\\n需要安装 Docker 和 Docker Compose, 环境准备可参考 [deploy](https://github.com/szluyu99/gin-vue-blog/tree/main/deploy)\\n\\n```\\n# 拉取项目\\ngit clone https://github.com/szluyu99/gin-vue-blog\\n\\n# 进入 docker-compose 目录\\ncd deploy/start\\n\\n# 一键运行\\ndocker-compose up -d\\n```\\n\\n默认用户：\\n- 管理员 admin 123456\\n- 普通用户 user 123456\\n- 测试用户 test 123456\\n\\n### 方式二：常规运行\\n\\n> 自行安装 Golang、Node、MySQL、Redis 环境\\n\\n需要先运行后端服务，再运行前端项目，因为很多前端配置由后端动态加载（如菜单等）。\\n\\n拉取项目到本地：\\n\\n```bash\\ngit clone https://github.com/szluyu99/gin-vue-blog.git\\n```\\n\\n后端项目运行：\\n\\n```bash\\n# 1、进入后端项目根目录 \\ncd gin-blog-server\\n\\n# 2、修改项目运行的配置文件，默认加载位于 config/config.toml \\n\\n# 3、MySQL 导入 gvb.sql\\n\\n# 4、启动 Redis \\n\\n# 5、运行项目\\ngo mod tidy\\ngo run main.go\\n```\\n\\n数据库中的默认用户：\\n- 管理员 admin 123456\\n- 普通用户 user 123456\\n- 测试用户 test 123456\\n\\n前端项目运行： 本项目使用 pnpm 进行包管理，建议全局安装 pnpm\\n\\n```bash\\nnpm install -g pnpm\\n```\\n\\n前台前端：\\n\\n```bash\\n# 1、进入前台前端项目根目录\\ncd gin-blog-front\\n\\n# 2、安装依赖\\npnpm install\\n\\n# 3、运行项目\\npnpm dev\\n```\\n\\n后台前端：\\n\\n```bash\\n# 1、进入后台前端项目根目录\\ncd gin-blog-admin\\n\\n# 2、安装依赖\\npnpm install\\n\\n# 3、运行项目\\npnpm dev\\n```\\n\\n### 项目部署\\n\\n> 很快就来。保证简单。\\n\\n## 总结鸣谢\\n\\n这个项目不管是前端，还是后端，都是花了比较大心血去架构的，并且从技术选型上，都是选择了目前最火 + 最新的技术栈。当然，这也是个人的学习之作，很多知识点都是边学边开发的（例如 Casbin），这个过程中也参考了很多优秀的开源项目，感谢大家的开源让程序员的世界更加美好，这也是开源本项目的目的之一。本项目中仍有很多不足，后续会继续更新。\\n\\n最后，项目整体代码风格很优秀，注释完善，适合 Golang 后端开发者、前端开发者学习。\\n\\n 鸣谢项目：\\n\\n- [https://butterfly.js.org/](https://butterfly.js.org/)\\n- [https://github.com/flipped-aurora/gin-vue-admin](https://github.com/flipped-aurora/gin-vue-admin)\\n- [https://github.com/qifengzhang007/GinSkeleton](https://github.com/qifengzhang007/GinSkeleton)\\n- [https://github.com/X1192176811/blog](https://github.com/X1192176811/blog)\\n- [https://github.com/zclzone/vue-naive-admin](https://github.com/zclzone/vue-naive-admin)\\n- [https://github.com/antfu/vitesse](https://github.com/antfu/vitesse)\\n- ...\\n\\n> 需要感谢的绝不止以上这些开源项目，但是一时难以全部列出，后面会慢慢补上。\\n\\n## 后续计划\\n\\n高优先级: \\n\\n- ~~完善图片上传功能, 目前文件上传还没怎么处理~~ 🆗\\n- 后台首页重新设计（目前没放什么内容）\\n- ~~前台首页搜索文章（目前使用数据库模糊搜索）~~ 🆗\\n- ~~博客文章导入导出 (.md 文件)~~ 🆗\\n- ~~权限管理中菜单编辑时选择图标（现在只能输入图标字符串）~~ 🆗\\n- 后端日志切割\\n- ~~后台修改背景图片，博客配置等~~ 🆗\\n- ~~后端的 IP 地址检测 BUG 待修复~~ 🆗\\n- ~~博客前台适配移动端~~ 🆗\\n- ~~文章详情, 目录锚点跟随~~ 🆗\\n- 邮箱注册 + 邮件发送验证码\\n\\n后续有空安排上：\\n- 黑夜模式\\n- 前台收缩侧边信息功能\\n- 说说\\n- 相册\\n- 音乐播放器\\n- 鼠标左击特效\\n- 看板娘\\n- 第三方登录: QQ、微信、Github ...\\n- 评论时支持选择表情，参考 Valine\\n- 单独部署：前后端 + 环境\\n- 重写单元测试，目前的单元测试是早期版本，项目架构更改后，无法跑通\\n- 前台首页搜索集成 ElasticSearch\\n- 国际化?\\n\\n其他：\\n- 写一份好的文档\\n- 补全 README.md\\n- 完善 Apifox 生成的接口文档\\n- ~~一键部署：使用 docker compose 单机一键部署整个项目（前后端 + 环境）~~ 🆗\\n\\n## 更新日志\\n\\n描述规范定义，有以下几种行为 ACTION:\\n- `FIX`: 修复\\n- `REFINE`: 优化\\n- `COMPLETE`: 完善\\n- `ADD`: 新增\\n\\n---\\n\\n2022-12-23:\\n\\n博客部署:\\n- 新增 deploy 子模块, 使用 docker-compose 一键运行前后端 ⭐⭐\\n\\n---\\n\\n2022-12-22:\\n\\n博客部署:\\n- 修复 线上图片上传问题, 本地上传则采用 Nginx 反向代理 Gin 的静态服务资源, 也可采用七牛云存储\\n\\n---\\n\\n2022-12-21:\\n\\n博客后台:\\n- 新增 图标选择组件, 选择范围为自定义图标数组 ⭐\\n\\n---\\n\\n2022-12-20:\\n\\n博客后台: \\n- 完善 IP 检测工具 ⭐\\n- 修复 Nginx 获取的客户端 IP 是服务器 IP (docker 部署 Nginx 的问题, 修改 Nginx 配置文件即可)\\n\\n---\\n\\n2022-12-19:\\n\\n博客后台:\\n- 添加简易版黑夜模式 (一行 CSS 实现)\\n\\n---\\n\\n2022-12-17:\\n\\n博客后台:\\n- 新增 文章导入、导出 ⭐\\n\\n---\\n\\n2022-12-16:\\n\\n博客后台:\\n- 修复 MySQL 无法存储 emoji 的问题，设置 utf8mb4 字符集编码，更新 SQL \\n- 完善 添加文章时选择标签的逻辑\\n- 新增 全屏水印 功能\\n\\n---\\n\\n2022-12-15:\\n\\n博客后台：\\n- 优化 菜单栏和标签栏，点击标签自动展开对应菜单，点击菜单自动滚动到显示对应标签 ⭐\\n- 优化 使用响应式语法糖重构代码\\n- 优化 代码结构 + 注释\\n\\n---\\n\\n2022-12-14:\\n\\n博客前台：\\n- 优化 代码，去除 n-card 组件，使用自定义 css 实现卡片视图\\n- 优化 对滚动的监听操作，添加节流函数，提升性能 ⭐\\n- 优化 文章目录，根据当前滚动条自动高亮锚点 ⭐⭐\\n- 新增 vite 打包优化相关插件\\n\\n---\\n\\n2022-12-13:\\n\\n项目部署：\\n- 新增 Nginx 配置 https 访问域名 (http 自动跳转到 https) ⭐\\n- 新增 七牛云添加加速域名访问图片资源\\n\\n博客后端：\\n- 新增 文章搜索接口（数据库模糊查询）\\n\\n博客前台：\\n- 新增 导航栏的文章搜索\\n\\n---\\n\\n2022-12-12:\\n\\n博客前台：\\n- 新增 适配移动端 ⭐⭐\\n- 优化 删除 Vuetify 相关组件及依赖 (css 样式存在冲突)，统一使用 naive-ui\\n- 优化 使用 `$ref` 语法糖功能重构页面\\n\\n---\\n\\n2022-12-09:\\n\\n博客前台：\\n- 完善 个人中心的头像上传（注意头像上传需要 Token）\\n- 优化 重构通用页面的代码 ⭐\\n\\n---\\n\\n2022-12-08:\\n\\n博客后端：\\n- 新增 页面模块 的接口 ⭐\\n- 修复 单元测试无法初始化全局变量（flag 包冲突）问题\\n\\n博客后台：\\n- 新增 pinia 数据持久化，防止刷新丢失数据 ⭐\\n- 新增 页面管理页面，动态配置前台显示的封面 ⭐\\n\\n博客前台：\\n- 新增 页面根据 `label` 从后端数据中加载封面 ⭐\\n- 优化 尝试性使用 `$ref` 语法糖功能\\n\\n---\\n\\n2022-12-07:\\n\\n博客后台：\\n- 修复 博客后台，动态加载路由模块导致的热加载失效问题 ⭐⭐\\n- 完善 文件上传，抽取出单独的组件 ⭐⭐\\n- 新增 个人信息页面 ⭐\\n- 优化 发布文章/查看文章 时的文章标签选择、分类选择\\n- 修复 发布文章/查看文章 页面数据加载错误\",\"img\":\"https://static.talkxj.com/articles/771941739cbc70fbe40e10cf441e02e5.jpg\",\"category_name\":\"后端\",\"tag_names\":[\"Golang\",\"Vue\"],\"type\":1,\"original_url\":\"\",\"is_top\":0,\"status\":1}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '172.12.0.1', '美国'),
       (60, '2022-12-24 12:04:14', '2022-12-24 12:04:14', '文章', '新增或修改',
        'gin-blog/api/v1.(*Article).SaveOrUpdate-fm', '/api/article', '新增或修改文章',
        '{\"id\":1,\"title\":\"项目介绍\",\"desc\":\"\",\"content\":\"## 博客介绍\\n\\n<p align=center>\\n<a href=\\\"http://www.hahacode.cn\\\">\\n<img src=\\\"https://img-blog.csdnimg.cn/fe2f1034cf7c4bd795552d47373ee405.jpeg\\\"  width=\\\"200\\\" hight=\\\"200\\\" alt=\\\"阵、雨的个人博客\\\" style=\\\"border-radius: 50%\\\">\\n</a>\\n</p>\\n\\n<p align=\\\"center\\\">\\n   <a target=\\\"_blank\\\" href=\\\"#\\\">\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/Go-1.19-blue\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/Gin-v1.8.1-blue\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/Casbin-v2.56.0-blue\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/mysql-8.0-blue\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/GORM-v1.24.0-blue\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/redis-7.0-red\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/vue-v3.X-green\\\"/>\\n    </a>\\n</p>\\n\\n[在线预览](#在线预览) | [项目介绍](#项目介绍) | [技术介绍](#技术介绍) | [目录结构](#目录结构) | [环境介绍](#环境介绍) | [快速开始](#快速开始) | [总结&鸣谢](#总结鸣谢)  | [后续计划](#后续计划) | [更新日志](#更新日志)\\n\\n您的 Star 是我坚持的动力，感谢大家的支持，欢迎提交 Pr 共同改进项目。\\n\\nGithub 地址：[https://github.com/szluyu99/gin-vue-blog](https://github.com/szluyu99/gin-vue-blog)\\n\\nGitee 地址：[https://gitee.com/szluyu99/gin-vue-blog](https://gitee.com/szluyu99/gin-vue-blog)\\n\\n\\n## 在线预览\\n\\n博客前台链接：[hahacode.cn](https://www.hahacode.cn)（已适配移动端）\\n\\n博客后台链接：[hahacode.cn/blog-admin](https://www.hahacode.cn/blog-admin)（暂未专门适配移动端）\\n\\n> 博客域名已通过备案，且配置 SSL，通过 https 访问\\n\\n测试账号：test@qq.com，密码：11111，前后台都可用这个账号登录\\n\\n在线接口文档地址：[doc.hahacode.cn](http://doc.hahacode.cn/)\\n\\n> 本项目在线接口文档由 Apifox 生成，由于项目架构调整，有些接口待完善和修改\\n>\\n> 由于一开始不会用，接口文档生成的信息不全（如返回响应、响应示例），后续完善\\n\\n以下放几张简单的预览图，强烈建议点击上面的[预览链接](#在线预览)进去体验下：\\n\\n![前台首页图片](https://img-blog.csdnimg.cn/fd25f0e52cdc467893925a48d0d66662.png)\\n\\n![前台首页文章列表](https://img-blog.csdnimg.cn/005cee463d3c4e729a1dd7bbee41e963.png)\\n\\n![后台文章列表](https://img-blog.csdnimg.cn/18c39f63b7b64f7bbd2a4ab764552d13.png)\\n\\n\\n## 项目介绍\\n\\nGithub 上有很多优秀的前后台框架，本项目也参考了许多开源项目，但是大多项目都比较重量级（并非坏处），如果从学习的角度来看对初学者并不是很友好。本项目在以**博客**这个业务为主的前提下，提供一个完整的全栈项目代码（前台前端 + 后台前端 + 后端），技术点基本都是最新 + 最火的技术，代码轻量级，注释完善，适合学习。\\n\\n同时，本项目可用于一键搭建动态博客（参考 [快速开始](#快速开始)），会尽可能多的将前端许多栏目做成后台可动态配置的形式。\\n\\n前台：\\n- 前台界面设计参考 Hexo 的 Butterfly 设计，美观简洁\\n- 响应式布局，适配了移动端\\n- 实现点赞，统计用户等功能 (Redis)\\n- 评论 + 回复评论功能\\n- 留言采用弹幕墙，效果炫酷\\n- 文章详情页有文章目录、推荐文章等功能，优化用户体验\\n\\n后台：\\n- 鉴权使用 JWT\\n- 权限管理使用 CASBIN，实现基于 RBAC 的权限管理\\n- 支持动态权限修改，前端菜单由后端生成（动态路由）\\n- 文章编辑使用 Markdown 编辑器\\n- 常规后台功能齐全：侧边栏、面包屑、标签栏等\\n- 实现记录操作日志功能（GET 不记录）\\n- 实现监听在线用户、强制下线功能\\n- 文件上传支持七牛云、本地（后续计划支持更多）\\n- 对 CRUD 操作封装了通用 Hook\\n\\n其他：\\n- 采用 Restful 风格的 API\\n- 前后端分离部署，前端使用 Nginx，后端使用 Docker\\n- 代码整洁层次清晰，利于开发者学习\\n- 技术点新颖，代码轻量级，适度封装\\n- Docker Compose 一键运行，轻松搭建在线博客\\n\\n### 技术介绍\\n\\n> 这里只写一些主流的通用技术，详细第三方库：前端参考 `package.json` 文件，后端参考 `go.mod` 文件\\n\\n前端技术栈: 使用 pnpm 包管理工具\\n- 基于 TypeScript\\n- Vue3\\n- VueUse: 服务于 Vue Composition API 的工具集\\n- Unocss: 原子化 CSS\\n- Pinia\\n- Vue Router \\n- Axios \\n- Naive UI\\n- ...\\n\\n后端技术栈:\\n- Golang\\n- Docker\\n- Gin\\n- GORM\\n- Viper: 支持 TOML (默认)、YAML 等常用格式作为配置文件\\n- Casbin\\n- Zap\\n- MySQL\\n- Redis\\n- Nginx: 部署静态资源 + 反向代理\\n- ...\\n\\n其他:\\n- 腾讯云人机验证\\n- 七牛云对象存储\\n- ...\\n\\n### 目录结构\\n\\n> 这里简单列出目录结构，具体可以查看源码\\n\\n代码仓库目录：\\n\\n```bash\\ngin-vue-blog\\n├── gin-blog-admin      -- 博客后台前端\\n├── gin-blog-front      -- 博客前台前端\\n├── gin-blog-server     -- 博客后端\\n├── deploy              -- 部署\\n\\n```\\n\\n> 项目运行参考：[快速开始](#快速开始)\\n\\n后端目录：简略版\\n\\n```bash\\ngin-blog-server\\n├── api             -- API\\n│   ├── front       -- 前台接口\\n│   └── v1          -- 后台接口\\n├── dao             -- 数据库操作模块\\n├── service         -- 服务模块\\n├── model           -- 数据模型\\n│   ├── req             -- 请求 VO 模型\\n│   ├── resp            -- 响应 VO 模型\\n│   ├── dto             -- 内部传输 DTO 模型\\n│   └── ...             -- 数据库模型对象 PO 模型\\n├── routes          -- 路由模块\\n│   └── middleware      -- 路由中间件\\n├── utils           -- 工具模块\\n│   ├── r               -- 响应封装\\n│   ├── upload          -- 文件上传\\n│   └── ...\\n├── routes          -- 路由模块\\n├── config          -- 配置文件\\n├── test            -- 测试模块\\n├── assets          -- 资源文件\\n├── log             -- 存放日志的目录\\n├── public          -- 外部访问的静态资源\\n│   └── uploaded    -- 本地文件上传目录\\n├── Dockerfile\\n└── main.go\\n```\\n\\n前端目录：简略版\\n\\n```\\ngin-vue-admin / gin-vue-front 通用目录结构\\n├── src              \\n│   ├── api             -- 接口\\n│   ├── assets          -- 静态资源\\n│   ├── styles          -- 样式\\n│   ├── components      -- 组件\\n│   ├── composables     -- 组合式函数\\n│   ├── router          -- 路由\\n│   ├── store           -- 状态管理\\n│   ├── utils           -- 工具方法\\n│   ├── views           -- 页面\\n│   ├── App.vue\\n│   └── main.ts\\n├── settings         -- 项目配置\\n├── build            -- 构建相关的配置\\n├── public           -- 公共资源, 在打包后会被加到 dist 根目录\\n├── package.json \\n├── package-lock.json\\n├── index.html\\n├── tsconfig.json\\n├── unocss.config.ts -- unocss 配置\\n└── vite.config.ts   -- vite 配置\\n├── .env             -- 通用环境变量\\n├── .env.development -- 开发环境变量\\n├── .env.production  -- 线上环境变量\\n├── .gitignore\\n├── .editorconfig    -- 编辑器配置\\n```\\n\\n部署目录：简略版\\n\\n```\\ndeploy\\n├── build      -- 镜像构建\\n│   ├── mysql  -- mysql 镜像构建\\n│   ├── server -- 后端镜像构建 (基于 gin-blog-server 目录)\\n│   └── web    -- 前端镜像构建 (基于前端项目打包的静态资源)\\n└── start\\n    ├── docker-compose.yml    -- 多容器管理\\n    └── .env                  -- 环境变量\\n    └── ...\\n```\\n\\n## 环境介绍\\n\\n### 线上环境\\n\\n服务器：腾讯云 2核 4G Ubuntu 22.04 LTS\\n\\n对象存储：七牛云\\n\\n### 开发环境\\n\\n| 开发工具                      | 说明                    |\\n| ----------------------------- | ----------------------- |\\n| Vscode                        | Golang 后端 +  Vue 前端 |\\n| Navicat                       | MySQL 远程连接工具      |\\n| Another Redis Desktop Manager | Redis 远程连接工具      |\\n| MobaXterm                     | Linux 远程工具          |\\n| Apifox                        | 接口调试 + 文档生成     |\\n\\n| 开发环境 | 版本 |\\n| -------- | ---- |\\n| Golang   | 1.19 |\\n| MySQL    | 8.x  |\\n| Redis    | 7.x  |\\n\\n### VsCode 插件\\n\\nTODO: 直接写到 .vscode 文件中, 用 VsCode 打开后自动推荐安装\\n\\n如果使用 Vscode 开发，推荐安装以下插件。\\n\\n前端开发插件：（必备）\\n\\n| 插件 | 作用 |\\n| -------- | ---- |\\n| Volar   | Vue 官方插件 |\\n| UnoCSS | Unocss 官方插件 |\\n| Iconify IntelliSense | Iconify 提示插件 |\\n\\n后端开发插件：（必备）\\n\\n| 插件 | 作用 |\\n| -------- | ---- |\\n| Go | Golang 官方插件 |\\n\\n\\n其他插件：（个人推荐，用于提升开发体验）\\n\\n| 名称 | 作用 |\\n| -------- | ---- |\\n| Better Comments   | 优化代码注释显示效果 |\\n| TODO Highlight | 高亮 TODO |\\n| Highlight Matching Tag | 高亮匹配的标签 | \\n\\n## 快速开始\\n\\n建议下载本项目后，先一键运行起来，查看本项目在本地的运行效果。\\n\\n需要修改源码的话，参考常规运行，前后端分开运行。\\n\\n### 方式一：Docker Compose 一键运行\\n\\n需要安装 Docker 和 Docker Compose, 环境准备可参考 [deploy](https://github.com/szluyu99/gin-vue-blog/tree/main/deploy)\\n\\n```\\n# 拉取项目\\ngit clone https://github.com/szluyu99/gin-vue-blog\\n\\n# 进入 docker-compose 目录\\ncd deploy/start\\n\\n# 一键运行\\ndocker-compose up -d\\n```\\n\\n默认用户：\\n- 管理员 admin 123456\\n- 普通用户 user 123456\\n- 测试用户 test 123456\\n\\n### 方式二：常规运行\\n\\n> 自行安装 Golang、Node、MySQL、Redis 环境\\n\\n需要先运行后端服务，再运行前端项目，因为很多前端配置由后端动态加载（如菜单等）。\\n\\n拉取项目到本地：\\n\\n```bash\\ngit clone https://github.com/szluyu99/gin-vue-blog.git\\n```\\n\\n后端项目运行：\\n\\n```bash\\n# 1、进入后端项目根目录 \\ncd gin-blog-server\\n\\n# 2、修改项目运行的配置文件，默认加载位于 config/config.toml \\n\\n# 3、MySQL 导入 gvb.sql\\n\\n# 4、启动 Redis \\n\\n# 5、运行项目\\ngo mod tidy\\ngo run main.go\\n```\\n\\n数据库中的默认用户：\\n- 管理员 admin 123456\\n- 普通用户 user 123456\\n- 测试用户 test 123456\\n\\n前端项目运行： 本项目使用 pnpm 进行包管理，建议全局安装 pnpm\\n\\n```bash\\nnpm install -g pnpm\\n```\\n\\n前台前端：\\n\\n```bash\\n# 1、进入前台前端项目根目录\\ncd gin-blog-front\\n\\n# 2、安装依赖\\npnpm install\\n\\n# 3、运行项目\\npnpm dev\\n```\\n\\n后台前端：\\n\\n```bash\\n# 1、进入后台前端项目根目录\\ncd gin-blog-admin\\n\\n# 2、安装依赖\\npnpm install\\n\\n# 3、运行项目\\npnpm dev\\n```\\n\\n### 项目部署\\n\\n> 很快就来。保证简单。\\n\\n## 总结鸣谢\\n\\n这个项目不管是前端，还是后端，都是花了比较大心血去架构的，并且从技术选型上，都是选择了目前最火 + 最新的技术栈。当然，这也是个人的学习之作，很多知识点都是边学边开发的（例如 Casbin），这个过程中也参考了很多优秀的开源项目，感谢大家的开源让程序员的世界更加美好，这也是开源本项目的目的之一。本项目中仍有很多不足，后续会继续更新。\\n\\n最后，项目整体代码风格很优秀，注释完善，适合 Golang 后端开发者、前端开发者学习。\\n\\n 鸣谢项目：\\n\\n- [https://butterfly.js.org/](https://butterfly.js.org/)\\n- [https://github.com/flipped-aurora/gin-vue-admin](https://github.com/flipped-aurora/gin-vue-admin)\\n- [https://github.com/qifengzhang007/GinSkeleton](https://github.com/qifengzhang007/GinSkeleton)\\n- [https://github.com/X1192176811/blog](https://github.com/X1192176811/blog)\\n- [https://github.com/zclzone/vue-naive-admin](https://github.com/zclzone/vue-naive-admin)\\n- [https://github.com/antfu/vitesse](https://github.com/antfu/vitesse)\\n- ...\\n\\n> 需要感谢的绝不止以上这些开源项目，但是一时难以全部列出，后面会慢慢补上。\\n\\n## 后续计划\\n\\n高优先级: \\n\\n- ~~完善图片上传功能, 目前文件上传还没怎么处理~~ 🆗\\n- 后台首页重新设计（目前没放什么内容）\\n- ~~前台首页搜索文章（目前使用数据库模糊搜索）~~ 🆗\\n- ~~博客文章导入导出 (.md 文件)~~ 🆗\\n- ~~权限管理中菜单编辑时选择图标（现在只能输入图标字符串）~~ 🆗\\n- 后端日志切割\\n- ~~后台修改背景图片，博客配置等~~ 🆗\\n- ~~后端的 IP 地址检测 BUG 待修复~~ 🆗\\n- ~~博客前台适配移动端~~ 🆗\\n- ~~文章详情, 目录锚点跟随~~ 🆗\\n- 邮箱注册 + 邮件发送验证码\\n\\n后续有空安排上：\\n- 黑夜模式\\n- 前台收缩侧边信息功能\\n- 说说\\n- 相册\\n- 音乐播放器\\n- 鼠标左击特效\\n- 看板娘\\n- 第三方登录: QQ、微信、Github ...\\n- 评论时支持选择表情，参考 Valine\\n- 单独部署：前后端 + 环境\\n- 重写单元测试，目前的单元测试是早期版本，项目架构更改后，无法跑通\\n- 前台首页搜索集成 ElasticSearch\\n- 国际化?\\n\\n其他：\\n- 写一份好的文档\\n- 补全 README.md\\n- 完善 Apifox 生成的接口文档\\n- ~~一键部署：使用 docker compose 单机一键部署整个项目（前后端 + 环境）~~ 🆗\\n\\n## 更新日志\\n\\n描述规范定义，有以下几种行为 ACTION:\\n- `FIX`: 修复\\n- `REFINE`: 优化\\n- `COMPLETE`: 完善\\n- `ADD`: 新增\\n\\n---\\n\\n2022-12-23:\\n\\n博客部署:\\n- 新增 deploy 子模块, 使用 docker-compose 一键运行前后端 ⭐⭐\\n\\n---\\n\\n2022-12-22:\\n\\n博客部署:\\n- 修复 线上图片上传问题, 本地上传则采用 Nginx 反向代理 Gin 的静态服务资源, 也可采用七牛云存储\\n\\n---\\n\\n2022-12-21:\\n\\n博客后台:\\n- 新增 图标选择组件, 选择范围为自定义图标数组 ⭐\\n\\n---\\n\\n2022-12-20:\\n\\n博客后台: \\n- 完善 IP 检测工具 ⭐\\n- 修复 Nginx 获取的客户端 IP 是服务器 IP (docker 部署 Nginx 的问题, 修改 Nginx 配置文件即可)\\n\\n---\\n\\n2022-12-19:\\n\\n博客后台:\\n- 添加简易版黑夜模式 (一行 CSS 实现)\\n\\n---\\n\\n2022-12-17:\\n\\n博客后台:\\n- 新增 文章导入、导出 ⭐\\n\\n---\\n\\n2022-12-16:\\n\\n博客后台:\\n- 修复 MySQL 无法存储 emoji 的问题，设置 utf8mb4 字符集编码，更新 SQL \\n- 完善 添加文章时选择标签的逻辑\\n- 新增 全屏水印 功能\\n\\n---\\n\\n2022-12-15:\\n\\n博客后台：\\n- 优化 菜单栏和标签栏，点击标签自动展开对应菜单，点击菜单自动滚动到显示对应标签 ⭐\\n- 优化 使用响应式语法糖重构代码\\n- 优化 代码结构 + 注释\\n\\n---\\n\\n2022-12-14:\\n\\n博客前台：\\n- 优化 代码，去除 n-card 组件，使用自定义 css 实现卡片视图\\n- 优化 对滚动的监听操作，添加节流函数，提升性能 ⭐\\n- 优化 文章目录，根据当前滚动条自动高亮锚点 ⭐⭐\\n- 新增 vite 打包优化相关插件\\n\\n---\\n\\n2022-12-13:\\n\\n项目部署：\\n- 新增 Nginx 配置 https 访问域名 (http 自动跳转到 https) ⭐\\n- 新增 七牛云添加加速域名访问图片资源\\n\\n博客后端：\\n- 新增 文章搜索接口（数据库模糊查询）\\n\\n博客前台：\\n- 新增 导航栏的文章搜索\\n\\n---\\n\\n2022-12-12:\\n\\n博客前台：\\n- 新增 适配移动端 ⭐⭐\\n- 优化 删除 Vuetify 相关组件及依赖 (css 样式存在冲突)，统一使用 naive-ui\\n- 优化 使用 `$ref` 语法糖功能重构页面\\n\\n---\\n\\n2022-12-09:\\n\\n博客前台：\\n- 完善 个人中心的头像上传（注意头像上传需要 Token）\\n- 优化 重构通用页面的代码 ⭐\\n\\n---\\n\\n2022-12-08:\\n\\n博客后端：\\n- 新增 页面模块 的接口 ⭐\\n- 修复 单元测试无法初始化全局变量（flag 包冲突）问题\\n\\n博客后台：\\n- 新增 pinia 数据持久化，防止刷新丢失数据 ⭐\\n- 新增 页面管理页面，动态配置前台显示的封面 ⭐\\n\\n博客前台：\\n- 新增 页面根据 `label` 从后端数据中加载封面 ⭐\\n- 优化 尝试性使用 `$ref` 语法糖功能\\n\\n---\\n\\n2022-12-07:\\n\\n博客后台：\\n- 修复 博客后台，动态加载路由模块导致的热加载失效问题 ⭐⭐\\n- 完善 文件上传，抽取出单独的组件 ⭐⭐\\n- 新增 个人信息页面 ⭐\\n- 优化 发布文章/查看文章 时的文章标签选择、分类选择\\n- 修复 发布文章/查看文章 页面数据加载错误\",\"img\":\"https://static.talkxj.com/articles/771941739cbc70fbe40e10cf441e02e5.jpg\",\"category_name\":\"后端\",\"tag_names\":[\"Golang\",\"Vue\"],\"type\":1,\"original_url\":\"\",\"is_top\":0,\"status\":1}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '172.12.0.1', '美国'),
       (61, '2022-12-24 12:04:59', '2022-12-24 12:04:59', '文章', '新增或修改',
        'gin-blog/api/v1.(*Article).SaveOrUpdate-fm', '/api/article', '新增或修改文章',
        '{\"id\":1,\"title\":\"项目介绍\",\"desc\":\"\",\"content\":\"## 博客介绍\\n\\n<p align=center>\\n<a href=\\\"http://www.hahacode.cn\\\">\\n<img src=\\\"https://img-blog.csdnimg.cn/fe2f1034cf7c4bd795552d47373ee405.jpeg\\\"  width=\\\"200\\\" hight=\\\"200\\\" alt=\\\"阵、雨的个人博客\\\" style=\\\"border-radius: 50%\\\">\\n</a>\\n</p>\\n\\n<p align=\\\"center\\\">\\n   <a target=\\\"_blank\\\" href=\\\"#\\\">\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/Go-1.19-blue\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/Gin-v1.8.1-blue\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/Casbin-v2.56.0-blue\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/mysql-8.0-blue\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/GORM-v1.24.0-blue\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/redis-7.0-red\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/vue-v3.X-green\\\"/>\\n    </a>\\n</p>\\n\\n[在线预览](#在线预览) | [项目介绍](#项目介绍) | [技术介绍](#技术介绍) | [目录结构](#目录结构) | [环境介绍](#环境介绍) | [快速开始](#快速开始) | [总结&鸣谢](#总结鸣谢)  | [后续计划](#后续计划) | [更新日志](#更新日志)\\n\\n您的 Star 是我坚持的动力，感谢大家的支持，欢迎提交 Pr 共同改进项目。\\n\\nGithub 地址：[https://github.com/szluyu99/gin-vue-blog](https://github.com/szluyu99/gin-vue-blog)\\n\\nGitee 地址：[https://gitee.com/szluyu99/gin-vue-blog](https://gitee.com/szluyu99/gin-vue-blog)\\n\\n\\n## 在线预览\\n\\n博客前台链接：[hahacode.cn](https://www.hahacode.cn)（已适配移动端）\\n\\n博客后台链接：[hahacode.cn/blog-admin](https://www.hahacode.cn/blog-admin)（暂未专门适配移动端）\\n\\n> 博客域名已通过备案，且配置 SSL，通过 https 访问\\n\\n测试账号：test@qq.com，密码：11111，前后台都可用这个账号登录\\n\\n在线接口文档地址：[doc.hahacode.cn](http://doc.hahacode.cn/)\\n\\n> 本项目在线接口文档由 Apifox 生成，由于项目架构调整，有些接口待完善和修改\\n>\\n> 由于一开始不会用，接口文档生成的信息不全（如返回响应、响应示例），后续完善\\n\\n以下放几张简单的预览图，强烈建议点击上面的[预览链接](#在线预览)进去体验下：\\n\\n![前台首页图片](https://img-blog.csdnimg.cn/fd25f0e52cdc467893925a48d0d66662.png)\\n\\n![前台首页文章列表](https://img-blog.csdnimg.cn/005cee463d3c4e729a1dd7bbee41e963.png)\\n\\n![后台文章列表](https://img-blog.csdnimg.cn/18c39f63b7b64f7bbd2a4ab764552d13.png)\\n\\n\\n## 项目介绍\\n\\nGithub 上有很多优秀的前后台框架，本项目也参考了许多开源项目，但是大多项目都比较重量级（并非坏处），如果从学习的角度来看对初学者并不是很友好。本项目在以**博客**这个业务为主的前提下，提供一个完整的全栈项目代码（前台前端 + 后台前端 + 后端），技术点基本都是最新 + 最火的技术，代码轻量级，注释完善，适合学习。\\n\\n同时，本项目可用于一键搭建动态博客（参考 [快速开始](#快速开始)），会尽可能多的将前端许多栏目做成后台可动态配置的形式。\\n\\n前台：\\n- 前台界面设计参考 Hexo 的 Butterfly 设计，美观简洁\\n- 响应式布局，适配了移动端\\n- 实现点赞，统计用户等功能 (Redis)\\n- 评论 + 回复评论功能\\n- 留言采用弹幕墙，效果炫酷\\n- 文章详情页有文章目录、推荐文章等功能，优化用户体验\\n\\n后台：\\n- 鉴权使用 JWT\\n- 权限管理使用 CASBIN，实现基于 RBAC 的权限管理\\n- 支持动态权限修改，前端菜单由后端生成（动态路由）\\n- 文章编辑使用 Markdown 编辑器\\n- 常规后台功能齐全：侧边栏、面包屑、标签栏等\\n- 实现记录操作日志功能（GET 不记录）\\n- 实现监听在线用户、强制下线功能\\n- 文件上传支持七牛云、本地（后续计划支持更多）\\n- 对 CRUD 操作封装了通用 Hook\\n\\n其他：\\n- 采用 Restful 风格的 API\\n- 前后端分离部署，前端使用 Nginx，后端使用 Docker\\n- 代码整洁层次清晰，利于开发者学习\\n- 技术点新颖，代码轻量级，适度封装\\n- Docker Compose 一键运行，轻松搭建在线博客\\n\\n### 技术介绍\\n\\n> 这里只写一些主流的通用技术，详细第三方库：前端参考 `package.json` 文件，后端参考 `go.mod` 文件\\n\\n前端技术栈: 使用 pnpm 包管理工具\\n- 基于 TypeScript\\n- Vue3\\n- VueUse: 服务于 Vue Composition API 的工具集\\n- Unocss: 原子化 CSS\\n- Pinia\\n- Vue Router \\n- Axios \\n- Naive UI\\n- ...\\n\\n后端技术栈:\\n- Golang\\n- Docker\\n- Gin\\n- GORM\\n- Viper: 支持 TOML (默认)、YAML 等常用格式作为配置文件\\n- Casbin\\n- Zap\\n- MySQL\\n- Redis\\n- Nginx: 部署静态资源 + 反向代理\\n- ...\\n\\n其他:\\n- 腾讯云人机验证\\n- 七牛云对象存储\\n- ...\\n\\n### 目录结构\\n\\n> 这里简单列出目录结构，具体可以查看源码\\n\\n代码仓库目录：\\n\\n```bash\\ngin-vue-blog\\n├── gin-blog-admin      -- 博客后台前端\\n├── gin-blog-front      -- 博客前台前端\\n├── gin-blog-server     -- 博客后端\\n├── deploy              -- 部署\\n\\n```\\n\\n> 项目运行参考：[快速开始](#快速开始)\\n\\n后端目录：简略版\\n\\n```bash\\ngin-blog-server\\n├── api             -- API\\n│   ├── front       -- 前台接口\\n│   └── v1          -- 后台接口\\n├── dao             -- 数据库操作模块\\n├── service         -- 服务模块\\n├── model           -- 数据模型\\n│   ├── req             -- 请求 VO 模型\\n│   ├── resp            -- 响应 VO 模型\\n│   ├── dto             -- 内部传输 DTO 模型\\n│   └── ...             -- 数据库模型对象 PO 模型\\n├── routes          -- 路由模块\\n│   └── middleware      -- 路由中间件\\n├── utils           -- 工具模块\\n│   ├── r               -- 响应封装\\n│   ├── upload          -- 文件上传\\n│   └── ...\\n├── routes          -- 路由模块\\n├── config          -- 配置文件\\n├── test            -- 测试模块\\n├── assets          -- 资源文件\\n├── log             -- 存放日志的目录\\n├── public          -- 外部访问的静态资源\\n│   └── uploaded    -- 本地文件上传目录\\n├── Dockerfile\\n└── main.go\\n```\\n\\n前端目录：简略版\\n\\n```\\ngin-vue-admin / gin-vue-front 通用目录结构\\n├── src              \\n│   ├── api             -- 接口\\n│   ├── assets          -- 静态资源\\n│   ├── styles          -- 样式\\n│   ├── components      -- 组件\\n│   ├── composables     -- 组合式函数\\n│   ├── router          -- 路由\\n│   ├── store           -- 状态管理\\n│   ├── utils           -- 工具方法\\n│   ├── views           -- 页面\\n│   ├── App.vue\\n│   └── main.ts\\n├── settings         -- 项目配置\\n├── build            -- 构建相关的配置\\n├── public           -- 公共资源, 在打包后会被加到 dist 根目录\\n├── package.json \\n├── package-lock.json\\n├── index.html\\n├── tsconfig.json\\n├── unocss.config.ts -- unocss 配置\\n└── vite.config.ts   -- vite 配置\\n├── .env             -- 通用环境变量\\n├── .env.development -- 开发环境变量\\n├── .env.production  -- 线上环境变量\\n├── .gitignore\\n├── .editorconfig    -- 编辑器配置\\n```\\n\\n部署目录：简略版\\n\\n```\\ndeploy\\n├── build      -- 镜像构建\\n│   ├── mysql  -- mysql 镜像构建\\n│   ├── server -- 后端镜像构建 (基于 gin-blog-server 目录)\\n│   └── web    -- 前端镜像构建 (基于前端项目打包的静态资源)\\n└── start\\n    ├── docker-compose.yml    -- 多容器管理\\n    └── .env                  -- 环境变量\\n    └── ...\\n```\\n\\n## 环境介绍\\n\\n### 线上环境\\n\\n服务器：腾讯云 2核 4G Ubuntu 22.04 LTS\\n\\n对象存储：七牛云\\n\\n### 开发环境\\n\\n| 开发工具                      | 说明                    |\\n| ----------------------------- | ----------------------- |\\n| Vscode                        | Golang 后端 +  Vue 前端 |\\n| Navicat                       | MySQL 远程连接工具      |\\n| Another Redis Desktop Manager | Redis 远程连接工具      |\\n| MobaXterm                     | Linux 远程工具          |\\n| Apifox                        | 接口调试 + 文档生成     |\\n\\n| 开发环境 | 版本 |\\n| -------- | ---- |\\n| Golang   | 1.19 |\\n| MySQL    | 8.x  |\\n| Redis    | 7.x  |\\n\\n### VsCode 插件\\n\\nTODO: 直接写到 .vscode 文件中, 用 VsCode 打开后自动推荐安装\\n\\n如果使用 Vscode 开发，推荐安装以下插件。\\n\\n前端开发插件：（必备）\\n\\n| 插件 | 作用 |\\n| -------- | ---- |\\n| Volar   | Vue 官方插件 |\\n| UnoCSS | Unocss 官方插件 |\\n| Iconify IntelliSense | Iconify 提示插件 |\\n\\n后端开发插件：（必备）\\n\\n| 插件 | 作用 |\\n| -------- | ---- |\\n| Go | Golang 官方插件 |\\n\\n\\n其他插件：（个人推荐，用于提升开发体验）\\n\\n| 名称 | 作用 |\\n| -------- | ---- |\\n| Better Comments   | 优化代码注释显示效果 |\\n| TODO Highlight | 高亮 TODO |\\n| Highlight Matching Tag | 高亮匹配的标签 | \\n\\n## 快速开始\\n\\n建议下载本项目后，先一键运行起来，查看本项目在本地的运行效果。\\n\\n需要修改源码的话，参考常规运行，前后端分开运行。\\n\\n### 方式一：Docker Compose 一键运行\\n\\n需要安装 Docker 和 Docker Compose, 环境准备可参考 [deploy](https://github.com/szluyu99/gin-vue-blog/tree/main/deploy)\\n\\n```\\n# 拉取项目\\ngit clone https://github.com/szluyu99/gin-vue-blog\\n\\n# 进入 docker-compose 目录\\ncd deploy/start\\n\\n# 一键运行\\ndocker-compose up -d\\n```\\n\\n默认用户：\\n- 管理员 admin 123456\\n- 普通用户 user 123456\\n- 测试用户 test 123456\\n\\n### 方式二：常规运行\\n\\n> 自行安装 Golang、Node、MySQL、Redis 环境\\n\\n需要先运行后端服务，再运行前端项目，因为很多前端配置由后端动态加载（如菜单等）。\\n\\n拉取项目到本地：\\n\\n```bash\\ngit clone https://github.com/szluyu99/gin-vue-blog.git\\n```\\n\\n后端项目运行：\\n\\n```bash\\n# 1、进入后端项目根目录 \\ncd gin-blog-server\\n\\n# 2、修改项目运行的配置文件，默认加载位于 config/config.toml \\n\\n# 3、MySQL 导入 gvb.sql\\n\\n# 4、启动 Redis \\n\\n# 5、运行项目\\ngo mod tidy\\ngo run main.go\\n```\\n\\n数据库中的默认用户：\\n- 管理员 admin 123456\\n- 普通用户 user 123456\\n- 测试用户 test 123456\\n\\n前端项目运行： 本项目使用 pnpm 进行包管理，建议全局安装 pnpm\\n\\n```bash\\nnpm install -g pnpm\\n```\\n\\n前台前端：\\n\\n```bash\\n# 1、进入前台前端项目根目录\\ncd gin-blog-front\\n\\n# 2、安装依赖\\npnpm install\\n\\n# 3、运行项目\\npnpm dev\\n```\\n\\n后台前端：\\n\\n```bash\\n# 1、进入后台前端项目根目录\\ncd gin-blog-admin\\n\\n# 2、安装依赖\\npnpm install\\n\\n# 3、运行项目\\npnpm dev\\n```\\n\\n### 项目部署\\n\\n> 很快就来。保证简单。\\n\\n## 总结鸣谢\\n\\n这个项目不管是前端，还是后端，都是花了比较大心血去架构的，并且从技术选型上，都是选择了目前最火 + 最新的技术栈。当然，这也是个人的学习之作，很多知识点都是边学边开发的（例如 Casbin），这个过程中也参考了很多优秀的开源项目，感谢大家的开源让程序员的世界更加美好，这也是开源本项目的目的之一。本项目中仍有很多不足，后续会继续更新。\\n\\n最后，项目整体代码风格很优秀，注释完善，适合 Golang 后端开发者、前端开发者学习。\\n\\n 鸣谢项目：\\n\\n- [https://butterfly.js.org/](https://butterfly.js.org/)\\n- [https://github.com/flipped-aurora/gin-vue-admin](https://github.com/flipped-aurora/gin-vue-admin)\\n- [https://github.com/qifengzhang007/GinSkeleton](https://github.com/qifengzhang007/GinSkeleton)\\n- [https://github.com/X1192176811/blog](https://github.com/X1192176811/blog)\\n- [https://github.com/zclzone/vue-naive-admin](https://github.com/zclzone/vue-naive-admin)\\n- [https://github.com/antfu/vitesse](https://github.com/antfu/vitesse)\\n- ...\\n\\n> 需要感谢的绝不止以上这些开源项目，但是一时难以全部列出，后面会慢慢补上。\\n\\n## 后续计划\\n\\n高优先级: \\n\\n- ~~完善图片上传功能, 目前文件上传还没怎么处理~~ 🆗\\n- 后台首页重新设计（目前没放什么内容）\\n- ~~前台首页搜索文章（目前使用数据库模糊搜索）~~ 🆗\\n- ~~博客文章导入导出 (.md 文件)~~ 🆗\\n- ~~权限管理中菜单编辑时选择图标（现在只能输入图标字符串）~~ 🆗\\n- 后端日志切割\\n- ~~后台修改背景图片，博客配置等~~ 🆗\\n- ~~后端的 IP 地址检测 BUG 待修复~~ 🆗\\n- ~~博客前台适配移动端~~ 🆗\\n- ~~文章详情, 目录锚点跟随~~ 🆗\\n- 邮箱注册 + 邮件发送验证码\\n\\n后续有空安排上：\\n- 黑夜模式\\n- 前台收缩侧边信息功能\\n- 说说\\n- 相册\\n- 音乐播放器\\n- 鼠标左击特效\\n- 看板娘\\n- 第三方登录: QQ、微信、Github ...\\n- 评论时支持选择表情，参考 Valine\\n- 单独部署：前后端 + 环境\\n- 重写单元测试，目前的单元测试是早期版本，项目架构更改后，无法跑通\\n- 前台首页搜索集成 ElasticSearch\\n- 国际化?\\n\\n其他：\\n- 写一份好的文档\\n- 补全 README.md\\n- 完善 Apifox 生成的接口文档\\n- ~~一键部署：使用 docker compose 单机一键部署整个项目（前后端 + 环境）~~ 🆗\\n\\n## 更新日志\\n\\n描述规范定义，有以下几种行为 ACTION:\\n- `FIX`: 修复\\n- `REFINE`: 优化\\n- `COMPLETE`: 完善\\n- `ADD`: 新增\\n\\n---\\n\\n2022-12-23:\\n\\n博客部署:\\n- 新增 deploy 子模块, 使用 docker-compose 一键运行前后端 ⭐⭐\\n\\n---\\n\\n2022-12-22:\\n\\n博客部署:\\n- 修复 线上图片上传问题, 本地上传则采用 Nginx 反向代理 Gin 的静态服务资源, 也可采用七牛云存储\\n\\n---\\n\\n2022-12-21:\\n\\n博客后台:\\n- 新增 图标选择组件, 选择范围为自定义图标数组 ⭐\\n\\n---\\n\\n2022-12-20:\\n\\n博客后台: \\n- 完善 IP 检测工具 ⭐\\n- 修复 Nginx 获取的客户端 IP 是服务器 IP (docker 部署 Nginx 的问题, 修改 Nginx 配置文件即可)\\n\\n---\\n\\n2022-12-19:\\n\\n博客后台:\\n- 添加简易版黑夜模式 (一行 CSS 实现)\\n\\n---\\n\\n2022-12-17:\\n\\n博客后台:\\n- 新增 文章导入、导出 ⭐\\n\\n---\\n\\n2022-12-16:\\n\\n博客后台:\\n- 修复 MySQL 无法存储 emoji 的问题，设置 utf8mb4 字符集编码，更新 SQL \\n- 完善 添加文章时选择标签的逻辑\\n- 新增 全屏水印 功能\\n\\n---\\n\\n2022-12-15:\\n\\n博客后台：\\n- 优化 菜单栏和标签栏，点击标签自动展开对应菜单，点击菜单自动滚动到显示对应标签 ⭐\\n- 优化 使用响应式语法糖重构代码\\n- 优化 代码结构 + 注释\\n\\n---\\n\\n2022-12-14:\\n\\n博客前台：\\n- 优化 代码，去除 n-card 组件，使用自定义 css 实现卡片视图\\n- 优化 对滚动的监听操作，添加节流函数，提升性能 ⭐\\n- 优化 文章目录，根据当前滚动条自动高亮锚点 ⭐⭐\\n- 新增 vite 打包优化相关插件\\n\\n---\\n\\n2022-12-13:\\n\\n项目部署：\\n- 新增 Nginx 配置 https 访问域名 (http 自动跳转到 https) ⭐\\n- 新增 七牛云添加加速域名访问图片资源\\n\\n博客后端：\\n- 新增 文章搜索接口（数据库模糊查询）\\n\\n博客前台：\\n- 新增 导航栏的文章搜索\\n\\n---\\n\\n2022-12-12:\\n\\n博客前台：\\n- 新增 适配移动端 ⭐⭐\\n- 优化 删除 Vuetify 相关组件及依赖 (css 样式存在冲突)，统一使用 naive-ui\\n- 优化 使用 `$ref` 语法糖功能重构页面\\n\\n---\\n\\n2022-12-09:\\n\\n博客前台：\\n- 完善 个人中心的头像上传（注意头像上传需要 Token）\\n- 优化 重构通用页面的代码 ⭐\\n\\n---\\n\\n2022-12-08:\\n\\n博客后端：\\n- 新增 页面模块 的接口 ⭐\\n- 修复 单元测试无法初始化全局变量（flag 包冲突）问题\\n\\n博客后台：\\n- 新增 pinia 数据持久化，防止刷新丢失数据 ⭐\\n- 新增 页面管理页面，动态配置前台显示的封面 ⭐\\n\\n博客前台：\\n- 新增 页面根据 `label` 从后端数据中加载封面 ⭐\\n- 优化 尝试性使用 `$ref` 语法糖功能\\n\\n---\\n\\n2022-12-07:\\n\\n博客后台：\\n- 修复 博客后台，动态加载路由模块导致的热加载失效问题 ⭐⭐\\n- 完善 文件上传，抽取出单独的组件 ⭐⭐\\n- 新增 个人信息页面 ⭐\\n- 优化 发布文章/查看文章 时的文章标签选择、分类选择\\n- 修复 发布文章/查看文章 页面数据加载错误\",\"img\":\"https://static.talkxj.com/articles/771941739cbc70fbe40e10cf441e02e5.jpg\",\"category_name\":\"后端\",\"tag_names\":[\"Golang\",\"Vue\"],\"type\":1,\"original_url\":\"\",\"is_top\":0,\"status\":1}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '172.12.0.1', '美国'),
       (62, '2022-12-24 12:05:13', '2022-12-24 12:05:13', '文章', '修改', 'gin-blog/api/v1.(*Article).UpdateTop-fm',
        '/api/article/top', '修改文章',
        '{\"id\":1,\"created_at\":\"2022-12-03T22:07:01.638Z\",\"updated_at\":\"2022-12-24T12:04:58.664Z\",\"category_id\":1,\"category\":{\"id\":1,\"created_at\":\"2022-12-03T22:01:29.106Z\",\"updated_at\":\"2022-12-03T22:01:29.106Z\",\"name\":\"后端\",\"Articles\":null},\"tags\":[{\"id\":1,\"created_at\":\"2022-12-03T22:01:51.624Z\",\"updated_at\":\"2022-12-03T22:01:51.624Z\",\"articles\":null,\"name\":\"Golang\"},{\"id\":2,\"created_at\":\"2022-12-03T22:01:56.984Z\",\"updated_at\":\"2022-12-03T22:01:56.984Z\",\"articles\":null,\"name\":\"Vue\"}],\"user_id\":1,\"title\":\"项目介绍\",\"desc\":\"\",\"content\":\"## 博客介绍\\n\\n<p align=center>\\n<a href=\\\"http://www.hahacode.cn\\\">\\n<img src=\\\"https://img-blog.csdnimg.cn/fe2f1034cf7c4bd795552d47373ee405.jpeg\\\"  width=\\\"200\\\" hight=\\\"200\\\" alt=\\\"阵、雨的个人博客\\\" style=\\\"border-radius: 50%\\\">\\n</a>\\n</p>\\n\\n<p align=\\\"center\\\">\\n   <a target=\\\"_blank\\\" href=\\\"#\\\">\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/Go-1.19-blue\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/Gin-v1.8.1-blue\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/Casbin-v2.56.0-blue\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/mysql-8.0-blue\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/GORM-v1.24.0-blue\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/redis-7.0-red\\\"/>\\n      <img style=\\\"display: inline-block;\\\" src=\\\"https://img.shields.io/badge/vue-v3.X-green\\\"/>\\n    </a>\\n</p>\\n\\n[在线预览](#在线预览) | [项目介绍](#项目介绍) | [技术介绍](#技术介绍) | [目录结构](#目录结构) | [环境介绍](#环境介绍) | [快速开始](#快速开始) | [总结&鸣谢](#总结鸣谢)  | [后续计划](#后续计划) | [更新日志](#更新日志)\\n\\n您的 Star 是我坚持的动力，感谢大家的支持，欢迎提交 Pr 共同改进项目。\\n\\nGithub 地址：[https://github.com/szluyu99/gin-vue-blog](https://github.com/szluyu99/gin-vue-blog)\\n\\nGitee 地址：[https://gitee.com/szluyu99/gin-vue-blog](https://gitee.com/szluyu99/gin-vue-blog)\\n\\n\\n## 在线预览\\n\\n博客前台链接：[hahacode.cn](https://www.hahacode.cn)（已适配移动端）\\n\\n博客后台链接：[hahacode.cn/blog-admin](https://www.hahacode.cn/blog-admin)（暂未专门适配移动端）\\n\\n> 博客域名已通过备案，且配置 SSL，通过 https 访问\\n\\n测试账号：test@qq.com，密码：11111，前后台都可用这个账号登录\\n\\n在线接口文档地址：[doc.hahacode.cn](http://doc.hahacode.cn/)\\n\\n> 本项目在线接口文档由 Apifox 生成，由于项目架构调整，有些接口待完善和修改\\n>\\n> 由于一开始不会用，接口文档生成的信息不全（如返回响应、响应示例），后续完善\\n\\n以下放几张简单的预览图，强烈建议点击上面的[预览链接](#在线预览)进去体验下：\\n\\n![前台首页图片](https://img-blog.csdnimg.cn/fd25f0e52cdc467893925a48d0d66662.png)\\n\\n![前台首页文章列表](https://img-blog.csdnimg.cn/005cee463d3c4e729a1dd7bbee41e963.png)\\n\\n![后台文章列表](https://img-blog.csdnimg.cn/18c39f63b7b64f7bbd2a4ab764552d13.png)\\n\\n\\n## 项目介绍\\n\\nGithub 上有很多优秀的前后台框架，本项目也参考了许多开源项目，但是大多项目都比较重量级（并非坏处），如果从学习的角度来看对初学者并不是很友好。本项目在以**博客**这个业务为主的前提下，提供一个完整的全栈项目代码（前台前端 + 后台前端 + 后端），技术点基本都是最新 + 最火的技术，代码轻量级，注释完善，适合学习。\\n\\n同时，本项目可用于一键搭建动态博客（参考 [快速开始](#快速开始)），会尽可能多的将前端许多栏目做成后台可动态配置的形式。\\n\\n前台：\\n- 前台界面设计参考 Hexo 的 Butterfly 设计，美观简洁\\n- 响应式布局，适配了移动端\\n- 实现点赞，统计用户等功能 (Redis)\\n- 评论 + 回复评论功能\\n- 留言采用弹幕墙，效果炫酷\\n- 文章详情页有文章目录、推荐文章等功能，优化用户体验\\n\\n后台：\\n- 鉴权使用 JWT\\n- 权限管理使用 CASBIN，实现基于 RBAC 的权限管理\\n- 支持动态权限修改，前端菜单由后端生成（动态路由）\\n- 文章编辑使用 Markdown 编辑器\\n- 常规后台功能齐全：侧边栏、面包屑、标签栏等\\n- 实现记录操作日志功能（GET 不记录）\\n- 实现监听在线用户、强制下线功能\\n- 文件上传支持七牛云、本地（后续计划支持更多）\\n- 对 CRUD 操作封装了通用 Hook\\n\\n其他：\\n- 采用 Restful 风格的 API\\n- 前后端分离部署，前端使用 Nginx，后端使用 Docker\\n- 代码整洁层次清晰，利于开发者学习\\n- 技术点新颖，代码轻量级，适度封装\\n- Docker Compose 一键运行，轻松搭建在线博客\\n\\n### 技术介绍\\n\\n> 这里只写一些主流的通用技术，详细第三方库：前端参考 `package.json` 文件，后端参考 `go.mod` 文件\\n\\n前端技术栈: 使用 pnpm 包管理工具\\n- 基于 TypeScript\\n- Vue3\\n- VueUse: 服务于 Vue Composition API 的工具集\\n- Unocss: 原子化 CSS\\n- Pinia\\n- Vue Router \\n- Axios \\n- Naive UI\\n- ...\\n\\n后端技术栈:\\n- Golang\\n- Docker\\n- Gin\\n- GORM\\n- Viper: 支持 TOML (默认)、YAML 等常用格式作为配置文件\\n- Casbin\\n- Zap\\n- MySQL\\n- Redis\\n- Nginx: 部署静态资源 + 反向代理\\n- ...\\n\\n其他:\\n- 腾讯云人机验证\\n- 七牛云对象存储\\n- ...\\n\\n### 目录结构\\n\\n> 这里简单列出目录结构，具体可以查看源码\\n\\n代码仓库目录：\\n\\n```bash\\ngin-vue-blog\\n├── gin-blog-admin      -- 博客后台前端\\n├── gin-blog-front      -- 博客前台前端\\n├── gin-blog-server     -- 博客后端\\n├── deploy              -- 部署\\n\\n```\\n\\n> 项目运行参考：[快速开始](#快速开始)\\n\\n后端目录：简略版\\n\\n```bash\\ngin-blog-server\\n├── api             -- API\\n│   ├── front       -- 前台接口\\n│   └── v1          -- 后台接口\\n├── dao             -- 数据库操作模块\\n├── service         -- 服务模块\\n├── model           -- 数据模型\\n│   ├── req             -- 请求 VO 模型\\n│   ├── resp            -- 响应 VO 模型\\n│   ├── dto             -- 内部传输 DTO 模型\\n│   └── ...             -- 数据库模型对象 PO 模型\\n├── routes          -- 路由模块\\n│   └── middleware      -- 路由中间件\\n├── utils           -- 工具模块\\n│   ├── r               -- 响应封装\\n│   ├── upload          -- 文件上传\\n│   └── ...\\n├── routes          -- 路由模块\\n├── config          -- 配置文件\\n├── test            -- 测试模块\\n├── assets          -- 资源文件\\n├── log             -- 存放日志的目录\\n├── public          -- 外部访问的静态资源\\n│   └── uploaded    -- 本地文件上传目录\\n├── Dockerfile\\n└── main.go\\n```\\n\\n前端目录：简略版\\n\\n```\\ngin-vue-admin / gin-vue-front 通用目录结构\\n├── src              \\n│   ├── api             -- 接口\\n│   ├── assets          -- 静态资源\\n│   ├── styles          -- 样式\\n│   ├── components      -- 组件\\n│   ├── composables     -- 组合式函数\\n│   ├── router          -- 路由\\n│   ├── store           -- 状态管理\\n│   ├── utils           -- 工具方法\\n│   ├── views           -- 页面\\n│   ├── App.vue\\n│   └── main.ts\\n├── settings         -- 项目配置\\n├── build            -- 构建相关的配置\\n├── public           -- 公共资源, 在打包后会被加到 dist 根目录\\n├── package.json \\n├── package-lock.json\\n├── index.html\\n├── tsconfig.json\\n├── unocss.config.ts -- unocss 配置\\n└── vite.config.ts   -- vite 配置\\n├── .env             -- 通用环境变量\\n├── .env.development -- 开发环境变量\\n├── .env.production  -- 线上环境变量\\n├── .gitignore\\n├── .editorconfig    -- 编辑器配置\\n```\\n\\n部署目录：简略版\\n\\n```\\ndeploy\\n├── build      -- 镜像构建\\n│   ├── mysql  -- mysql 镜像构建\\n│   ├── server -- 后端镜像构建 (基于 gin-blog-server 目录)\\n│   └── web    -- 前端镜像构建 (基于前端项目打包的静态资源)\\n└── start\\n    ├── docker-compose.yml    -- 多容器管理\\n    └── .env                  -- 环境变量\\n    └── ...\\n```\\n\\n## 环境介绍\\n\\n### 线上环境\\n\\n服务器：腾讯云 2核 4G Ubuntu 22.04 LTS\\n\\n对象存储：七牛云\\n\\n### 开发环境\\n\\n| 开发工具                      | 说明                    |\\n| ----------------------------- | ----------------------- |\\n| Vscode                        | Golang 后端 +  Vue 前端 |\\n| Navicat                       | MySQL 远程连接工具      |\\n| Another Redis Desktop Manager | Redis 远程连接工具      |\\n| MobaXterm                     | Linux 远程工具          |\\n| Apifox                        | 接口调试 + 文档生成     |\\n\\n| 开发环境 | 版本 |\\n| -------- | ---- |\\n| Golang   | 1.19 |\\n| MySQL    | 8.x  |\\n| Redis    | 7.x  |\\n\\n### VsCode 插件\\n\\nTODO: 直接写到 .vscode 文件中, 用 VsCode 打开后自动推荐安装\\n\\n如果使用 Vscode 开发，推荐安装以下插件。\\n\\n前端开发插件：（必备）\\n\\n| 插件 | 作用 |\\n| -------- | ---- |\\n| Volar   | Vue 官方插件 |\\n| UnoCSS | Unocss 官方插件 |\\n| Iconify IntelliSense | Iconify 提示插件 |\\n\\n后端开发插件：（必备）\\n\\n| 插件 | 作用 |\\n| -------- | ---- |\\n| Go | Golang 官方插件 |\\n\\n\\n其他插件：（个人推荐，用于提升开发体验）\\n\\n| 名称 | 作用 |\\n| -------- | ---- |\\n| Better Comments   | 优化代码注释显示效果 |\\n| TODO Highlight | 高亮 TODO |\\n| Highlight Matching Tag | 高亮匹配的标签 | \\n\\n## 快速开始\\n\\n建议下载本项目后，先一键运行起来，查看本项目在本地的运行效果。\\n\\n需要修改源码的话，参考常规运行，前后端分开运行。\\n\\n### 方式一：Docker Compose 一键运行\\n\\n需要安装 Docker 和 Docker Compose, 环境准备可参考 [deploy](https://github.com/szluyu99/gin-vue-blog/tree/main/deploy)\\n\\n```\\n# 拉取项目\\ngit clone https://github.com/szluyu99/gin-vue-blog\\n\\n# 进入 docker-compose 目录\\ncd deploy/start\\n\\n# 一键运行\\ndocker-compose up -d\\n```\\n\\n默认用户：\\n- 管理员 admin 123456\\n- 普通用户 user 123456\\n- 测试用户 test 123456\\n\\n### 方式二：常规运行\\n\\n> 自行安装 Golang、Node、MySQL、Redis 环境\\n\\n需要先运行后端服务，再运行前端项目，因为很多前端配置由后端动态加载（如菜单等）。\\n\\n拉取项目到本地：\\n\\n```bash\\ngit clone https://github.com/szluyu99/gin-vue-blog.git\\n```\\n\\n后端项目运行：\\n\\n```bash\\n# 1、进入后端项目根目录 \\ncd gin-blog-server\\n\\n# 2、修改项目运行的配置文件，默认加载位于 config/config.toml \\n\\n# 3、MySQL 导入 gvb.sql\\n\\n# 4、启动 Redis \\n\\n# 5、运行项目\\ngo mod tidy\\ngo run main.go\\n```\\n\\n数据库中的默认用户：\\n- 管理员 admin 123456\\n- 普通用户 user 123456\\n- 测试用户 test 123456\\n\\n前端项目运行： 本项目使用 pnpm 进行包管理，建议全局安装 pnpm\\n\\n```bash\\nnpm install -g pnpm\\n```\\n\\n前台前端：\\n\\n```bash\\n# 1、进入前台前端项目根目录\\ncd gin-blog-front\\n\\n# 2、安装依赖\\npnpm install\\n\\n# 3、运行项目\\npnpm dev\\n```\\n\\n后台前端：\\n\\n```bash\\n# 1、进入后台前端项目根目录\\ncd gin-blog-admin\\n\\n# 2、安装依赖\\npnpm install\\n\\n# 3、运行项目\\npnpm dev\\n```\\n\\n### 项目部署\\n\\n> 很快就来。保证简单。\\n\\n## 总结鸣谢\\n\\n这个项目不管是前端，还是后端，都是花了比较大心血去架构的，并且从技术选型上，都是选择了目前最火 + 最新的技术栈。当然，这也是个人的学习之作，很多知识点都是边学边开发的（例如 Casbin），这个过程中也参考了很多优秀的开源项目，感谢大家的开源让程序员的世界更加美好，这也是开源本项目的目的之一。本项目中仍有很多不足，后续会继续更新。\\n\\n最后，项目整体代码风格很优秀，注释完善，适合 Golang 后端开发者、前端开发者学习。\\n\\n 鸣谢项目：\\n\\n- [https://butterfly.js.org/](https://butterfly.js.org/)\\n- [https://github.com/flipped-aurora/gin-vue-admin](https://github.com/flipped-aurora/gin-vue-admin)\\n- [https://github.com/qifengzhang007/GinSkeleton](https://github.com/qifengzhang007/GinSkeleton)\\n- [https://github.com/X1192176811/blog](https://github.com/X1192176811/blog)\\n- [https://github.com/zclzone/vue-naive-admin](https://github.com/zclzone/vue-naive-admin)\\n- [https://github.com/antfu/vitesse](https://github.com/antfu/vitesse)\\n- ...\\n\\n> 需要感谢的绝不止以上这些开源项目，但是一时难以全部列出，后面会慢慢补上。\\n\\n## 后续计划\\n\\n高优先级: \\n\\n- ~~完善图片上传功能, 目前文件上传还没怎么处理~~ 🆗\\n- 后台首页重新设计（目前没放什么内容）\\n- ~~前台首页搜索文章（目前使用数据库模糊搜索）~~ 🆗\\n- ~~博客文章导入导出 (.md 文件)~~ 🆗\\n- ~~权限管理中菜单编辑时选择图标（现在只能输入图标字符串）~~ 🆗\\n- 后端日志切割\\n- ~~后台修改背景图片，博客配置等~~ 🆗\\n- ~~后端的 IP 地址检测 BUG 待修复~~ 🆗\\n- ~~博客前台适配移动端~~ 🆗\\n- ~~文章详情, 目录锚点跟随~~ 🆗\\n- 邮箱注册 + 邮件发送验证码\\n\\n后续有空安排上：\\n- 黑夜模式\\n- 前台收缩侧边信息功能\\n- 说说\\n- 相册\\n- 音乐播放器\\n- 鼠标左击特效\\n- 看板娘\\n- 第三方登录: QQ、微信、Github ...\\n- 评论时支持选择表情，参考 Valine\\n- 单独部署：前后端 + 环境\\n- 重写单元测试，目前的单元测试是早期版本，项目架构更改后，无法跑通\\n- 前台首页搜索集成 ElasticSearch\\n- 国际化?\\n\\n其他：\\n- 写一份好的文档\\n- 补全 README.md\\n- 完善 Apifox 生成的接口文档\\n- ~~一键部署：使用 docker compose 单机一键部署整个项目（前后端 + 环境）~~ 🆗\\n\\n## 更新日志\\n\\n描述规范定义，有以下几种行为 ACTION:\\n- `FIX`: 修复\\n- `REFINE`: 优化\\n- `COMPLETE`: 完善\\n- `ADD`: 新增\\n\\n---\\n\\n2022-12-23:\\n\\n博客部署:\\n- 新增 deploy 子模块, 使用 docker-compose 一键运行前后端 ⭐⭐\\n\\n---\\n\\n2022-12-22:\\n\\n博客部署:\\n- 修复 线上图片上传问题, 本地上传则采用 Nginx 反向代理 Gin 的静态服务资源, 也可采用七牛云存储\\n\\n---\\n\\n2022-12-21:\\n\\n博客后台:\\n- 新增 图标选择组件, 选择范围为自定义图标数组 ⭐\\n\\n---\\n\\n2022-12-20:\\n\\n博客后台: \\n- 完善 IP 检测工具 ⭐\\n- 修复 Nginx 获取的客户端 IP 是服务器 IP (docker 部署 Nginx 的问题, 修改 Nginx 配置文件即可)\\n\\n---\\n\\n2022-12-19:\\n\\n博客后台:\\n- 添加简易版黑夜模式 (一行 CSS 实现)\\n\\n---\\n\\n2022-12-17:\\n\\n博客后台:\\n- 新增 文章导入、导出 ⭐\\n\\n---\\n\\n2022-12-16:\\n\\n博客后台:\\n- 修复 MySQL 无法存储 emoji 的问题，设置 utf8mb4 字符集编码，更新 SQL \\n- 完善 添加文章时选择标签的逻辑\\n- 新增 全屏水印 功能\\n\\n---\\n\\n2022-12-15:\\n\\n博客后台：\\n- 优化 菜单栏和标签栏，点击标签自动展开对应菜单，点击菜单自动滚动到显示对应标签 ⭐\\n- 优化 使用响应式语法糖重构代码\\n- 优化 代码结构 + 注释\\n\\n---\\n\\n2022-12-14:\\n\\n博客前台：\\n- 优化 代码，去除 n-card 组件，使用自定义 css 实现卡片视图\\n- 优化 对滚动的监听操作，添加节流函数，提升性能 ⭐\\n- 优化 文章目录，根据当前滚动条自动高亮锚点 ⭐⭐\\n- 新增 vite 打包优化相关插件\\n\\n---\\n\\n2022-12-13:\\n\\n项目部署：\\n- 新增 Nginx 配置 https 访问域名 (http 自动跳转到 https) ⭐\\n- 新增 七牛云添加加速域名访问图片资源\\n\\n博客后端：\\n- 新增 文章搜索接口（数据库模糊查询）\\n\\n博客前台：\\n- 新增 导航栏的文章搜索\\n\\n---\\n\\n2022-12-12:\\n\\n博客前台：\\n- 新增 适配移动端 ⭐⭐\\n- 优化 删除 Vuetify 相关组件及依赖 (css 样式存在冲突)，统一使用 naive-ui\\n- 优化 使用 `$ref` 语法糖功能重构页面\\n\\n---\\n\\n2022-12-09:\\n\\n博客前台：\\n- 完善 个人中心的头像上传（注意头像上传需要 Token）\\n- 优化 重构通用页面的代码 ⭐\\n\\n---\\n\\n2022-12-08:\\n\\n博客后端：\\n- 新增 页面模块 的接口 ⭐\\n- 修复 单元测试无法初始化全局变量（flag 包冲突）问题\\n\\n博客后台：\\n- 新增 pinia 数据持久化，防止刷新丢失数据 ⭐\\n- 新增 页面管理页面，动态配置前台显示的封面 ⭐\\n\\n博客前台：\\n- 新增 页面根据 `label` 从后端数据中加载封面 ⭐\\n- 优化 尝试性使用 `$ref` 语法糖功能\\n\\n---\\n\\n2022-12-07:\\n\\n博客后台：\\n- 修复 博客后台，动态加载路由模块导致的热加载失效问题 ⭐⭐\\n- 完善 文件上传，抽取出单独的组件 ⭐⭐\\n- 新增 个人信息页面 ⭐\\n- 优化 发布文章/查看文章 时的文章标签选择、分类选择\\n- 修复 发布文章/查看文章 页面数据加载错误\",\"img\":\"https://static.talkxj.com/articles/771941739cbc70fbe40e10cf441e02e5.jpg\",\"type\":1,\"status\":1,\"is_top\":1,\"is_delete\":0,\"original_url\":\"\",\"like_count\":0,\"view_count\":3,\"publishing\":true}',
        'PUT', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '172.12.0.1', '美国'),
       (63, '2022-12-24 12:07:29', '2022-12-24 12:07:29', '文章', '新增或修改',
        'gin-blog/api/v1.(*Article).SaveOrUpdate-fm', '/api/article', '新增或修改文章',
        '{\"status\":1,\"is_top\":0,\"title\":\"学习有捷径\",\"content\":\"学习有捷径。学习的捷径之一就是多看看别人是怎么理解这些知识的。\\n\\n举两个例子。\\n\\n如果你喜欢《水浒》，千万不要只读原著当故事看，一定要读一读各代名家的批注和点评，看他们是如何理解的。之前学 C# 时，看《CLR via C#》晦涩难懂，但是我又通过看《你必须知道的.net》而更加了解了。因为后者就是中国一个 80 后写的，我通过他对 C# 的了解，作为桥梁和阶梯，再去窥探比较高达上的书籍和知识。\\n\\n——《css知多少》也是一样的。\\n\\n最后，真诚的希望你能借助别人的力量来提高自己。我也一直在这样要求我自己。\\n\\n---> 摘自 CSS 知多少\",\"category_name\":\"前端\",\"tag_names\":[\"学习\"],\"type\":2}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '172.12.0.1', '美国'),
       (64, '2022-12-24 12:08:31', '2022-12-24 12:08:31', '文章', '新增或修改',
        'gin-blog/api/v1.(*Article).SaveOrUpdate-fm', '/api/article', '新增或修改文章',
        '{\"id\":3,\"title\":\"学习有捷径\",\"desc\":\"\",\"content\":\"学习有捷径。学习的捷径之一就是多看看别人是怎么理解这些知识的。\\n\\n举两个例子。\\n\\n如果你喜欢《水浒》，千万不要只读原著当故事看，一定要读一读各代名家的批注和点评，看他们是如何理解的。之前学 C# 时，看《CLR via C#》晦涩难懂，但是我又通过看《你必须知道的.net》而更加了解了。因为后者就是中国一个 80 后写的，我通过他对 C# 的了解，作为桥梁和阶梯，再去窥探比较高达上的书籍和知识。\\n\\n最后，真诚的希望你能借助别人的力量来提高自己。我也一直在这样要求我自己。\\n\",\"img\":\"https://static.talkxj.com/config/e587c4651154e4da49b5a54f865baaed.jpg\",\"category_name\":\"前端\",\"tag_names\":[\"学习\"],\"type\":2,\"original_url\":\"\",\"is_top\":0,\"status\":1}',
        'POST', '{\"code\":0,\"message\":\"OK\",\"data\":null}', 1, '管理员', '172.12.0.1', '美国');
/*!40000 ALTER TABLE `operation_log` ENABLE KEYS */;

--
-- Table structure for table `page`
--

DROP TABLE IF EXISTS `page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `page`
(
  `id`         bigint                                                        NOT NULL AUTO_INCREMENT,
  `created_at` datetime                                                     DEFAULT NULL,
  `updated_at` datetime                                                     DEFAULT NULL,
  `name`       varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  NOT NULL COMMENT '页面名称',
  `label`      varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '页面标签',
  `cover`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '页面封面',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `page`
--

/*!40000 ALTER TABLE `page` DISABLE KEYS */;
INSERT INTO `page`
VALUES (1, '2022-12-08 13:09:59', '2022-12-08 15:08:38', '首页', 'home', 'http://www.revocat.tech/img/bkimg.jpg'),
       (2, '2022-12-08 13:51:49', '2022-12-08 13:51:49', '归档', 'archive',
        'https://static.talkxj.com/config/643f28683e1c59a80ccfc9cb19735a9c.jpg'),
       (3, '2022-12-08 13:52:18', '2022-12-08 13:52:18', '分类', 'category',
        'https://static.talkxj.com/config/83be0017d7f1a29441e33083e7706936.jpg'),
       (4, '2022-12-08 13:52:31', '2022-12-08 13:52:31', '标签', 'tag',
        'https://static.talkxj.com/config/a6f141372509365891081d755da963a1.png'),
       (5, '2022-12-08 13:52:52', '2022-12-08 13:52:52', '友链', 'link',
        'https://static.talkxj.com/config/9034edddec5b8e8542c2e61b0da1c1da.jpg'),
       (6, '2022-12-08 13:53:04', '2022-12-08 13:53:04', '关于', 'about', 'http://www.revocat.tech/img/articleImg.jpg'),
       (7, '2022-12-08 13:53:18', '2022-12-16 23:46:51', '留言', 'message',
        'https://img-blog.csdnimg.cn/50e0ec7fde824633b2cd7870028670b2.jpeg'),
       (8, '2022-12-08 13:53:30', '2022-12-08 13:53:30', '个人中心', 'user',
        'https://static.talkxj.com/config/ebae4c93de1b286a8d50aa62612caa59.jpeg'),
       (9, '2022-12-16 23:54:53', '2022-12-16 23:54:53', '相册', 'album',
        'https://static.talkxj.com/config/e587c4651154e4da49b5a54f865baaed.jpg'),
       (10, '2022-12-16 23:55:36', '2022-12-16 23:55:36', '错误页面', '404',
        'https://img-blog.csdnimg.cn/2c0e923329974daabb91373d0834359f.jpeg'),
       (11, '2022-12-16 23:56:18', '2022-12-16 23:56:18', '文章列表', 'article_list',
        'https://static.talkxj.com/config/924d65cc8312e6cdad2160eb8fce6831.jpg');
/*!40000 ALTER TABLE `page` ENABLE KEYS */;

--
-- Table structure for table `photo`
--

DROP TABLE IF EXISTS `photo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `photo`
(
  `id`        int NOT NULL AUTO_INCREMENT COMMENT 'Primary Key',
  `create_at` datetime     DEFAULT NULL COMMENT 'Create Time',
  `url`       varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `photo`
--

/*!40000 ALTER TABLE `photo` DISABLE KEYS */;
INSERT INTO `photo`
VALUES (1, NULL, 'http://dummyimage.com/100x100'),
       (2, NULL, 'http://dummyimage.com/100x100'),
       (3, NULL, 'http://dummyimage.com/1000x1000'),
       (4, NULL, 'http://dummyimage.com/1920x1080'),
       (5, NULL, 'http://dummyimage.com/2560x1600');
/*!40000 ALTER TABLE `photo` ENABLE KEYS */;

--
-- Table structure for table `resource`
--

DROP TABLE IF EXISTS `resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `resource`
(
  `id`             bigint NOT NULL AUTO_INCREMENT,
  `created_at`     datetime                                                      DEFAULT NULL,
  `updated_at`     datetime                                                      DEFAULT NULL,
  `url`            varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '资源路径(接口URL)',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  DEFAULT NULL COMMENT '请求方式',
  `name`           varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  DEFAULT NULL COMMENT '资源名(接口名)',
  `parent_id`      bigint                                                        DEFAULT NULL COMMENT '父权限id',
  `is_anonymous`   tinyint(1) DEFAULT NULL COMMENT '是否匿名访问(0-否 1-是)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resource`
--

/*!40000 ALTER TABLE `resource` DISABLE KEYS */;
INSERT INTO `resource`
VALUES (3, '2022-10-20 22:42:01', '2022-10-20 22:42:01', '', '', '文章模块', 0, 0),
       (6, '2022-10-20 22:42:23', '2022-10-20 22:42:23', '', '', '留言模块', 0, 0),
       (7, '2022-10-20 22:42:29', '2022-10-20 22:42:29', '', '', '菜单模块', 0, 0),
       (8, '2022-10-20 22:42:32', '2022-10-20 22:42:32', '', '', '角色模块', 0, 0),
       (9, '2022-10-20 22:42:36', '2022-10-20 22:42:36', '', '', '评论模块', 0, 0),
       (10, '2022-10-20 22:42:41', '2022-10-20 22:42:41', '', '', '资源模块', 0, 0),
       (11, '2022-10-20 22:42:51', '2022-10-20 22:42:51', '', '', '博客信息模块', 0, 0),
       (23, '2022-10-22 22:13:12', '2022-10-26 11:15:24', '/resource/anonymous', 'PUT', '修改资源匿名访问', 10, 0),
       (34, '2022-10-31 17:14:12', '2022-10-31 17:14:12', '/resource', 'POST', '新增/编辑资源', 10, 0),
       (35, '2022-10-31 17:14:42', '2022-10-31 17:18:53', '/resource/list', 'GET', '资源列表', 10, 0),
       (36, '2022-10-31 17:15:15', '2022-10-31 17:19:01', '/resource/option', 'GET', '资源选项列表(树形)', 10, 0),
       (37, '2022-10-31 17:16:57', '2022-10-31 17:16:57', '/resource/:id', 'DELETE', '删除资源', 10, 0),
       (38, '2022-10-31 17:19:29', '2022-10-31 17:19:29', '/menu/list', 'GET', '菜单列表', 7, 0),
       (39, '2022-10-31 18:46:33', '2022-10-31 18:46:33', '/menu', 'POST', '新增/编辑菜单', 7, 0),
       (40, '2022-10-31 18:46:54', '2022-10-31 18:46:54', '/menu/:id', 'DELETE', '删除菜单', 7, 0),
       (41, '2022-10-31 18:47:17', '2022-10-31 18:47:28', '/menu/option', 'GET', '菜单选项列表(树形)', 7, 0),
       (42, '2022-10-31 18:48:05', '2022-10-31 18:48:05', '/menu/user/list', 'GET', '获取当前用户菜单', 7, 0),
       (43, '2022-10-31 19:20:35', '2022-10-31 19:20:35', '/article/list', 'GET', '文章列表', 3, 0),
       (44, '2022-10-31 19:21:02', '2022-10-31 19:21:02', '/article/:id', 'GET', '文章详情', 3, 0),
       (45, '2022-10-31 19:26:05', '2022-10-31 19:26:10', '/article', 'POST', '新增/编辑文章', 3, 0),
       (46, '2022-10-31 19:26:36', '2022-10-31 19:26:36', '/article/soft-delete', 'PUT', '软删除文章', 3, 0),
       (47, '2022-10-31 19:26:52', '2022-10-31 19:26:52', '/article', 'DELETE', '删除文章', 3, 0),
       (48, '2022-10-31 19:27:08', '2022-10-31 19:27:08', '/article/top', 'PUT', '修改文章置顶', 3, 0),
       (49, '2022-10-31 20:19:56', '2022-10-31 20:19:56', '', '', '分类模块', 0, 0),
       (50, '2022-10-31 20:20:03', '2022-10-31 20:20:03', '', '', '标签模块', 0, 0),
       (51, '2022-10-31 20:22:04', '2022-10-31 20:22:04', '/category/list', 'GET', '分类列表', 49, 0),
       (52, '2022-10-31 20:22:29', '2022-10-31 20:22:29', '/category', 'POST', '新增/编辑分类', 49, 0),
       (53, '2022-10-31 20:31:05', '2022-10-31 20:31:05', '/category', 'DELETE', '删除分类', 49, 0),
       (54, '2022-10-31 20:31:37', '2022-10-31 20:31:37', '/category/option', 'GET', '分类选项列表', 49, 0),
       (55, '2022-10-31 20:32:57', '2022-10-31 20:33:13', '/tag/list', 'GET', '标签列表', 50, 0),
       (56, '2022-10-31 20:33:29', '2022-10-31 20:33:29', '/tag', 'POST', '新增/编辑标签', 50, 0),
       (57, '2022-10-31 20:33:40', '2022-10-31 20:33:40', '/tag', 'DELETE', '删除标签', 50, 0),
       (58, '2022-10-31 20:33:54', '2022-10-31 20:33:54', '/tag/option', 'GET', '标签选项列表', 50, 0),
       (59, '2022-10-31 20:35:06', '2022-10-31 20:35:06', '/message/list', 'GET', '留言列表', 6, 0),
       (60, '2022-10-31 20:35:26', '2022-10-31 20:35:26', '/message', 'DELETE', '删除留言', 6, 0),
       (61, '2022-10-31 20:36:21', '2022-10-31 20:36:21', '/message/review', 'PUT', '修改留言审核', 6, 0),
       (62, '2022-10-31 20:37:05', '2022-10-31 20:37:05', '/comment/list', 'GET', '评论列表', 9, 0),
       (63, '2022-10-31 20:37:30', '2022-10-31 20:37:30', '/comment', 'DELETE', '删除评论', 9, 0),
       (64, '2022-10-31 20:37:40', '2022-10-31 20:37:40', '/comment/review', 'PUT', '修改评论审核', 9, 0),
       (65, '2022-10-31 20:38:31', '2022-10-31 20:38:31', '/role/list', 'GET', '角色列表', 8, 0),
       (66, '2022-10-31 20:38:51', '2022-10-31 20:38:51', '/role', 'POST', '新增/编辑角色', 8, 0),
       (67, '2022-10-31 20:39:04', '2022-10-31 20:39:04', '/role', 'DELETE', '删除角色', 8, 0),
       (68, '2022-10-31 20:39:28', '2022-10-31 20:39:28', '/role/option', 'GET', '角色选项', 8, 0),
       (69, '2022-10-31 20:44:23', '2022-10-31 20:44:23', '', '', '友链模块', 0, 0),
       (70, '2022-10-31 20:44:41', '2022-10-31 20:44:41', '/link/list', 'GET', '友链列表', 69, 0),
       (71, '2022-10-31 20:45:01', '2022-10-31 20:45:01', '/link', 'POST', '新增/编辑友链', 69, 0),
       (72, '2022-10-31 20:45:12', '2022-10-31 20:45:12', '/link', 'DELETE', '删除友链', 69, 0),
       (74, '2022-10-31 20:46:48', '2022-10-31 20:47:02', '', '', '用户信息模块', 0, 0),
       (78, '2022-10-31 20:51:16', '2022-10-31 20:51:16', '/user/list', 'GET', '用户列表', 74, 0),
       (79, '2022-10-31 20:55:15', '2022-10-31 20:55:15', '/setting/blog-config', 'GET', '获取博客设置', 11, 0),
       (80, '2022-10-31 20:55:48', '2022-10-31 20:55:48', '/setting/about', 'GET', '获取关于我', 11, 0),
       (81, '2022-10-31 20:56:22', '2022-10-31 20:56:22', '/setting/blog-config', 'PUT', '修改博客设置', 11, 0),
       (82, '2022-10-31 21:57:30', '2022-10-31 21:57:30', '/user/info', 'GET', '获取当前用户信息', 74, 0),
       (84, '2022-10-31 22:06:18', '2022-10-31 22:07:38', '/user', 'PUT', '修改用户信息', 74, 0),
       (85, '2022-11-02 11:55:05', '2022-11-02 11:55:05', '/setting/about', 'PUT', '修改关于我', 11, 0),
       (86, '2022-11-02 13:20:09', '2022-11-02 13:20:09', '/user/online', 'GET', '获取在线用户列表', 74, 0),
       (91, '2022-11-03 16:42:32', '2022-11-03 16:42:32', '', '', '操作日志模块', 0, 0),
       (92, '2022-11-03 16:42:50', '2022-11-03 16:42:50', '/operation/log/list', 'GET', '获取操作日志列表', 91, 0),
       (93, '2022-11-03 16:43:05', '2022-11-03 16:43:05', '/operation/log', 'DELETE', '删除操作日志', 91, 0),
       (95, '2022-11-05 14:22:48', '2022-11-05 14:22:48', '/home', 'GET', '获取后台首页信息', 11, 0),
       (98, '2022-11-29 23:35:43', '2022-11-29 23:35:43', '/user/offline', 'DELETE', '强制离线用户', 74, 0),
       (99, '2022-12-07 20:48:06', '2022-12-07 20:48:06', '/user/current/password', 'PUT', '修改当前用户密码', 74, 0),
       (100, '2022-12-07 20:48:36', '2022-12-07 20:48:36', '/user/current', 'PUT', '修改当前用户信息', 74, 0),
       (101, '2022-12-07 20:55:08', '2022-12-07 20:55:08', '/user/disable', 'PUT', '修改用户禁用', 74, 0),
       (102, '2022-12-08 15:43:15', '2022-12-08 15:43:15', '', '', '页面模块', 0, 0),
       (103, '2022-12-08 15:43:26', '2022-12-08 15:43:26', '/page/list', 'GET', '页面列表', 102, 0),
       (104, '2022-12-08 15:43:39', '2022-12-08 15:43:39', '/page', 'POST', '新增/编辑页面', 102, 0),
       (105, '2022-12-08 15:43:51', '2022-12-08 15:43:51', '/page', 'DELETE', '删除页面', 102, 0),
       (106, '2022-12-16 11:53:58', '2022-12-16 11:53:58', '', '', '文件模块', 0, 0),
       (107, '2022-12-16 11:54:21', '2022-12-16 11:54:21', '/upload', 'POST', '文件上传', 106, 0),
       (108, '2022-12-18 01:34:48', '2022-12-18 01:34:48', '/article/export', 'POST', '导出文章', 3, 0),
       (109, '2022-12-18 01:34:59', '2022-12-18 01:34:59', '/article/import', 'POST', '导入文章', 3, 0);
/*!40000 ALTER TABLE `resource` ENABLE KEYS */;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role`
(
  `id`         bigint NOT NULL AUTO_INCREMENT,
  `created_at` datetime                                                     DEFAULT NULL,
  `updated_at` datetime                                                     DEFAULT NULL,
  `name`       varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色名',
  `label`      varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '角色描述',
  `is_disable` tinyint(1) DEFAULT NULL COMMENT '是否禁用(0-否 1-是)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role`
VALUES (1, '2022-10-20 21:24:28', '2022-12-18 01:35:08', '管理员', 'admin', 0),
       (2, '2022-10-20 21:25:07', '2022-12-08 15:44:09', '用户', 'user', 0),
       (3, '2022-10-20 21:25:09', '2022-12-08 15:44:14', '测试', 'test', 0);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;

--
-- Table structure for table `role_menu`
--

DROP TABLE IF EXISTS `role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_menu`
(
  `role_id` bigint DEFAULT NULL,
  `menu_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_menu`
--

/*!40000 ALTER TABLE `role_menu` DISABLE KEYS */;
INSERT INTO `role_menu`
VALUES (2, 1),
       (2, 2),
       (2, 6),
       (2, 8),
       (2, 9),
       (2, 10),
       (2, 3),
       (2, 25),
       (2, 26),
       (2, 16),
       (2, 17),
       (2, 23),
       (2, 24),
       (2, 4),
       (2, 27),
       (2, 28),
       (2, 29),
       (2, 5),
       (2, 30),
       (2, 32),
       (2, 31),
       (2, 33),
       (2, 34),
       (2, 36),
       (2, 37),
       (2, 38),
       (2, 39),
       (3, 1),
       (3, 2),
       (3, 3),
       (3, 4),
       (3, 33),
       (3, 6),
       (3, 34),
       (3, 8),
       (3, 9),
       (3, 10),
       (3, 25),
       (3, 26),
       (3, 16),
       (3, 17),
       (3, 23),
       (3, 24),
       (3, 5),
       (3, 29),
       (3, 30),
       (3, 32),
       (3, 31),
       (3, 27),
       (3, 28),
       (3, 36),
       (3, 37),
       (3, 38),
       (3, 39),
       (1, 2),
       (1, 3),
       (1, 4),
       (1, 5),
       (1, 6),
       (1, 7),
       (1, 8),
       (1, 9),
       (1, 16),
       (1, 17),
       (1, 23),
       (1, 24),
       (1, 25),
       (1, 26),
       (1, 27),
       (1, 28),
       (1, 29),
       (1, 30),
       (1, 31),
       (1, 32),
       (1, 33),
       (1, 36),
       (1, 37),
       (1, 38),
       (1, 34),
       (1, 10),
       (1, 39);
/*!40000 ALTER TABLE `role_menu` ENABLE KEYS */;

--
-- Table structure for table `role_resource`
--

DROP TABLE IF EXISTS `role_resource`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role_resource`
(
  `role_id`     bigint DEFAULT NULL,
  `resource_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_resource`
--

/*!40000 ALTER TABLE `role_resource` DISABLE KEYS */;
INSERT INTO `role_resource`
VALUES (2, 43),
       (2, 44),
       (2, 59),
       (2, 38),
       (2, 42),
       (2, 65),
       (2, 68),
       (2, 62),
       (2, 35),
       (2, 36),
       (2, 51),
       (2, 54),
       (2, 55),
       (2, 58),
       (2, 70),
       (2, 78),
       (2, 82),
       (2, 79),
       (2, 80),
       (2, 86),
       (2, 92),
       (2, 95),
       (2, 41),
       (2, 103),
       (3, 43),
       (3, 44),
       (3, 59),
       (3, 38),
       (3, 41),
       (3, 42),
       (3, 65),
       (3, 68),
       (3, 62),
       (3, 35),
       (3, 36),
       (3, 79),
       (3, 80),
       (3, 51),
       (3, 54),
       (3, 55),
       (3, 58),
       (3, 70),
       (3, 78),
       (3, 82),
       (3, 92),
       (3, 95),
       (3, 86),
       (3, 103),
       (1, 43),
       (1, 44),
       (1, 45),
       (1, 46),
       (1, 47),
       (1, 48),
       (1, 6),
       (1, 59),
       (1, 60),
       (1, 61),
       (1, 7),
       (1, 38),
       (1, 39),
       (1, 40),
       (1, 41),
       (1, 42),
       (1, 8),
       (1, 65),
       (1, 66),
       (1, 67),
       (1, 68),
       (1, 9),
       (1, 62),
       (1, 63),
       (1, 64),
       (1, 10),
       (1, 23),
       (1, 34),
       (1, 35),
       (1, 36),
       (1, 37),
       (1, 79),
       (1, 80),
       (1, 81),
       (1, 85),
       (1, 49),
       (1, 51),
       (1, 52),
       (1, 53),
       (1, 54),
       (1, 50),
       (1, 55),
       (1, 56),
       (1, 57),
       (1, 58),
       (1, 69),
       (1, 70),
       (1, 71),
       (1, 72),
       (1, 91),
       (1, 92),
       (1, 93),
       (1, 78),
       (1, 82),
       (1, 84),
       (1, 86),
       (1, 98),
       (1, 95),
       (1, 11),
       (1, 99),
       (1, 100),
       (1, 101),
       (1, 74),
       (1, 102),
       (1, 103),
       (1, 104),
       (1, 105),
       (1, 106),
       (1, 107),
       (1, 109),
       (1, 108),
       (1, 3);
/*!40000 ALTER TABLE `role_resource` ENABLE KEYS */;

--
-- Table structure for table `sentence`
--

DROP TABLE IF EXISTS `sentence`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sentence`
(
  `id`      mediumint NOT NULL AUTO_INCREMENT,
  `content` varchar(30) DEFAULT NULL,
  `author`  varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sentence`
--

/*!40000 ALTER TABLE `sentence` DISABLE KEYS */;
INSERT INTO `sentence`
VALUES (1, '楼上谁将玉笛吹，⼭前水阔暝云低。', '张炎'),
       (2, '自在飞花轻似梦，无边丝雨细如愁。', '秦观'),
       (3, '折得⼀枝杨柳，归来插向谁家？', '张炎'),
       (4, '新酒又添残酒困，今春不减前春恨。', '赵令畤'),
       (5, '衣带渐宽终不悔，为伊消得人憔悴。', '柳永'),
       (6, '泪眼问花花不语，乱红飞过秋千去。', '欧阳修'),
       (7, '日日花前常病酒，不辞镜里朱颜瘦。', '冯延巳'),
       (8, '山有木兮木有枝，心悦君兮君不知。', '佚名'),
       (9, '海水梦悠悠，君愁我亦愁。', '佚名'),
       (10, '皑如山上雪，皎若云间月。', '卓文君'),
       (11, '枯桑知天风，海水知天寒。', '佚名'),
       (12, '盈盈一水间，脉脉不得语。', '佚名'),
       (13, '灭烛怜光满，披衣觉露滋。', '张九龄'),
       (14, '明月随良缘，春潮夜夜深。', '王昌龄'),
       (15, '借问梅花何处落，风吹一夜满关山。', '高适'),
       (16, '岩扉松径长寂寥，唯有幽人自来去。', '孟浩然'),
       (17, '竹喧归浣女，莲动下渔舟。', '王维'),
       (18, '月出惊山鸟，时鸣春涧中。', '王维'),
       (19, '惟有相思似春色，江南江北送君归。', '王维'),
       (20, '羌笛何须怨杨柳，春风不度玉门关。', '王之涣'),
       (21, '云想霓裳花想容，春风拂槛露华浓。', '李白'),
       (22, '夜发清溪向三峡，思君不见下渝州。', '李白'),
       (23, '云青青兮欲雨，水澹澹兮生烟。', '李白'),
       (24, '掬水月在手，弄花香满衣。', '于良史'),
       (25, '身在赤城名绛阙，至今潭影照郎星。', '楼钥'),
       (26, '月落乌啼霜满天，江枫渔火对愁眠。', '张继'),
       (27, '天街小雨润如酥，草色遥看近却无。', '韩愈'),
       (28, '从此无心爱良夜，任他明月下西楼。', '李益'),
       (29, '东边日出西边雨，道是无晴却有晴。', '刘禹锡'),
       (30, '可怜九月初三夜，露似真珠月似弓。', '白居易'),
       (31, '玉轮轧露湿团光，鸾佩相逢桂香陌。', '李贺'),
       (32, '曾经沧海难为水，除却巫山不是云。', '元稹'),
       (33, '人面不知何处去，桃花依旧笑春风。', '崔护'),
       (34, '银烛秋光冷画屏，轻罗小扇扑流萤。', '杜牧'),
       (35, '日暮酒醒人已远，满天风雨下西楼。', '许浑'),
       (36, '可怜楼上月徘徊，应照离人妆镜台。', '张若虚'),
       (37, '身无彩凤双飞翼，心有灵犀一点通。', '李商隐'),
       (38, '此情可待成追忆，只是当时已惘然。', '李商隐'),
       (39, '红楼隔雨相望冷，珠箔飘灯独自归。', '李商隐'),
       (40, '妆罢低声问夫婿，画眉深浅入时无。', '朱庆馀'),
       (41, '曲终人不见，江上数峰青。', '钱起'),
       (42, '平淮忽迷天远近，青山久与船低昂。', '苏轼'),
       (43, '暗潮生渚吊寒蚓，落月挂柳看悬蛛。', '苏轼'),
       (44, '应怜屐齿印苍苔，小扣柴扉久不开。', '叶绍翁'),
       (45, '疏影横斜水清浅，暗香浮动月黄昏。', '林逋'),
       (46, '有约不来过夜半，闲敲棋子落灯花。', '赵师秀'),
       (47, '梨花院落溶溶月，柳絮池塘淡淡风。', '晏殊'),
       (48, '歌罢彩云无觅处，梦回明月生南浦。', '司马槱'),
       (49, '悲欢离合总无情，一任阶前、点滴到天明。', '蒋捷'),
       (50, '浮生只合尊前老，雪满长安道。', '舒亶'),
       (51, '书诏许传宫烛，轻罗初试朝衫。', '虞集'),
       (52, '今宵剩把银釭照，犹恐相逢是梦中。', '晏几道'),
       (53, '人道长眉似远山，山不似长眉好。', '赵长卿'),
       (54, '垆边人似月，皓腕凝霜雪。', '韦庄'),
       (55, '柳下桃蹊，乱分春色到人家。', '秦观'),
       (56, '浓睡觉来慵不语，惊残好梦无寻处。', '冯延巳'),
       (57, '青鸟不传云外信，丁香空结雨中愁。', '李璟'),
       (58, '临风谁更飘香屑，醉拍阑干情味切。', '李煜'),
       (59, '一场愁梦酒醒时，斜阳却照深深院。', '晏殊'),
       (60, '记得小苹初见，两重心字罗衣。', '晏几道');
/*!40000 ALTER TABLE `sentence` ENABLE KEYS */;

--
-- Table structure for table `tag`
--

DROP TABLE IF EXISTS `tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tag`
(
  `id`         bigint unsigned NOT NULL AUTO_INCREMENT,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `name`       varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag`
--

/*!40000 ALTER TABLE `tag` DISABLE KEYS */;
INSERT INTO `tag`
VALUES (1, '2022-12-03 22:01:52', '2022-12-03 22:01:52', 'Golang'),
       (2, '2022-12-03 22:01:57', '2022-12-03 22:01:57', 'Vue'),
       (3, '2022-12-24 12:07:29', '2022-12-24 12:07:29', '学习');
/*!40000 ALTER TABLE `tag` ENABLE KEYS */;

--
-- Table structure for table `user_auth`
--

DROP TABLE IF EXISTS `user_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_auth`
(
  `id`              bigint NOT NULL AUTO_INCREMENT,
  `created_at`      datetime                                                      DEFAULT NULL,
  `updated_at`      datetime                                                      DEFAULT NULL,
  `user_info_id`    bigint                                                        DEFAULT NULL COMMENT '用户信息ID',
  `username`        varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  DEFAULT NULL COMMENT '用户名',
  `password`        varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '密码',
  `login_type`      tinyint(1) DEFAULT NULL COMMENT '登录类型',
  `ip_address`      varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  DEFAULT NULL COMMENT '登录IP地址',
  `ip_source`       varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  DEFAULT NULL COMMENT 'IP来源',
  `last_login_time` datetime(3) DEFAULT NULL COMMENT '上次登录时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_auth`
--

/*!40000 ALTER TABLE `user_auth` DISABLE KEYS */;
INSERT INTO `user_auth`
VALUES (1, '2022-10-31 21:54:11', '2023-01-31 22:26:12', 1, 'admin',
        '$2a$10$np.P54Jep7GB/H5vG1PcbudYcxAAf1iiBf7NzsQJT9ZfsYz6tFPcm', 1, '172.12.0.1', '美国',
        '2022-12-24 12:00:50.252'),
       (2, '2022-10-19 22:31:27', '2022-12-24 12:13:52', 2, 'user',
        '$2a$10$9vHpoeT7sF4j9beiZfPsOe0jJ67gOceO2WKJzJtHRZCjNJajl7Fhq', 1, '172.12.0.6:48716', '',
        '2022-12-24 12:13:52.494'),
       (3, '2022-11-01 10:41:13', '2023-01-22 14:24:18', 3, 'test@qq.com',
        '$2a$10$FmU4jxwDlibSL9pdt.AsuODkbB4gLp3IyyXeoMmW/XALtT/HdwTsi', 1, '172.12.0.6:55438', '',
        '2022-12-24 12:14:26.744'),
       (11, '2023-01-22 21:37:31', '2023-02-26 14:53:04', 11, 'space',
        '$2a$10$mUXA39BMYT96oMuJPvflWu3kWPZBiVVcyyHe5N66kdyVVMJW7vzo6', 1, '', '', '2023-01-22 21:37:31.437'),
       (12, '2023-01-23 16:25:19', '2023-02-26 14:08:20', 12, '田所浩二',
        '$2a$10$7Jx9zbwfj/aTwpegaxgTFOGntEH9wfxjkyPy0H5RReWuF1z771aYm', 1, '', '', '2023-01-23 16:25:19.161'),
       (13, '2023-01-31 19:22:39', '2023-01-31 19:22:53', 13, 'test',
        '$2a$10$b8ABqc8bXWYRiJIzBsut7O9zpsxWRQC4EQtUhk6gy9vGBW8wJ27OC', 1, '', '', '2023-01-31 19:22:39.482');
/*!40000 ALTER TABLE `user_auth` ENABLE KEYS */;

--
-- Table structure for table `user_info`
--

DROP TABLE IF EXISTS `user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_info`
(
  `id`         bigint                                                         NOT NULL AUTO_INCREMENT,
  `created_at` datetime                                                      DEFAULT NULL,
  `updated_at` datetime                                                      DEFAULT NULL,
  `email`      varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci  DEFAULT NULL COMMENT '邮箱',
  `nickname`   varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci   NOT NULL COMMENT '昵称',
  `avatar`     varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '头像地址',
  `intro`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '个人简介',
  `website`    varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '个人网站',
  `is_disable` tinyint(1) DEFAULT NULL COMMENT '是否禁用(0-否 1-是)',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_info`
--

/*!40000 ALTER TABLE `user_info` DISABLE KEYS */;
INSERT INTO `user_info`
VALUES (1, '2022-10-31 21:54:11', '2022-12-16 23:42:32', '', '管理员',
        'https://www.bing.com/rp/ar_9isCNU2Q-VG1yEDDHnx8HAFQ.png', '我是管理员用户！', 'https://www.hahacode.cn', 0),
       (2, '2022-10-19 22:31:27', '2022-12-07 20:55:30', 'user@qq.com', '普通用户',
        'https://www.bing.com/rp/ar_9isCNU2Q-VG1yEDDHnx8HAFQ.png', '我是个普通用户！', 'https://www.hahacode.cn', 0),
       (3, '2022-11-01 10:41:13', '2022-11-30 13:51:52', 'test@qq.com', '测试用户',
        'https://www.bing.com/rp/ar_9isCNU2Q-VG1yEDDHnx8HAFQ.png', '我是测试用的！', 'https://www.hahacode.cn', 0),
       (11, '2023-01-22 21:37:31', '2023-01-22 21:37:31', '3240138799@qq.com', '用户space',
        'https://static.talkxj.com/avatar/user.png', '', '', 0),
       (12, '2023-01-23 16:25:19', '2023-01-24 11:47:48', '983854135@qq.com', 'User_test',
        'http://dummyimage.com/100x100', 'We', 'http://www.revocat.tech', 0),
       (13, '2023-01-31 19:22:39', '2023-01-31 19:22:39', 'isaiah2032@foxmail.com', '用户test',
        'https://static.talkxj.com/avatar/user.png', '', '', NULL);
/*!40000 ALTER TABLE `user_info` ENABLE KEYS */;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_role`
(
  `user_id` bigint DEFAULT NULL,
  `role_id` bigint DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role`
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (11, 2),
       (12, 1),
       (13, 2);
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;

--
-- Dumping routines for database 'blogdb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-02-26 22:20:36
