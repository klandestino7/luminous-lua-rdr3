-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.11-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win64
-- HeidiSQL Versão:              10.3.0.5771
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Copiando estrutura do banco de dados para redm
CREATE DATABASE IF NOT EXISTS `redm` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `redm`;

-- Copiando estrutura para tabela redm.characters
CREATE TABLE IF NOT EXISTS `characters` (
  `charid` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `characterName` varchar(50) NOT NULL,
  `level` int(11) DEFAULT 1,
  `age` int(11) DEFAULT 1,
  `xp` int(11) DEFAULT 0,
  `wanted` text NOT NULL DEFAULT '{}',
  `groups` text NOT NULL DEFAULT '{}',
  `charTable` text NOT NULL DEFAULT '{}',
  `SkinMdf` text NOT NULL DEFAULT '{}',
  `clothes` text DEFAULT '{}',
  `is_dead` int(11) DEFAULT 0,
  PRIMARY KEY (`charid`),
  KEY `FK_characters_users` (`user_id`),
  CONSTRAINT `FK_characters_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.characters: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;
/*!40000 ALTER TABLE `characters` ENABLE KEYS */;

-- Copiando estrutura para tabela redm.chests
CREATE TABLE IF NOT EXISTS `chests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charid` int(11) DEFAULT NULL,
  `position` text NOT NULL DEFAULT '{}[]',
  `type` int(11) NOT NULL,
  `capacity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_chests_characters` (`charid`),
  CONSTRAINT `FK_chests_characters` FOREIGN KEY (`charid`) REFERENCES `characters` (`charid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.chests: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `chests` DISABLE KEYS */;
INSERT INTO `chests` (`id`, `charid`, `position`, `type`, `capacity`) VALUES
	(45, NULL, '[100.1,200.2,300.2,180.0]', 0, 20);
/*!40000 ALTER TABLE `chests` ENABLE KEYS */;

-- Copiando estrutura para tabela redm.fort
CREATE TABLE IF NOT EXISTS `fort` (
  `id` int(11) NOT NULL DEFAULT 0,
  `nome` text NOT NULL DEFAULT '0',
  `bando` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.fort: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `fort` DISABLE KEYS */;
INSERT INTO `fort` (`id`, `nome`, `bando`) VALUES
	(1, 'Mercer', 0),
	(2, 'Wallace', 0);
/*!40000 ALTER TABLE `fort` ENABLE KEYS */;

-- Copiando estrutura para procedure redm.getData
DELIMITER //
CREATE PROCEDURE `getData`(
	IN `typeData` VARCHAR(10),
	IN `id` INT(8),
	IN `keyValue` VARCHAR(50)
)
BEGIN
	IF (keyValue = 'all' && typeData = 'clothes') THEN
		SELECT clothes as Value FROM characters WHERE charid = id;
	ELSEIF (keyValue = 'all' && typeData = 'wanted') THEN
		SELECT wanted as Value FROM characters WHERE charid = id;
	ELSEIF (keyValue = 'all' && typeData = 'groups') THEN
		SELECT groups as Value FROM characters WHERE charid = id;
	ELSEIF (keyValue = 'all' && typeData = 'charTable') THEN
		SELECT charTable as Value FROM characters WHERE charid = id;		
	ELSEIF (keyValue = 'all' && typeData = 'SkinMdf') THEN
		SELECT SkinMdf as Value FROM characters WHERE charid = id;			
	ELSEIF (keyValue = 'all' && typeData = 'modificacao') THEN
		SELECT modificacao as Value FROM horses WHERE id = id;
	END IF;
	
	
	IF (typeData = 'groups') THEN
		SELECT json_extract(groups, CONCAT("$.", keyValue)) as Value FROM characters WHERE charid = id;
	ELSEIF (typeData = 'wanted') THEN
		SELECT json_extract(wanted, CONCAT("$.", keyValue)) as Value FROM characters WHERE charid = id;
	ELSEIF (typeData = 'clothes') THEN
		SELECT json_extract(clothes, CONCAT("$.", keyValue)) as Value FROM characters WHERE charid = id;
	ELSEIF (typeData = 'charTable') THEN
		SELECT json_extract(charTable, CONCAT("$.", keyValue)) as Value FROM characters WHERE charid = id;
	ELSEIF (typeData = 'SkinMdf') THEN
		SELECT json_extract(SkinMdf, CONCAT("$.", keyValue)) as Value FROM characters WHERE charid = id;
	ELSEIF (typeData = 'modificacao') THEN
		SELECT json_extract(modificacao, CONCAT("$.", keyValue)) as Value FROM horses WHERE id = id;
	END IF;
END//
DELIMITER ;

-- Copiando estrutura para tabela redm.horses
CREATE TABLE IF NOT EXISTS `horses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charid` int(11) NOT NULL,
  `model` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `components` text NOT NULL DEFAULT '{}',
  PRIMARY KEY (`id`),
  KEY `FK_horses_characters` (`charid`),
  CONSTRAINT `FK_horses_characters` FOREIGN KEY (`charid`) REFERENCES `characters` (`charid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.horses: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `horses` DISABLE KEYS */;
/*!40000 ALTER TABLE `horses` ENABLE KEYS */;

-- Copiando estrutura para procedure redm.inventories
DELIMITER //
CREATE PROCEDURE `inventories`(
	IN `iid` VARCHAR(20),
	IN `charid` INT(8),
	IN `itemName` VARCHAR(100),
	IN `itemCount` INT(8),
	IN `typeInv` VARCHAR(8)



)
BEGIN
    IF (typeInv = "update") THEN
        UPDATE inventories SET items = JSON_SET(items, CONCAT("$.", itemName), itemCount) WHERE id = iid;
    ELSEIF (typeInv = "remove") THEN
        UPDATE inventories SET items = JSON_REMOVE(items, CONCAT("$.", itemName)) WHERE id = iid;
    ELSEIF (typeInv = "select") THEN
        SELECT * from inventories WHERE id = iid;
    ELSEIF (typeInv = "insert") THEN
        INSERT INTO inventories(id, charid, capacity, items) VALUES (iid, charid, 20, "{}");
    ELSEIF (typeInv = "deadPlayer") THEN
        UPDATE inventories SET items = '{}' WHERE id = iid and charid = charid;
    END IF;
END//
DELIMITER ;

-- Copiando estrutura para tabela redm.inventories
CREATE TABLE IF NOT EXISTS `inventories` (
  `id` varchar(100) NOT NULL,
  `charid` int(11) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `items` text NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_inventoriers_characters` (`charid`),
  CONSTRAINT `FK_inventories_characters` FOREIGN KEY (`charid`) REFERENCES `characters` (`charid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.inventories: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `inventories` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventories` ENABLE KEYS */;

-- Copiando estrutura para tabela redm.jail
CREATE TABLE IF NOT EXISTS `jail` (
  `id` int(11) NOT NULL DEFAULT 0,
  `charid` int(11) DEFAULT NULL,
  `jail_time` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_jail_characters` (`charid`),
  CONSTRAINT `FK_jail_characters` FOREIGN KEY (`charid`) REFERENCES `characters` (`charid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.jail: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `jail` DISABLE KEYS */;
/*!40000 ALTER TABLE `jail` ENABLE KEYS */;

-- Copiando estrutura para tabela redm.posses
CREATE TABLE IF NOT EXISTS `posses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charid` int(11) NOT NULL,
  `members` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `charid` (`charid`),
  CONSTRAINT `FK_posses_characters` FOREIGN KEY (`charid`) REFERENCES `characters` (`charid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.posses: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `posses` DISABLE KEYS */;
/*!40000 ALTER TABLE `posses` ENABLE KEYS */;

-- Copiando estrutura para procedure redm.procInventory
DELIMITER //
CREATE PROCEDURE `procInventory`(
	IN `iid` VARCHAR(20),
	IN `charid` INT(8),
	IN `slot` INT(8),
	IN `itemId` VARCHAR(100),
	IN `itemAmount` INT(8),
	IN `procType` VARCHAR(8)
)
BEGIN
    IF (procType = "update") THEN
        UPDATE inventories SET items = JSON_SET(items, 'CONCAT("$.", slot)[0]', itemId, 'CONCAT("$.", slot)[1]', itemAmount) WHERE id = iid;
    ELSEIF (procType = "remove") THEN
        UPDATE inventories SET items = JSON_REMOVE(items, CONCAT("$.", slot)) WHERE id = iid;
    ELSEIF (procType = "select") THEN
        SELECT * from inventories WHERE id = iid;
    ELSEIF (procType = "insert") THEN
        INSERT INTO inventories(id, charid, capacity, items) VALUES (iid, charid, 20, "{}");
    ELSEIF (procType = "clear") THEN
        UPDATE inventories SET items = '{}' WHERE id = iid and charid = charid;
    END IF;
END//
DELIMITER ;

-- Copiando estrutura para tabela redm.quests
CREATE TABLE IF NOT EXISTS `quests` (
  `questId` varchar(50) NOT NULL DEFAULT '0',
  `charid` int(11) NOT NULL AUTO_INCREMENT,
  `questSteps` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`questId`),
  KEY `charid` (`charid`),
  CONSTRAINT `FK_quests_characters` FOREIGN KEY (`charid`) REFERENCES `characters` (`charid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.quests: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `quests` DISABLE KEYS */;
/*!40000 ALTER TABLE `quests` ENABLE KEYS */;

-- Copiando estrutura para procedure redm.remData
DELIMITER //
CREATE PROCEDURE `remData`(
	IN `typeData` VARCHAR(20),
	IN `keyValue` VARCHAR(50),
	IN `id` INT(8)
)
BEGIN
	IF (typeData = 'groups') THEN
		UPDATE characters SET groups = JSON_REMOVE(groups, CONCAT("$.", keyValue)) WHERE charid = id;		
	ELSEIF (typeData = 'clothes') THEN
		UPDATE characters SET clothes = JSON_REMOVE(clothes, CONCAT("$.", keyValue)) WHERE charid = id;
	ELSEIF (typeData = 'wanted') THEN
		UPDATE characters SET wanted = JSON_REMOVE(wanted, CONCAT("$.", keyValue)) WHERE charid = id;
	ELSEIF (typeData = 'charTable') THEN
		UPDATE characters SET charTable = JSON_REMOVE(charTable, CONCAT("$.", keyValue)) WHERE charid = id;
	ELSEIF (typeData = 'SkinMdf') THEN
		UPDATE characters SET SkinMdf = JSON_REMOVE(SkinMdf, CONCAT("$.", keyValue)) WHERE charid = id;
	ELSEIF (typeData = 'modificacao') THEN
		UPDATE horses SET modificacao = JSON_REMOVE(modificacao, CONCAT("$.", keyValue)) WHERE charid = id;
	END IF;
END//
DELIMITER ;

-- Copiando estrutura para procedure redm.setData
DELIMITER //
CREATE PROCEDURE `setData`(
	IN `typeData` VARCHAR(20),
	IN `keyValue` VARCHAR(50),
	IN `valueKey` VARCHAR(50),
	IN `id` INT(8)
)
BEGIN
	IF (typeData = 'groups') THEN
		UPDATE characters SET groups = JSON_SET(groups, CONCAT("$.", keyValue), valueKey) WHERE charid = id;		
	ELSEIF (typeData = 'clothes') THEN
		UPDATE characters SET clothes = JSON_SET(clothes, CONCAT("$.", keyValue), valueKey) WHERE charid = id;	
	ELSEIF (typeData = 'wanted') THEN
		UPDATE characters SET wanted = JSON_SET(wanted, CONCAT("$.", keyValue), valueKey) WHERE charid = id;			
	ELSEIF (typeData = 'charTable') THEN
		UPDATE characters SET charTable = JSON_SET(charTable, CONCAT("$.", keyValue), valueKey) WHERE charid = id;		
	ELSEIF (typeData = 'SkinMdf') THEN
		UPDATE characters SET SkinMdf = JSON_SET(SkinMdf, CONCAT("$.", keyValue), valueKey) WHERE charid = id;
	ELSEIF (typeData = 'modificacao') THEN
		UPDATE horses SET modificacao = JSON_SET(modif, CONCAT("$.", keyValue), valueKey) WHERE id = id;
	END IF;
END//
DELIMITER ;

-- Copiando estrutura para tabela redm.users
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(21) NOT NULL,
  `name` varchar(50) NOT NULL,
  `banned` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`user_id`),
  KEY `identifier` (`identifier`),
  CONSTRAINT `FK_users_whitelist` FOREIGN KEY (`identifier`) REFERENCES `whitelist` (`identifier`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.users: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Copiando estrutura para tabela redm.whitelist
CREATE TABLE IF NOT EXISTS `whitelist` (
  `id` int(11) NOT NULL,
  `identifier` varchar(21) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.whitelist: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `whitelist` DISABLE KEYS */;
INSERT INTO `whitelist` (`id`, `identifier`) VALUES
	(1, 'steam:11000010596ee06');
/*!40000 ALTER TABLE `whitelist` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
