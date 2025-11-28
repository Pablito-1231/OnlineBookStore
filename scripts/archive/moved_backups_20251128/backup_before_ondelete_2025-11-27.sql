-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: onlinebookstore
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `authorities`
--

DROP TABLE IF EXISTS `authorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authorities` (
  `authority` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  PRIMARY KEY (`authority`,`username`),
  KEY `FKhjuy9y4fd8v5m3klig05ktofg` (`username`),
  CONSTRAINT `FKhjuy9y4fd8v5m3klig05ktofg` FOREIGN KEY (`username`) REFERENCES `users` (`username`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authorities`
--

LOCK TABLES `authorities` WRITE;
/*!40000 ALTER TABLE `authorities` DISABLE KEYS */;
INSERT INTO `authorities` VALUES ('ROLE_ADMIN','admin'),('ROLE_CUSTOMER','customer');
/*!40000 ALTER TABLE `authorities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book` (
  `book_detail_id` int(11) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `price` double DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKirgh8wpt0i2c1uv9650vf2g4m` (`book_detail_id`),
  CONSTRAINT `FKio72xbateqjgsts3w2fwwr8l2` FOREIGN KEY (`book_detail_id`) REFERENCES `book_detail` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (1,1,69000,12,'Cien a├▒os de soledad'),(6,2,62000,10,'El amor en los tiempos del c├│lera'),(26,3,58000,8,'La sombra del viento'),(11,4,85000,6,'Don Quijote de la Mancha'),(15,5,54000,9,'Rayuela'),(22,7,49000,7,'1984'),(10,8,99000,5,'El se├▒or de los anillos: La comunidad del anillo'),(5,10,35000,20,'El principito'),(24,13,43000,16,'Cr├│nica de una muerte anunciada'),(12,14,89000,9,'Sapiens: De animales a dioses'),(4,16,67000,6,'Breves respuestas a las grandes preguntas'),(8,17,150000,4,'Clean Code'),(20,18,68000,13,'El poder del h├íbito'),(9,19,56000,15,'Cocina colombiana tradicional'),(7,20,49000,0,'El c├│digo Da Vinci'),(2,22,99000,9,'Dune');
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_detail`
--

DROP TABLE IF EXISTS `book_detail`;
/*!40101 SET @saved_cs_client     = @@CHARACTER_SET_CLIENT */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sold` int(11) DEFAULT NULL,
  `type` varchar(20) NOT NULL,
  `detail` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_detail`
--

LOCK TABLES `book_detail` WRITE;
/*!40000 ALTER TABLE `book_detail` DISABLE KEYS */;
INSERT INTO `book_detail` VALUES (1,0,'Fiction','Mystery novel'),(2,0,'Fiction','Sci-Fi adventure'),(3,0,'Non-Fiction','History overview'),(4,0,'Non-Fiction','Science essays'),(5,0,'Children','Fairy tales'),(6,0,'Fiction','Romance drama'),(7,0,'Fiction','Detective stories'),(8,0,'Non-Fiction','Tech handbook'),(9,0,'Non-Fiction','Cooking recipes'),(10,0,'Fiction','Fantasy epic'),(11,0,'Fiction','Short stories'),(12,0,'Non-Fiction','Business strategy'),(13,0,'Fiction','Urban tales'),(14,0,'Non-Fiction','Art design'),(15,0,'Fiction','Space opera'),(16,0,'Fiction','Noir classic'),(17,0,'Non-Fiction','Health & wellness'),(18,0,'Fiction','Comedy sketches'),(19,0,'Children','Learning ABC'),(20,0,'Non-Fiction','Finance basics'),(21,0,'Fiction','Mythology retold'),(22,0,'Fiction','Dystopian saga'),(23,0,'Non-Fiction','Photography guide'),(24,0,'Fiction','Cozy mystery'),(25,0,'Non-Fiction','Gardening tips'),(26,0,'Fiction','Historical drama'),(27,0,'Non-Fiction','DIY handbook'),(28,0,'Fiction','Superhero chronicles'),(29,0,'Non-Fiction','Language learning'),(30,0,'Fiction','Cyberpunk tales');
/*!40000 ALTER TABLE `book_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_user`
--

DROP TABLE IF EXISTS `book_user`;
/*!40101 SET @saved_cs_client     = @@CHARACTER_SET_CLIENT */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `book_user` (
  `book_id` int(11) NOT NULL,
  `customer_id` varchar(255) NOT NULL,
  PRIMARY KEY (`book_id`,`customer_id`),
  KEY `FK1waa89oewkqqu3nbjb419i4tg` (`customer_id`),
  CONSTRAINT `FK1waa89oewkqqu3nbjb419i4tg` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`),
  CONSTRAINT `FKd5nhq3rdfgy9koewdex7bm7q1` FOREIGN KEY (`book_id`) REFERENCES `book` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_user`
--

LOCK TABLES `book_user` WRITE;
/*!40000 ALTER TABLE `book_user` DISABLE KEYS */;
INSERT INTO `book_user` VALUES (1,'customer'),(2,'customer');
/*!40000 ALTER TABLE `book_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@CHARACTER_SET_CLIENT */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `customer` (
  `mob` bigint(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `id` varchar(255) NOT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (123456789,'Calle Principal 123','customer@test.com','Juan','customer','P├®rez');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_detail`
--

DROP TABLE IF EXISTS `purchase_detail`;
/*!40101 SET @saved_cs_client     = @@CHARACTER_SET_CLIENT */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_detail` (
  `book_id` int(11) NOT NULL,
  `price` double DEFAULT NULL,
  `quanitity` int(11) DEFAULT NULL,
  `purchase_history_id` varchar(255) NOT NULL,
  PRIMARY KEY (`book_id`,`purchase_history_id`),
  UNIQUE KEY `UK363hi7osoc0dy0hsn7d443xwg` (`book_id`),
  KEY `FKnkddajvp78n4h156ep0hkahms` (`purchase_history_id`),
  CONSTRAINT `FK1d4rvjv5v7sg625wm4x326jh8` FOREIGN KEY (`book_id`) REFERENCES `book` (`id`),
  CONSTRAINT `FKnkddajvp78n4h156ep0hkahms` FOREIGN KEY (`purchase_history_id`) REFERENCES `purchase_history` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_detail`
--

LOCK TABLES `purchase_detail` WRITE;
/*!40000 ALTER TABLE `purchase_detail` DISABLE KEYS */;
INSERT INTO `purchase_detail` VALUES (1,69000,1,'ph1'),(2,62000,1,'ph1');
/*!40000 ALTER TABLE `purchase_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchase_history`
--

DROP TABLE IF EXISTS `purchase_history`;
/*!40101 SET @saved_cs_client     = @@CHARACTER_SET_CLIENT */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchase_history` (
  `date` datetime(6) DEFAULT NULL,
  `customer_id` varchar(255) DEFAULT NULL,
  `id` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKmph04f5q5b8vv86lf04c3vepb` (`customer_id`),
  CONSTRAINT `FKmph04f5q5b8vv86lf04c3vepb` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchase_history`
--

LOCK TABLES `purchase_history` WRITE;
/*!40000 ALTER TABLE `purchase_history` DISABLE KEYS */;
INSERT INTO `purchase_history` VALUES ('2025-11-26 00:00:00.000000','customer','ph1');
/*!40000 ALTER TABLE `purchase_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@CHARACTER_SET_CLIENT */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UKofx66keruapi6vyqpv6f2or37` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'ROLE_ADMIN'),(2,'ROLE_CUSTOMER');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shopping_cart`
--

DROP TABLE IF EXISTS `shopping_cart`;
/*!40101 SET @saved_cs_client     = @@CHARACTER_SET_CLIENT */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shopping_cart` (
  `book_id` int(11) NOT NULL,
  `count` int(11) DEFAULT NULL,
  `customer_id` varchar(255) NOT NULL,
  PRIMARY KEY (`book_id`,`customer_id`),
  KEY `FKh7db6pdgs2ol2t6k73wn3xj75` (`customer_id`),
  CONSTRAINT `FK1sxgwv5nvek5hcv0or8302xge` FOREIGN KEY (`book_id`) REFERENCES `book` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FKh7db6pdgs2ol2t6k73wn3xj75` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shopping_cart`
--

LOCK TABLES `shopping_cart` WRITE;
/*!40000 ALTER TABLE `shopping_cart` DISABLE KEYS */;
INSERT INTO `shopping_cart` VALUES (1,2,'customer'),(2,1,'customer');
/*!40000 ALTER TABLE `shopping_cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@CHARACTER_SET_CLIENT */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `enabled` bit(1) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES ('\x01','{noop}admin','admin'),('\x01','{noop}customer','customer');
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

-- Dump completed on 2025-11-27  9:27:50
