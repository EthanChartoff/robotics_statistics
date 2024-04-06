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
-- Table structure for table `Countries`
--

DROP TABLE IF EXISTS `Countries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Countries` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8 NOT NULL COMMENT 'official name of country',
  `code` varchar(2) NOT NULL COMMENT 'each country is given a unique code, so they can be easily identified by users.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=751 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Countries`
--

LOCK TABLES `Countries` WRITE;
/*!40000 ALTER TABLE `Countries` DISABLE KEYS */;
INSERT INTO `Countries` VALUES (501,'Afghanistan','AF'),(502,'Aland Islands','AX'),(503,'Albania','AL'),(504,'Algeria','DZ'),(505,'American Samoa','AS'),(506,'Andorra','AD'),(507,'Angola','AO'),(508,'Anguilla','AI'),(509,'Antarctica','AQ'),(510,'Antigua and Barbuda','AG'),(511,'Argentina','AR'),(512,'Armenia','AM'),(513,'Aruba','AW'),(514,'Australia','AU'),(515,'Austria','AT'),(516,'Azerbaijan','AZ'),(517,'Bahrain','BH'),(518,'Bangladesh','BD'),(519,'Barbados','BB'),(520,'Belarus','BY'),(521,'Belgium','BE'),(522,'Belize','BZ'),(523,'Benin','BJ'),(524,'Bermuda','BM'),(525,'Bhutan','BT'),(526,'Bolivia','BO'),(527,'Bonaire, Sint Eustatius and Saba','BQ'),(528,'Bosnia and Herzegovina','BA'),(529,'Botswana','BW'),(530,'Bouvet Island','BV'),(531,'Brazil','BR'),(532,'British Indian Ocean Territory','IO'),(533,'Brunei','BN'),(534,'Bulgaria','BG'),(535,'Burkina Faso','BF'),(536,'Burundi','BI'),(537,'Cambodia','KH'),(538,'Cameroon','CM'),(539,'Canada','CA'),(540,'Cape Verde','CV'),(541,'Cayman Islands','KY'),(542,'Central African Republic','CF'),(543,'Chad','TD'),(544,'Chile','CL'),(545,'China','CN'),(546,'Christmas Island','CX'),(547,'Cocos (Keeling) Islands','CC'),(548,'Colombia','CO'),(549,'Comoros','KM'),(550,'Congo','CG'),(551,'Cook Islands','CK'),(552,'Costa Rica','CR'),(553,'Cote D\'Ivoire (Ivory Coast)','CI'),(554,'Croatia','HR'),(555,'Cuba','CU'),(556,'Curaçao','CW'),(557,'Cyprus','CY'),(558,'Czech Republic','CZ'),(559,'Democratic Republic of the Congo','CD'),(560,'Denmark','DK'),(561,'Djibouti','DJ'),(562,'Dominica','DM'),(563,'Dominican Republic','DO'),(564,'Ecuador','EC'),(565,'Egypt','EG'),(566,'El Salvador','SV'),(567,'Equatorial Guinea','GQ'),(568,'Eritrea','ER'),(569,'Estonia','EE'),(570,'Eswatini','SZ'),(571,'Ethiopia','ET'),(572,'Falkland Islands','FK'),(573,'Faroe Islands','FO'),(574,'Fiji Islands','FJ'),(575,'Finland','FI'),(576,'France','FR'),(577,'French Guiana','GF'),(578,'French Polynesia','PF'),(579,'French Southern Territories','TF'),(580,'Gabon','GA'),(581,'Gambia The','GM'),(582,'Georgia','GE'),(583,'Germany','DE'),(584,'Ghana','GH'),(585,'Gibraltar','GI'),(586,'Greece','GR'),(587,'Greenland','GL'),(588,'Grenada','GD'),(589,'Guadeloupe','GP'),(590,'Guam','GU'),(591,'Guatemala','GT'),(592,'Guernsey and Alderney','GG'),(593,'Guinea','GN'),(594,'Guinea-Bissau','GW'),(595,'Guyana','GY'),(596,'Haiti','HT'),(597,'Heard Island and McDonald Islands','HM'),(598,'Honduras','HN'),(599,'Hong Kong S.A.R.','HK'),(600,'Hungary','HU'),(601,'Iceland','IS'),(602,'India','IN'),(603,'Indonesia','ID'),(604,'Iran','IR'),(605,'Iraq','IQ'),(606,'Ireland','IE'),(607,'Israel','IL'),(608,'Italy','IT'),(609,'Jamaica','JM'),(610,'Japan','JP'),(611,'Jersey','JE'),(612,'Jordan','JO'),(613,'Kazakhstan','KZ'),(614,'Kenya','KE'),(615,'Kiribati','KI'),(616,'Kosovo','XK'),(617,'Kuwait','KW'),(618,'Kyrgyzstan','KG'),(619,'Laos','LA'),(620,'Latvia','LV'),(621,'Lebanon','LB'),(622,'Lesotho','LS'),(623,'Liberia','LR'),(624,'Libya','LY'),(625,'Liechtenstein','LI'),(626,'Lithuania','LT'),(627,'Luxembourg','LU'),(628,'Macau S.A.R.','MO'),(629,'Madagascar','MG'),(630,'Malawi','MW'),(631,'Malaysia','MY'),(632,'Maldives','MV'),(633,'Mali','ML'),(634,'Malta','MT'),(635,'Man (Isle of)','IM'),(636,'Marshall Islands','MH'),(637,'Martinique','MQ'),(638,'Mauritania','MR'),(639,'Mauritius','MU'),(640,'Mayotte','YT'),(641,'Mexico','MX'),(642,'Micronesia','FM'),(643,'Moldova','MD'),(644,'Monaco','MC'),(645,'Mongolia','MN'),(646,'Montenegro','ME'),(647,'Montserrat','MS'),(648,'Morocco','MA'),(649,'Mozambique','MZ'),(650,'Myanmar','MM'),(651,'Namibia','NA'),(652,'Nauru','NR'),(653,'Nepal','NP'),(654,'Netherlands','NL'),(655,'New Caledonia','NC'),(656,'New Zealand','NZ'),(657,'Nicaragua','NI'),(658,'Niger','NE'),(659,'Nigeria','NG'),(660,'Niue','NU'),(661,'Norfolk Island','NF'),(662,'North Korea','KP'),(663,'North Macedonia','MK'),(664,'Northern Mariana Islands','MP'),(665,'Norway','NO'),(666,'Oman','OM'),(667,'Pakistan','PK'),(668,'Palau','PW'),(669,'Palestinian Territory Occupied','PS'),(670,'Panama','PA'),(671,'Papua New Guinea','PG'),(672,'Paraguay','PY'),(673,'Peru','PE'),(674,'Philippines','PH'),(675,'Pitcairn Island','PN'),(676,'Poland','PL'),(677,'Portugal','PT'),(678,'Puerto Rico','PR'),(679,'Qatar','QA'),(680,'Reunion','RE'),(681,'Romania','RO'),(682,'Russia','RU'),(683,'Rwanda','RW'),(684,'Saint Helena','SH'),(685,'Saint Kitts and Nevis','KN'),(686,'Saint Lucia','LC'),(687,'Saint Pierre and Miquelon','PM'),(688,'Saint Vincent and the Grenadines','VC'),(689,'Saint-Barthelemy','BL'),(690,'Saint-Martin (French part)','MF'),(691,'Samoa','WS'),(692,'San Marino','SM'),(693,'Sao Tome and Principe','ST'),(694,'Saudi Arabia','SA'),(695,'Senegal','SN'),(696,'Serbia','RS'),(697,'Seychelles','SC'),(698,'Sierra Leone','SL'),(699,'Singapore','SG'),(700,'Sint Maarten (Dutch part)','SX'),(701,'Slovakia','SK'),(702,'Slovenia','SI'),(703,'Solomon Islands','SB'),(704,'Somalia','SO'),(705,'South Africa','ZA'),(706,'South Georgia','GS'),(707,'South Korea','KR'),(708,'South Sudan','SS'),(709,'Spain','ES'),(710,'Sri Lanka','LK'),(711,'Sudan','SD'),(712,'Suriname','SR'),(713,'Svalbard and Jan Mayen Islands','SJ'),(714,'Sweden','SE'),(715,'Switzerland','CH'),(716,'Syria','SY'),(717,'Taiwan','TW'),(718,'Tajikistan','TJ'),(719,'Tanzania','TZ'),(720,'Thailand','TH'),(721,'The Bahamas','BS'),(722,'Timor-Leste','TL'),(723,'Togo','TG'),(724,'Tokelau','TK'),(725,'Tonga','TO'),(726,'Trinidad and Tobago','TT'),(727,'Tunisia','TN'),(728,'Turkey','TR'),(729,'Turkmenistan','TM'),(730,'Turks and Caicos Islands','TC'),(731,'Tuvalu','TV'),(732,'Uganda','UG'),(733,'Ukraine','UA'),(734,'United Arab Emirates','AE'),(735,'United Kingdom','GB'),(736,'United States','US'),(737,'United States Minor Outlying Islands','UM'),(738,'Uruguay','UY'),(739,'Uzbekistan','UZ'),(740,'Vanuatu','VU'),(741,'Vatican City State (Holy See)','VA'),(742,'Venezuela','VE'),(743,'Vietnam','VN'),(744,'Virgin Islands (British)','VG'),(745,'Virgin Islands (US)','VI'),(746,'Wallis and Futuna Islands','WF'),(747,'Western Sahara','EH'),(748,'Yemen','YE'),(749,'Zambia','ZM'),(750,'Zimbabwe','ZW');
/*!40000 ALTER TABLE `Countries` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-04-06 12:54:19
