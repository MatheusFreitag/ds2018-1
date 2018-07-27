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
  `FotoVeiculoFrente` varchar(255) DEFAULT NULL,
  `Titulo` varchar(200) DEFAULT NULL,
  `CPFDono` varchar(11) DEFAULT NULL,
  PRIMARY KEY (`idAluguel`),
  KEY `Aluguel_fk_1` (`CPF`),
  KEY `Aluguel_fk_2` (`Placa`),
  KEY `Aluguel_fk_3` (`idAvaliacao`),
  CONSTRAINT `Aluguel_fk_1` FOREIGN KEY (`CPF`) REFERENCES `Usuario` (`CPF`) ON DELETE CASCADE,
  CONSTRAINT `Aluguel_fk_2` FOREIGN KEY (`Placa`) REFERENCES `Automovel` (`Placa`) ON DELETE CASCADE,
  CONSTRAINT `Aluguel_fk_3` FOREIGN KEY (`idAvaliacao`) REFERENCES `Avaliacao` (`idAvaliacao`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Aluguel`
--

LOCK TABLES `Aluguel` WRITE;
/*!40000 ALTER TABLE `Aluguel` DISABLE KEYS */;
INSERT INTO `Aluguel` VALUES (3,'2018-08-10','2018-08-12','N','92831049323','LDO9120',NULL,'LDO9120_FotoVeiculo.jpg','fiat gol rebaixado com rodas volcano','03427485230'),(6,'2018-12-23','2019-01-02','N','19283109231','IVM6684',NULL,'IVM6684_FotoVeiculo.jpg','HB20 2017','92817392932'),(7,'2018-02-18','2018-02-24','N','03427485230','IGS2817',NULL,'IGS2817_FotoVeiculo.jpg','Renault Sandero 2016','92817392932');
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
  `FotoVeiculoFrente` varchar(255) DEFAULT NULL,
  `FotoVeiculoInterior` varchar(255) DEFAULT NULL,
  `FotoVeiculoLateral` varchar(255) DEFAULT NULL,
  `FotoDocumento` varchar(255) DEFAULT NULL,
  `PossuiSeguro` tinyint(1) DEFAULT NULL,
  `Status` varchar(255) DEFAULT NULL,
  `Cidade` varchar(30) NOT NULL,
  `Estado` varchar(30) NOT NULL,
  `Avaliacao` float NOT NULL DEFAULT '0',
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
INSERT INTO `Automovel` VALUES ('IFT1928','21','Palio 1.0 ECONOMY Fi','2008','manual','flex','mecanica',1,'Hatch',4,'Branco','63283718237','D',1,0,0,0,1,0,0,0,0,'Fiat Palio 1.0','','IFT1928_FotoVeiculo.jpg','IFT1928_FotoVeiculo.jpg','IFT1928_FotoVeiculo.jpg','IFT1928_FotoVeiculo.jpg',1,'Disponivel','Pelotas','RS',0,0,100,'56338223059'),('IGS2817','48','SANDERO STEP. Easy R','2016','manual','flex','hidraulica',1.6,'Hatch',4,'Branco','1381029372327','D',1,1,1,1,1,1,0,0,0,'Renault Sandero 2016','','IGS2817_FotoVeiculo.jpg','IGS2817_FotoVeiculo.jpg','IGS2817_FotoVeiculo.jpg','IGS2817_FotoVeiculo.jpg',1,'Disponivel','Pelotas','RS',0,0,50,'92817392932'),('IVM6684','26','HB20 Comfort Style 1','2017','manual','flex','mecanica',1,'Passeio',4,'Preto','80238121283','D',1,1,1,1,1,1,0,0,0,'HB20 2017','Todas as revisões feitas em concessionária e perfeito estado e conservação. Único dono. Não fumante.','IVM6684_FotoVeiculo.jpg','IVM6684_FotoVeiculo.jpg','IVM6684_FotoVeiculo.jpg','IVM6684_FotoVeiculo.jpg',1,'Disponivel','São Paulo','SP',3,1,135,'92817392932'),('IVT5436','21','UNO WAY 1.0 EVO Fire','2017','manual','flex','hidraulica',1,'Passeio',4,'Vermelho','12899830129147192','D',1,1,1,1,1,1,1,1,0,'Fiat Uno 1.0 Fora Temer','Carro novo, poucos quilômetros rodados, não alugo para vampiros.','IVT5436_FotoVeiculo.jpg','IVT5436_FotoVeiculo.jpg','IVT5436_FotoVeiculo.jpg','IVT5436_FotoVeiculo.jpg',1,'Disponivel','Porto Alegre','RS',0,0,150,'98129837483'),('LDO9120','59','Gol 1.0 Trend/ Power','2010','manual','gasolina','mecanica',1,'Passeio',4,'Branco','429311829793','D',1,0,1,0,1,0,0,0,0,'fiat gol rebaixado com rodas volcano','Gol G4 rebaixado com rodas Volcano Strong aro 18','LDO9120_FotoVeiculo.jpg','LDO9120_FotoVeiculo.jpg','LDO9120_FotoVeiculo.jpg','LDO9120_FotoVeiculo.jpg',1,'Disponivel','São Paulo','SP',0,0,200,'03427485230'),('OEX8273','22','Ranger Limited 2.3 1','2016','automatico','diesel','hidraulica',2,'Pick-up',4,'Vermelho','27371297312','D',1,1,1,1,1,1,1,1,1,'Ford Ranger 2016','Ar quente, Banco do motorista com ajuste de altura, Bancos de couro, Rádio e CD Player, Computador de bordo, Controle de tração, Encosto de cabeça traseiro, Freio ABS, Tração 4x4, Protetor de caçamba, Rádio, Retrovisores elétricos, Rodas de liga leve, Sensor de estacionamento, Volante com Regulagem de Altura, Capota marítima','OEX8273_FotoVeiculo.jpg','OEX8273_FotoVeiculo.jpg','OEX8273_FotoVeiculo.jpg','OEX8273_FotoVeiculo.jpg',1,'Disponivel','Angra dos Reis','RJ',0,0,345,'19283109231');
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
  CONSTRAINT `ListaAutomoveis_fk_1` FOREIGN KEY (`CPF`) REFERENCES `Usuario` (`CPF`) ON DELETE CASCADE,
  CONSTRAINT `ListaAutomoveis_fk_2` FOREIGN KEY (`Placa`) REFERENCES `Automovel` (`Placa`) ON DELETE CASCADE
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
INSERT INTO `Usuario` VALUES ('02381293028','Sandy & Junior','0000-00-00','9128319723','sandyejunior@gmail.com','F','010101','02381293028_FotoPerfil.jpg','Um lugarzinho no meio do nada','33415678','São Paulo','SP',0,0),('03427485230','Caio Castro','0000-00-00','1927912391723','caiocastro@uol.com.br','M','010101','03427485230_FotoPerfil.jpg','Rua Assis Brasil','34562894','Brasília','DF',0,0),('19283109231','Luis Inácio Lula da Silva','0000-00-00','98329382199','expresidentelula@gmail.com','M','010101','19283109231_FotoPerfil.jpg','Triplex','982746163','Angra dos Reis','RJ',4.25,1),('56338223059','Seu Jorge','0000-00-00','219873187238','seujorge@hotmail.com','M','010101','56338223059_FotoPerfil.jpg','Avenida São Pedro','33417568','Alto Horizonte','GO',0,0),('92817392932','Anitta','0000-00-00','rs2108439rs','anitta@uol.com.br','F','010101','92817392932_FotoPerfil.jpg','Rua 5','983718229','Rio de Janeiro','RJ',4,2),('92831049323','Felipe Neto','0000-00-00','98209381983','fneto@gmail.com','M','010101','92831049323_FotoPerfil.jpg','Rua 5','992847284','São Paulo','SP',0,0),('98129837483','Dilma Rousseff','0000-00-00','291823971','presidentadilma@gmail.com','F','010101','98129837483_FotoPerfil.jpg','Avenida Bento Gonçalves','982736127','Aceguá','RS',0,0);
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

-- Dump completed on 2018-07-27 17:37:07
