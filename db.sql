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
  `groups` bigint(20) NOT NULL DEFAULT 0,
  `charTable` text NOT NULL DEFAULT '{}',
  `SkinMdf` text NOT NULL DEFAULT '{}',
  `clothes` text DEFAULT '{}',
  `is_dead` int(11) DEFAULT 0,
  PRIMARY KEY (`charid`),
  KEY `FK_characters_users` (`user_id`),
  CONSTRAINT `FK_characters_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.characters: ~6 rows (aproximadamente)
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(84, 3, 'Serjão Berranteiro', 16, 33, 2584, '{}', 9, '{"hunger": "0", "thirst": "0", "banco": "51000", "position": "[-2604.174,288.381,147.036]", "dog": "A_C_DogHusky_01", "posse": "57", "stats": "[250,33.6,100,100]"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[]","model":"mp_male"}', '{"Outfit": "23"}', 0),
	(107, 4, 'saaadadad', 2, 123, 210, '{}', 1, '{"hunger": "0", "thirst": "0", "banco": "2000", "position": "[2713.944,142.423,53.997]", "stats": "[250,20.5,100,42]", "posse": "57"}', '{"modSkin":"[732816121,null,885240113,202858862,null,1629650936]","pedSize":1.0,"model":"mp_male","bodySize":126,"features":"[0.0,0.3,0.2,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.1,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"vests": "0x250E43A3", "coats": "0x22A8A5DA", "shirts": "0x16AD55DC", "hat": "0x11D847BB", "spurs": "0x1CA207BD", "offhand": "0x1DB9FEE8", "masks": "0x270FFC87", "beltbuckle": "0x18F5C8D7", "gloves": "0x18A95C7", "neckwear": "0x164C04CF", "boots": "0x12F962EC", "chaps": "0x1F6783A7"}', 0),
	(109, 6, 'Florence Claremont', 1, 24, 160, '{}', 1, '{"hunger": "0", "thirst": "0", "banco": "4000", "position": "[-820.754,-1312.87,43.711]"}', '{"modSkin":"[196967420,null,923281039,923281039]","model":"mp_female","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{}', 1),
	(110, 5, 'Tião', 4, 18, 240, '{}', 1, '{"hunger": "0", "thirst": "0", "banco": "2000", "position": "[1554.943,1450.113,146.61]", "stats": "[249,26.75,100,69]"}', '{"model":"mp_male","pedSize":1.079995,"bodySize":125,"modSkin":"[1077303312,429332843,1519555092,4045206010,46507404,712446626,382614413]","features":"[-0.4,0.2,0.1,0.2,0.5,0.4,0.5,0.4,0.8,0.6,0.0,0.5,0.7,0.1,0.3,0.2,0.0,0.0,0.0,0.4,0.6,-0.2,0.1,-0.8,-0.2,0.6,0.3,0.6,0.4,0.8,0.6,0.8,0.0,0.6,0.9,0.4,0.6,0.9,0.2]"}', '[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]', 0),
	(111, 3, 'Zezin', 1, 30, 10, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2655.98,-1144.508,50.789]", "stats": "[10,32.76,10,96]"}', '{"pedSize":0.920005,"bodySize":124,"model":"mp_male","features":"[0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[1201891801,306039588,1773547611,1824319804,642477207,null,306678665]"}', '{}', 0),
	(112, 8, 'cdzx', 1, 21650, 10, '{}', 1, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-92.13,213.156,99.688]", "stats": "[170,23.85,100,56]"}', '{"pedSize":1.0,"model":"mp_female","modSkin":"[]","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{}', 0);
/*!40000 ALTER TABLE `characters` ENABLE KEYS */;

-- Copiando estrutura para tabela redm.chests
CREATE TABLE IF NOT EXISTS `chests` (
  `id` tinytext NOT NULL DEFAULT 'AUTO_INCREMENT',
  `charid` int(11) DEFAULT NULL,
  `position` text NOT NULL DEFAULT '{}[]',
  `type` int(11) NOT NULL,
  `capacity` int(11) NOT NULL,
  KEY `FK_chests_characters` (`charid`),
  CONSTRAINT `FK_chests_characters` FOREIGN KEY (`charid`) REFERENCES `characters` (`charid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.chests: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `chests` DISABLE KEYS */;
