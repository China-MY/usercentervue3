-- MySQL dump 10.13  Distrib 8.0.12, for Win64 (x86_64)
--
-- Host: localhost    Database: myxzusercenter
-- ------------------------------------------------------
-- Server version	8.0.12

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '昵称',
  `userAccount` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '登录账号',
  `stuId` varchar(512) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '学号',
  `className` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '班级',
  `avatarUrl` varchar(1024) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '头像',
  `gender` tinyint(4) DEFAULT NULL COMMENT '性别 0-女 1-男',
  `userPassword` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '密码',
  `phone` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '电话',
  `email` varchar(512) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '邮箱',
  `userStatus` int(11) DEFAULT '0' COMMENT '用户状态 0- 正常 1-封号',
  `createTime` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updateTime` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `isDelete` tinyint(4) DEFAULT '0' COMMENT '是否删除 0 1',
  `userRole` int(255) DEFAULT '0' COMMENT '用户角色 0 - 普通用户 1 - 管理员 2-毕业校友 3-在校学生',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'系统管理员','admin','2001','测试','https://public.ysjf.com/mediastorm/material/material/%E9%9D%92%E5%B2%9B-10-%E5%85%A8%E6%99%AF-20250114.JPG',1,'2d78a16649283fbf56453dffa8c93c6e','13012345678','13012345678',0,'2025-03-02 17:04:05','2025-03-06 10:08:12',0,1),(2,'测试','admin1','2001','测试','https://public.ysjf.com/mediastorm/material/material/%E6%97%A5%E6%9C%AC-09-%E5%85%A8%E6%99%AF-20250114.JPG',1,'2d78a16649283fbf56453dffa8c93c6e','13012345678','13012345678',0,'2025-03-03 10:02:17','2025-03-06 10:08:14',0,2),(3,'测试','admin2','2001','测试','https://public.ysjf.com/mediastorm/material/material/%E6%97%A5%E6%9C%AC-09-%E5%85%A8%E6%99%AF-20250114.JPG',0,'2d78a16649283fbf56453dffa8c93c6e','13012345678','13012345678',0,'2025-03-04 12:24:44','2025-03-06 10:08:14',0,0),(4,'测试','admin3','2001','测试','https://public.ysjf.com/mediastorm/material/material/%E6%97%A5%E6%9C%AC-09-%E5%85%A8%E6%99%AF-20250114.JPG',0,'2d78a16649283fbf56453dffa8c93c6e','13012345678','13012345678',0,'2025-03-04 15:35:21','2025-03-06 10:08:14',0,0),(5,'测试','admin4','2001','测试','https://public.ysjf.com/mediastorm/material/material/%E6%97%A5%E6%9C%AC-09-%E5%85%A8%E6%99%AF-20250114.JPG',1,'2d78a16649283fbf56453dffa8c93c6e','13012345678','13012345678',0,'2025-03-04 18:14:28','2025-03-06 10:07:37',0,1),(6,'测试','admin5','2001','测试','https://public.ysjf.com/mediastorm/material/material/%E6%97%A5%E6%9C%AC-09-%E5%85%A8%E6%99%AF-20250114.JPG',1,'2d78a16649283fbf56453dffa8c93c6e','13012345678','13012345678',0,'2025-03-04 18:19:19','2025-03-06 10:07:40',0,3);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-06 10:10:41
