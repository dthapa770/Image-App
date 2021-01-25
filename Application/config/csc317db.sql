-- MySQL dump 10.13  Distrib 8.0.22, for macos10.15 (x86_64)
--
-- Host: localhost    Database: csc317db
-- ------------------------------------------------------
-- Server version	8.0.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `id` int NOT NULL AUTO_INCREMENT,
  `comment` longtext NOT NULL,
  `fk_authorid` int unsigned NOT NULL,
  `fk_postid` int unsigned NOT NULL,
  `created` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `key_toposttable_idx` (`fk_postid`),
  KEY `key_tousertable_idx` (`fk_authorid`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (52,'Test comment',25,102,'2020-12-23 11:09:09'),(53,'Test comment',25,102,'2020-12-23 11:09:11'),(54,'Test comment',25,102,'2020-12-23 11:09:12'),(55,'Test comment',25,102,'2020-12-23 11:09:12'),(56,'Test comment',25,102,'2020-12-23 11:09:12'),(57,'Test comment',25,102,'2020-12-23 11:09:12'),(58,'Test comment',25,102,'2020-12-23 11:09:12');
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `description` varchar(4096) NOT NULL,
  `photopath` varchar(4096) NOT NULL,
  `thumbnail` varchar(4096) NOT NULL,
  `active` int NOT NULL DEFAULT '0',
  `created` datetime NOT NULL,
  `fk_userid` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `posts to users_idx` (`fk_userid`),
  CONSTRAINT `posts to users` FOREIGN KEY (`fk_userid`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (94,'Test1','Test1','public/images/uploads/17a2445db110ac1442252bb2ccb291c30364b8aae8d4.jpeg','public/images/uploads/thumbnail-17a2445db110ac1442252bb2ccb291c30364b8aae8d4.jpeg',0,'2020-12-23 11:04:46',25),(95,'Test 2','Test 2','public/images/uploads/acbd18056307e96f5ec7a0a8dc3073b191bbceeef0a7.jpeg','public/images/uploads/thumbnail-acbd18056307e96f5ec7a0a8dc3073b191bbceeef0a7.jpeg',0,'2020-12-23 11:05:21',25),(96,'Test 3','Test 3','public/images/uploads/ba95dcb9120ff9a691a78f4af63fa7ad011969c20766.jpeg','public/images/uploads/thumbnail-ba95dcb9120ff9a691a78f4af63fa7ad011969c20766.jpeg',0,'2020-12-23 11:07:32',25),(97,'Test 4','Test 4','public/images/uploads/986f0c156b19e9c633e2a8d6e32aa35526f06962db0d.jpeg','public/images/uploads/thumbnail-986f0c156b19e9c633e2a8d6e32aa35526f06962db0d.jpeg',0,'2020-12-23 11:07:45',25),(98,'Test 5','Test 5','public/images/uploads/360f62320d679197c67ea5f442fe58ca138fa606f87d.jpeg','public/images/uploads/thumbnail-360f62320d679197c67ea5f442fe58ca138fa606f87d.jpeg',0,'2020-12-23 11:07:59',25),(99,'Test 6','Test 6','public/images/uploads/626ea8f5fc67f3537868ebb7232d83f5e148ea159fe3.jpeg','public/images/uploads/thumbnail-626ea8f5fc67f3537868ebb7232d83f5e148ea159fe3.jpeg',0,'2020-12-23 11:08:13',25),(100,'Test 7','Test 7','public/images/uploads/0bfddeab0df7e528c851005cae7575517f0da0da42a2.jpeg','public/images/uploads/thumbnail-0bfddeab0df7e528c851005cae7575517f0da0da42a2.jpeg',0,'2020-12-23 11:08:27',25),(101,'Test 8','Test 8','public/images/uploads/124986e9f1c3a2cef016cb2b84cfa3ce739ededa6117.jpeg','public/images/uploads/thumbnail-124986e9f1c3a2cef016cb2b84cfa3ce739ededa6117.jpeg',0,'2020-12-23 11:08:41',25),(102,'Test 9','Test 9','public/images/uploads/a1a0f60444bb394f75ae4b814ad67d77bfcc6d9eb34b.jpeg','public/images/uploads/thumbnail-a1a0f60444bb394f75ae4b814ad67d77bfcc6d9eb34b.jpeg',0,'2020-12-23 11:08:57',25);
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(64) NOT NULL,
  `email` varchar(128) NOT NULL,
  `password` varchar(128) NOT NULL,
  `usertype` int NOT NULL DEFAULT '0',
  `active` int NOT NULL DEFAULT '0',
  `created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (24,'user1','user1@mail.com','$2b$15$AnHyYK1jyLcmCNxgMdnOvubUevTXJEUABSS5D0/2SAH1uCsBkRlNq',0,0,'2020-12-23 10:57:24'),(25,'myuser','myuser@mail.com','$2b$15$/k8IQdERgmDLo3DEPtX2SessYhktRmvD7CQmNy/F2z93XPLUfLbMG',0,0,'2020-12-23 10:58:38');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-12-23 11:15:41
