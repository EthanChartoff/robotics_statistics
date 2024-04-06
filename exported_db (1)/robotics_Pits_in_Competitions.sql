-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: robotics
-- ------------------------------------------------------
-- Server version	5.7.17

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
-- Table structure for table `Pits_in_Competitions`
--

DROP TABLE IF EXISTS `Pits_in_Competitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pits_in_Competitions` (
  `Pits_id` int(11) NOT NULL,
  `Competitions_id` int(10) unsigned NOT NULL,
  `Teams_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`Pits_id`,`Competitions_id`,`Teams_id`),
  KEY `fk_Pits_has_Competitions_Competitions1_idx` (`Competitions_id`),
  KEY `fk_Pits_has_Competitions_Pits1_idx` (`Pits_id`),
  KEY `fk_Pits_has_Competitions_Teams1_idx` (`Teams_id`),
  CONSTRAINT `fk_Pits_has_Competitions_Competitions1` FOREIGN KEY (`Competitions_id`) REFERENCES `Competitions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pits_has_Competitions_Pits1` FOREIGN KEY (`Pits_id`) REFERENCES `Pits` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pits_has_Competitions_Teams1` FOREIGN KEY (`Teams_id`) REFERENCES `Teams` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pits_in_Competitions`
--

LOCK TABLES `Pits_in_Competitions` WRITE;
/*!40000 ALTER TABLE `Pits_in_Competitions` DISABLE KEYS */;
INSERT INTO `Pits_in_Competitions` VALUES (37,3515,15465),(44,3534,16816),(27,3588,17090),(71,3589,15969),(86,3589,16727),(79,3603,16302),(57,3680,16042),(5,3688,17453),(47,3691,16161),(25,3698,18099),(83,3716,15762),(81,3741,17539),(1,3744,16654),(38,3745,18223),(88,3762,15663),(3,3768,16185),(40,3774,17314),(18,3811,16049),(16,3818,15865),(77,3831,17855),(26,3840,16749),(9,3841,16662),(43,3851,16249),(53,3856,15633),(56,3867,16231),(13,3872,18782),(33,3895,16184),(69,3898,18672),(91,3912,17595),(98,3912,17071),(49,3939,15459),(50,3943,15526),(2,3948,15956),(4,3975,18363),(67,4039,18078),(39,4073,17237),(24,4101,19636),(34,4209,19675),(94,4217,15575),(73,4240,18682),(87,4243,16021),(78,4247,19351),(54,4248,19057),(62,4265,16955),(92,4271,20274),(89,4379,20394),(8,4392,15592),(95,4457,18059),(75,4467,20098),(68,4513,18772),(36,4572,15452),(65,4613,15662),(97,4632,15954),(70,4663,19608),(15,4674,18327),(82,4678,20285),(96,4685,19811),(41,4703,18069),(6,4720,19456),(10,4754,15750),(90,4784,15742),(85,4786,18271),(22,4798,17736),(74,4838,18781),(64,4886,17440),(48,4909,21576),(76,4950,21748),(55,4968,16885),(17,5076,20049),(23,5111,20574),(52,5136,19640),(72,5137,18981),(99,5184,17198),(61,5198,20022),(19,5234,21519),(46,5254,19170),(100,5322,19642),(29,5369,22171),(42,5374,20031),(20,5378,20744),(80,5448,16360),(51,5557,21330),(60,5840,16829),(21,5865,19979),(30,5934,16021),(63,5950,19762),(66,5992,18323),(35,5996,19716),(59,6025,17480),(58,6180,21151),(7,6199,22389),(45,6210,17691),(32,6223,22082),(31,6230,17254),(84,6269,20212),(28,6293,20302),(93,6357,22152),(11,6427,23004),(12,6578,22140),(14,6614,23012);
/*!40000 ALTER TABLE `Pits_in_Competitions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-06 12:56:16
