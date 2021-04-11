-- MySQL dump 10.13  Distrib 8.0.23, for macos10.15 (x86_64)
--
-- Host: localhost    Database: eshop
-- ------------------------------------------------------
-- Server version	8.0.23

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
-- Table structure for table `bestallning`
--

DROP TABLE IF EXISTS `bestallning`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bestallning` (
  `id` int NOT NULL AUTO_INCREMENT,
  `kund_id` int NOT NULL,
  `skapad` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `uppdaterad` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `bestalld` timestamp NULL DEFAULT NULL,
  `skickad` timestamp NULL DEFAULT NULL,
  `raderad` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kund_id` (`kund_id`),
  CONSTRAINT `bestallning_ibfk_1` FOREIGN KEY (`kund_id`) REFERENCES `kund` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bestallning`
--

LOCK TABLES `bestallning` WRITE;
/*!40000 ALTER TABLE `bestallning` DISABLE KEYS */;
INSERT INTO `bestallning` VALUES (1,5,'2021-03-19 15:17:47','2021-03-20 16:16:47','2021-03-20 13:08:33','2021-03-20 16:16:47',NULL),(2,1,'2021-03-20 10:03:40','2021-03-20 17:22:51','2021-03-20 11:23:01','2021-03-20 17:22:51',NULL),(3,5,'2021-03-20 11:24:07','2021-03-20 17:22:19','2021-03-20 12:51:58','2021-03-20 17:22:19',NULL),(4,5,'2021-03-20 12:55:29','2021-03-20 17:22:30','2021-03-20 13:41:58','2021-03-20 17:22:30',NULL),(5,5,'2021-03-20 15:19:15','2021-03-20 17:22:31',NULL,'2021-03-20 17:22:31',NULL),(6,5,'2021-03-20 15:19:19',NULL,NULL,NULL,NULL),(7,5,'2021-03-20 15:19:24','2021-03-20 15:20:58','2021-03-20 15:20:13','2021-03-20 15:20:58',NULL),(8,5,'2021-03-20 15:21:56','2021-03-22 14:48:47','2021-03-20 15:51:00','2021-03-22 14:48:47',NULL),(9,3,'2021-03-22 12:08:07','2021-03-22 12:08:50','2021-03-22 12:08:30','2021-03-22 12:08:50',NULL),(10,4,'2021-03-23 14:44:10','2021-03-23 15:04:41','2021-03-23 15:04:41',NULL,NULL),(11,1,'2021-03-23 15:13:06','2021-03-23 15:13:36','2021-03-23 15:13:21','2021-03-23 15:13:36',NULL);
/*!40000 ALTER TABLE `bestallning` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`user`@`%`*/ /*!50003 TRIGGER `logg_bestallning_insert` AFTER INSERT ON `bestallning` FOR EACH ROW INSERT INTO logg (`händelse`)
        VALUES(CONCAT('Order ', NEW.id, ' lades till. Kund id är ', NEW.kund_id, '.')) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`user`@`%`*/ /*!50003 TRIGGER `logg_bestallning_update` AFTER UPDATE ON `bestallning` FOR EACH ROW INSERT INTO logg (`händelse`)
        VALUES(CONCAT('Ny orderstatus för beställning ', NEW.id,  ' är ',
         order_status(NEW.raderad, NEW.skickad, NEW.bestalld, NEW.uppdaterad, NEW.skapad),
          '.')) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`user`@`%`*/ /*!50003 TRIGGER `logg_bestallning_delete` AFTER DELETE ON `bestallning` FOR EACH ROW INSERT INTO logg (`händelse`)
        VALUES(CONCAT('Order ', OLD.id, ' raderades.')) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `bestallning_produkt`
--

DROP TABLE IF EXISTS `bestallning_produkt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bestallning_produkt` (
  `produktkod` char(100) NOT NULL,
  `bestallning_id` int NOT NULL,
  `antal` int NOT NULL,
  KEY `produktkod` (`produktkod`),
  KEY `bestallning_id` (`bestallning_id`),
  CONSTRAINT `bestallning_produkt_ibfk_1` FOREIGN KEY (`produktkod`) REFERENCES `produkt` (`produktkod`),
  CONSTRAINT `bestallning_produkt_ibfk_2` FOREIGN KEY (`bestallning_id`) REFERENCES `bestallning` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bestallning_produkt`
--

