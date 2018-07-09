-- MySQL dump 10.13  Distrib 5.5.57, for debian-linux-gnu (x86_64)
--
-- Host: 0.0.0.0    Database: c9
-- ------------------------------------------------------
-- Server version	5.5.57-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aluguel`
--

DROP TABLE IF EXISTS `aluguel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `aluguel` (
  `idAluguel` int(11) NOT NULL,
  `cpf` varchar(255) DEFAULT NULL,
  `placa` varchar(255) DEFAULT NULL,
  `dataInicio` date DEFAULT NULL,
  `dataFim` date DEFAULT NULL,
  `idAvaliacao` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idAluguel`),
  KEY `cpf` (`cpf`),
  KEY `placa` (`placa`),
  KEY `idAvaliacao` (`idAvaliacao`),
  CONSTRAINT `aluguel_ibfk_1` FOREIGN KEY (`cpf`) REFERENCES `usuario` (`cpf`),
  CONSTRAINT `aluguel_ibfk_2` FOREIGN KEY (`placa`) REFERENCES `automovel` (`placa`),
  CONSTRAINT `aluguel_ibfk_3` FOREIGN KEY (`idAvaliacao`) REFERENCES `avaliacao` (`idAvaliacao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aluguel`
--

LOCK TABLES `aluguel` WRITE;
/*!40000 ALTER TABLE `aluguel` DISABLE KEYS */;
/*!40000 ALTER TABLE `aluguel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `automovel`
--

DROP TABLE IF EXISTS `automovel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `automovel` (
  `placa` varchar(255) NOT NULL DEFAULT '',
  `modelo` varchar(255) DEFAULT NULL,
  `cor` varchar(255) DEFAULT NULL,
  `chassi` varchar(255) DEFAULT NULL,
  `disponibilidade` tinyint(1) DEFAULT NULL,
  `dataInicio` date DEFAULT NULL,
  `dataFim` date DEFAULT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `fotoVeiculo` varchar(255) DEFAULT NULL,
  `fotoDocumento` varchar(255) DEFAULT NULL,
  `possuiSeguro` tinyint(1) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `cidade` varchar(255) DEFAULT NULL,
  `estado` varchar(255) DEFAULT NULL,
  `avaliacao` varchar(255) DEFAULT NULL,
  `cpf` varchar(255) DEFAULT NULL,
  `numeroDeAvalicoes` varchar(255) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`placa`),
  UNIQUE KEY `placa` (`placa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `automovel`
--

LOCK TABLES `automovel` WRITE;
/*!40000 ALTER TABLE `automovel` DISABLE KEYS */;
INSERT INTO `automovel` VALUES ('IKO 5856','Fiesta','Branco','958642088495181',0,'2018-06-14','2018-06-26','                                                    Carro em perfeitas condições, modelo 2015, possui rádio e ar condicionado.\r\n                      \r\n                      ',NULL,NULL,0,NULL,'Pelotas','Rio Grande do Sul',NULL,NULL,NULL,NULL,NULL),('IML 6666','KA','Vermelho','092319281203',0,'2018-06-20','2018-06-28','Carro completo, com ar condicionado, direção hidráulica, vidros e travas elétricas.',NULL,NULL,0,NULL,'Pelotas','Rio Grande do Sul',NULL,NULL,NULL,NULL,NULL),('IVK 3030','Gol','Branco','91274102381210',0,'2018-07-18','2018-07-18','ar condicionado, vidros elétricos nas 4 portas, direção hidráulica, banco com regulagem de altura, travas elétricas',NULL,NULL,0,NULL,'São Paulo','São Paulo',NULL,NULL,NULL,NULL,NULL),('VGF 6562','BMW 120','Prata','912847102381',0,'2018-06-23','2018-06-24','',NULL,NULL,0,NULL,'Porto Alegre','Rio Grande do Sul',NULL,NULL,NULL,NULL,NULL),('VMW 0294','Sentra SV 2015','Preto','012381923812',0,'2018-06-05','2018-06-28','Nissan Sentra SV 2015, Câmbio CVT, 2.0, 140cv, Bancos em Couro, Ar condicionado digital, Piloto Automático, média de 9,5 km/l na cidade, 15 km/l na estrada.',NULL,NULL,0,NULL,'Curitiba','Paraná',NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `automovel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avaliacao`
--

DROP TABLE IF EXISTS `avaliacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `avaliacao` (
  `idAvaliacao` int(11) NOT NULL,
  `idAluguel` int(11) DEFAULT NULL,
  `placa` varchar(255) DEFAULT NULL,
  `cpf` varchar(255) DEFAULT NULL,
  `nota` int(11) DEFAULT NULL,
  `comentario` text,
  PRIMARY KEY (`idAvaliacao`),
  KEY `idAluguel` (`idAluguel`),
  KEY `placa` (`placa`),
  KEY `cpf` (`cpf`),
  CONSTRAINT `avaliacao_ibfk_1` FOREIGN KEY (`idAluguel`) REFERENCES `aluguel` (`idAluguel`),
  CONSTRAINT `avaliacao_ibfk_2` FOREIGN KEY (`placa`) REFERENCES `automovel` (`placa`),
  CONSTRAINT `avaliacao_ibfk_3` FOREIGN KEY (`cpf`) REFERENCES `usuario` (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avaliacao`
--

LOCK TABLES `avaliacao` WRITE;
/*!40000 ALTER TABLE `avaliacao` DISABLE KEYS */;
/*!40000 ALTER TABLE `avaliacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserva`
--

DROP TABLE IF EXISTS `reserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reserva` (
  `idReserva` int(11) NOT NULL,
  `placa` varchar(255) DEFAULT NULL,
  `dataInicio` date DEFAULT NULL,
  `dataFim` date DEFAULT NULL,
  PRIMARY KEY (`idReserva`),
  KEY `placa` (`placa`),
  CONSTRAINT `reserva_ibfk_1` FOREIGN KEY (`placa`) REFERENCES `automovel` (`placa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserva`
--

LOCK TABLES `reserva` WRITE;
/*!40000 ALTER TABLE `reserva` DISABLE KEYS */;
/*!40000 ALTER TABLE `reserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuario` (
  `cpf` varchar(255) NOT NULL DEFAULT '',
  `nome` varchar(255) DEFAULT NULL,
  `nascimento` date DEFAULT NULL,
  `rg` tinyint(1) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `senha` tinyint(1) DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `endereco` varchar(255) DEFAULT NULL,
  `telefone` varchar(255) DEFAULT NULL,
  `cidade` varchar(255) DEFAULT NULL,
  `estado` varchar(255) DEFAULT NULL,
  `avaliacao` varchar(255) DEFAULT NULL,
  `numeroDeAvalicoes` varchar(255) DEFAULT NULL,
  `createdAt` datetime DEFAULT NULL,
  `updatedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`cpf`),
  UNIQUE KEY `cpf` (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES ('0203457860','Matheus Eduardo','2018-06-05',127,'me@gmail.com',0,NULL,'Rua Almirante, 123','(53) 98765421','Pelotas','RS',NULL,NULL,NULL,NULL),('02744465852','Renata Junges','1995-12-31',127,'renatajunges@hotmail.com',0,NULL,'Rua','981254876','Pelotas','Rio',NULL,NULL,NULL,NULL),('06741324641','Carolina Finger','1984-09-16',127,'finger_carol@gmail.com',0,NULL,'Rua dos Dedos, 64','964856123','Gramado','Rio Grande do Sul',NULL,NULL,NULL,NULL),('06741324691','Manuela Mendes','1960-06-23',127,'manuzinha81@gmail.com',0,NULL,'Rua das Pitangas, 71','981254850','Porto Alegre','Rio Grande do Sul',NULL,NULL,NULL,NULL),('20649631526','Bernardo Fernandes','1998-01-04',127,'befe@gmail.ccm',0,NULL,'Rua das Laranjas, 981','964856103','Pelotas','Rio Grande do Sul',NULL,NULL,NULL,NULL),('51236482105','Fora Temer Fracasso','1953-06-17',127,'temer_fracasso_total@gmail.com',123,NULL,'Rua do crime, 123','536259426','Brasília','Distrito Federal',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-06-24 23:08:19
