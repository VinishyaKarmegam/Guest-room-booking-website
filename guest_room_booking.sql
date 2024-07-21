-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: guest_room_booking
-- ------------------------------------------------------
-- Server version	8.0.38

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
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `room_id` int DEFAULT NULL,
  `customer_id` int DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `room_id` (`room_id`,`start_date`,`end_date`),
  KEY `customer_id` (`customer_id`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`),
  CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'customer1','customer1@example.com','0987654321','pbkdf2:sha256:600000$samplehash1'),(2,'customer2','customer2@example.com','0987654322','pbkdf2:sha256:600000$samplehash2'),(3,'customer3','customer3@example.com','0987654323','pbkdf2:sha256:600000$samplehash3'),(4,'customer4','customer4@example.com','0987654324','pbkdf2:sha256:600000$samplehash4'),(5,'customer5','customer5@example.com','0987654325','pbkdf2:sha256:600000$samplehash5'),(6,'hari123','hari123@gmail.com','1234567894','pbkdf2:sha256:600000$epuWgpsuud2yXiuF$436ba2f2f65d19ea7205134c0deef7cbd5a9c6b216f0b7f505730f76149be6c6'),(7,'balamurugan2452005@gmail.com','balamurugan2452005@gmail.com','098746373','pbkdf2:sha256:600000$qQlYkKvzJ5gaFJCv$c8e4c60f6dedf5e415d9a41fe6ce86c71ef120d962531777716884fb32e42c1a'),(10,'balamurugan2005@gmail.com','balamurugan2005@gmail.com','123445566397','pbkdf2:sha256:600000$R8nVkOHCghVrgjSn$954b5ba2a649540f09221e6d576bb8adcb1b284744a081230b42d40f26419cc8'),(11,'balamurugan2005','hello@gmail.com','976756546','pbkdf2:sha256:600000$zuHWXkFPFuIlN58X$d4d1596af7bd8f0240c0cf69def10870f599ca6b6f95bedc22c88837624750f8'),(14,'kumaran','kumaran123@gmail.com','979198764','pbkdf2:sha256:600000$2pYnvszDutMqBVYL$0e201377fcdb92f53d3b134273e3a555e967f8eaee39c11fc835784d7c10bda9'),(15,'siva','sivanesh@gmail.com','097543425','pbkdf2:sha256:600000$TSfdZU5egOW2sT0Z$9db14919073994d3f9bd40474ba26974892cf10fef057380b1194c35a65f6e3f'),(16,'abc','abc@gmail.com','3498463463','pbkdf2:sha256:600000$AbYlU2nCJO6LbYi5$17c899865bbf44168f30d6c12aab9a3492d1f650871549c17cda30ffb5ef60d4'),(17,'vinishyak','vinishya@gmail.com','3764275456','pbkdf2:sha256:600000$EKU0aLrBTyAPGTKL$e8dbc723783c8964a2c2229fc3c988da1c1f4a1c29b55e25640997579521725c'),(18,'vinishyakarmagam','vinuk123@gmail.com','8738447834','pbkdf2:sha256:600000$Gt4TysoMZATdCYb0$ff982edc6157dab4c0c79daeea6c2bbc4e1c6aba5a92f852b43ac6c91131aa1c'),(19,'vinukar','vinukar@gmail.com','3746327846','pbkdf2:sha256:600000$KJkp0gKScbmlMmsB$0e548a82ed89b7a966135dbaf61d3c557dd026de0d618ea6d27fa0017f0527c2');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customers`
--

DROP TABLE IF EXISTS `customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customers` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `address` text,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customers`
--

LOCK TABLES `customers` WRITE;
/*!40000 ALTER TABLE `customers` DISABLE KEYS */;
/*!40000 ALTER TABLE `customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `house_owner`
--

DROP TABLE IF EXISTS `house_owner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `house_owner` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone_number` varchar(15) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `house_owner`
--

LOCK TABLES `house_owner` WRITE;
/*!40000 ALTER TABLE `house_owner` DISABLE KEYS */;
INSERT INTO `house_owner` VALUES (1,'owner1','owner1@example.com','1234567890','pbkdf2:sha256:600000$samplehash1'),(2,'owner2','owner2@example.com','1234567891','pbkdf2:sha256:600000$samplehash2'),(3,'owner3','owner3@example.com','1234567892','pbkdf2:sha256:600000$samplehash3'),(4,'owner4','owner4@example.com','1234567893','pbkdf2:sha256:600000$samplehash4'),(5,'owner5','owner5@example.com','1234567894','pbkdf2:sha256:600000$samplehash5'),(6,'owner6','owner6@example.com','1234567895','pbkdf2:sha256:600000$samplehash6'),(7,'owner7','owner7@example.com','1234567896','pbkdf2:sha256:600000$samplehash7'),(8,'owner8','owner8@example.com','1234567897','pbkdf2:sha256:600000$samplehash8'),(9,'owner9','owner9@example.com','1234567898','pbkdf2:sha256:600000$samplehash9'),(10,'owner10','owner10@example.com','1234567899','pbkdf2:sha256:600000$samplehash10'),(11,'hari123','hari123@gmail.com','1234567894','pbkdf2:sha256:600000$pzTxUTOQX91EwzEI$6d23d9fb46da6cebf7309dbf98bc7f33711c3bdc5b09f6cb598a262e04ae4e2b'),(15,'vinishya','vinishya@gmail.com','820238738','pbkdf2:sha256:600000$laBSKxrkdKvjVshT$393f6a52eb8110f908a078c6f5bf7dd94256b62486465e027886af9c546f1c4a'),(16,'bala1234','bala1234@gmail.com','23648236','pbkdf2:sha256:600000$aXweA6BouQtIO0yV$7f2c87c1b1cf243a7f32cfdd5be31c5cf67c0eb830fabfbfaf38142bc1942535'),(17,'new','new@gmail.com','0987654321','pbkdf2:sha256:600000$dyJdZ4eM8b6XlUPx$375483bcea8b76bd4a7bd60b72e71622c7e3ddc3aad84c70fb11303c2c64f5b7'),(18,'hello123','hello123@gmail.com','123958957','pbkdf2:sha256:600000$PgF4s5OaeTxnx7JB$9c19810c8d63795bd944e18bd6ca76cafc68dd00f460866227255f4309c97261'),(19,'vinu','vinu@gmail.com','24564985665','pbkdf2:sha256:600000$aJXVk9dlaZItD3S0$6c1b46929fcf88376c8f27d52c26a4402e9291e39f01c168a3776e316d1bf3de'),(20,'vinuk','vinuk@gmail.com','381197834','pbkdf2:sha256:600000$5ib71933GFvm8RzK$d847a215f44085654f517d4078a686207c792b8ebdb6c7b35daed1afb64e8186');
/*!40000 ALTER TABLE `house_owner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `house_owners`
--

DROP TABLE IF EXISTS `house_owners`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `house_owners` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `address` text,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `house_owners`
--

LOCK TABLES `house_owners` WRITE;
/*!40000 ALTER TABLE `house_owners` DISABLE KEYS */;
/*!40000 ALTER TABLE `house_owners` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `floor_size` float NOT NULL,
  `beds` int NOT NULL,
  `amenities` varchar(200) DEFAULT NULL,
  `rent_per_day` float NOT NULL,
  `owner_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `owner_id` (`owner_id`),
  CONSTRAINT `room_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `house_owner` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms` (
  `id` int NOT NULL AUTO_INCREMENT,
  `owner_id` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `floor_size` varchar(255) DEFAULT NULL,
  `num_beds` int NOT NULL,
  `amenities` text,
  `rent_amount` decimal(10,2) NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `owner_id` (`owner_id`),
  CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `house_owners` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-21  9:19:52
