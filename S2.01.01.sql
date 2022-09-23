-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: cul_d'ampolla
-- ------------------------------------------------------
-- Server version	8.0.30

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

CREATE SCHEMA IF NOT EXISTS `cul_d'ampolla` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `cul_d'ampolla` ;

--
-- Table structure for table `clients`
--
DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `id_client` int NOT NULL AUTO_INCREMENT,
  `client_name` varchar(15) NOT NULL,
  `postal_code` int NOT NULL,
  `phone` int NOT NULL,
  `mail` varchar(20) NOT NULL,
  `register_date` date NOT NULL,
  `recommendation_id_client` int DEFAULT NULL,
  `id_glasses` int NOT NULL,
  PRIMARY KEY (`id_client`,`id_glasses`),
  KEY `id_idx` (`id_glasses`),
  KEY `recommendation_id_client_idx` (`recommendation_id_client`),
  CONSTRAINT `id` FOREIGN KEY (`id_glasses`) REFERENCES `glasses` (`id_glasses`),
  CONSTRAINT `recommendation_id_client` FOREIGN KEY (`recommendation_id_client`) REFERENCES `clients` (`id_client`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'Carlota',8015,66548932,'carlota@gmail.com','2020-09-20',NULL,1),(2,'Biel',8013,66598785,'biel@gmail.com','2020-09-20',NULL,4),(3,'Sara',8018,66523145,'sara@gmail.com','2021-09-20',1,3),(4,'Júlia',8018,65214785,'julia@gmail.com','2022-09-20',2,2);
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `glasses`
--

DROP TABLE IF EXISTS `glasses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `glasses` (
  `id_glasses` int NOT NULL AUTO_INCREMENT,
  `brand` varchar(15) NOT NULL,
  `right_graduation` decimal(5,0) NOT NULL,
  `left_graduation` decimal(5,0) NOT NULL,
  `glasses_frame` varchar(20) NOT NULL,
  `frame_color` varchar(20) NOT NULL,
  `right_glass_color` varchar(20) NOT NULL,
  `left_glass_color` varchar(20) NOT NULL,
  `price` decimal(5,0) NOT NULL,
  `id_provider` int NOT NULL,
  PRIMARY KEY (`id_glasses`,`id_provider`),
  KEY `id_provider_idx` (`id_provider`),
  CONSTRAINT `id_provider` FOREIGN KEY (`id_provider`) REFERENCES `providers` (`id_provider`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `glasses`
--

LOCK TABLES `glasses` WRITE;
/*!40000 ALTER TABLE `glasses` DISABLE KEYS */;
INSERT INTO `glasses` VALUES (1,'eo',1,2,'plastic','black','no color','no color',55,1),(2,'glasss',1,1,'plastic','white','no color','no color',80,2),(3,'eo',0,3,'wood','brown','black','black',45,1),(4,'eo',2,1,'plastic','white','clear','clear',50,1),(5,'vision',1,1,'wood','green','no color','no color',35,3);
/*!40000 ALTER TABLE `glasses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `providers`
--

DROP TABLE IF EXISTS `providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `providers` (
  `id_provider` int NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  `street` varchar(20) NOT NULL,
  `number` int NOT NULL,
  `floor` int DEFAULT NULL,
  `door` varchar(3) DEFAULT NULL,
  `city` varchar(15) NOT NULL,
  `postal_code` int NOT NULL,
  `country` varchar(15) NOT NULL,
  `phone` int NOT NULL,
  `fax` int NOT NULL,
  `NIF` varchar(9) NOT NULL,
  PRIMARY KEY (`id_provider`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `providers`
--

LOCK TABLES `providers` WRITE;
/*!40000 ALTER TABLE `providers` DISABLE KEYS */;
INSERT INTO `providers` VALUES (1,'provider1','cartagena',250,1,'2','BCN',8013,'Spain',935489633,35345,''),(2,'provider2','aragó',600,6,'b','BCN',8018,'Spain',985623145,45344,'6524984V');
/*!40000 ALTER TABLE `providers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sales` (
  `id_sale` int NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `id_client` int NOT NULL,
  `id_glasses` int NOT NULL,
  `id_worker` int NOT NULL,
  PRIMARY KEY (`id_sale`,`id_worker`,`id_client`,`id_glasses`),
  KEY `id_glasses_idx` (`id_glasses`),
  KEY `id_worker_idx` (`id_worker`),
  KEY `id_client` (`id_client`),
  CONSTRAINT `id_client` FOREIGN KEY (`id_client`) REFERENCES `clients` (`id_client`),
  CONSTRAINT `id_glasses` FOREIGN KEY (`id_glasses`) REFERENCES `glasses` (`id_glasses`),
  CONSTRAINT `id_worker` FOREIGN KEY (`id_worker`) REFERENCES `worker` (`id_worker`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` VALUES (1,'2020-09-20',1,1,1),(2,'2021-09-20',2,4,2),(3,'2021-09-20',3,3,2),(4,'2021-09-22',4,2,3);
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `worker`
--

DROP TABLE IF EXISTS `worker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `worker` (
  `id_worker` int NOT NULL AUTO_INCREMENT,
  `worker_name` varchar(45) NOT NULL,
  PRIMARY KEY (`id_worker`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `worker`
--

LOCK TABLES `worker` WRITE;
/*!40000 ALTER TABLE `worker` DISABLE KEYS */;
INSERT INTO `worker` VALUES (1,'Joan'),(2,'Cristina'),(3,'Max');
/*!40000 ALTER TABLE `worker` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-09-23 21:00:12
