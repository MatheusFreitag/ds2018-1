UNLOCK TABLES;
DROP DATABASE IF EXISTS `Banco`;
CREATE DATABASE IF NOT EXISTS `Banco`;

USE `Banco`;

/*QUERIES DE CRIAÇÃO DAS TABELAS:*/

DROP TABLE IF EXISTS `Usuario`;
CREATE TABLE `Usuario` (
  `CPF` VARCHAR(11) NOT NULL PRIMARY KEY,
  `Nome` VARCHAR(45) NOT NULL,
  `Nascimento` DATE NOT NULL,
  `RG` VARCHAR(14) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Sexo` ENUM('M','F') NULL,
  `Senha` VARCHAR(20) NOT NULL,
  `Foto` LONGBLOB NOT NULL,
  `Endereco` VARCHAR(50) NOT NULL,
  `Telefone` VARCHAR(11) NOT NULL,
  `Cidade` VARCHAR(30) NOT NULL,
  `Estado` VARCHAR(30) NOT NULL,
  `Avaliacao` FLOAT NULL DEFAULT 0,
  `NumeroAvaliacoes` INT NULL DEFAULT 0)
ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `Usuario` WRITE;
UNLOCK TABLES;

DROP TABLE IF EXISTS `Automovel`;
CREATE TABLE `Automovel` (
  `Placa` VARCHAR(7) NOT NULL PRIMARY KEY,
  `Marca` VARCHAR(20) NOT NULL,
  `Modelo` VARCHAR(20) NOT NULL,
  `Ano` VARCHAR(4) NOT NULL,
  `Cambio` ENUM('M', 'A', 'S') NOT NULL DEFAULT 'M',
  `Combustivel` ENUM('G', 'A', 'F', 'GN', 'D') NOT NULL DEFAULT 'G',
  `Direcao` ENUM('H', 'E', 'M', 'A') NOT NULL DEFAULT 'H',
  `PotenciaMotor` FLOAT NOT NULL DEFAULT 1.0,
  `Tipo` VARCHAR(10) NOT NULL,
  `Portas` INT NOT NULL,
  `Cor` VARCHAR(20) NOT NULL,
  `Chassi` VARCHAR(17) NOT NULL,
  `Disponibilidade` ENUM('D', 'I') NOT NULL DEFAULT 'I',
  `AirBag` ENUM('S', 'N') NOT NULL DEFAULT 'N',
  `ArCondicionado` ENUM('S', 'N') NOT NULL DEFAULT 'N',
  `Alarme` ENUM('S', 'N') NOT NULL DEFAULT 'N',
  `TravaEletrica` ENUM('S', 'N') NOT NULL DEFAULT 'N',
  `Som` ENUM('S', 'N') NOT NULL DEFAULT 'N',
  `VidroEletrico` ENUM('S', 'N') NOT NULL DEFAULT 'N',
  `Blindado` ENUM('S', 'N') NOT NULL DEFAULT 'N',
  `SensorRe` ENUM('S', 'N') NOT NULL DEFAULT 'N',
  `CameraRe` ENUM('S', 'N') NOT NULL DEFAULT 'N',
  `Titulo` VARCHAR(200) NOT NULL,
  `Descricao` VARCHAR(1000) NULL,
  `FotoVeiculoFrente` LONGBLOB NOT NULL,
  `FotoVeiculoInterior` LONGBLOB NOT NULL,
  `FotoVeiculoLateral` LONGBLOB NOT NULL,
  `FotoDocumento` LONGBLOB NOT NULL,
  `PossuiSeguro` ENUM('S', 'N') NOT NULL DEFAULT 'N',
  `Status` ENUM('A', 'R', 'P') NOT NULL DEFAULT 'P',
  `Cidade` VARCHAR(30) NOT NULL,
  `Estado` VARCHAR(30) NOT NULL,
  `Avaliacao` FLOAT NOT NULL,
  `NumeroAvaliacoes` INT NOT NULL DEFAULT 0,
  `PrecoDiaria` FLOAT NOT NULL,
  `CPF` VARCHAR(11) NOT NULL)
ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `Aluguel`;
CREATE TABLE `Aluguel` (
  `idAluguel` INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  `DataInicio` DATE NOT NULL,
  `DataFim` DATE NOT NULL,
  `Status` ENUM('N', 'O', 'C') NOT NULL DEFAULT 'N', /*Não começou, Ocorrendo, Concluído*/
  `CPF` VARCHAR(11) NOT NULL,
  `Placa` VARCHAR(7) NOT NULL,
  `idAvaliacao` INT) /*idAvaliacao só vai ser disponibilizado depois da Avaliação ser feita*/
ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `Avaliacao`;
CREATE TABLE `Avaliacao` (
  `idAvaliacao` INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
  `NotaAutomovel` FLOAT NOT NULL,
  `NotaUsuario` FLOAT NOT NULL,
  `Comentario` VARCHAR(500) NOT NULL,
  `idAluguel` INT NOT NULL)
ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `ListaAutomoveis`;
CREATE TABLE `ListaAutomoveis` (
  `CPF` VARCHAR(11) NOT NULL PRIMARY KEY,
  `Placa` VARCHAR(7) NOT NULL)
ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `Automovel` ADD CONSTRAINT `Automovel_fk_1` FOREIGN KEY (`CPF`) REFERENCES `Usuario` (`CPF`) ON DELETE CASCADE;
ALTER TABLE `Aluguel` ADD CONSTRAINT `Aluguel_fk_1` FOREIGN KEY (`CPF`) REFERENCES `Usuario` (`CPF`) ON DELETE CASCADE;
ALTER TABLE `Aluguel` ADD CONSTRAINT `Aluguel_fk_2` FOREIGN KEY (`Placa`) REFERENCES `Automovel` (`Placa`) ON DELETE CASCADE;
ALTER TABLE `Aluguel` ADD CONSTRAINT `Aluguel_fk_3` FOREIGN KEY (`idAvaliacao`) REFERENCES `Avaliacao` (`idAvaliacao`) ON DELETE CASCADE;
ALTER TABLE `Avaliacao` ADD CONSTRAINT `Avaliacao_fk_1` FOREIGN KEY (`idAluguel`) REFERENCES `Aluguel` (`idAluguel`) ON DELETE CASCADE;
ALTER TABLE `ListaAutomoveis` ADD CONSTRAINT `ListaAutomoveis_fk_1` FOREIGN KEY (`CPF`) REFERENCES `Usuario` (`CPF`) ON DELETE CASCADE;
ALTER TABLE `ListaAutomoveis` ADD CONSTRAINT `ListaAutomoveis_fk_2` FOREIGN KEY (`Placa`) REFERENCES `Automovel` (`Placa`) ON DELETE CASCADE;


/*QUERIES DE INSERÇÃO:*/

LOCK TABLES `Usuario` WRITE;
INSERT INTO `Usuario` VALUES ('02840193719', 'Fulano Silva', '1990-10-02', '5910394012', 'fulanosilva@gmail.com', 'M', '123teste', LOAD_FILE('C:/Users/Pennywise/Downloads/FotoUsuario.jpg'), 'Rua General Osório, 500', '53981230412', 'Pelotas', 'Rio Grande do Sul', 0.00, 0);
UNLOCK TABLES;

LOCK TABLES `Usuario` WRITE;
INSERT INTO `Usuario` VALUES ('42567189023', 'Ciclano Silva', '1990-10-02', '5910394012', 'fulanosilva@gmail.com', 'M', '123teste', LOAD_FILE('C:/Users/Pennywise/Downloads/FotoUsuario.jpg'), 'Rua General Osório, 500', '53981230412', 'Pelotas', 'Rio Grande do Sul', 0.00, 0);
UNLOCK TABLES;

LOCK TABLES `Automovel` WRITE;
INSERT INTO `Automovel` VALUES ('ICQ2941', 'Fiat', 'Uno', '2015', 'M', 'G', 'H', 2.0, 'Hatch', 4, 'Vermelho', '9BWZZZ377VT004251', 'I', 'S', 'S', 'S', 'S', 'S', 'N', 'N', 'N', 'N', 'Fiat Uno 2015 com baixa quilometragem', 'Ofereço para aluguel um Fiat Uno 2015 com baixa quilometragem e todo o conforto que você procura', LOAD_FILE('C:/Users/Pennywise/Downloads/FotoFrente.png'), LOAD_FILE('C:/Users/Pennywise/Downloads/FotoInterior.png'), LOAD_FILE('C:/Users/Pennywise/Downloads/FotoLateral.png'), LOAD_FILE('C:/Users/Pennywise/Downloads/FotoDocumento.jpg'), 'S', 'P', 'Pelotas', 'Rio Grande do Sul', 0.00, 0, 250.00, '02840193719');
UNLOCK TABLES;

LOCK TABLES `Automovel` WRITE;
INSERT INTO `Automovel` VALUES ('VWX5621', 'Fiat', 'Uno', '2015', 'M', 'G', 'H', 2.0, 'Hatch', 4, 'Vermelho', '9BWZZZ377VT004251', 'I', 'S', 'S', 'S', 'S', 'S', 'N', 'N', 'N', 'N', 'Fiat Uno 2015 com baixa quilometragem', 'Ofereço para aluguel um Fiat Uno 2015 com baixa quilometragem e todo o conforto que você procura', LOAD_FILE('C:/Users/Pennywise/Downloads/FotoFrente.png'), LOAD_FILE('C:/Users/Pennywise/Downloads/FotoInterior.png'), LOAD_FILE('C:/Users/Pennywise/Downloads/FotoLateral.png'), LOAD_FILE('C:/Users/Pennywise/Downloads/FotoDocumento.jpg'), 'S', 'P', 'Pelotas', 'Rio Grande do Sul', 0.00, 0, 250.00, '42567189023');
UNLOCK TABLES;

LOCK TABLES `Automovel` WRITE;
INSERT INTO `Automovel` VALUES ('JQZ4912', 'Fiat', 'Uno', '2015', 'M', 'G', 'H', 2.0, 'Hatch', 4, 'Vermelho', '9BWZZZ377VT004251', 'I', 'S', 'S', 'S', 'S', 'S', 'N', 'N', 'N', 'N', 'Fiat Uno 2015 com baixa quilometragem', 'Ofereço para aluguel um Fiat Uno 2015 com baixa quilometragem e todo o conforto que você procura', LOAD_FILE('C:/Users/Pennywise/Downloads/FotoFrente.png'), LOAD_FILE('C:/Users/Pennywise/Downloads/FotoInterior.png'), LOAD_FILE('C:/Users/Pennywise/Downloads/FotoLateral.png'), LOAD_FILE('C:/Users/Pennywise/Downloads/FotoDocumento.jpg'), 'S', 'P', 'Pelotas', 'Rio Grande do Sul', 0.00, 0, 250.00, '02840193719');
UNLOCK TABLES;

LOCK TABLES `ListaAutomoveis` WRITE;
INSERT INTO `ListaAutomoveis` VALUES ('02840193719', 'ICQ2941');
UNLOCK TABLES;

LOCK TABLES `ListaAutomoveis` WRITE;
INSERT INTO `ListaAutomoveis` VALUES ('42567189023', 'VWX5621');
UNLOCK TABLES;

LOCK TABLES `Aluguel` WRITE;
INSERT INTO `Aluguel` (`DataInicio`, `DataFim`, `Status`, `CPF`, `Placa`)
VALUES ('2018-06-02', '2018-06-10', 'N', '02840193719', 'ICQ2941');
UNLOCK TABLES;

LOCK TABLES `Aluguel` WRITE;
INSERT INTO `Aluguel` (`DataInicio`, `DataFim`, `Status`, `CPF`, `Placa`)
VALUES ('2018-08-10', '2018-09-10', 'N', '42567189023', 'VWX5621');
UNLOCK TABLES;

/*Atualização do status Aluguel quando começar, de fato:*/

LOCK TABLES `Aluguel` WRITE;
UPDATE `Aluguel`
SET `Status` = 'O'
WHERE `idAluguel` = 1;
UNLOCK TABLES;

/*ATENÇÃO nas tabelas Avaliação e Aluguel:
A tabela Aluguel tem como chave estrangeira idAvaliacao, que só vai ser gerada depois
do aluguel ser efetuado E avaliado. Então, ao fazer a avaliação, o idAluguel já deve
existir e ser inserido de maneira correta nesse insert abaixo. Aí depois de feita a
avaliação, se altera a tabela de Aluguel, linkando o idAvaliação feito naquele aluguel.
OBS: Enquanto não houver a avaliação feita, o idAvaliação fica com o valor 0.
OBS 2: idAvaliação e idAluguel estão com AUTO_INCREMENT, então são gerados e incrementados
automaticamente na medida que as tabelas Avaliação e Aluguel são preenchidas.
OBS 3: TODAS as queries abaixo, antes do começo das queries de edição, devem ser
executadas assim que for feita uma avaliação*/

LOCK TABLES `Avaliacao` WRITE;
INSERT INTO `Avaliacao` (`NotaAutomovel`, `NotaUsuario`, `Comentario`, `idAluguel`)
VALUES (5.00, 5.00, 'Carro em excelente estado, ótimo de dirigir', 1);
UNLOCK TABLES;

LOCK TABLES `Aluguel` WRITE;
UPDATE `Aluguel`
SET `idAvaliacao` = 1, `Status` = 'C' /*Aqui pega o idAvaliação que foi feito*/
WHERE `idAluguel` = 1; /*E bota na tabela Aluguel na linha do idAluguel usado na Avaliação*/
UNLOCK TABLES;

/*Atualização das notas de Usuário e Automóvel, depois de feita uma avaliação:*/

SET @CPFUsuario = (SELECT `CPF` from `Aluguel` where `idAvaliacao` = 1);
SET @NumeroAvaliacoesUsuario = (SELECT `NumeroAvaliacoes` from `Usuario` where (`CPF` = @CPFUsuario));
SET @NotaAtualUsuario = (SELECT `Avaliacao` from `Usuario` where `CPF` = @CPFUsuario);
LOCK TABLES `Usuario` WRITE;
UPDATE `Usuario`
SET `NumeroAvaliacoes` = (@NumeroAvaliacoesUsuario+1), `Avaliacao` = ((@NotaAtualUsuario + 5.00)/(@NumeroAvaliacoesUsuario+1))
WHERE `CPF` = @CPFUsuario;
UNLOCK TABLES;

SET @PlacaAutomovel = (SELECT `Placa` from `Aluguel` where `idAvaliacao` = 1);
SET @NumeroAvaliacoesAutomovel = (SELECT `NumeroAvaliacoes` from `Automovel` where (`Placa` = @PlacaAutomovel));
SET @NotaAtualAutomovel = (SELECT `Avaliacao` from `Automovel` where `Placa` = @PlacaAutomovel);
LOCK TABLES `Automovel` WRITE;
UPDATE `Automovel`
SET `NumeroAvaliacoes` = (@NumeroAvaliacoesAutomovel+1), `Avaliacao` = ((@NotaAtualAutomovel + 5.00)/(@NumeroAvaliacoesAutomovel+1))
WHERE `Placa` = @PlacaAutomovel;
UNLOCK TABLES;

/*QUERRY DE EDIÇÃO DE USUÁRIO*/

LOCK TABLES `Usuario` WRITE;
UPDATE `Usuario`
SET  `Email` = 'fulano@gmail.com', `Senha` = 'novasenha', `Foto` = ('C:/Users/Pennywise/Downloads/NovaFoto.png'), `Endereco` = 'Nova Rua, 200', `Telefone` = '51984205812', `Cidade` = 'Porto Alegre', `Estado` = 'Rio Grande do Sul'
WHERE `CPF` =  '02840193719';
UNLOCK TABLES;

/*Update do status do automóvel para disponível:*/

LOCK TABLES `Automovel` WRITE;
UPDATE `Automovel`
SET `Status` = 'D'
WHERE `Placa` = 'ICQ2941';
UNLOCK TABLES;

/*QUERRIES DE BUSCA*/

/*Busca usuario por cpf*/

LOCK TABLES `Usuario` WRITE;
SELECT * FROM `Usuario` 
WHERE `CPF` = '02840193719';
UNLOCK TABLES;

/*Busca usuario por nome*/

LOCK TABLES `Usuario` WRITE;
SELECT * FROM `Usuario` 
WHERE `Nome` = 'Fulano Silva';
UNLOCK TABLES;

/*Busca lista de carros do usuário*/

LOCK TABLES `Automovel` WRITE;
SELECT * FROM `Automovel` 
WHERE `CPF` = '02840193719';
UNLOCK TABLES;

/*Busca a avaliação de um certo aluguel*/

LOCK TABLES `Avaliacao` WRITE;
SELECT * FROM `Avaliacao` 
WHERE `idAluguel` = 1;
UNLOCK TABLES;

/*Busca as reservas de um usuário*/

LOCK TABLE `Aluguel` WRITE;
SELECT * FROM `Aluguel` 
WHERE `CPF` = '42567189023' AND `Status` = 'N';
UNLOCK TABLE;

/*Busca de carro utilizando os filtros*/

LOCK TABLE `Automovel` WRITE;
SELECT * FROM `Automovel` WHERE `Marca` = 'Fiat'
OR `Modelo` = 'Uno' 
OR `Ano` = '2015'
OR `Cambio` = 'M'
OR `Combustivel` = 'G' 
OR `Direcao` = 'H'
OR `PotenciaMotor` = 2.0 
OR `Tipo` = 'Hatch'
OR `Portas` = 4
OR `Cor` = 'Vermelho'
OR `AirBag` = 'S'
OR `ArCondicionado` = 'S'
OR `Alarme` = 'S' 
OR `TravaEletrica` = 'S' 
OR `Som` = 'S'
OR `VidroEletrico` = 'N' 
OR `Blindado` = 'N'
OR `SensorRe` = 'N'
OR `CameraRe` = 'N'
OR `PossuiSeguro` = 'S' 
OR `Cidade` = 'Pelotas'
OR `Estado` = 'Rio Grande do Sul'
OR `PrecoDiaria` = 100.0;
UNLOCK TABLE;

/*Busca de carro pela placa*/

LOCK TABLE `Automovel` WRITE;
SELECT * FROM `Automovel` 
WHERE `Placa` = 'ICQ2941';
UNLOCK TABLE;

/*QUERIES DE DELEÇÃO (Usuário e Automóvel):*/

LOCK TABLES `Usuario` WRITE;
DELETE FROM `Usuario`
WHERE `CPF` = '02840193719';
UNLOCK TABLES;

LOCK TABLES `Automovel` WRITE;
DELETE FROM `Automovel`
WHERE `Placa` = 'ICQ2941';
UNLOCK TABLES;