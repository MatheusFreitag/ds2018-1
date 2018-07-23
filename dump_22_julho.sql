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

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `c9` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `c9`;

--
-- Table structure for table `Aluguel`
--

DROP TABLE IF EXISTS `Aluguel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Aluguel` (
  `idAluguel` int(11) NOT NULL AUTO_INCREMENT,
  `DataInicio` date NOT NULL,
  `DataFim` date NOT NULL,
  `Status` enum('N','O','C') NOT NULL DEFAULT 'N',
  `CPF` varchar(11) NOT NULL,
  `Placa` varchar(7) NOT NULL,
  `idAvaliacao` int(11) DEFAULT NULL,
  PRIMARY KEY (`idAluguel`),
  KEY `Aluguel_fk_1` (`CPF`),
  KEY `Aluguel_fk_2` (`Placa`),
  KEY `Aluguel_fk_3` (`idAvaliacao`),
  CONSTRAINT `Aluguel_fk_3` FOREIGN KEY (`idAvaliacao`) REFERENCES `Avaliacao` (`idAvaliacao`) ON DELETE CASCADE,
  CONSTRAINT `Aluguel_fk_1` FOREIGN KEY (`CPF`) REFERENCES `Usuario` (`CPF`) ON DELETE CASCADE,
  CONSTRAINT `Aluguel_fk_2` FOREIGN KEY (`Placa`) REFERENCES `Automovel` (`Placa`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Aluguel`
--

LOCK TABLES `Aluguel` WRITE;
/*!40000 ALTER TABLE `Aluguel` DISABLE KEYS */;
/*!40000 ALTER TABLE `Aluguel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Automovel`
--

DROP TABLE IF EXISTS `Automovel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Automovel` (
  `Placa` varchar(7) NOT NULL,
  `Marca` varchar(20) NOT NULL,
  `Modelo` varchar(20) NOT NULL,
  `Ano` varchar(4) NOT NULL,
  `Cambio` varchar(255) DEFAULT NULL,
  `Combustivel` varchar(255) DEFAULT NULL,
  `Direcao` varchar(255) DEFAULT NULL,
  `PotenciaMotor` float NOT NULL DEFAULT '1',
  `Tipo` varchar(10) NOT NULL,
  `Portas` int(11) NOT NULL,
  `Cor` varchar(20) NOT NULL,
  `Chassi` varchar(17) NOT NULL,
  `Disponibilidade` enum('D','I') NOT NULL DEFAULT 'I',
  `AirBag` tinyint(1) DEFAULT NULL,
  `ArCondicionado` tinyint(1) DEFAULT NULL,
  `Alarme` tinyint(1) DEFAULT NULL,
  `TravaEletrica` tinyint(1) DEFAULT NULL,
  `Som` tinyint(1) DEFAULT NULL,
  `VidroEletrico` tinyint(1) DEFAULT NULL,
  `Blindado` tinyint(1) DEFAULT NULL,
  `SensorRe` tinyint(1) DEFAULT NULL,
  `CameraRe` tinyint(1) DEFAULT NULL,
  `Titulo` varchar(200) NOT NULL,
  `Descricao` varchar(1000) DEFAULT NULL,
  `FotoVeiculoFrente` longblob NOT NULL,
  `FotoVeiculoInterior` longblob NOT NULL,
  `FotoVeiculoLateral` longblob NOT NULL,
  `FotoDocumento` longblob NOT NULL,
  `PossuiSeguro` tinyint(1) DEFAULT NULL,
  `Status` varchar(255) DEFAULT NULL,
  `Cidade` varchar(30) NOT NULL,
  `Estado` varchar(30) NOT NULL,
  `Avaliacao` float NOT NULL,
  `NumeroAvaliacoes` int(11) NOT NULL DEFAULT '0',
  `PrecoDiaria` float NOT NULL,
  `CPF` varchar(11) NOT NULL,
  PRIMARY KEY (`Placa`),
  KEY `Automovel_fk_1` (`CPF`),
  CONSTRAINT `Automovel_fk_1` FOREIGN KEY (`CPF`) REFERENCES `Usuario` (`CPF`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Automovel`
--

LOCK TABLES `Automovel` WRITE;
/*!40000 ALTER TABLE `Automovel` DISABLE KEYS */;
INSERT INTO `Automovel` VALUES ('AAA-111','AUSI','A','1994','manual','alcool','eletrica',1,'Hatch',2,'Preto','aaa','D',1,1,1,1,1,1,1,1,1,'undefined','                                                                                          BBB        \r\n        \r\n        \r\n        \r\n        \r\n        \r\n        \r\n        \r\n        \r\n        ','images/automovel/fiatUno.jpg','images/automovel/fiatUno.jpg','images/automovel/fiatUno.jpg','images/automovel/fiatUno.jpg',1,'Disponivel','Pelotas','RS',5,0,42,'02840193719'),('ICQ2941','Fiat','Uno','2015','M','G','H',2,'Hatch',4,'Vermelho','9BWZZZ377VT004251','I',1,1,1,1,1,2,2,2,2,'Fiat Uno 2015 com baixa quilometragem','Ofereço para aluguel um Fiat Uno 2015 com baixa quilometragem e todo o conforto que você procura','images/automovel/fiatUno.jpg','images/automovel/fiatUno.jpg','images/automovel/fiatUno.jpg','images/automovel/fiatUno.jpg',1,'P','Pelotas','Rio Grande do Sul',0,0,250,'02840193719');
/*!40000 ALTER TABLE `Automovel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Avaliacao`
--

DROP TABLE IF EXISTS `Avaliacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Avaliacao` (
  `idAvaliacao` int(11) NOT NULL AUTO_INCREMENT,
  `NotaAutomovel` float NOT NULL,
  `NotaUsuario` float NOT NULL,
  `Comentario` varchar(500) NOT NULL,
  `idAluguel` int(11) NOT NULL,
  PRIMARY KEY (`idAvaliacao`),
  KEY `Avaliacao_fk_1` (`idAluguel`),
  CONSTRAINT `Avaliacao_fk_1` FOREIGN KEY (`idAluguel`) REFERENCES `Aluguel` (`idAluguel`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Avaliacao`
--

LOCK TABLES `Avaliacao` WRITE;
/*!40000 ALTER TABLE `Avaliacao` DISABLE KEYS */;
/*!40000 ALTER TABLE `Avaliacao` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ListaAutomoveis`
--

DROP TABLE IF EXISTS `ListaAutomoveis`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ListaAutomoveis` (
  `CPF` varchar(11) NOT NULL,
  `Placa` varchar(7) NOT NULL,
  PRIMARY KEY (`CPF`),
  KEY `ListaAutomoveis_fk_2` (`Placa`),
  CONSTRAINT `ListaAutomoveis_fk_2` FOREIGN KEY (`Placa`) REFERENCES `Automovel` (`Placa`) ON DELETE CASCADE,
  CONSTRAINT `ListaAutomoveis_fk_1` FOREIGN KEY (`CPF`) REFERENCES `Usuario` (`CPF`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ListaAutomoveis`
--

LOCK TABLES `ListaAutomoveis` WRITE;
/*!40000 ALTER TABLE `ListaAutomoveis` DISABLE KEYS */;
/*!40000 ALTER TABLE `ListaAutomoveis` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Usuario`
--

DROP TABLE IF EXISTS `Usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Usuario` (
  `CPF` varchar(11) NOT NULL,
  `Nome` varchar(45) NOT NULL,
  `Nascimento` date NOT NULL,
  `RG` varchar(14) NOT NULL,
  `Email` varchar(45) NOT NULL,
  `Sexo` enum('M','F') DEFAULT NULL,
  `Senha` varchar(20) NOT NULL,
  `Foto` longblob NOT NULL,
  `Endereco` varchar(50) NOT NULL,
  `Telefone` varchar(11) NOT NULL,
  `Cidade` varchar(30) NOT NULL,
  `Estado` varchar(30) NOT NULL,
  `Avaliacao` float DEFAULT '0',
  `NumeroAvaliacoes` int(11) DEFAULT '0',
  PRIMARY KEY (`CPF`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Usuario`
--

LOCK TABLES `Usuario` WRITE;
/*!40000 ALTER TABLE `Usuario` DISABLE KEYS */;
INSERT INTO `Usuario` VALUES ('02840193719','Fulano Silva','1990-10-02','5910394012','fulanosilva@gmail.com','M','123teste','images/automovel/fiatUno.jpg','Rua General Osório, 500','53981230412','Pelotas','Rio Grande do Sul',0,0);
/*!40000 ALTER TABLE `Usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-07-23  2:35:21