INSERT IGNORE INTO `chests` (`id`, `charid`, `position`, `type`, `capacity`) VALUES
	('45', NULL, '[-63.092,331.621,110.446,180.0]', 0, 20);
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
INSERT IGNORE INTO `fort` (`id`, `nome`, `bando`) VALUES
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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.horses: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `horses` DISABLE KEYS */;
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(15, 84, 'A_C_Horse_AmericanStandardbred_Buckskin', 'CavaloRuim', '["0x106961A8","0x3278996D","0x67AF7302","0x1D4EDB88","0x130E341A","0x12DBBBAF","0x333CDC06","0x12F0DF9F"]'),
	(16, 84, 'A_C_HORSE_MORGAN_FLAXENCHESTNUT', 'CavaloBom', '["0x14168240","0x19C5E80C","0x587DD49F","0x20AA8620","0x14098229","0x1BB5EAA1","0x2A28C8BE","0x12F0DF9F"]');
/*!40000 ALTER TABLE `horses` ENABLE KEYS */;

-- Copiando estrutura para tabela redm.inventories
CREATE TABLE IF NOT EXISTS `inventories` (
  `id` varchar(100) NOT NULL,
  `charid` int(11) DEFAULT NULL,
  `inv_capacity` tinyint(4) DEFAULT 20,
  `inv_slots` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`inv_slots`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.inventories: ~48 rows (aproximadamente)
/*!40000 ALTER TABLE `inventories` DISABLE KEYS */;
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:83', 83, 20, '{}'),
	('char:84', 84, 20, '{"75": "[\\"lasso\\",1]", "129": "[\\"revolver_lemat\\",1,1,0]", "131": "[\\"melee_hatchet\\",1,0,1]", "130": "[\\"bow\\",1,0,0]", "132": "[\\"fishingrod\\",1,0,1]", "17": "[\\"moonshine\\",1]", "65": "[\\"pistol_m1899\\",1,8,10]", "97": "[\\"money\\",5244]", "66": "[\\"thrown_molotov\\",5,0,1]", "49": "[\\"herb_oregano\\",1]", "50": "[\\"herb_lady_slipper\\",1]", "51": "[\\"flask\\",4]", "18": "[\\"opio\\",2]", "52": "[\\"coal\\",4]", "53": "[\\"corn\\",1]", "54": "[\\"marijuana_seed\\",1]", "55": "[\\"herb_american_ginseng\\",1]"}'),
	('char:85', 85, 20, '{}'),
	('char:86', 86, 20, '{}'),
	('char:87', 87, 20, '{}'),
	('char:88', 88, 20, '{}'),
	('char:89', 89, 20, '{}'),
	('char:90', 90, 20, '{}'),
	('char:91', 91, 20, '{}'),
	('char:92', 92, 20, '{}'),
	('char:93', 93, 20, '{}'),
	('char:94', 94, 20, '{}'),
	('char:95', 95, 20, '{}'),
	('char:96', 96, 20, '{}'),
	('char:97', 97, 20, '{}'),
	('char:98', 98, 20, '{}'),
	('char:99', 99, 20, '{}'),
	('char:100', 100, 20, '{}'),
	('char:101', 101, 20, '{}'),
	('char:102', 102, 20, '{}'),
	('char:103', 103, 20, '{}'),
	('char:104', 104, 20, '{}'),
	('char:105', 105, 20, '{}'),
	('char:106', 106, 20, '{}'),
	('char:107', 107, 20, '{"129": "[\\"melee_knife\\",1,0,1]", "97": "[\\"money\\",6000]", "130": "[\\"revolver_cattleman\\",1,0,0]", "131": "[\\"lasso\\",1]"}'),
	('char:108', 108, 20, '{}'),
	('char:109', 109, 20, '{}'),
	('char:110', 110, 20, '{"129": "[\\"revolver_cattleman\\",1,6,59]", "97": "[\\"money\\",150000]", "130": "[\\"lasso\\",1]", "65": "[\\"lasso\\",1]", "131": "[\\"fishingrod\\",1,0,1]", "49": "[\\"meat_perfect\\",1]"}'),
	('horse:15', 84, 20, '{}'),
	('horse:17', 84, 20, '{}'),
	('horse:18', 84, 20, '{}'),
	('horse:19', 84, 20, '{}'),
	('horse:20', 84, 20, '{}'),
	('horse:21', 84, 20, '{}'),
	('horse:22', 84, 20, '{}'),
	('horse:23', 84, 20, '{}'),
	('horse:24', 84, 20, '{}'),
	('horse:25', 84, 20, '{}'),
	('horse:26', 84, 20, '{}'),
	('horse:27', 84, 20, '{}'),
	('horse:28', 84, 20, '{}'),
	('chest:static:trooper:1', 0, 60, '{}'),
	('chest:static:trooper:2', 0, 60, '{}'),
	('chest:static:trooper:3', 0, 60, '{}'),
	('static:public:2:84', 84, 100, '{}'),
	('static:public:2:84', 84, 100, '{}'),
	('char:111', 111, 40, '{}'),
	('char:112', 112, 40, '{"97": "[\\"money\\",20300]", "129": "[\\"revolver_lemat\\",1,9,76]", "67": "[\\"lasso\\",1]", "66": "[\\"lasso\\",1]", "65": "[\\"lasso\\",1]", "68": "[\\"repeater_winchester\\",1,0,0]", "72": "[\\"revolver_cattleman\\",1,0,0]", "70": "[\\"revolver_cattleman\\",1,0,0]", "71": "[\\"revolver_cattleman\\",1,0,0]", "69": "[\\"ammo_arrow\\",20]", "74": "[\\"bow\\",1,0,0]", "73": "[\\"bow\\",1,0,0]"}');
/*!40000 ALTER TABLE `inventories` ENABLE KEYS */;

-- Copiando estrutura para procedure redm.inv_remove_slot
DELIMITER //
CREATE PROCEDURE `inv_remove_slot`(
IN `inv_id` VARCHAR(100), IN `slot_id` INT
)
BEGIN
    UPDATE inventories SET inv_slots = JSON_REMOVE(inv_slots, CONCAT("$.", slot_id)) WHERE id = inv_id;
END//
DELIMITER ;

-- Copiando estrutura para procedure redm.inv_update_slot
DELIMITER //
CREATE PROCEDURE `inv_update_slot`(
IN `inv_id` VARCHAR(100), IN `slot_id` INT(8), IN `slot_value` VARCHAR(255)
)
BEGIN
    UPDATE inventories SET inv_slots = JSON_SET(inv_slots, CONCAT("$.", slot_id), slot_value) WHERE id = inv_id;
END//
DELIMITER ;

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
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.posses: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `posses` DISABLE KEYS */;
INSERT IGNORE INTO `posses` (`id`, `charid`, `members`, `name`) VALUES
	(57, 84, '{"84":1}', 'Klan');
/*!40000 ALTER TABLE `posses` ENABLE KEYS */;

-- Copiando estrutura para procedure redm.procInventory
DELIMITER //
CREATE PROCEDURE `procInventory`(
	IN `iid` VARCHAR(20),
	IN `charid` INT(8),
	IN `capacity` INT(8),
	IN `slot` INT(8),
	IN `itemId` VARCHAR(100),
	IN `itemAmount` INT(8),
	IN `procType` VARCHAR(8)
)
BEGIN
    IF (procType = "update") THEN
		UPDATE inventories SET inv_slots = JSON_SET(inv_slots, CONCAT("$.", slot), "{}") WHERE id = iid;
        UPDATE inventories SET inv_slots = JSON_SET(inv_slots, CONCAT(CONCAT("$.", slot), "[0]"), itemId, CONCAT(CONCAT("$.", slot), "[1]"), itemAmount) WHERE id = iid;
    ELSEIF (procType = "updateAmmoOnly") THEN
        UPDATE inventories SET inv_slots = JSON_SET(inv_slots, CONCAT(CONCAT("$.", slot), "[3]"), itemAmmoInClip, CONCAT(CONCAT("$.", slot), "[4]"), itemAmmoInWeapon) WHERE id = iid;
    ELSEIF (procType = "remove") THEN
        UPDATE inventories SET inv_slots = JSON_REMOVE(inv_slots, CONCAT("$.", slot)) WHERE id = iid;
    ELSEIF (procType = "select") THEN
        SELECT * from inventories WHERE id = iid;
    ELSEIF (procType = "insert") THEN
        INSERT INTO inventories(id, charid, inv_capacity, inv_slots) VALUES (iid, charid, capacity, "{}");
    ELSEIF (procType = "clear") THEN
        UPDATE inventories SET inv_slots = "{}" WHERE id = iid and charid = charid;
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

-- Copiando estrutura para tabela redm.tents
CREATE TABLE IF NOT EXISTS `tents` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charid` int(11) NOT NULL,
  `model` bigint(20) NOT NULL,
  `position` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4;

-- Copiando dados para a tabela redm.tents: ~43 rows (aproximadamente)
/*!40000 ALTER TABLE `tents` DISABLE KEYS */;
INSERT IGNORE INTO `tents` (`id`, `charid`, `model`, `position`) VALUES
	(42, 84, 1231676579, '{"z":115.02,"rotx":2.95,"rotz":-33.36,"roty":0.0,"y":742.15,"x":-367.59,"h":326.6}'),
	(43, 84, -838945132, '{"z":115.41,"rotx":-3.28,"rotz":48.17,"roty":0.0,"y":727.07,"x":-363.1,"h":48.22}'),
	(46, 84, 615627222, '{"rotx":-10.22,"z":170.78,"rotz":118.61,"h":118.23,"y":2027.67,"roty":-0.01,"x":2373.54}'),
	(47, 84, 615627222, '{"z":170.81,"rotx":-10.7,"roty":0.0,"rotz":-67.59,"h":292.06,"x":2374.21,"y":2027.78}'),
	(53, 84, -1223489959, '{"roty":-0.01,"rotz":95.14,"h":95.11,"y":556.74,"z":103.19,"x":-498.79,"rotx":-6.43}'),
	(55, 84, -1775023743, '{"roty":0.0,"rotz":-31.09,"x":-502.14,"y":561.47,"z":103.01,"rotx":-22.71,"h":326.83}'),
	(61, 84, 737690157, '{"rotz":-92.04,"y":-2302.63,"x":1328.96,"rotx":0.0,"z":47.54,"roty":0.0,"h":267.96}'),
	(62, 84, -689630872, '{"rotz":-0.89,"y":-2301.26,"x":1329.55,"h":359.11,"z":47.58,"roty":0.0,"rotx":0.0}'),
	(63, 84, 1946434792, '{"rotx":0.0,"z":58.05,"y":109.55,"h":298.37,"x":2689.75,"roty":0.0,"rotz":-61.63}'),
	(64, 84, -1775023743, '{"rotx":0.0,"y":107.08,"z":58.17,"x":2688.8,"h":142.92,"roty":0.0,"rotz":142.92}'),
	(65, 84, 737690157, '{"rotx":0.0,"roty":0.0,"rotz":61.09,"h":61.09,"x":2688.73,"y":107.44,"z":58.16}'),
	(66, 84, -1775023743, '{"rotx":0.0,"rotz":0.0,"x":-2.76,"y":3.68,"h":0.0,"roty":0.0,"z":-0.01}'),
	(67, 84, -1775023743, '{"rotx":0.0,"z":59.68,"y":100.13,"x":2686.27,"h":179.14,"roty":0.0,"rotz":179.14}'),
	(68, 84, -1775023743, '{"rotx":-0.39,"roty":-5.0,"rotz":147.52,"h":147.61,"x":2687.75,"y":87.35,"z":58.44}'),
	(69, 84, -1775023743, '{"rotx":-2.97,"h":50.93,"roty":0.0,"rotz":50.89,"x":2707.86,"y":137.74,"z":53.22}'),
	(70, 84, -1775023743, '{"rotx":-5.3,"rotz":-92.19,"roty":0.0,"x":2711.23,"h":267.82,"y":128.05,"z":52.89}'),
	(71, 84, -1775023743, '{"rotx":-0.64,"roty":0.0,"rotz":20.21,"z":53.56,"y":140.13,"x":2702.15,"h":20.21}'),
	(72, 84, -1775023743, '{"x":2698.05,"roty":0.0,"rotz":0.0,"z":53.35,"rotx":-3.54,"h":0.0,"y":149.7}'),
	(76, 84, 1946434792, '{"rotx":-8.33,"z":107.1,"y":-14.53,"h":0.0,"rotz":0.0,"roty":0.0,"x":280.77}'),
	(77, 84, 1946434792, '{"rotx":-25.09,"z":106.91,"rotz":0.0,"h":0.0,"y":-18.68,"roty":0.0,"x":274.54}'),
	(78, 84, 1946434792, '{"rotx":-15.03,"z":106.7,"x":280.76,"h":0.0,"y":-28.63,"roty":0.0,"rotz":0.0}'),
	(79, 84, 1946434792, '{"rotx":-25.46,"z":106.57,"y":-26.55,"x":275.83,"rotz":0.0,"roty":0.0,"h":0.0}'),
	(80, 84, 1946434792, '{"rotx":-16.88,"z":106.49,"y":-30.23,"x":271.65,"rotz":0.0,"roty":0.0,"h":0.0}'),
	(81, 84, 1946434792, '{"rotx":-17.48,"z":105.85,"y":-41.15,"x":262.93,"rotz":0.0,"roty":0.0,"h":0.0}'),
	(82, 84, 1946434792, '{"rotx":-16.15,"z":105.04,"x":255.4,"h":0.0,"y":-40.59,"roty":0.0,"rotz":0.0}'),
	(83, 84, 1946434792, '{"rotx":-14.38,"z":103.7,"y":-46.53,"x":248.8,"rotz":0.0,"roty":0.0,"h":0.0}'),
	(84, 84, 1946434792, '{"rotx":-5.92,"z":103.3,"y":-56.93,"x":243.66,"rotz":0.0,"roty":0.0,"h":0.0}'),
	(85, 84, 1946434792, '{"rotx":-23.82,"z":103.16,"y":-53.04,"x":234.87,"rotz":0.0,"roty":0.0,"h":0.0}'),
	(86, 84, 1946434792, '{"rotx":-19.15,"z":102.13,"y":-45.1,"x":224.65,"rotz":0.0,"roty":0.0,"h":0.0}'),
	(87, 84, 1946434792, '{"rotx":-15.49,"z":102.45,"y":-23.3,"x":229.76,"rotz":0.0,"roty":0.0,"h":0.0}'),
	(88, 84, 1946434792, '{"rotx":-17.82,"z":102.46,"y":-20.6,"x":223.42,"rotz":0.0,"roty":0.0,"h":0.0}'),
	(89, 84, 1946434792, '{"rotx":-16.74,"z":102.18,"y":-28.05,"x":222.83,"rotz":0.0,"roty":0.0,"h":0.0}'),
	(90, 84, 1946434792, '{"rotx":-27.66,"z":106.06,"y":-15.61,"x":263.79,"rotz":0.0,"roty":0.0,"h":0.0}'),
	(91, 84, 1946434792, '{"rotx":-24.52,"z":106.86,"y":-21.94,"x":273.0,"rotz":0.0,"roty":0.0,"h":0.0}'),
	(92, 84, 1946434792, '{"rotx":-16.54,"z":107.03,"y":-22.22,"x":288.72,"rotz":0.0,"roty":0.0,"h":0.0}'),
	(93, 84, 1946434792, '{"rotx":-29.35,"z":106.77,"y":-26.98,"x":289.28,"rotz":0.0,"roty":0.0,"h":0.0}'),
	(94, 84, 1946434792, '{"rotx":-19.43,"z":106.49,"y":-15.78,"x":268.15,"rotz":0.0,"roty":0.0,"h":0.0}'),
	(95, 84, 1946434792, '{"rotx":-26.59,"z":105.73,"y":-7.34,"x":259.18,"rotz":0.0,"roty":0.0,"h":0.0}'),
	(96, 84, 1946434792, '{"rotx":-25.0,"z":105.92,"y":1.08,"x":261.6,"rotz":0.0,"roty":0.0,"h":0.0}'),
	(97, 84, 1946434792, '{"rotx":-25.43,"z":106.95,"y":-1.98,"x":280.88,"rotz":0.0,"roty":0.0,"h":0.0}'),
	(98, 84, 1946434792, '{"rotx":-19.75,"z":106.5,"y":5.99,"x":268.62,"rotz":0.0,"roty":0.0,"h":0.0}'),
	(99, 84, 1946434792, '{"rotx":-0.1,"z":106.5,"y":10.88,"x":265.98,"rotz":0.0,"roty":0.0,"h":0.0}'),
	(100, 84, 1946434792, '{"rotx":5.03,"z":106.32,"y":9.85,"x":261.63,"rotz":0.0,"roty":0.0,"h":0.0}');
/*!40000 ALTER TABLE `tents` ENABLE KEYS */;

-- Copiando estrutura para tabela redm.users
CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(21) NOT NULL,
  `name` varchar(50) NOT NULL,
  `banned` int(11) unsigned NOT NULL DEFAULT 0,
  `reason` varchar(50) NOT NULL DEFAULT 'não definido',
  PRIMARY KEY (`user_id`),
  KEY `identifier` (`identifier`),
  CONSTRAINT `FK_users_whitelist` FOREIGN KEY (`identifier`) REFERENCES `whitelist` (`identifier`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.users: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`, `reason`) VALUES
	(3, 'steam:11000010596ee06', 'KlandesTino', 0, ''),
	(4, 'steam:110000109766c18', 'key_value', 0, ''),
	(5, 'steam:110000106321dbf', 'Tião Santo', 0, 'não definido'),
	(6, 'steam:1100001349014c1', '♥', 0, 'não definido'),
	(7, 'steam:110000115598f8c', 'gashex', 0, 'não definido'),
	(8, 'steam:1100001063df198', 'Nhish', 0, 'não definido');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Copiando estrutura para tabela redm.whitelist
CREATE TABLE IF NOT EXISTS `whitelist` (
  `id` int(11) NOT NULL,
  `identifier` varchar(21) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.whitelist: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `whitelist` DISABLE KEYS */;
INSERT IGNORE INTO `whitelist` (`id`, `identifier`) VALUES
	(1, 'steam:11000010596ee06'),
	(3, 'steam:110000106321dbf'),
	(5, 'steam:1100001063df198'),
	(2, 'steam:110000109766c18'),
	(0, 'steam:110000115598f8c'),
	(4, 'steam:1100001349014c1');
/*!40000 ALTER TABLE `whitelist` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