LOCK TABLES `bestallning_produkt` WRITE;
/*!40000 ALTER TABLE `bestallning_produkt` DISABLE KEYS */;
INSERT INTO `bestallning_produkt` VALUES ('kaffe1',1,5),('te45',2,2),('te45',3,123),('skiva1',1,5),('te45',4,2),('skiva1',4,15),('kaffe1',4,15),('te3',4,32),('kaffemix1',4,35),('te45',8,5),('te3',8,2),('te1',9,5),('te45',9,2),('te3',9,3),('te3',10,12),('te45',10,15),('kaffe1',11,5),('skiva1',11,7);
/*!40000 ALTER TABLE `bestallning_produkt` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faktura`
--

DROP TABLE IF EXISTS `faktura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faktura` (
  `id` int NOT NULL AUTO_INCREMENT,
  `totalt_pris` int NOT NULL,
  `bestallning_id` int NOT NULL,
  `betald` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_pris_bestallning_id` (`totalt_pris`,`bestallning_id`),
  KEY `bestallning_id` (`bestallning_id`),
  CONSTRAINT `faktura_ibfk_1` FOREIGN KEY (`bestallning_id`) REFERENCES `bestallning` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faktura`
--

LOCK TABLES `faktura` WRITE;
/*!40000 ALTER TABLE `faktura` DISABLE KEYS */;
INSERT INTO `faktura` VALUES (1,29692,3,NULL),(4,22981,4,NULL),(5,478,2,'2020-01-01'),(9,1990,1,'2020-03-20'),(10,1770,9,NULL),(12,1793,8,'2021-03-19'),(13,2588,11,'2021-03-23');
/*!40000 ALTER TABLE `faktura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hylla`
--

DROP TABLE IF EXISTS `hylla`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hylla` (
  `lager_hylla` char(100) NOT NULL,
  `produktkod` char(100) NOT NULL,
  `antal` int DEFAULT NULL,
  PRIMARY KEY (`lager_hylla`,`produktkod`),
  KEY `produktkod` (`produktkod`),
  KEY `lager_hylla` (`lager_hylla`),
  CONSTRAINT `hylla_ibfk_1` FOREIGN KEY (`produktkod`) REFERENCES `produkt` (`produktkod`),
  CONSTRAINT `hylla_ibfk_2` FOREIGN KEY (`lager_hylla`) REFERENCES `lager` (`hylla`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hylla`
--

LOCK TABLES `hylla` WRITE;
/*!40000 ALTER TABLE `hylla` DISABLE KEYS */;
INSERT INTO `hylla` VALUES ('A:101','kaffe1',95),('A:102','te1',100),('A:103','kaffemix1',100),('B:101','skiva1',93),('B:101','te3',100),('B:102','te3',100),('B:102','te45',100);
/*!40000 ALTER TABLE `hylla` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kategori`
--

DROP TABLE IF EXISTS `kategori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kategori` (
  `id` char(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kategori`
--

LOCK TABLES `kategori` WRITE;
/*!40000 ALTER TABLE `kategori` DISABLE KEYS */;
INSERT INTO `kategori` VALUES ('Inez'),('kaffe'),('kaffeblandning'),('kaffemix'),('kaffiz'),('katter'),('katterna'),('kattisarna'),('muggar'),('skivor'),('Skivsamling'),('te'),('temuggar'),('Tepåse');
/*!40000 ALTER TABLE `kategori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kund`
--

DROP TABLE IF EXISTS `kund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kund` (
  `id` int NOT NULL AUTO_INCREMENT,
  `adress` char(50) NOT NULL,
  `email` char(100) NOT NULL,
  `fornamn` char(50) NOT NULL,
  `efternamn` char(75) NOT NULL,
  `postnummer` char(50) NOT NULL,
  `ort` char(50) NOT NULL,
  `land` char(50) NOT NULL,
  `telefonnummer` char(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kund`
--

LOCK TABLES `kund` WRITE;
/*!40000 ALTER TABLE `kund` DISABLE KEYS */;
INSERT INTO `kund` VALUES (1,'Centrumgatan 1','mikroos@hotmail.com','Mikael','Roos','564 00','Bankeryd','Sverige','070 42 42 42'),(2,'Skogen 1','john.svensson@gmail.com','John','Svensson','555 55','Nästäppan','Sverige','070 555 555'),(3,'Skogen 1','Jeandersson@yahoo.com','Jeanette','Andersson','555 55','Landet','Sverige','070 556 556'),(4,'Blå hus 1','anki91@gmail.com','Ann-Christine','Allbäck','111 11','Karlstad','Sverige','070 111 111'),(5,'Gamlestads Brygga 6','agnes.fotboll@hotmail.com','Agnes','Ström','415 12','Göteborg','Sverige','070 658 01 98');
/*!40000 ALTER TABLE `kund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lager`
--

DROP TABLE IF EXISTS `lager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lager` (
  `hylla` char(100) NOT NULL,
  `plats` char(100) NOT NULL,
  PRIMARY KEY (`hylla`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lager`
--

LOCK TABLES `lager` WRITE;
/*!40000 ALTER TABLE `lager` DISABLE KEYS */;
INSERT INTO `lager` VALUES ('A:101','Torslanda'),('A:102','Torslanda'),('A:103','Torslanda'),('B:101','Torslanda'),('B:102','Torslanda');
/*!40000 ALTER TABLE `lager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logg`
--

DROP TABLE IF EXISTS `logg`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `logg` (
  `id` int NOT NULL AUTO_INCREMENT,
  `tidsstämpel` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `händelse` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logg`
--

LOCK TABLES `logg` WRITE;
/*!40000 ALTER TABLE `logg` DISABLE KEYS */;
INSERT INTO `logg` VALUES (1,'2021-03-19 15:17:36','Ny produkt lades till med produktkod kaffe1.'),(2,'2021-03-19 15:17:36','Ny produkt lades till med produktkod te1.'),(3,'2021-03-19 15:17:36','Ny produkt lades till med produktkod kaffemix1.'),(4,'2021-03-19 15:17:36','Ny produkt lades till med produktkod skiva1.'),(5,'2021-03-19 15:17:36','Ny produkt lades till med produktkod kaffe2.'),(6,'2021-03-19 15:17:47','Order 1 lades till. Kund id är 5.'),(7,'2021-03-19 15:17:49','Ny orderstatus för beställning 1 är Beställd.'),(8,'2021-03-19 15:38:31','Ny produkt lades till med produktkod te2.'),(9,'2021-03-19 15:39:38','Detaljer om produktkod te2 uppdaterades.'),(10,'2021-03-19 15:40:42','Ny orderstatus för beställning 1 är Beställd.'),(12,'2021-03-20 09:42:15','Detaljer om produktkod te1 uppdaterades.'),(13,'2021-03-20 10:03:40','Order 2 lades till. Kund id är 1.'),(14,'2021-03-20 10:15:21','Ny produkt lades till med produktkod te3.'),(15,'2021-03-20 10:59:19','Produkten med produktkod te2 raderades.'),(16,'2021-03-20 11:03:30','Detaljer om produktkod skiva1 uppdaterades.'),(17,'2021-03-20 11:04:19','Detaljer om produktkod kaffe1 uppdaterades.'),(18,'2021-03-20 11:05:46','Detaljer om produktkod kaffe1 uppdaterades.'),(19,'2021-03-20 11:10:38','Detaljer om produktkod kaffemix1 uppdaterades.'),(20,'2021-03-20 11:16:32','Detaljer om produktkod kaffemix1 uppdaterades.'),(21,'2021-03-20 11:18:13','Detaljer om produktkod skiva1 uppdaterades.'),(22,'2021-03-20 11:19:46','Detaljer om produktkod te3 uppdaterades.'),(23,'2021-03-20 11:19:55','Detaljer om produktkod kaffemix1 uppdaterades.'),(24,'2021-03-20 11:20:00','Detaljer om produktkod kaffemix1 uppdaterades.'),(25,'2021-03-20 11:20:44','Ny produkt lades till med produktkod te45.'),(26,'2021-03-20 11:21:14','Ny produkt lades till med produktkod te46.'),(27,'2021-03-20 11:22:34','Produkten med produktkod te46 raderades.'),(28,'2021-03-20 11:23:01','Ny orderstatus för beställning 2 är Beställd.'),(29,'2021-03-20 11:24:07','Order 3 lades till. Kund id är 5.'),(30,'2021-03-20 11:25:12','Ny orderstatus för beställning 2 är Skickad.'),(31,'2021-03-20 11:25:36','Ny orderstatus för beställning 1 är Beställd.'),(32,'2021-03-20 11:25:57','Ny orderstatus för beställning 1 är Skickad.'),(33,'2021-03-20 12:21:11','Detaljer om produktkod kaffe1 uppdaterades.'),(34,'2021-03-20 12:49:59','Ny produkt lades till med produktkod te13.'),(35,'2021-03-20 12:50:13','Ny orderstatus för beställning 3 är Beställd.'),(36,'2021-03-20 12:50:27','Produkten med produktkod te13 raderades.'),(37,'2021-03-20 12:51:43','Ny produkt lades till med produktkod te16.'),(38,'2021-03-20 12:51:58','Ny orderstatus för beställning 3 är Beställd.'),(39,'2021-03-20 12:52:06','Produkten med produktkod te16 raderades.'),(40,'2021-03-20 12:55:29','Order 4 lades till. Kund id är 5.'),(41,'2021-03-20 13:08:33','Ny orderstatus för beställning 1 är Skickad.'),(42,'2021-03-20 13:09:06','Ny orderstatus för beställning 4 är Beställd.'),(43,'2021-03-20 13:11:27','Ny orderstatus för beställning 4 är Beställd.'),(44,'2021-03-20 13:41:58','Ny orderstatus för beställning 4 är Beställd.'),(45,'2021-03-20 14:32:12','Ny orderstatus för beställning 2 är Skickad.'),(46,'2021-03-20 14:59:59','Ny orderstatus för beställning 2 är Skickad.'),(47,'2021-03-20 15:00:26','Ny orderstatus för beställning 2 är Skickad.'),(48,'2021-03-20 15:18:22','Ny orderstatus för beställning 4 är Skickad.'),(49,'2021-03-20 15:19:15','Order 5 lades till. Kund id är 5.'),(50,'2021-03-20 15:19:19','Order 6 lades till. Kund id är 5.'),(51,'2021-03-20 15:19:24','Order 7 lades till. Kund id är 5.'),(52,'2021-03-20 15:20:13','Ny orderstatus för beställning 7 är Beställd.'),(53,'2021-03-20 15:20:58','Ny orderstatus för beställning 7 är Skickad.'),(54,'2021-03-20 15:21:56','Order 8 lades till. Kund id är 5.'),(55,'2021-03-20 15:22:12','Ny orderstatus för beställning 8 är Beställd.'),(56,'2021-03-20 15:22:35','Ny orderstatus för beställning 8 är Skickad.'),(57,'2021-03-20 15:51:00','Ny orderstatus för beställning 8 är Skickad.'),(58,'2021-03-20 16:16:47','Ny orderstatus för beställning 1 är Skickad.'),(59,'2021-03-20 17:18:18','Ny orderstatus för beställning 2 är Skickad.'),(60,'2021-03-20 17:20:35','Ny orderstatus för beställning 4 är Skickad.'),(61,'2021-03-20 17:20:45','Ny orderstatus för beställning 3 är Skickad.'),(62,'2021-03-20 17:20:46','Ny orderstatus för beställning 2 är Skickad.'),(63,'2021-03-20 17:21:05','Ny orderstatus för beställning 5 är Skickad.'),(64,'2021-03-20 17:22:19','Ny orderstatus för beställning 3 är Skickad.'),(65,'2021-03-20 17:22:30','Ny orderstatus för beställning 4 är Skickad.'),(66,'2021-03-20 17:22:31','Ny orderstatus för beställning 5 är Skickad.'),(67,'2021-03-20 17:22:51','Ny orderstatus för beställning 2 är Skickad.'),(68,'2021-03-22 12:08:07','Order 9 lades till. Kund id är 3.'),(69,'2021-03-22 12:08:30','Ny orderstatus för beställning 9 är Beställd.'),(70,'2021-03-22 12:08:50','Ny orderstatus för beställning 9 är Skickad.'),(71,'2021-03-22 12:39:47','Ny orderstatus för beställning 8 är Skickad.'),(72,'2021-03-22 14:48:47','Ny orderstatus för beställning 8 är Skickad.'),(73,'2021-03-23 14:44:10','Order 10 lades till. Kund id är 4.'),(74,'2021-03-23 15:04:41','Ny orderstatus för beställning 10 är Beställd.'),(75,'2021-03-23 15:12:24','Produkten med produktkod kaffe2 raderades.'),(76,'2021-03-23 15:13:06','Order 11 lades till. Kund id är 1.'),(77,'2021-03-23 15:13:21','Ny orderstatus för beställning 11 är Beställd.'),(78,'2021-03-23 15:13:36','Ny orderstatus för beställning 11 är Skickad.');
/*!40000 ALTER TABLE `logg` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produkt`
--

DROP TABLE IF EXISTS `produkt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produkt` (
  `produktkod` char(100) NOT NULL,
  `namn` char(100) NOT NULL,
  `beskrivning` varchar(400) DEFAULT NULL,
  `pris` int NOT NULL,
  PRIMARY KEY (`produktkod`),
  KEY `index_namn` (`namn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produkt`
--

LOCK TABLES `produkt` WRITE;
/*!40000 ALTER TABLE `produkt` DISABLE KEYS */;
INSERT INTO `produkt` VALUES ('kaffe1','Kaffemugg med dbwebb-tryck','En vacker snövit keramisk kaffemugg med högupplöst flerfärgstryck från dbwebb.',99),('kaffemix1','Kaffeblandning med dbwebb-krydda','En egenbryggd kaffeblandning för aktiva studiedagara, utan paus, spetsad med dbwebb-krydda.',199),('skiva1','Skiva där BTHs lärarkår sjunger sånger','BTHs samlade lärarkår sjunger studiemotiverande sångar, inkluderar länk till online spellista.',299),('te1','Temugg med dbwebb-tryck','En ståtlig matt helsvart temugg, extra stor, med grön dbwebb-logo, för sköna stunder framför datorn.',79),('te3','En tepåse med smultron','Tepåse med smultronsmak',299),('te45','Tepåse citroner','En tesmak som ger en doft av exklusiva citroner.',239);
/*!40000 ALTER TABLE `produkt` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`user`@`%`*/ /*!50003 TRIGGER `logg_produkt_insert` AFTER INSERT ON `produkt` FOR EACH ROW INSERT INTO logg (`händelse`)
        VALUES(CONCAT('Ny produkt lades till med produktkod ', NEW.produktkod, '.')) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`user`@`%`*/ /*!50003 TRIGGER `logg_produkt_update` AFTER UPDATE ON `produkt` FOR EACH ROW INSERT INTO logg (`händelse`)
        VALUES(CONCAT('Detaljer om produktkod ', NEW.produktkod, ' uppdaterades.')) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`user`@`%`*/ /*!50003 TRIGGER `logg_produkt_delete` AFTER DELETE ON `produkt` FOR EACH ROW INSERT INTO logg (`händelse`)
        VALUES(CONCAT('Produkten med produktkod ', OLD.produktkod,  ' raderades.')) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `produkt2kategori`
--

DROP TABLE IF EXISTS `produkt2kategori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produkt2kategori` (
  `produktkod` char(100) NOT NULL,
  `kategori_id` char(100) NOT NULL,
  PRIMARY KEY (`produktkod`,`kategori_id`),
  KEY `kategori_id` (`kategori_id`),
  CONSTRAINT `produkt2kategori_ibfk_1` FOREIGN KEY (`produktkod`) REFERENCES `produkt` (`produktkod`) ON UPDATE CASCADE,
  CONSTRAINT `produkt2kategori_ibfk_2` FOREIGN KEY (`kategori_id`) REFERENCES `kategori` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produkt2kategori`
--

LOCK TABLES `produkt2kategori` WRITE;
/*!40000 ALTER TABLE `produkt2kategori` DISABLE KEYS */;
INSERT INTO `produkt2kategori` VALUES ('kaffe1','kaffeblandning'),('kaffemix1','kaffeblandning'),('kaffemix1','kaffemix'),('skiva1','kaffemix'),('kaffe1','kaffiz'),('kaffe1','katter'),('skiva1','kattisarna'),('te1','muggar'),('skiva1','skivor'),('skiva1','Skivsamling'),('te45','te'),('te1','temuggar'),('te1','Tepåse'),('te45','Tepåse');
/*!40000 ALTER TABLE `produkt2kategori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `test`
--

DROP TABLE IF EXISTS `test`;
/*!50001 DROP VIEW IF EXISTS `test`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `test` AS SELECT 
 1 AS `produktkod`,
 1 AS `Name_exp_2`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'eshop'
--
/*!50003 DROP FUNCTION IF EXISTS `bestalld_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` FUNCTION `bestalld_status`(
    a_bestalld TIMESTAMP
) RETURNS char(15) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    IF a_bestalld IS NOT NULL THEN
        RETURN 'Betald';
    ELSE 
        RETURN 'Ej betald';
    END IF;
    RETURN 'Okänd status';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `order_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` FUNCTION `order_status`(
    a_raderad TIMESTAMP, a_skickad TIMESTAMP, a_bestalld TIMESTAMP, a_uppdaterad TIMESTAMP, a_skapad TIMESTAMP
) RETURNS char(15) CHARSET utf8mb4
    DETERMINISTIC
BEGIN
    IF a_raderad IS NOT NULL THEN
        RETURN 'Raderad';
    ELSEIF a_skickad IS NOT NULL THEN
        RETURN 'Skickad';
    ELSEIF a_bestalld IS NOT NULL THEN
        RETURN 'Beställd';
    ELSEIF a_uppdaterad IS NOT NULL THEN
        RETURN 'Uppdaterad';
    ELSEIF a_skapad IS NOT NULL THEN
        RETURN 'Skapad';
    END IF;
    RETURN 'Okänd status';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_category` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `add_category`(IN category CHAR(100))
BEGIN
    INSERT IGNORE INTO kategori VALUES (category)
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_category_to_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `add_category_to_product`(IN a_produktkod CHAR(100), a_kategori CHAR(100))
BEGIN
    INSERT INTO produkt2kategori (produktkod, kategori_id) VALUES (a_produktkod, a_kategori);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_product_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `add_product_order`(a_produktkod CHAR(100), a_bestallning_id INT, a_antal INT)
BEGIN
    INSERT INTO bestallning_produkt 
    (produktkod, bestallning_id, antal)
    VALUES (a_produktkod, a_bestallning_id, a_antal);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `create_order`(customer_id INT)
BEGIN
    INSERT INTO bestallning (kund_id)
        VALUES (customer_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `create_product`(IN a_produktkod CHAR(100), a_namn CHAR(100), a_beskrivning VARCHAR(400), a_pris INT, a_kategori CHAR(50))
BEGIN
    INSERT INTO produkt (produktkod, namn, beskrivning, pris)
    VALUES (a_produktkod, a_namn, a_beskrivning, a_pris);

    INSERT IGNORE INTO  kategori VALUES (a_kategori);

    INSERT INTO produkt2kategori VALUES (a_produktkod, a_kategori);

    INSERT INTO hylla (lager_hylla, produktkod, antal)
    VALUES ('A:101', a_produktkod, 10);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_amount_product_shelf` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `delete_amount_product_shelf`(IN a_hylla VARCHAR(40), a_produktkod CHAR(100), a_antal INT)
BEGIN
    UPDATE HYLLA
    SET antal = antal - a_antal
    WHERE produktkod = a_produktkod AND lager_hylla = a_hylla; 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `delete_product`(IN a_produktkod CHAR(100))
BEGIN
    DELETE FROM hylla
        WHERE produktkod = a_produktkod;

    DELETE FROM bestallning_produkt
        WHERE produktkod = a_produktkod;

    DELETE FROM produkt2kategori
        WHERE produktkod = a_produktkod;

    DELETE FROM produkt
        WHERE produktkod = a_produktkod;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_categories_from_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `get_categories_from_product`(IN a_produktkod CHAR(100))
BEGIN
    SELECT kategori_id AS kategori FROM produkt2kategori WHERE produktkod = a_produktkod;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_customers` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `get_customers`()
BEGIN
    SELECT id, CONCAT(fornamn, " ", efternamn) AS namn, email, telefonnummer FROM kund;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_invoices` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `get_invoices`()
BEGIN
    SELECT faktura.id, totalt_pris, bestallning_id, CONCAT(fornamn, " ", efternamn) AS namn,
    bestalld_status(faktura.betald) AS betal_status
    FROM faktura 
    JOIN bestallning AS b ON b.id = bestallning_id 
    JOIN kund AS k ON k.id = kund_id ORDER BY id DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_invoice_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `get_invoice_details`(IN order_number INT)
BEGIN
    SELECT SUM(pris*antal) as faktura_total FROM produkt 
    JOIN bestallning_produkt ON produkt.produktkod = bestallning_produkt.produktkod 
    WHERE bestallning_id = order_number
;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_invoice_overview` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `get_invoice_overview`(IN order_number INT)
BEGIN
    SELECT faktura.id, bestallning_id, 
    DATE_FORMAT(b.skapad, "%Y-%m-%d %T") AS skapad,
    order_status(b.raderad, b.skickad, b.bestalld, b.uppdaterad, b.skapad) AS status,
    k.id AS kund_id, CONCAT(fornamn, " ", efternamn) AS namn, k.adress, k.ort, k.postnummer,
    totalt_pris, bestalld_status(faktura.betald) AS betal_status
    FROM faktura 
    JOIN bestallning AS b ON b.id = bestallning_id 
    JOIN kund AS k ON k.id = kund_id WHERE bestallning_id = order_number;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_invoice_product_info` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `get_invoice_product_info`(IN order_number INT)
BEGIN
    SELECT p.produktkod, p.pris, bp.antal,
        SUM(p.pris * bp.antal) AS totalt
        FROM faktura 
            JOIN bestallning AS b ON b.id = faktura.bestallning_id
            JOIN bestallning_produkt AS bp ON bp.bestallning_id = b.id
            JOIN produkt AS p ON p.produktkod = bp.produktkod
            JOIN kund AS k ON k.id = kund_id WHERE faktura.bestallning_id = order_number
        GROUP BY bp.antal, p.produktkod, faktura.id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_invoice_total_price` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `get_invoice_total_price`(IN order_number INT)
BEGIN
    SELECT pris*antal AS kostnad 
    FROM produkt 
    JOIN bestallning_produkt ON produkt.produktkod = bestallning_produkt.produktkod 
    WHERE bestallning_id = order_number

UNION

    SELECT SUM(pris*antal) FROM produkt 
    JOIN bestallning_produkt ON produkt.produktkod = bestallning_produkt.produktkod 
    WHERE bestallning_id = order_number 
    ORDER BY kostnad ASC
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `get_order`(IN a_bestallning_id INT)
BEGIN
    SELECT DISTINCT a.produktkod, o.namn, pris, antal,
    (SELECT SUM(antal) FROM produkt AS z JOIN hylla ON z.produktkod = hylla.produktkod WHERE z.produktkod = a.produktkod) AS lagerstatus
    FROM bestallning
    JOIN bestallning_produkt AS a ON bestallning_id = a.bestallning_id 
    JOIN produkt AS o ON o.produktkod = a.produktkod 
    WHERE bestallning_id = a_bestallning_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_orders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `get_orders`()
BEGIN
    SELECT DISTINCT bestallning.id,
    DATE_FORMAT(skapad, "%Y-%m-%d %T") AS skapad,
    (SELECT COUNT(antal) FROM bestallning_produkt WHERE bestallning_id = o.bestallning_id) AS antal_orderrader,
    order_status(bestallning.raderad, bestallning.skickad, bestallning.bestalld, bestallning.uppdaterad, bestallning.skapad) AS status,
    kund_id,
    CONCAT(fornamn, " ", efternamn) AS namn,
    adress,
    ort,
    postnummer
    FROM bestallning
    LEFT JOIN bestallning_produkt AS o ON bestallning.id = o.bestallning_id
    JOIN kund ON kund.id = kund_id
    ORDER BY id DESC
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_order_status` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `get_order_status`(a_bestallning_id INT)
BEGIN
    SELECT order_status(bestallning.raderad, bestallning.skickad, bestallning.bestalld, bestallning.uppdaterad, bestallning.skapad) AS status
    FROM bestallning
    WHERE id = a_bestallning_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `get_product`(IN a_produktkod CHAR(100))
BEGIN
    SELECT produkt.produktkod, namn, beskrivning, pris, kategori_id AS kategori 
    FROM produkt
    JOIN produkt2kategori AS k ON k.produktkod = produkt.produktkod 
    WHERE produkt.produktkod = a_produktkod
    ;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_products` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `get_products`()
BEGIN
    SELECT namn, produktkod 
    FROM produkt;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_products_from_category` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `get_products_from_category`(IN search VARCHAR(50))
BEGIN
    SELECT produkt.produktkod, namn, beskrivning, pris, kategori_id AS kategori 
    FROM produkt JOIN produkt2kategori AS k ON k.produktkod = produkt.produktkod 
    WHERE k.kategori_id = search
    ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `inventory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `inventory`()
BEGIN
    SELECT hylla.produktkod, namn, lager_hylla, antal FROM hylla JOIN produkt ON produkt.produktkod = hylla.produktkod;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `inventory_like` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `inventory_like`(IN search VARCHAR(40))
BEGIN
    SET search = CONCAT('%', search, '%');
    SELECT hylla.produktkod, namn, lager_hylla, antal FROM hylla JOIN produkt ON produkt.produktkod = hylla.produktkod
    WHERE hylla.produktkod LIKE search
    OR produkt.namn LIKE search
    OR lager_hylla LIKE search
    ORDER BY produktkod;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `latest_orders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `latest_orders`()
BEGIN
    SELECT 
        id,
        DATE_FORMAT(tidsstämpel, "%Y-%m-%d %T") AS tidsstämpel,
        händelse
        FROM logg
        ORDER BY tidsstämpel DESC
        LIMIT 20;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `pay_invoice` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `pay_invoice`(IN invoice_number INT, betal_datum DATE)
BEGIN
    UPDATE faktura 
        SET betald = betal_datum
    WHERE faktura.id = invoice_number
    ;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `picklist_get_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `picklist_get_order`(IN a_bestallning_id INT)
BEGIN
    SELECT DISTINCT a.produktkod, a.antal AS antal_bestallda,
    (SELECT GROUP_CONCAT(lager_hylla SEPARATOR ' - ') FROM hylla AS h WHERE h.produktkod = a.produktkod LIMIT 1) AS hylla,
    (SELECT SUM(antal) FROM produkt AS z JOIN hylla ON z.produktkod = hylla.produktkod WHERE z.produktkod = a.produktkod) AS lagerstatus
    FROM bestallning
    JOIN bestallning_produkt AS a ON bestallning_id = a.bestallning_id 
    JOIN produkt AS o ON o.produktkod = a.produktkod
    JOIN hylla ON o.produktkod = hylla.produktkod  
    WHERE bestallning_id = a_bestallning_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `search_order`(IN search VARCHAR(40))
BEGIN
    SET search = CONCAT('%', search, '%');

    SELECT DISTINCT bestallning.id,
    DATE_FORMAT(skapad, "%Y-%m-%d %T") AS skapad,
    kund_id,
    (SELECT COUNT(antal) FROM bestallning_produkt WHERE bestallning_id = o.bestallning_id) AS antal_orderrader,
    order_status(bestallning.raderad, bestallning.skickad, bestallning.bestalld, bestallning.uppdaterad, bestallning.skapad) AS status
    FROM bestallning
    LEFT JOIN bestallning_produkt AS o ON bestallning.id = o.bestallning_id
    WHERE bestallning.id LIKE search 
    OR kund_id LIKE search;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `search_orders` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `search_orders`(IN search VARCHAR(100))
BEGIN
    SELECT 
        id,
        DATE_FORMAT(tidsstämpel, "%Y-%m-%d %T") AS tidsstämpel,
        händelse
        FROM logg
        WHERE id LIKE search
        OR tidsstämpel LIKE search
        OR händelse LIKE search
        ;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `send_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `send_order`(a_bestallning_id INT)
BEGIN
    UPDATE bestallning
        SET bestalld = CURRENT_TIMESTAMP()
        WHERE id = a_bestallning_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ship_order` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `ship_order`(a_bestallning_id INT)
BEGIN
    UPDATE bestallning
        SET skickad = CURRENT_TIMESTAMP()
        WHERE id = a_bestallning_id;

        UPDATE hylla
        JOIN bestallning_produkt AS bp ON bp.bestallning_id = a_bestallning_id
        SET hylla.antal = hylla.antal - bp.antal 
        WHERE hylla.produktkod = bp.produktkod AND bestallning_id = a_bestallning_id;

        INSERT INTO faktura (totalt_pris, bestallning_id) 
        SELECT SUM(pris*antal), bestallning_id FROM produkt 
        JOIN bestallning_produkt ON produkt.produktkod = bestallning_produkt.produktkod 
        WHERE bestallning_id = a_bestallning_id
        GROUP BY bestallning_produkt.bestallning_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_categories` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `show_categories`()
BEGIN
    SELECT id FROM kategori;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_log_rows` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `show_log_rows`(IN `rows` INT)
BEGIN
    SELECT * FROM logg ORDER BY tidsstämpel DESC LIMIT `rows`;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_products_available` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `show_products_available`()
BEGIN
    SELECT DISTINCT p.produktkod, namn, pris,
    (SELECT SUM(antal) FROM produkt AS z JOIN hylla ON z.produktkod = hylla.produktkod WHERE z.produktkod = p.produktkod) AS antal,
    GROUP_CONCAT(c.id SEPARATOR ' - ') AS 'kategori'
    FROM produkt AS p 
    LEFT JOIN hylla ON p.produktkod = hylla.produktkod
        JOIN produkt2kategori AS p2c
            ON p.produktkod = p2c.produktkod
        JOIN kategori AS c 
            ON c.id = p2c.kategori_id
    GROUP BY p.produktkod, hylla.antal;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `show_shelves` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `show_shelves`()
BEGIN
    SELECT * FROM hylla;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_amount_product_shelf` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `update_amount_product_shelf`(IN a_hylla VARCHAR(40), a_produktkod CHAR(100), a_antal INT)
BEGIN
    UPDATE HYLLA
    SET antal = antal + a_antal
    WHERE produktkod = a_produktkod AND lager_hylla = a_hylla; 

    INSERT IGNORE INTO hylla (lager_hylla, produktkod, antal)
        VALUES (a_hylla, a_produktkod, a_antal);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_product` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`user`@`%` PROCEDURE `update_product`(IN a_produktkod CHAR(100), a_namn CHAR(100), a_beskrivning VARCHAR(400), a_pris INT, a_kategori CHAR(50))
BEGIN
    UPDATE produkt
    SET namn = a_namn, beskrivning = a_beskrivning, pris = a_pris
    WHERE produktkod = a_produktkod;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `test`
--

/*!50001 DROP VIEW IF EXISTS `test`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`user`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `test` AS select distinct `hylla`.`produktkod` AS `produktkod`,(select distinct `hylla`.`lager_hylla` from `hylla` where ((`bp`.`bestallning_id` = 1) and (`hylla`.`produktkod` = `bp`.`produktkod`)) limit 1) AS `Name_exp_2` from (`hylla` join `bestallning_produkt` `bp` on((`bp`.`produktkod` = `hylla`.`produktkod`))) where (`bp`.`bestallning_id` = 1) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-23 16:52:43
