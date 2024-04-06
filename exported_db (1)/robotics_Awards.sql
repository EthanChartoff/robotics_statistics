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
-- Table structure for table `Awards`
--

DROP TABLE IF EXISTS `Awards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Awards` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `award_name` varchar(45) NOT NULL COMMENT 'an award is given to a team who has shown: \n- extraordinary effort in a given field\n- a unique and out of the box result\n- success in the tournament\n- and more...\n\neach award has a unique purpose. ',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `award_name_UNIQUE` (`award_name`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Awards`
--

LOCK TABLES `Awards` WRITE;
/*!40000 ALTER TABLE `Awards` DISABLE KEYS */;
INSERT INTO `Awards` VALUES (50,'AGAINST_ALL_ODDS'),(34,'AUTODESK_INVENTOR'),(72,'AUTONOMOUS'),(8,'BART_KAMEN_MEMORIAL'),(62,'BEST_CRAFTSMANSHIP'),(63,'BEST_DEFENSIVE_MATCH'),(44,'BEST_OFFENSIVE_ROUND'),(45,'BEST_PLAY_OF_THE_DAY'),(1,'CHAIRMANS'),(70,'CHAIRMANS_FINALIST'),(52,'CHAIRMANS_HONORABLE_MENTION'),(80,'CONCEPT'),(53,'CONTENT_COMMUNICATION_HONORABLE_MENTION'),(13,'COOPERTITION'),(21,'CREATIVITY'),(5,'DEANS_LIST'),(79,'DESIGNERS'),(57,'DESIGN_YOUR_FUTURE'),(58,'DESIGN_YOUR_FUTURE_HONORABLE_MENTION'),(27,'DRIVING_TOMORROWS_TECHNOLOGY'),(78,'ENGINEERING_DESIGN'),(22,'ENGINEERING_EXCELLENCE'),(10,'ENGINEERING_INSPIRATION'),(23,'ENTREPRENEURSHIP'),(24,'EXCELLENCE_IN_DESIGN'),(26,'EXCELLENCE_IN_DESIGN_ANIMATION'),(25,'EXCELLENCE_IN_DESIGN_CAD'),(46,'FEATHERWEIGHT_IN_THE_FINALS'),(3,'FINALIST'),(7,'FOUNDERS'),(35,'FUTURE_INNOVATOR'),(82,'GAME_DESIGN_CHALLENGE_FINALIST'),(81,'GAME_DESIGN_CHALLENGE_WINNER'),(67,'GOLDEN_CORNDOG'),(12,'GRACIOUS_PROFESSIONALISM'),(15,'HIGHEST_ROOKIE_SEED'),(60,'HIGH_SCORE'),(28,'IMAGERY'),(41,'INCREDIBLE_PLAY'),(17,'INDUSTRIAL_DESIGN'),(73,'INNOVATION_CHALLENGE_SEMI_FINALIST'),(30,'INNOVATION_IN_CONTROL'),(14,'JUDGES'),(39,'LEADERSHIP_IN_CONTROL'),(9,'MAKE_IT_LOUD'),(29,'MEDIA_AND_TECHNOLOGY'),(68,'MOST_IMPROVED_TEAM'),(47,'MOST_PHOTOGENIC'),(40,'NUM_1_SEED'),(71,'OTHER'),(37,'OUTSTANDING_CART'),(48,'OUTSTANDING_DEFENSE'),(42,'PEOPLES_CHOICE_ANIMATION'),(64,'PLAY_OF_THE_DAY'),(49,'POWER_TO_SIMPLIFY'),(66,'PROFESSIONALISM'),(65,'PROGRAMMING'),(18,'QUALITY'),(55,'REALIZATION'),(56,'REALIZATION_HONORABLE_MENTION'),(36,'RECOGNITION_OF_EXTRAORDINARY_SERVICE'),(51,'RISING_STAR'),(11,'ROOKIE_ALL_STAR'),(77,'ROOKIE_DESIGN'),(74,'ROOKIE_GAME_CHANGER'),(16,'ROOKIE_INSPIRATION'),(19,'SAFETY'),(76,'SKILLS_COMPETITION_FINALIST'),(75,'SKILLS_COMPETITION_WINNER'),(59,'SPECIAL_RECOGNITION_CHARACTER_ANIMATION'),(31,'SPIRIT'),(20,'SPORTSMANSHIP'),(61,'TEACHER_PIONEER'),(54,'TECHNICAL_EXECUTION_HONORABLE_MENTION'),(33,'VISUALIZATION'),(43,'VISUALIZATION_RISING_STAR'),(6,'VOLUNTEER'),(32,'WEBSITE'),(69,'WILDCARD'),(2,'WINNER'),(4,'WOODIE_FLOWERS'),(38,'WSU_AIM_HIGHER');
/*!40000 ALTER TABLE `Awards` ENABLE KEYS */;
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
