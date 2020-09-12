-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.4.11-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win32
-- HeidiSQL Versão:              10.2.0.5599
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
  `SkinMdf` text NOT NULL DEFAULT '[]',
  `clothes` text DEFAULT '{}',
  `is_dead` int(11) DEFAULT 0,
  PRIMARY KEY (`charid`),
  KEY `FK_characters_users` (`user_id`),
  CONSTRAINT `FK_characters_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=726 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.characters: ~404 rows (aproximadamente)
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(0, 0, 'system', 0, 0, 0, '{}', 0, '{}', '[]', '{}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(172, 7, 'jack', 4, 18, 820, '{}', 1, '{"hunger": "0", "thirst": "0", "banco": "14000", "position": "[-340.551,866.589,115.522]", "stats": "[250,33.6,100,100]"}', '{"modSkin":"[]","model":"mp_male","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"boots": "0x38772DE7", "vests": "0x5CECE174", "hat": "0x1B8C8FD9", "pants": "0x774537CE", "shirts": "0x1D615E9", "gunbelts": "0x620C1BC5"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(189, 4, 'Ze Bigorna', 1, 18, 300, '{}', 25, '{"hunger": "0", "thirst": "0", "banco": "12000", "position": "[1430.956,-1284.413,77.875]", "posse": "59", "stats": "[250,33.6,100,100]"}', '{"features":"[0.0,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[1201891801,740714047,885240113,202858862,642477207]","model":"mp_male","pedSize":1.05}', '{"hat": "0x1796EC71", "coats2": "0", "coats": "0xEF678D3", "pants": "0x12D463B0", "boots": "0x10E40F4E"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(193, 6, 'Marcin da vila', 5, 27, 290, '{"Rhodes": "1001"}', 257, '{"hunger": "0", "thirst": "0", "banco": "5000", "position": "[2554.887,1517.622,87.095]", "stats": "[25,11.2,25,0]"}', '{"bodySize":125,"features":"[-0.9,0.1,0.5,0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,0.8,0.0,0.0,0.0,0.2,0.0,0.0,0.0,0.0,0.0,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[487821771,null,1180660122,2539219498]","pedSize":1.06,"model":"mp_male"}', '{"beltbuckle": "0x5FE96AD9", "pants": "0xE1B0ABFF", "boots": "0xC430AF11", "eyewear": "0xB72097D4", "hat": "0x342B7753", "gunbelts": "0x620C1BC5", "belts": "0", "gloves": "0x10BD09BD", "shirts": "0x12801254", "suspenders": "0", "offhand": "0", "ponchos": "0", "vests": "0x59786AE7", "coats2": "0xCAB6E0A9", "access": "0", "masks": "0", "legs": "0", "cloaks": "0", "neckwear": "0", "chaps": "0", "spurs": "0", "neckties": "0x67B0CC14", "skirts": "0", "gauntlets": "0", "bracelets": "0", "coats": "0", "spats": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(196, 6, 'Marcin da vila', 1, 27, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-225.934,819.74,124.305]"}', '{"bodySize":125,"features":"[-0.9,0.1,0.5,0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,0.8,0.0,0.0,0.0,0.2,0.0,0.0,0.0,0.0,0.0,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[487821771,null,1180660122,2539219498]","pedSize":1.06,"model":"mp_male"}', '{}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(204, 7, 'Jack Houston', 2, 27, 122, '{}', 1, '{"hunger": "0", "thirst": "0", "banco": "36000", "position": "[676.2,-650.24,71.418]", "stats": "[236,33.6,100,100]"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[2696825467,623103571,543187419,2226823945,612262189,null,502538388]","model":"mp_male","bodySize":128}', '{"pants": "0x1D8ADDD1", "boots": "0x20D85860", "coats2": "0", "shirts": "0x1D615E9", "vests": "0", "hat": "0", "gunbelts": "0x620C1BC5", "coats": "0", "masks": "0", "neckwear": "0", "gauntlets": "0", "spurs": "0", "bracelets": "0", "gloves": "0", "access": "0", "ponchos": "0", "neckties": "0", "belts": "0", "eyewear": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(229, 1, 'Serjão Berranteiro', 14, 38, 1352, '{}', 9, '{"hunger": "0", "thirst": "0", "banco": "253500", "position": "[2797.688,-1382.232,51.776]", "stats": "[250,31.24,100,89]"}', '{"pedSize":1.005333,"features":"[0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":127,"modSkin":"[1631383957,1037287971,1519555092,4045206010,2432743988,null,481122513]","model":"mp_male"}', '{"boots": "0x1002199A", "hat": "0x1B8C8FD9", "gunbelts": "0x10CD7D44", "pants": "0x10051C7", "shirts": "0x1281AB3F", "coats2": "0x2F00ED28", "coats": "0", "chaps": "0", "vests": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(235, 1, 'Billy Joe', 1, 30, 0, '{}', 1, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-744.539,-1278.609,43.236]"}', '{"bodySize":125,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[361543666,332193580,543187419,2226823945,612262189,null,298392309]","pedSize":1.079995,"model":"mp_male"}', '{}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(240, 52, 'John Miller', 1, 18, 4, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "95264", "position": "[-270.907,809.043,119.37]", "stats": "[250,32.97,100,97]", "dog": "A_C_DogAmericanFoxhound_01"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","pedSize":1.0,"modSkin":"[908431499,2670890105,1180660122,2539219498,1552505114,null,3359587060]","bodySize":128}', '{"shirts": "0x9CB923E0", "pants": "0xD50D1A3D", "boots": "0xE84EF68D", "eyewear": "0x9A1DFEE", "hat": "0x9A3DA99D", "vests": "0xC5AD8CF2", "coats2": "0xBD2A56CA", "gloves": "0xC48D9BD2", "gunbelts": "0x5261D9F3", "neckwear": "0", "beltbuckle": "0xA9E228BA", "belts": "0", "offhand": "0xE07C3B9A", "spurs": "0x1F7752AF", "coats": "0", "access": "0", "gauntlets": "0", "cloaks": "0", "neckties": "0x7E246698", "chaps": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(241, 53, 'Will Kane', 11, 25, 735, '{"Blackwater": "100"}', 12, '{"hunger": "0", "thirst": "0", "banco": "372400", "position": "[1228.741,-1297.231,76.905]", "stats": "[177,33.6,100,100]"}', '{"features":"[0.0,0.0,0.0,0.0,0.9,0.0,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","pedSize":1.0,"modSkin":"[908431499,576291658,543187419,2226823945,642477207,712446626,382614413]","bodySize":128}', '{"pants": "0xE1B0ABFF", "boots": "0xC430AF11", "hat": "0x267E3453", "coats": "0", "shirts": "0x12801254", "gloves": "0x1A2D8F40", "gunbelts": "0x620C1BC5", "suspenders": "0", "coats2": "0xCAB6E0A9", "masks": "0", "legs": "0", "cloaks": "0", "eyewear": "0", "vests": "0x381EF1D3", "chaps": "0", "offhand": "0", "ponchos": "0", "spurs": "0x1CA207BD", "belts": "0", "neckwear": "0", "skirts": "0", "gauntlets": "0", "neckties": "0x67B0CC14", "spats": "0", "bracelets": "0", "beltbuckle": "0x24914BD1", "access": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(242, 56, 'Tonico Butler', 1, 43, 55, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "16000", "position": "[1298.949,-1320.204,76.651]", "stats": "[250,33.6,100,100]", "dog": "A_C_Cat_01"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.3,0.0,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","pedSize":0.952003,"modSkin":"[913546243,719802851,1180660122,2539219498,46507404,null,382614413]","bodySize":127}', '{"coats": "0", "spurs": "0", "coats2": "0", "suspenders": "0x429BB5D8", "gunbelts": "0x412B86A", "pants": "0x11354899", "hat": "0x1FE651E5", "boots": "0", "belts": "0x277A5E96", "vests": "0", "shirts": "0x28BBFD59"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(243, 57, 'Mark Nunes', 1, 30, 4, '{}', 12, '{"hunger": "0", "thirst": "0", "banco": "85082", "position": "[2710.847,-272.563,42.368]", "stats": "[250,33.6,100,100]"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,-0.5,-0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","pedSize":0.962669,"modSkin":"[3396185070,0,1180660122,2539219498,46507404,null,1529291189]","bodySize":126}', '{"shirts": "0x4A07D78B", "boots": "0x9AA788F7", "hat": "0x166462F8", "pants": "0x73A0FBB0", "gloves": "0x5C2CB213", "coats": "0", "beltbuckle": "0x24914BD1", "gunbelts": "0", "vests": "0", "coats2": "0", "chaps": "0", "belts": "0", "offhand": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(244, 58, 'Taylla Andrews', 14, 18, 1506, '{"Blackwater": "10"}', 16, '{"hunger": "0", "thirst": "0", "banco": "237900", "position": "[2401.63,-1120.88,46.542]", "stats": "[227,32.75,100,96]", "dog": "A_C_Cat_01"}', '{"features":"[-0.5,0.6,0.0,0.0,0.0,0.0,0.0,-0.3,0.1,0.0,0.2,-0.5,-0.4,-0.4,0.0,-0.5,0.0,0.0,-0.2,0.0,0.0,0.0,0.0,-0.5,-0.4,0.0,0.0,0.0,-0.1,0.0,0.0,0.0,0.0,0.0,0.1,0.5,0.0,0.1,0.7]","model":"mp_female","pedSize":0.957336,"modSkin":"[1705365104,2879698054,736263364,736263364,1647937151,959712255]","bodySize":127}', '{"skirts": "0xA517C35D", "shirts": "0x258E61F5", "boots": "0x4CAF9C45", "coats2": "0", "vests": "0", "neckties": "0x9693EDCA", "gloves": "0", "access": "0", "belts": "0", "coats": "0", "beltbuckle": "0", "bracelets": "0", "neckwear": "0", "eyewear": "0", "gunbelts": "0", "offhand": "0", "suspenders": "0", "masks": "0", "gauntlets": "0", "hat": "0", "chaps": "0", "pants": "0x11FE25C4", "cloaks": "0", "ponchos": "0", "spurs": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(245, 56, 'Andrew Butler', 2, 43, 200, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "4700", "position": "[-247.256,751.094,116.241]", "stats": "[179,33.6,100,100]", "dog": "A_C_Cat_01"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","pedSize":1.0,"modSkin":"[null,719802851,null,null,null,null,382614413]","bodySize":127}', '{"shirts": "0xDBB2BDA2", "boots": "0x119D4929", "coats2": "0xB81C3B74", "belts": "0x7B529F6", "vests": "0x74790121", "pants": "0x1D8ADDD1", "hat": "0x1053D06F", "gunbelts": "0x620C1BC5", "neckties": "0xF10A20E1", "coats": "0", "gloves": "0", "eyewear": "0x24FAF393", "beltbuckle": "0x6CFAC5AB", "suspenders": "0", "offhand": "0", "neckwear": "0x4EE47277", "bracelets": "0", "ponchos": "0x8E7E5481", "cloaks": "0", "gauntlets": "0", "access": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(246, 59, 'Nersim da capitinga', 1, 18, 85, '{"Blackwater": "1"}', 12, '{"hunger": "0", "thirst": "0", "banco": "96400", "position": "[1308.43,-1251.275,78.13]", "stats": "[246,15.23,100,18]", "dog": "A_C_DogChesBayRetriever_01"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","pedSize":0.920005,"modSkin":"[3717591255,440009573,null,null,null,null,502538388]","bodySize":124}', '{"pants": "0xE1B0ABFF", "boots": "0xC430AF11", "hat": "0x1AFDD7DC", "coats": "0", "gunbelts": "0x15AF5CC4", "vests": "0x381EF1D3", "coats2": "0xCAB6E0A9", "shirts": "0x29423FD8", "beltbuckle": "0x5453DA31", "gloves": "0x10BD09BD", "neckties": "0x67B0CC14", "spurs": "0x6DF05052", "suspenders": "0", "access": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(247, 60, 'Maria Vaquejada', 12, 20, 908, '{"Saint Denis": "300", "Valentine": "40", "Cidade Fantasma": "90", "Rhodes": "20", "Braithwaite": "20"}', 0, '{"hunger": "0", "thirst": "0", "banco": "13000", "position": "[652.754,-1243.559,43.698]", "stats": "[194,11.2,100,0]"}', '{"modSkin":"[]","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"cs_mrsadler","pedSize":1.0}', '{"Outfit": "3"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(248, 4, 'Tião Santo', 18, 50, 2963, '{}', 17, '{"hunger": "0", "thirst": "0", "banco": "249200", "position": "[2697.766,-1202.62,56.469]", "stats": "[250,32.18,100,94]", "dog": "A_C_DogHusky_01", "posse": "61"}', '{"modSkin":"[3518440159,731356029,942003495,1694074219,612262189,1629650936,4179638410]","bodySize":124,"features":"[0.0,0.9,0.7,0.7,-0.1,-0.1,-0.3,-0.9,0.0,-0.8,0.2,-0.5,0.2,0.0,0.0,0.0,0.0,-0.3,0.8,-0.6,0.1,0.0,-0.2,-0.5,-0.7,0.0,0.0,0.0,-0.3,0.0,0.9,0.0,0.0,0.0,0.1,0.2,0.0,0.0,0.0]","pedSize":1.0,"model":"mp_male"}', '{"shirts": "0", "boots": "0xBC42F16F", "hat": "0", "vests": "0", "coats2": "0", "pants": "0x47F9586A", "gloves": "0x17241F4", "gunbelts": "0", "offhand": "0", "beltbuckle": "0", "belts": "0x34A718CD", "spurs": "0x123BDDCB", "eyewear": "0x24FAF393", "neckwear": "0", "access": "0", "suspenders": "0x1CB2B388", "coats": "0", "cloaks": "0", "chaps": "0", "masks": "0", "ponchos": "0", "bracelets": "0", "neckties": "0", "gauntlets": "0x16D700B3"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(249, 67, 'Emeritus Bicondova', 7, 27, 385, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "500", "position": "[625.358,-1185.63,42.65]", "stats": "[249,31.57,100,91]", "dog": "A_C_Cat_01"}', '{"modSkin":"[908431499,1557718331,942003495,1694074219,642477207,null,502538388]","bodySize":126,"model":"mp_male","pedSize":1.079995,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.5,0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"access": "0x17920A1E", "boots": "0x3D5D87DB", "pants": "0x1A97ED82", "shirts": "0xF724BA61", "vests": "0x242A4C73", "ponchos": "0x8E7E5481", "belts": "0x3D771836", "coats2": "0", "gunbelts": "0x10CD7D44", "gloves": "0", "cloaks": "0", "coats": "0", "neckwear": "0", "offhand": "0", "eyewear": "0", "suspenders": "0", "neckties": "0", "masks": "0", "hat": "0", "gauntlets": "0x166A3B1B"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(251, 68, 'Charles Winter', 1, 30, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2728.659,-1215.823,49.653]"}', '{"modSkin":"[1757924776,1912251213,543187419,2226823945,1552505114,712446626,601768357]","bodySize":127,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.7,-0.5,0.1,0.2,0.0,-0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":0.978668,"model":"mp_male"}', '{"shirts": "0x16CD2EAC", "pants": "0x10051C7", "boots": "0x119D4929", "vests": "0x1525E68A", "hat": "0x38B3DB72"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(252, 51, 'Velma Dricky', 14, 22, 1466, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "38700", "position": "[1892.501,-1863.301,47.335]", "stats": "[209,33.6,100,100]"}', '{"pedSize":1.0,"model":"mp_female","modSkin":"[3333943798,751446730,null,null,3045109292]","features":"[-0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.2,-0.9,0.0,0.0,0.0,0.2,0.0,0.0,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"boots": "0x19E17B75", "skirts": "0", "eyewear": "0x1890826", "shirts": "0x24643C10", "hat": "0x20124C63", "beltbuckle": "0", "gunbelts": "0", "belts": "0", "pants": "0x1B8A6854", "coats2": "0", "access": "0", "coats": "0", "suspenders": "0x2B3C7DAF", "spurs": "0x1468A6E1", "gloves": "0", "vests": "0", "offhand": "0", "neckwear": "0x25548912", "masks": "0", "chaps": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(254, 69, 'Jack Middleton', 14, 25, 1202, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "360400", "position": "[2742.437,-1396.061,46.183]", "stats": "[248,13.84,100,15]", "dog": "A_C_DogChesBayRetriever_011"}', '{"model":"mp_male","bodySize":128,"modSkin":"[1309745678,470018738,543187419,2226823945,642477207,null,481122513]","pedSize":0.973335,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"pants": "0x106E3B84", "boots": "0x1EF2B6A3", "eyewear": "0x24FAF393", "hat": "0x166462F8", "shirts": "0x8B648137", "coats": "0", "neckties": "0", "gloves": "0xEADA5149", "belts": "0", "gunbelts": "0x2FDA7221", "access": "0", "spurs": "0x6DF05052", "beltbuckle": "0", "offhand": "0", "coats2": "0x3EAFAB30", "gauntlets": "0", "vests": "0x941D725E", "masks": "0", "ponchos": "0", "cloaks": "0", "chaps": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(256, 70, 'Paloma Soares', 10, 30, 549, '{"Rhodes": "5"}', 0, '{"hunger": "0", "thirst": "0", "banco": "229642", "position": "[2684.409,-1254.554,51.132]", "stats": "[84,33.6,84,100]", "dog": "A_C_DogHusky_01"}', '{"features":"[0.0,0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.8,0.0,0.0,0.9,0.0,-0.5,0.0,-0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":0.994667,"model":"mp_female","bodySize":127,"modSkin":"[1705365104,315772104,743432389,743432389,3117725108]"}', '{"hat": "0", "masks": "0", "beltbuckle": "0", "pants": "0x3784B1A1", "access": "0x12CBC8FA", "boots": "0xC24179B9", "eyewear": "0x1890826", "shirts": "0x4B65DA87", "gunbelts": "0", "bracelets": "0x64D71DBC", "belts": "0", "gauntlets": "0", "suspenders": "0x82C27B38", "spurs": "0", "coats2": "0", "gloves": "0", "legs": "0", "cloaks": "0", "neckwear": "0", "vests": "0", "chaps": "0", "offhand": "0", "ponchos": "0", "spats": "0", "neckties": "0", "coats": "0", "skirts": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(257, 62, 'Dinho Penatorta', 10, 22, 507, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "30300", "position": "[1297.896,-1296.035,77.016]", "stats": "[211,33.6,100,100]", "dog": "A_C_DogHusky_01"}', '{"model":"mp_male","bodySize":128,"modSkin":"[1106971106,254066903,62321923,3550965899]","pedSize":0.984001,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.9,0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"pants": "0x2632C994", "boots": "0", "vests": "0", "cloaks": "0", "gunbelts": "0x412B86A", "bracelets": "0x2254C72E", "suspenders": "0", "hat": "0", "coats2": "0x27B6D575", "coats": "0", "shirts": "0x27C0F18F", "eyewear": "0", "belts": "0", "ponchos": "0", "offhand": "0", "access": "0x5B5591A4", "masks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(260, 73, 'Carlos Alejandro', 13, 28, 1123, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "398000", "position": "[1415.975,-1267.742,78.567]", "dog": "A_C_DogHusky_01", "stats": "[250,26.42,100,68]", "posse": "61"}', '{"features":"[0.9,0.7,0.9,0.7,0.5,0.2,0.2,0.0,0.5,-0.1,0.2,0.5,0.6,0.6,0.5,0.4,0.0,0.4,0.5,0.0,0.0,0.0,0.4,0.2,0.0,0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":0.920005,"modSkin":"[1108478392,0,62321923,3550965899,3065185688,null,4078914253]","bodySize":127,"model":"mp_male"}', '{"shirts": "0", "suspenders": "0", "access": "0", "eyewear": "0xB7DC3C64", "ponchos": "0", "gunbelts": "0x1CE0C5ED", "hat": "0x9CBE7DDF", "pants": "0x106E3B84", "spurs": "0", "boots": "0x119D4929", "neckwear": "0xDC810E8A", "belts": "0x102F20E6", "vests": "0x102714D5", "coats2": "0xF58FC794", "beltbuckle": "0xBBEF7111", "gloves": "0x1D319438", "coats": "0", "bracelets": "0", "gauntlets": "0", "chaps": "0", "cloaks": "0", "neckties": "0", "masks": "0", "offhand": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(261, 65, 'Amber Houston', 9, 20, 481, '{}', 1, '{"hunger": "0", "thirst": "0", "banco": "23300", "position": "[-749.207,-1287.863,43.267]", "stats": "[250,33.6,100,100]", "dog": "A_C_DogCollie_01"}', '{"pedSize":1.07,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"CS_marybeth","modSkin":"[]"}', '{"Outfit": "7"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(263, 74, 'Billy Kimber', 1, 45, 1, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2526.837,-1321.813,48.703]", "stats": "[168,33.6,100,100]"}', '{"features":"[0.0,0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":128,"modSkin":"[3322561239,576291658,543187419,2226823945,642477207,null,298392309]","pedSize":0.973335,"model":"mp_male"}', '{"boots": "0x195A47E0", "shirts": "0x3115A1EB", "coats2": "0xFE114013", "vests": "0x74790121", "hat": "0x26342E05", "pants": "0x58584555", "gloves": "0x3B94811C", "gunbelts": "0x153557", "belts": "0xE456C936", "neckwear": "0x1301145F", "neckties": "0x68923B74", "coats": "0xFCB4544F", "beltbuckle": "0x14DCF24E"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(264, 61, 'Gabriel Caraspo', 2, 29, 161, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "251905", "position": "[-270.576,824.693,118.885]", "stats": "[205,28.34,100,77]", "dog": "A_C_DogHusky_01"}', '{"bodySize":126,"pedSize":1.0,"model":"mp_male","modSkin":"[2230576261,555297777,543187419,2226823945,612262189,null,481122513]","features":"[0.0,-0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"boots": "0xC430AF11", "hat": "0x38B3DB72", "shirts": "0x29423FD8", "coats": "0", "pants": "0xE1B0ABFF", "beltbuckle": "0x24914BD1", "access": "0", "gunbelts": "0x620C1BC5", "gloves": "0x85A08C0", "offhand": "0", "eyewear": "0x1A5EDE5B", "belts": "0", "gauntlets": "0", "suspenders": "0", "neckties": "0x67B0CC14", "coats2": "0xCAB6E0A9", "vests": "0x381EF1D3", "spurs": "0x82501863", "cloaks": "0", "masks": "0", "neckwear": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(265, 75, 'Henry Newton Brown', 1, 32, 9, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "13600", "position": "[2049.048,-971.901,41.726]", "stats": "[227,16.49,100,24]"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":1.079995,"modSkin":"[908431499,1643025786,null,null,642477207,null,1092082138]","bodySize":127,"model":"mp_male"}', '{"pants": "0x1DDA04F5", "boots": "0x16BDB756", "hat": "0x12F02AD", "shirts": "0x1D615E9", "coats2": "0x179F6D87", "vests": "0x1525E68A", "coats": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(266, 71, 'Geremmy James', 1, 25, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[868.793,954.689,114.111]", "stats": "[250,33.6,100,100]"}', '{"pedSize":1.0,"bodySize":128,"model":"mp_male","features":"[0.0,0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,0.2,0.0,0.2,0.0,-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[908431499,3770895777,null,null,46507404,712446626,3805805594]"}', '{"coats2": "0x3EAFAB30", "neckwear": "0x56BD0300", "pants": "0xDFD0BF78", "boots": "0x914989BA", "shirts": "0x423171B6", "spurs": "0xF69270AF", "vests": "0x1525E68A", "gloves": "0xE5F9A5C9", "belts": "0xC0C7EB2A"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(267, 76, 'Jack Foster', 1, 18, 120, '{}', 16, '{"hunger": "0", "thirst": "0", "banco": "10000", "position": "[2727.055,-1236.79,49.945]", "stats": "[117,33.6,100,100]"}', '{"modSkin":"[1998225129,1835598870,1180660122,2539219498,2452638665,null,1389714514]","bodySize":126,"features":"[0.0,0.0,0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":1.015999,"model":"mp_male"}', '{"beltbuckle": "0x18DB3EB3", "boots": "0x4D0FC31D", "eyewear": "0x3766BB7B", "pants": "0x5DCAD55A", "neckwear": "0x14757301", "belts": "0x19D8A81", "offhand": "0x3E9E41E8", "shirts": "0x1D615E9", "hat": "0xAF686AEC", "gloves": "0x2B8130D7", "coats": "0", "gunbelts": "0x5261D9F3", "spurs": "0x1A7F9150", "coats2": "0xE6F3AA5C"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(270, 78, 'Tatanka', 1, 19, 1, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-282.855,795.775,118.641]", "stats": "[90,28.27,91,76]"}', '{"modSkin":"[665115682,null,1180660122,2539219498,612262189,712446626]","bodySize":127,"model":"mp_male","pedSize":0.920005,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"pants": "0xF4920EC7", "boots": "0x559998B8", "bracelets": "0x136BA95C", "hat": "0x1AFDD7DC", "coats": "0x51C84709", "spurs": "0xFF093F0", "access": "0x5B5591A4"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(271, 82, 'Will de Bill Hiccup', 1, 44, 40, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-1817.063,-372.36,166.497]", "stats": "[185,20.61,100,42]"}', '{"bodySize":127,"pedSize":1.0,"modSkin":"[1587165517,373001057,null,null,null,null,822923592]","model":"mp_male","features":"[-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"pants": "0x10051C7", "boots": "0x11044269", "vests": "0", "shirts": "0x339C7959", "hat": "0x10106532", "coats2": "0x751454BE", "coats": "0", "chaps": "0x430F81E6", "gunbelts": "0x1CE0C5ED"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(272, 80, 'Jhon Carson', 14, 32, 1554, '{}', 2048, '{"hunger": "0", "thirst": "0", "banco": "41616", "position": "[1360.075,-1309.139,77.645]", "stats": "[214,33.6,100,100]", "dog": "A_C_DogHusky_01", "posse": "61"}', '{"modSkin":"[1303185113,571455569,1210379577,3723790941,1552505114,null,605652010]","bodySize":127,"model":"mp_male","pedSize":0.973335,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"hat": "0x166462F8", "pants": "0x12D463B0", "boots": "0x38772DE7", "shirts": "0x1D615E9", "coats2": "0xC5D5D820", "beltbuckle": "0", "gloves": "0x10BD09BD", "gunbelts": "0x620C1BC5", "coats": "0", "spurs": "0x1EDE4AC0", "eyewear": "0", "neckwear": "0", "vests": "0xDAF9867", "belts": "0x2330E0ED", "suspenders": "0", "masks": "0", "legs": "0", "cloaks": "0", "spats": "0", "chaps": "0", "offhand": "0", "ponchos": "0", "gauntlets": "0", "skirts": "0", "neckties": "0", "bracelets": "0", "access": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(273, 81, 'Pirog Bisonho', 1, 38, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-794.878,-1330.621,43.502]"}', '{"pedSize":1.026665,"bodySize":128,"modSkin":"[913546243,843248893,1660566152,1694074219,612262189,null,1239485608]","features":"[0.0,0.0,0.0,0.0,0.0,-0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male"}', '{"shirts": "0x339C7959", "pants": "0x3C9ADC2", "boots": "0x192C2A4B", "eyewear": "0x25C51838", "hat": "0xBB959BC0", "belts": "0x34A718CD", "neckwear": "0x163F4C6E", "gloves": "0x10BD09BD", "coats2": "0xFE114013", "spurs": "0x142D2BE8"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(274, 84, 'Jacob Walker', 1, 34, 9, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "16404", "position": "[-810.975,-1277.45,43.664]", "stats": "[95,33.6,95,100]"}', '{"modSkin":"[2640330835,3829475470,942003495,1694074219,46507404,1015527107,605652010]","bodySize":127,"features":"[0.5,0.9,0.1,0.1,0.0,0.0,0.0,0.0,0.7,-0.9,-0.4,0.8,-0.4,-0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":1.026665,"model":"mp_male"}', '{"beltbuckle": "0x16BBC668", "gloves": "0x48786BD5", "boots": "0x15E08C22", "eyewear": "0x24FAF393", "gunbelts": "0x2E7B7D68", "gauntlets": "0xE56F1F1C", "vests": "0x59786AE7", "access": "0x13F53A09", "coats2": "0xEDFE128B", "shirts": "0x110DED53", "pants": "0xE1B0ABFF", "neckties": "0x188D7769"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(275, 83, 'Jonny Graham', 1, 31, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "16500", "position": "[-281.762,788.597,118.685]", "stats": "[250,33.6,100,100]"}', '{"bodySize":128,"pedSize":0.936004,"modSkin":"[null,399469078,543187419,2226823945,null,null,298392309]","model":"mp_male","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"pants": "0x7011504B", "boots": "0x85EEDF53", "cloaks": "0", "shirts": "0xEB586184", "vests": "0x5DDCE240", "coats2": "0", "ponchos": "0", "hat": "0x60C27EC7", "coats": "0", "beltbuckle": "0x24914BD1", "gloves": "0x5912ECA0", "neckwear": "0xD5F1688D", "gunbelts": "0x153557", "spurs": "0x123BDDCB", "gauntlets": "0x30C8B496", "access": "0x6599ED2"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(279, 86, 'Jackson Davis', 1, 21, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[1311.761,-1275.297,76.299]", "stats": "[234,13.25,100,9]"}', '{"bodySize":128,"pedSize":0.989334,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.2,-0.5,-0.4,-0.7,-0.7,-0.2,0.0,0.0,-0.8,0.0,-0.1,-0.9,-0.3,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[1723194916,1385015042,2582128739,2539219498,3065185688,1629650936,4252816540]","model":"mp_male"}', '{"pants": "0x1A97ED82", "access": "0x7C374665", "boots": "0x23156B7D", "vests": "0xF30FEAE2", "ponchos": "0x9D875AF8", "bracelets": "0x136BA95C", "gauntlets": "0x7483944C", "offhand": "0x2E39B36", "neckwear": "0x288E2953", "gunbelts": "0x3D55DEC7", "spurs": "0x1EDE4AC0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(280, 87, 'André da Silva', 1, 25, 24, '{}', 512, '{"hunger": "0", "thirst": "0", "banco": "10800", "position": "[-327.722,686.65,116.609]", "stats": "[220,12.05,100,4]", "dog": "A_C_DogChesBayRetriever_01"}', '{"modSkin":"[2105189191,1227459665,543187419,2226823945,3065185688,1015527107,1706701994]","bodySize":125,"features":"[0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.8,-0.1,0.9,-0.9,0.9,0.0,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":1.026665,"model":"mp_male"}', '{"shirts": "0x553AAF93", "pants": "0x2A14E8CF", "boots": "0x11B7CAB1", "eyewear": "0x1A5EDE5B", "hat": "0x3677F5B", "vests": "0x5BB21D42", "gunbelts": "0x5261D9F3", "access": "0x7241EEE5", "beltbuckle": "0x19E1847B", "suspenders": "0x27A3F8", "spurs": "0x142D2BE8"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(281, 85, 'Michael Kimber', 1, 29, 69, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[1295.178,-1300.576,77.019]", "stats": "[250,33.6,100,100]"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":0.978668,"modSkin":"[2702657477,2281057286,null,null,642477207,null,146025810]","bodySize":128,"model":"mp_male"}', '{"coats": "0", "coats2": "0x751454BE", "vests": "0x1525E68A", "pants": "0xD9641720", "boots": "0x35C87ED", "shirts": "0x15298CA8", "gloves": "0x3033DA22", "gunbelts": "0x620C1BC5", "hat": "0x5E0FA994", "beltbuckle": "0x17B4FFBC"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(283, 89, 'miguel alejandro', 13, 28, 1075, '{}', 9, '{"hunger": "0", "thirst": "0", "banco": "123400", "position": "[1359.515,-1304.066,77.688]", "stats": "[250,32.68,100,96]", "dog": "A_C_DogHusky_01", "posse": "61"}', '{"bodySize":127,"pedSize":0.920005,"features":"[0.9,0.7,0.9,0.7,0.5,0.2,0.2,0.0,0.6,-0.1,0.2,0.5,0.6,0.6,0.5,0.4,0.0,0.4,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[1108478392,465258498,62321923,3550965899,3065185688,null,1127522151]","model":"mp_male"}', '{"beltbuckle": "0x5FE96AD9", "pants": "0xE1B0ABFF", "boots": "0xC430AF11", "eyewear": "0xB72097D4", "hat": "0x342B7753", "gunbelts": "0x620C1BC5", "belts": "0", "gloves": "0x10BD09BD", "shirts": "0x12801254", "suspenders": "0", "offhand": "0", "ponchos": "0", "vests": "0x59786AE7", "coats2": "0xCAB6E0A9", "access": "0", "masks": "0", "legs": "0", "cloaks": "0", "neckwear": "0", "chaps": "0", "spurs": "0", "neckties": "0x67B0CC14", "skirts": "0", "gauntlets": "0", "bracelets": "0", "coats": "0", "spats": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(284, 90, 'Johnny Marston', 1, 32, 0, '{"Saint Denis": "40"}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2555.338,-1160.857,53.717]", "stats": "[250,11.2,100,0]", "dog": "A_C_DogHusky_01"}', '{"pedSize":1.015999,"bodySize":126,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,0.0,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.1,0.0]","modSkin":"[2696825467,2213512467,942003495,1694074219,642477207,null,1717239876]","model":"mp_male"}', '{"gloves": "0xD4329873", "boots": "0x195A47E0", "hat": "0x59F583EB", "pants": "0x10051C7", "gunbelts": "0x153557", "coats2": "0xC27D27F9", "neckwear": "0x163F4C6E", "access": "0xECC2276D", "shirts": "0x1D615E9", "spurs": "0x19E1EC40", "beltbuckle": "0xF1FF1CFE", "belts": "0x102F20E6", "coats": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(301, 63, 'Vartan Romanov', 1, 22, 115, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "9900", "position": "[-321.809,766.756,117.393]", "stats": "[164,31.53,100,91]", "dog": "A_C_DogLab_01"}', '{"modSkin":"[665115682,386766442,1180660122,2539219498,612262189,null,323985567]","pedSize":0.957336,"features":"[0.0,0.9,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.3,0.8,0.9,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":127,"model":"mp_male"}', '{"pants": "0x2800212A", "boots": "0x151EAB71", "vests": "0x1525E68A", "hat": "0x2D625B41", "coats": "0xAD794606", "neckties": "0", "neckwear": "0", "gloves": "0", "shirts": "0x1D615E9", "eyewear": "0", "suspenders": "0", "gunbelts": "0", "spurs": "0", "gauntlets": "0", "access": "0", "beltbuckle": "0", "coats2": "0", "belts": "0", "masks": "0", "cloaks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(302, 92, 'Araceia Theira', 1, 48, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2400.616,-1000.232,44.433]", "stats": "[236,20.3,100,41]"}', '{"pedSize":0.920005,"bodySize":127,"model":"mp_female","modSkin":"[2864896169,702099763,1679300899,1679300899,928002221,959712255]","features":"[-0.1,0.8,0.6,0.2,-0.4,0.0,-0.3,-0.4,-0.7,0.2,0.3,0.8,0.9,0.0,0.0,0.0,-0.2,0.0,-0.3,0.0,0.0,0.0,-0.3,0.1,0.1,0.9,0.2,0.0,-0.2,0.0,0.0,0.0,0.9,-0.3,-0.4,0.8,0.9,0.0,0.0]"}', '{"gloves": "0x263E22E1", "hat": "0x337A5D19", "boots": "0x4CAF9C45", "vests": "0x2CFF5C25", "skirts": "0x27B2AA60", "eyewear": "0x40E33A12", "shirts": "0x15A72A5", "neckties": "0x5F15FBD7", "coats2": "0x12C15FB8"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(303, 79, 'Charlie Shelby', 1, 18, 12, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "21325", "position": "[1302.45,-1280.747,75.896]", "stats": "[213,13.38,100,10]"}', '{"model":"mp_male","pedSize":1.021332,"modSkin":"[1998225129,3932014484,543187419,2226823945,2195072443,null,323985567]","bodySize":128,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.7,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"gloves": "0x46CAD525", "boots": "0x1EF2B6A3", "hat": "0x166462F8", "vests": "0xE37E0D13", "pants": "0x1D8ADDD1", "neckwear": "0x1750CBF5", "shirts": "0xE7E2B21B", "coats2": "0x1DE62579", "coats": "0", "gunbelts": "0", "suspenders": "0", "masks": "0", "legs": "0", "cloaks": "0", "spats": "0", "chaps": "0", "offhand": "0", "ponchos": "0", "spurs": "0", "belts": "0", "eyewear": "0", "bracelets": "0", "gauntlets": "0", "neckties": "0", "beltbuckle": "0", "skirts": "0", "access": "0x33D9B861"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(304, 94, 'John Pino', 1, 45, 1, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-311.938,815.959,121.979]", "stats": "[215,33.6,100,100]"}', '{"model":"mp_male","pedSize":0.920005,"bodySize":125,"modSkin":"[3477613418,361562633,942003495,1694074219,642477207,712446626,323985567]","features":"[0.9,0.8,0.7,0.5,0.9,0.9,0.9,0.9,0.9,0.9,0.9,-0.9,0.9,0.9,0.9,0.9,0.9,0.0,0.0,0.0,0.0,0.0,0.9,0.9,0.9,0.9,0.0,0.9,0.9,0.9,0.9,0.0,0.0,0.9,0.9,0.9,0.9,0.9,0.9]"}', '{"gloves": "0x1A2D8F40", "vests": "0xFEACB6D7", "shirts": "0x2A77805F", "hat": "0x166462F8", "boots": "0x11B7CAB1", "eyewear": "0x24FAF393", "neckwear": "0xFFDD24F8", "pants": "0xF9D51D01"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(305, 106, 'Leroy Parker', 1, 28, 1, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2546.892,-1180.277,53.257]", "stats": "[229,21.57,100,46]"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":0.94667,"bodySize":128,"modSkin":"[1844773948,1643025786,543187419,2226823945,46507404,712446626,382614413]","model":"mp_male"}', '{"shirts": "0x7EB4ED0E", "neckwear": "0x34E62EF6", "boots": "0x195A47E0", "pants": "0x1D8ADDD1", "coats2": "0", "hat": "0xBB959BC0", "coats": "0x80D7252E", "ponchos": "0x9D875AF8"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(306, 101, 'Reginah Carthy', 1, 25, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2726.741,-1232.123,50.372]", "stats": "[250,11.2,100,0]"}', '{"model":"mp_female","pedSize":1.005333,"modSkin":"[2958627630,681141339,3227133357,3227133357,2210319017,4118611090]","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.1,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.7,0.5,0.0,0.5,0.7,-0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.4,0.0,0.0,0.0,0.6,0.0,0.0,0.6,0.0]"}', '{"bracelets": "0xACD52E27", "shirts": "0xDBF627DD", "hat": "0x1481E304", "belts": "0x214BD73B", "pants": "0x1FBCC141", "boots": "0x134D7E03", "coats2": "0x7AADCCA8", "spurs": "0x15D112D7", "eyewear": "0x19C16BCF", "neckwear": "0x1BA10D1"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(310, 93, 'Jack McBill', 12, 28, 924, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "81291", "position": "[1391.894,-1330.343,79.061]", "stats": "[166,33.6,100,100]", "posse": "67"}', '{"model":"mp_male","pedSize":0.973335,"bodySize":128,"modSkin":"[908431499,1408438106,942003495,1694074219,2452638665,null,1672202441]","features":"[0.2,0.0,0.4,0.4,0.0,0.2,0.2,-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.5,0.5,0.0,0.0,0.0,-0.1,0.0,0.0,-0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"gunbelts": "0x56DC1321", "vests": "0x1525E68A", "shirts": "0x1148337", "offhand": "0", "hat": "0x38B3DB72", "beltbuckle": "0xFE7D89E8", "belts": "0", "pants": "0xF294D831", "spurs": "0xF69270AF", "coats2": "0x3A582B32", "boots": "0xC08EA183", "neckties": "0", "coats": "0", "gloves": "0", "access": "0", "suspenders": "0", "masks": "0", "legs": "0", "cloaks": "0", "spats": "0", "chaps": "0", "ponchos": "0", "eyewear": "0", "neckwear": "0", "gauntlets": "0", "bracelets": "0", "skirts": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(311, 111, 'Leopoldo Sousa', 1, 29, 28, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "15000", "position": "[-273.972,797.386,118.934]", "stats": "[250,33.6,100,100]", "dog": "A_C_DogAmericanFoxhound_01"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":1.079995,"bodySize":125,"modSkin":"[1723194916,470018738,942003495,1694074219,3096645940,null,3388554110]","model":"mp_male"}', '{"vests": "0x381EF1D3", "shirts": "0x12801254", "hat": "0x267E3453", "beltbuckle": "0x24914BD1", "boots": "0xC430AF11", "pants": "0xE1B0ABFF", "gunbelts": "0x153557", "spurs": "0x6DF05052", "neckwear": "0x31BD90FC", "coats": "0", "coats2": "0xCAB6E0A9", "neckties": "0x67B0CC14"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(314, 95, 'John Cooper', 15, 30, 2314, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "101411", "position": "[1360.073,-1309.109,77.608]", "stats": "[250,33.6,100,100]"}', '{"model":"mp_male","pedSize":0.936004,"bodySize":128,"modSkin":"[1209218150,39008355,543187419,2226823945,2739887825,712446626,1063184222]","features":"[0.0,0.5,0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.1,0.0,0.0,-0.7,0.0,-0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"gunbelts": "0x1CE0C5ED", "vests": "0x3D55C4CC", "hat": "0x8F0DC2A9", "beltbuckle": "0x24914BD1", "boots": "0x23F56F2C", "spurs": "0x82501863", "coats2": "0xCAB6E0A9", "pants": "0xE1B0ABFF", "coats": "0", "shirts": "0x12801254", "neckties": "0x67B0CC14", "gloves": "0", "bracelets": "0", "gauntlets": "0", "neckwear": "0", "belts": "0x2AD73F47", "chaps": "0", "access": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(315, 113, 'Vinicius Rego', 16, 24, 2368, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "673600", "position": "[-271.997,784.788,118.425]", "stats": "[102,33.6,100,100]", "dog": "A_C_DogCollie_01", "posse": "73"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":0.973335,"bodySize":127,"modSkin":"[1309745678,399469078,null,null,3508160042,null,382614413]","model":"mp_male"}', '{"vests": "0xFEACB6D7", "hat": "0x16DC2BDE", "boots": "0x312A5CC0", "pants": "0xF09E9B3F", "chaps": "0", "coats2": "0x20ED22EA", "offhand": "0", "belts": "0", "neckwear": "0x1024C03D", "gloves": "0xF39F4F82", "shirts": "0", "eyewear": "0x8953AC8", "beltbuckle": "0x25409ADF", "gunbelts": "0x319BEEC1", "suspenders": "0", "masks": "0", "legs": "0", "cloaks": "0", "ponchos": "0xE5BD82FE", "spurs": "0", "skirts": "0", "gauntlets": "0x30C8B496", "neckties": "0", "spats": "0", "bracelets": "0", "coats": "0", "access": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(316, 114, 'Carl Baker', 1, 26, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-324.834,773.821,121.711]", "stats": "[24,33.04,25,97]"}', '{"model":"mp_male","pedSize":1.079995,"bodySize":128,"modSkin":"[2640330835,604645064,1519555092,4045206010,612262189,null,1517615086]","features":"[0.0,0.0,0.0,0.2,0.6,0.5,0.4,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.4,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"vests": "0", "coats2": "0xD2ABC7B8", "shirts": "0x339C7959", "coats": "0", "hat": "0xA8A2E6B9", "boots": "0xC6972257", "chaps": "0", "pants": "0xBA8C46C8", "belts": "0xCC933469", "cloaks": "0", "masks": "0", "gauntlets": "0", "neckwear": "0x69FD90B3", "eyewear": "0xB7DC3C64", "suspenders": "0", "neckties": "0", "access": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(318, 96, 'Hector Mendoza', 1, 27, 12, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "53900", "position": "[2639.647,-1283.962,52.274]", "stats": "[250,23.07,100,53]"}', '{"model":"mp_male","pedSize":0.941337,"bodySize":128,"modSkin":"[2949506350,843248893,543187419,2226823945,642477207,null,282054283]","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"gloves": "0x10BD09BD", "vests": "0x1B53FA5", "shirts": "0x110DED53", "hat": "0x12BD5208", "beltbuckle": "0x2087F4FB", "belts": "0x2063DB53", "boots": "0x192C2A4B", "pants": "0x19CB5254", "coats": "0", "coats2": "0x1DE62579", "gunbelts": "0x1CE0C5ED", "spurs": "0", "neckwear": "0", "ponchos": "0", "cloaks": "0", "gauntlets": "0", "eyewear": "0", "masks": "0", "offhand": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(320, 110, 'Tommy Shelby', 6, 29, 334, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "51000", "position": "[2639.545,-1222.621,59.606]", "stats": "[239,33.6,100,100]"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":1.005333,"bodySize":128,"modSkin":"[1209218150,0,null,null,642477207,null,282054283]","model":"mp_male"}', '{"coats2": "0xE0FD61FA", "beltbuckle": "0x16E62CC9", "pants": "0x106E3B84", "gunbelts": "0x620C1BC5", "shirts": "0x12801254", "spurs": "0x123BDDCB", "vests": "0x74790121", "hat": "0x166462F8", "boots": "0x1EF2B6A3", "gloves": "0x3033DA22", "offhand": "0x1105E694", "neckwear": "0", "coats": "0", "belts": "0x28FBEC8B", "access": "0x13F53A09"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(321, 108, 'William Blake', 8, 26, 414, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "33200", "position": "[2746.337,-1174.3,49.064]", "stats": "[98,33.6,99,100]"}', '{"model":"mp_male","pedSize":1.042664,"modSkin":"[null,3798985182,null,null,1552505114,712446626,1658715876]","features":"[0.0,0.6,0.5,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.1,0.1,0.0,0.0,0.0,0.0,0.0,0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"pants": "0x1D8ADDD1", "shirts": "0x1F373F7C", "eyewear": "0x3BA1A0E0", "neckties": "0x977FFC3B", "suspenders": "0", "boots": "0x1EF2B6A3", "hat": "0", "belts": "0", "coats2": "0", "gloves": "0", "access": "0", "vests": "0", "masks": "0", "legs": "0", "cloaks": "0", "neckwear": "0", "chaps": "0", "offhand": "0", "ponchos": "0", "spurs": "0x1CA207BD", "bracelets": "0", "gunbelts": "0x412B86A", "skirts": "0", "gauntlets": "0", "spats": "0", "coats": "0", "beltbuckle": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(322, 105, 'Igor Regalla', 2, 32, 141, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "4200", "position": "[1278.112,378.37,92.721]", "stats": "[210,33.6,100,100]", "dog": "A_C_DogCollie_01"}', '{"model":"mp_male","pedSize":1.0,"bodySize":128,"modSkin":"[1218683388,0,1773547611,1824319804,2501331517,null,282054283]","features":"[-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"neckwear": "0", "pants": "0xE1B0ABFF", "coats": "0", "spurs": "0x6DF05052", "shirts": "0x29423FD8", "boots": "0xC430AF11", "gloves": "0x3033DA22", "chaps": "0", "hat": "0xB16BB2D6", "gunbelts": "0x10CD7D44", "coats2": "0xCAB6E0A9", "beltbuckle": "0x24914BD1", "offhand": "0", "neckties": "0x67B0CC14", "gauntlets": "0", "bracelets": "0", "access": "0", "masks": "0", "eyewear": "0x25C51838", "belts": "0", "vests": "0x381EF1D3"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(323, 116, 'Victor Galloway', 1, 27, 3, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[1323.761,-1321.708,77.9]", "stats": "[79,11.2,80,0]"}', '{"features":"[-0.3,0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":1.010666,"bodySize":128,"modSkin":"[2702657477,1060376337,543187419,2226823945,2432743988,null,529788430]","model":"mp_male"}', '{"hat": "0x166462F8", "vests": "0x59786AE7", "pants": "0x5151D24C", "boots": "0x1EF2B6A3", "beltbuckle": "0xE82BEAF8", "coats2": "0x7596B65E", "gunbelts": "0x620C1BC5", "shirts": "0x65C1B5F6", "neckties": "0x3E56C2FB"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(324, 104, 'Chiyo Strode ', 1, 55, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-1099.255,-1839.145,60.944]", "stats": "[250,33.6,100,100]"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_female","pedSize":1.0,"modSkin":"[454405754,3684813256,null,null,928002221]"}', '{}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(326, 120, 'Billy Jhow', 3, 25, 175, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "107900", "position": "[1304.568,-1278.754,75.903]", "stats": "[242,11.2,100,0]"}', '{"model":"mp_male","modSkin":"[908431499,399469078,1834492501,2968922921,2432743988,1629650936,382614413]","pedSize":1.0,"features":"[0.1,0.0,0.0,0.0,-0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":126}', '{"boots": "0x156828EB", "coats2": "0xF654FBD1", "pants": "0x1D8ADDD1", "shirts": "0", "hat": "0x1632867A", "chaps": "0x25BF1052", "gunbelts": "0x1CE0C5ED", "vests": "0x1525E68A", "beltbuckle": "0x4B046666", "coats": "0", "neckwear": "0x163F4C6E", "ponchos": "0", "cloaks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(327, 118, 'Shallow Nowthon', 1, 35, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2555.243,-1160.272,53.632]", "stats": "[250,33.6,100,100]"}', '{"model":"mp_female","features":"[-0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":0.930671,"modSkin":"[2082085198]","bodySize":127}', '{"hat": "0x132989D8", "boots": "0x134D7E03", "cloaks": "0x5F086D4", "coats": "0x16F991F3", "gloves": "0x1D8BDEE4", "shirts": "0x373CE1E6", "pants": "0x46390E3D"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(328, 119, 'John Dorn Dubar', 14, 27, 1648, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "709900", "position": "[1156.089,-406.019,92.146]", "stats": "[250,33.6,100,100]", "dog": "A_C_DogCollie_01", "posse": "73"}', '{"model":"mp_male","modSkin":"[2696825467,2120703472,543187419,2226823945,642477207,null,382614413]","pedSize":1.079995,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":128}', '{"boots": "0x23156B7D", "cloaks": "0", "vests": "0", "pants": "0xF09E9B3F", "shirts": "0", "coats2": "0xA0ECA2E7", "spurs": "0x15076986", "gunbelts": "0x10CD7D44", "neckwear": "0xFE6C9CCD", "belts": "0", "beltbuckle": "0x506570F0", "access": "0x790DCD14", "gauntlets": "0", "bracelets": "0", "hat": "0x28654956", "offhand": "0", "coats": "0", "chaps": "0", "eyewear": "0", "suspenders": "0", "ponchos": "0", "neckties": "0", "masks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(331, 104, 'Helga Miranda', 1, 60, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[1476.298,-436.692,76.737]", "stats": "[250,33.6,100,100]"}', '{"model":"mp_female","bodySize":124,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.7,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[75220166,68508030,186465082,186465082]","pedSize":0.920005}', '{"boots": "0x1ECA005A", "eyewear": "0x19C16BCF", "access": "0x33D36086", "skirts": "0xC8330993", "neckwear": "0x1BA575B4", "shirts": "0xD8C92063"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(332, 121, 'George Hayes', 1, 31, 13, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "5900", "position": "[1788.884,-1352.319,43.954]", "stats": "[199,33.6,100,100]"}', '{"model":"mp_male","bodySize":125,"features":"[0.0,0.9,0.4,0.0,0.7,0.2,-0.4,0.3,0.0,0.7,0.0,0.7,0.9,-0.3,0.0,0.8,0.4,0.0,0.0,0.3,0.0,0.9,0.7,-0.5,0.3,-0.5,-0.4,0.0,0.3,0.5,0.5,0.3,0.5,0.0,0.0,0.0,0.7,0.2,0.0]","pedSize":1.079995,"modSkin":"[2078925650,2116383364,1180660122,2539219498,2432743988,712446626,2104391593]"}', '{"ponchos": "0", "gunbelts": "0x153557", "boots": "0x16BDB756", "access": "0x29A9AE4D", "gloves": "0x17241F4", "spurs": "0x200A7968", "shirts": "0x46824CF0", "beltbuckle": "0x2CB79FF4", "hat": "0x2D625B41", "eyewear": "0x14F06EA7", "belts": "0x2AD73F47", "gauntlets": "0", "pants": "0x5F622EED", "chaps": "0", "coats": "0", "coats2": "0x96C72D22", "suspenders": "0x129DD6FD"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(333, 122, 'Alisa Bennet MacCoy', 1, 21, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-960.69,-369.051,55.839]", "stats": "[250,33.13,100,98]"}', '{"model":"mp_female","bodySize":128,"features":"[0.0,0.8,0.2,-0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.8,0.9,0.0,-0.6,-0.6,0.0,0.0,0.0,0.2,0.5,0.8,0.7,-0.3,0.0]","pedSize":0.920005,"modSkin":"[1200388119,1320043540,923281039,923281039,928002221,959712255]"}', '{}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(334, 125, 'Johny Pokaballa', 11, 27, 740, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "299300", "position": "[1607.868,-1540.475,59.917]", "stats": "[236,32.89,100,97]", "posse": "61"}', '{"model":"mp_male","bodySize":128,"features":"[0.1,-0.9,-0.9,0.0,-0.1,-0.1,0.0,0.2,0.0,0.0,0.1,0.2,0.0,0.0,0.0,0.9,0.7,0.7,0.1,0.0,0.0,0.0,0.0,0.0,-0.4,0.2,-0.3,0.0,0.1,-0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[2436988180,1683326018,942003495,1694074219,2432743988,712446626,1717239876]","pedSize":1.026665}', '{"coats2": "0", "boots": "0x97F0C157", "gunbelts": "0x1C04C393", "pants": "0x47F9586A", "shirts": "0x3BCFDFB3", "spurs": "0x17346DD4", "hat": "0x8F0DC2A9", "vests": "0", "bracelets": "0x5D60E31", "coats": "0", "ponchos": "0", "eyewear": "0", "belts": "0x34A718CD", "offhand": "0", "neckwear": "0", "masks": "0", "gloves": "0", "access": "0x33D9B861", "gauntlets": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(335, 124, 'Thomy Kludge', 1, 30, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2735.932,-1398.68,46.151]", "stats": "[68,33.6,68,100]"}', '{"pedSize":0.968002,"modSkin":"[2722026837,2789684254,942003495,1694074219,612262189,null,382614413]","model":"mp_male","features":"[-0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":128}', '{"pants": "0x58584555", "shirts": "0xBAF7FB0C", "coats2": "0xE0FD61FA", "hat": "0x166462F8", "vests": "0xFA736FA9", "spurs": "0xFEFE4C76", "gloves": "0x1A2D8F40", "neckwear": "0x163F4C6E", "boots": "0x38271590", "gunbelts": "0x153557"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(336, 127, 'Jorge Tambara', 1, 22, 4, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "40395", "position": "[-282.599,786.382,119.502]", "stats": "[124,26.71,100,69]"}', '{"pedSize":1.0,"bodySize":128,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[1209218150,864946818,543187419,2226823945,612262189,null,1063184222]","model":"mp_male"}', '{"pants": "0x1A0CD667", "neckwear": "0x163F4C6E", "boots": "0x1BB1DE12", "vests": "0x1525E68A", "shirts": "0x22300420", "hat": "0x1796EC71", "gunbelts": "0x620C1BC5", "beltbuckle": "0x17B4FFBC", "gloves": "0x1D319438", "belts": "0x5C32A201", "coats2": "0", "coats": "0xEF678D3"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(338, 128, 'Bill Allison', 1, 23, 5, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2720.958,-1286.256,49.636]", "stats": "[102,11.2,100,0]"}', '{"pedSize":1.005333,"bodySize":128,"model":"mp_male","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[908431499,39008355,null,null,null,null,1239485608]"}', '{"boots": "0x195A47E0", "neckwear": "0x1750CBF5", "coats": "0x7386B340", "beltbuckle": "0x10443A0F", "pants": "0x10051C7", "shirts": "0x10B87936", "spurs": "0x19E1EC40", "hat": "0x267E3453", "belts": "0x2063DB53", "vests": "0x1525E68A", "gunbelts": "0x15AF5CC4"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(339, 88, 'Tarik Shelby', 1, 29, 12, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "25500", "position": "[2565.092,-1226.324,53.321]", "stats": "[172,32.35,100,100]"}', '{"pedSize":1.010666,"bodySize":128,"features":"[0.3,-0.9,0.0,0.2,-0.5,-0.1,0.0,0.0,0.0,-0.3,0.0,0.0,0.8,0.1,0.2,0.2,0.2,0.3,-0.3,0.0,0.0,0.0,-0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","modSkin":"[908431499,0,1180660122,2539219498,46507404,null,382614413]"}', '{"coats2": "0xC5D5D820", "pants": "0x1D8ADDD1", "vests": "0xE37E0D13", "hat": "0x166462F8", "gloves": "0x46CAD525", "boots": "0x20D85860", "shirts": "0xDAFF9855", "neckties": "0x3E56C2FB", "eyewear": "0x24FAF393"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(341, 130, 'Clay Allison ', 1, 20, 34, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "6000", "position": "[1271.691,-1282.625,75.384]", "stats": "[250,33.6,100,100]"}', '{"pedSize":1.0,"features":"[-0.7,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.8,-0.2,0.0,0.3,0.0,0.0,-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,0.3,0.0,0.0,0.0,0.0,-0.7,0.6,0.0,0.0,0.0,-0.5,0.0,-0.5,-0.4,-0.1]","bodySize":128,"model":"mp_male","modSkin":"[1209218150,576291658,543187419,2226823945,642477207,1629650936,605652010]"}', '{"boots": "0x5D6DC7F7", "neckwear": "0x288E2953", "gunbelts": "0x620C1BC5", "pants": "0xCEFD6664", "gloves": "0x2B8130D7", "shirts": "0x1D615E9", "hat": "0x166462F8", "vests": "0x1525E68A", "beltbuckle": "0x353C3AD6", "coats2": "0x3FE0A71C", "belts": "0x102F20E6"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(343, 126, 'Butch Taylor', 11, 21, 772, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "9700", "position": "[1414.419,-1317.937,77.679]", "stats": "[250,33.6,100,100]"}', '{"pedSize":0.962669,"bodySize":127,"model":"mp_male","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[913546243,332623772,1180660122,2539219498,1864171073,712446626,502538388]"}', '{"offhand": "0", "neckwear": "0", "beltbuckle": "0x24914BD1", "pants": "0xB3977466", "belts": "0x131D437B", "hat": "0x8B7D339A", "shirts": "0x12801254", "boots": "0x6A2B9E5", "coats2": "0xCAB6E0A9", "gloves": "0x1A2D8F40", "coats": "0", "gunbelts": "0x5261D9F3", "cloaks": "0", "access": "0", "vests": "0x29FE9E1E", "chaps": "0", "suspenders": "0", "masks": "0", "spurs": "0", "ponchos": "0", "neckties": "0x67B0CC14"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(344, 131, 'David Marston', 1, 35, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2731.747,-1247.593,49.823]", "stats": "[184,33.6,100,100]"}', '{"pedSize":1.063996,"bodySize":126,"model":"mp_male","features":"[-0.1,0.3,-0.3,-0.9,-0.4,-0.7,-0.2,-0.4,0.0,-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[2702657477,39008355,942003495,1694074219,1552505114,null,1063184222]"}', '{"pants": "0x205D1C26", "shirts": "0x77D1B31E", "coats2": "0xA7FD850C", "hat": "0x7DC55449", "boots": "0x30539D9C", "vests": "0x374E6E38"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(345, 132, 'Butch Maverick', 1, 30, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2089.947,-895.701,41.257]", "stats": "[0,31.89,0,92]"}', '{"pedSize":0.994667,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.2,0.0,0.0,-0.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.1,0.0,0.0,0.0,0.0,0.0]","modSkin":"[128860735,2275703638,543187419,2226823945,46507404,712446626,282054283]","model":"mp_male","bodySize":127}', '{"offhand": "0x3A08F9BC", "neckwear": "0x17C80517", "coats": "0x32C84619", "pants": "0x1AE548B", "shirts": "0x68A0ED3F", "boots": "0x24CBC01D", "gloves": "0x16DEB1F", "coats2": "0x1C6E3810", "eyewear": "0x24FAF393"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(346, 129, 'Laurete Lurdes', 1, 46, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2187.451,-986.096,42.023]", "stats": "[0,33.6,0,100]"}', '{"pedSize":0.920005,"model":"mp_female","bodySize":127,"features":"[-0.8,0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.1,0.0,0.0,0.4,0.0,0.7,0.0,0.0,0.0]","modSkin":"[1974431363,797659203,900188667,900188667,928002221,959712255]"}', '{"coats2": "0xDEF398B6", "neckwear": "0x37F82E59", "skirts": "0xE0A0F616", "vests": "0x141955A6", "spurs": "0x1E38EE93", "boots": "0x134D7E03", "beltbuckle": "0x270442E4", "eyewear": "0xE561C067"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(347, 136, 'Daemon James', 5, 25, 271, '{}', 16, '{"hunger": "0", "thirst": "0", "banco": "40914", "position": "[1371.346,-1311.773,77.438]", "stats": "[250,33.6,100,100]"}', '{"pedSize":1.079995,"bodySize":126,"features":"[0.0,0.3,-0.1,0.6,-0.9,-0.3,-0.8,0.0,0.0,-0.9,0.0,0.8,0.8,-0.7,-0.1,0.8,0.8,-0.7,0.6,0.3,0.0,0.0,0.0,0.0,0.5,0.0,0.4,0.0,-0.2,0.1,0.0,0.0,0.0,0.0,0.3,0.0,0.8,0.0,0.0]","model":"mp_male","modSkin":"[2640330835,2222080734,2582128739,2539219498,46507404,712446626,2115010028]"}', '{"offhand": "0", "coats2": "0", "shirts": "0x581A73B0", "beltbuckle": "0xFE7D89E8", "pants": "0x5F622EED", "vests": "0x1525E68A", "neckties": "0x4574F536", "belts": "0x8DB52B0E", "spurs": "0xF3ED74DB", "boots": "0x119D4929", "gloves": "0x570E2C50", "hat": "0x33D11769", "gunbelts": "0x29875F42", "eyewear": "0x2761A139", "chaps": "0", "bracelets": "0", "gauntlets": "0", "coats": "0", "ponchos": "0", "cloaks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(349, 107, 'William Donkarius', 1, 31, 29, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "6800", "position": "[-285.809,664.263,113.469]", "stats": "[250,32.23,100,94]", "dog": "A_C_DogBluetickCoonhound_01"}', '{"pedSize":1.015999,"modSkin":"[2207881199,1642850383,543187419,2226823945,3065185688,null,298392309]","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","bodySize":128}', '{"gunbelts": "0x23396D4", "pants": "0x1A97ED82", "shirts": "0x2EC3810A", "spurs": "0x3144C7E2", "access": "0x6599ED2", "vests": "0xCF3D2221", "beltbuckle": "0x1B301155", "ponchos": "0xEDF00687", "hat": "0x45829A05", "eyewear": "0x9A1DFEE", "bracelets": "0x136BA95C", "boots": "0x23156B7D", "gloves": "0x1A2D8F40", "suspenders": "0", "coats2": "0", "gauntlets": "0x7483944C", "offhand": "0", "coats": "0", "cloaks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(352, 102, 'Luke Hunter', 1, 16, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[1482.545,-835.305,50.289]", "stats": "[209,33.6,100,100]"}', '{"pedSize":0.920005,"model":"mp_male","bodySize":126,"features":"[0.0,0.1,0.1,0.1,0.1,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.1,0.1,0.0,0.0,0.0,-0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.3,0.0,0.1]","modSkin":"[3620587182,39008355,null,null,642477207,1629650936]"}', '{"coats": "0x742C10B1", "offhand": "0x1105E694", "neckwear": "0x14757301", "beltbuckle": "0x14DCF24E", "pants": "0xE5EB6137", "shirts": "0x339C7959", "gunbelts": "0x153557", "belts": "0x102F20E6", "cloaks": "0x3CDEDC38", "boots": "0x195A47E0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(353, 138, 'Victor Corleone', 1, 30, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-1517.34,730.236,126.683]", "stats": "[21,11.2,22,0]"}', '{"pedSize":0.984001,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[2063814808,555297777,942003495,1694074219,2195072443,null,1071274056]","model":"mp_male","bodySize":127}', '{"pants": "0x106E3B84", "shirts": "0x339C7959", "vests": "0xD0E85435", "boots": "0x1EF2B6A3"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(354, 112, 'Johny Cash', 1, 26, 52, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "69677", "position": "[1363.232,-1243.43,79.734]", "stats": "[203,33.6,100,100]"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":1.079995,"model":"mp_male","modSkin":"[2640330835,3026895863,1519555092,4045206010,642477207,null,605652010]"}', '{"neckwear": "0x1C990028", "coats2": "0x26A3702F", "beltbuckle": "0x353C3AD6", "pants": "0x3C9ADC2", "shirts": "0x1D615E9", "spurs": "0x1CA207BD", "hat": "0x166462F8", "gunbelts": "0x319BEEC1", "gloves": "0x2B8130D7", "eyewear": "0x1A5EDE5B", "boots": "0x34B705E8", "vests": "0x1525E68A", "coats": "0", "access": "0", "gauntlets": "0", "ponchos": "0", "chaps": "0", "bracelets": "0", "offhand": "0", "cloaks": "0x7D0FD5A2", "belts": "0x2AD73F47"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(355, 139, 'Alucard.Correa', 1, 24, 24, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "16035", "position": "[2725.574,-1237.76,50.023]", "stats": "[211,31.09,100,89]"}', '{"pedSize":1.079995,"modSkin":"[908431499,null,1257168263,3623045497,642477207,1015527107]","model":"mp_male","features":"[-0.4,0.0,0.0,0.0,0.9,0.9,0.9,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":128}', '{"coats": "0x3C532100", "gunbelts": "0x10CD7D44", "pants": "0x10051C7", "chaps": "0x1F6783A7", "spurs": "0x123BDDCB", "boots": "0x1002199A", "shirts": "0", "hat": "0x166462F8", "coats2": "0", "ponchos": "0x15D9888E", "vests": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(356, 140, 'Alex Silva', 1, 23, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2519.461,-1285.162,48.959]", "stats": "[250,33.6,100,100]"}', '{"pedSize":1.0,"modSkin":"[3322561239,3932014484,null,null,46507404,712446626,1743934292]","model":"mp_male","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":126}', '{"neckwear": "0x24F81EAB", "shirts": "0x3AC92C5A", "offhand": "0xE0EAD765", "hat": "0x6926E8D5", "boots": "0x24CBC01D", "beltbuckle": "0x17B4FFBC", "gunbelts": "0x620C1BC5", "spurs": "0x19E1EC40", "vests": "0x4B3BCE6E", "pants": "0x2800212A", "coats2": "0x7E124755", "eyewear": "0x24FAF393", "gloves": "0x2B8130D7", "belts": "0x102F20E6"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(358, 72, 'Henrique Benett', 1, 50, 1, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "31800", "position": "[-308.038,777.773,118.704]", "stats": "[42,30.39,43,86]", "dog": "A_C_DogCollie_01"}', '{"pedSize":1.0,"modSkin":"[913546243,879214843,2966572863,181068809,2739887825,null,611832531]","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":127,"model":"mp_male"}', '{"shirts": "0x29423FD8", "pants": "0xE1B0ABFF", "hat": "0x9A3DA99D", "boots": "0xC430AF11", "vests": "0x59786AE7", "beltbuckle": "0xA9E228BA", "gunbelts": "0x620C1BC5", "chaps": "0", "coats": "0", "gloves": "0", "spurs": "0x6DF05052", "coats2": "0xBD2A56CA", "cloaks": "0", "belts": "0", "suspenders": "0", "access": "0", "neckties": "0x31975FE2", "gauntlets": "0", "bracelets": "0", "eyewear": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(359, 141, 'Tom Coy', 1, 22, 18, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "26777", "position": "[-405.098,380.252,50.697]", "stats": "[250,33.6,100,100]"}', '{"model":"mp_male","modSkin":"[1422840308,0,885240113,202858862,642477207,3776970741,4197281720]","features":"[0.9,0.5,0.0,0.9,-0.2,0.2,0.0,-0.2,-0.7,0.0,0.0,0.0,-0.7,0.0,-0.1,-0.3,0.0,-0.8,0.6,0.5,0.0,0.5,-0.9,0.5,0.0,-0.2,0.0,0.0,0.0,-0.9,0.8,0.0,0.0,-0.9,0.8,0.0,0.4,0.0,0.9]","bodySize":125,"pedSize":1.05333}', '{"neckwear": "0x1750CBF5", "pants": "0x389AB19E", "boots": "0x6E4BDAB1", "gunbelts": "0x620C1BC5", "shirts": "0x7EB4ED0E", "beltbuckle": "0x25409ADF", "belts": "0x62ED7559", "ponchos": "0x312219CA", "hat": "0x78068228", "offhand": "0x3A08F9BC", "chaps": "0x270BE13C", "coats2": "0xC4CC096E", "access": "0x17920A1E", "spurs": "0x69E5678E", "gloves": "0xE5F9A5C9"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(360, 137, 'Ray Jake Dimitri', 1, 31, 1, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "300", "position": "[1349.502,-1114.035,79.949]", "stats": "[100,21.79,100,47]"}', '{"pedSize":1.079995,"modSkin":"[3396185070,2482891161,null,null,1864171073,null,298392309]","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.9,-0.5,0.6,0.0,0.0,0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":126,"model":"mp_male"}', '{"neckwear": "0xFE38E6F8", "belts": "0xCB1596B4", "pants": "0xE3CFC09B", "boots": "0x189227AA", "vests": "0xDAF9867", "access": "0x7C374665", "gloves": "0xF3BB414C", "coats2": "0x68958A76", "spurs": "0xFB85B05F", "hat": "0x59F583EB"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(362, 103, 'Jon Jones', 1, 35, 3, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-154.325,580.098,112.821]", "stats": "[227,33.6,100,100]", "dog": "A_C_DogHusky_01"}', '{"model":"mp_male","modSkin":"[908431499,0,1519555092,4045206010,null,712446626,4252816540]","features":"[0.0,0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,0.0,0.0,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.2,0.0,-0.7,0.4,0.7,0.0,0.0,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":126,"pedSize":1.021332}', '{"belts": "0x3D771836", "pants": "0x106E3B84", "bracelets": "0x2FDF6243", "coats2": "0x1DE62579", "neckties": "0x3AD5725E", "boots": "0x119D4929", "gloves": "0x2B8130D7", "shirts": "0x1D615E9", "eyewear": "0x1A5EDE5B", "hat": "0x262CC9D4", "suspenders": "0", "masks": "0", "coats": "0", "access": "0", "gunbelts": "0", "beltbuckle": "0", "spurs": "0x17346DD4", "cloaks": "0", "offhand": "0", "neckwear": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(363, 143, 'Kekel Coys', 1, 29, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-285.278,806.919,119.413]", "stats": "[236,33.6,100,100]"}', '{"modSkin":"[908431499,3386814586,2582128739,2539219498,3065185688]","model":"mp_male","bodySize":127,"pedSize":1.026665,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"shirts": "0x28BBFD59", "pants": "0x5D288492", "gloves": "0x97832569"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(364, 144, 'Alex Misnete', 10, 30, 544, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "4700", "position": "[1405.991,-1296.15,78.048]", "stats": "[250,33.6,100,100]", "dog": "A_C_DogBluetickCoonhound_01", "posse": "61"}', '{"modSkin":"[2597378528,2700264190,1588167928,1535332499,1864171073,null,1658715876]","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":128,"pedSize":1.042664,"model":"mp_male"}', '{"shirts": "0", "neckties": "0", "beltbuckle": "0x5891017F", "access": "0", "pants": "0x10051C7", "boots": "0x119D4929", "vests": "0x1525E68A", "gunbelts": "0x10CD7D44", "offhand": "0", "eyewear": "0x24FAF393", "gloves": "0x1A2D8F40", "hat": "0xB25D8F20", "coats2": "0x1DE62579", "belts": "0", "coats": "0", "ponchos": "0", "cloaks": "0", "chaps": "0", "spurs": "0", "masks": "0", "suspenders": "0x1EB8E2E0", "gauntlets": "0x30C8B496", "bracelets": "0x136BA95C", "neckwear": "0x163F4C6E"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(365, 123, 'Henrique Morgan', 1, 25, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-561.912,698.819,91.962]", "stats": "[236,33.6,100,100]"}', '{"modSkin":"[3239248279,470018738,null,null,null,null,282054283]","model":"mp_male","bodySize":126,"pedSize":1.0,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"hat": "0x10106532", "boots": "0x16BDB756", "gunbelts": "0x153557", "pants": "0x4D348A92", "eyewear": "0x111AFF82", "coats": "0x4E397758"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(367, 133, 'Carlin Chaveco', 1, 30, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-2719.352,678.339,144.066]", "stats": "[0,30.04,0,84]"}', '{"modSkin":"[2207881199,2627254114,543187419,2226823945,3508160042,712446626]","model":"mp_male","bodySize":125,"pedSize":1.026665,"features":"[-0.3,0.0,0.0,0.0,0.4,0.0,0.0,0.0,0.0,0.8,-0.8,0.0,0.8,0.8,0.7,-0.7,-0.8,0.6,0.8,0.6,0.0,0.5,0.0,0.0,0.0,0.0,0.0,-0.7,0.0,0.0,0.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"shirts": "0x1D615E9", "beltbuckle": "0x3FB1B271", "hat": "0x267E3453", "neckwear": "0x36DE44AB", "access": "0x3B7F8161", "coats2": "0xAA997C94", "boots": "0x9C120B2D", "spurs": "0x19E1EC40", "gunbelts": "0x620C1BC5", "pants": "0xE1B0ABFF", "offhand": "0x2E15B9B7"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(370, 145, 'Dante Brewer', 1, 28, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "6200", "position": "[1348.074,-1374.339,80.478]", "stats": "[239,32.11,100,93]"}', '{"modSkin":"[2702657477,613297523,543187419,2226823945,642477207,712446626,146025810]","model":"mp_male","bodySize":128,"pedSize":0.989334,"features":"[-0.5,0.9,0.9,-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.9,0.0,0.0,0.0,0.0,0.0,-0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"shirts": "0x28BBFD59", "hat": "0x12BD5208", "pants": "0xEFD36FF8", "boots": "0x42297DE0", "vests": "0x1FFA3CFC", "gunbelts": "0x319BEEC1", "neckwear": "0x183C75A3", "coats2": "0x5263AACE", "gloves": "0x1A2D8F40", "access": "0xECC2276D"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(371, 146, 'Fernando Diaz', 1, 27, 2, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "3200", "position": "[2723.668,-1240.784,49.987]", "stats": "[2,32.0,2,93]"}', '{"modSkin":"[908431499,429332843,942003495,1694074219,3508160042,null,282054283]","model":"mp_male","bodySize":126,"pedSize":1.05333,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"ponchos": "0x4B71D26B", "beltbuckle": "0x353C3AD6", "hat": "0x23582134", "offhand": "0x2E15B9B7", "access": "0x13F53A09", "boots": "0x195A47E0", "vests": "0x38F7760D", "gunbelts": "0x319BEEC1", "pants": "0x5151D24C", "eyewear": "0x47AF47AC", "neckwear": "0x1610AF5E"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(372, 148, 'John Turnbull', 1, 23, 82, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "189275", "position": "[-307.156,796.785,118.998]", "stats": "[237,30.49,100,100]", "dog": "A_C_DogHusky_01"}', '{"modSkin":"[908431499,557173395,1257168263,3623045497,612262189,null,354937489]","model":"mp_male","bodySize":126,"pedSize":1.042664,"features":"[0.0,0.4,0.4,0.0,0.0,0.0,0.0,0.0,0.4,0.3,0.0,0.3,0.0,0.0,0.5,0.3,0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"coats": "0", "vests": "0x1525E68A", "hat": "0x8B655559", "shirts": "0x3A5E458B", "pants": "0xC21EAA28", "gunbelts": "0x450CB6", "spurs": "0x6DF05052", "eyewear": "0x25C51838", "gloves": "0x3033DA22", "boots": "0x15E08C22", "coats2": "0x292B8B8F", "belts": "0xC0C7EB2A", "offhand": "0x3E9E41E8", "neckties": "0x4629890E", "beltbuckle": "0x25409ADF", "suspenders": "0", "masks": "0", "legs": "0", "cloaks": "0", "spats": "0", "chaps": "0", "ponchos": "0", "gauntlets": "0", "skirts": "0", "bracelets": "0", "neckwear": "0", "access": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(373, 147, 'James West', 1, 28, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-701.876,639.556,62.375]", "stats": "[2,33.6,2,100]"}', '{"modSkin":"[487821771,3670621102,543187419,2226823945,null,null,1692876447]","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":128,"pedSize":0.952003,"model":"mp_male"}', '{"shirts": "0xE5F4BDB2", "hat": "0x166462F8", "pants": "0x10051C7", "boots": "0x151EAB71", "spurs": "0x142D2BE8", "vests": "0x1CEFDC14", "gunbelts": "0x319BEEC1", "eyewear": "0x14F06EA7", "offhand": "0x1105E694", "beltbuckle": "0x139FCC19", "gloves": "0x10BD09BD"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(375, 151, 'Frederik Raninsky', 1, 68, 3, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-316.046,819.212,121.85]", "stats": "[215,33.29,100,99]"}', '{"modSkin":"[908431499,4225644199,2582128739,2539219498,612262189,null,231928634]","bodySize":127,"model":"mp_male","features":"[-0.9,-0.3,0.8,0.9,-0.2,0.7,0.9,0.7,0.7,-0.8,0.0,-0.7,0.0,-0.7,0.1,0.0,0.9,0.0,0.0,0.6,0.8,-0.3,-0.1,0.0,0.9,0.4,-0.9,0.0,0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":1.0}', '{"vests": "0x1ED62F2B", "pants": "0xD9641720", "coats2": "0xAD41268B", "boots": "0x54BC791", "shirts": "0x65C1B5F6", "eyewear": "0x111AFF82", "gunbelts": "0x1CE0C5ED", "spurs": "0x42FC0DC", "beltbuckle": "0x9845E1F6", "neckwear": "0x34E62EF6", "gloves": "0x1A2D8F40", "belts": "0xC9C76891", "access": "0x469B5DE4", "neckties": "0x3E56C2FB"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(376, 152, 'Rolo Dorn Dubar', 1, 33, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-1271.857,-876.644,51.818]", "stats": "[236,26.75,100,69]"}', '{"pedSize":1.079995,"features":"[0.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[1303185113,373001057,1996808861,2289847408,3450854762]","bodySize":127,"model":"mp_male"}', '{"hat": "0x12BD5208", "belts": "0x28FBEC8B", "shirts": "0x25D9BB59", "gunbelts": "0x153557", "boots": "0x156828EB", "vests": "0x1E442267", "pants": "0x1B9F91CD"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(377, 153, 'Juba campofino', 1, 18, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2745.775,-1241.617,49.833]", "stats": "[223,30.92,100,88]"}', '{"pedSize":1.0,"features":"[0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[487821771,null,543187419,2226823945]","bodySize":125,"model":"mp_male"}', '{"hat": "0x2D78BDDE", "neckwear": "0x3771091D", "belts": "0x2063DB53", "shirts": "0x27C0F18F", "gunbelts": "0x153557", "boots": "0x115D47FD", "coats2": "0x3B066B01", "pants": "0x1D8ADDD1", "access": "0x790DCD14", "offhand": "0x6BF75E20", "chaps": "0x25BF1052"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(380, 156, 'Kanaã Rodrigues', 1, 20, 1, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2370.543,985.8,74.129]", "stats": "[114,11.2,100,0]"}', '{"model":"mp_male","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[1587165517,489478938,1180660122,2539219498,642477207,null,298392309]","bodySize":127,"pedSize":1.0}', '{"hat": "0x104B07BD", "neckwear": "0x163F4C6E", "belts": "0x3F49FF1B", "eyewear": "0x3BA1A0E0", "boots": "0x30BED3D", "vests": "0x38F7760D", "coats2": "0x1DE62579", "pants": "0x389AB19E", "gunbelts": "0x2DF2E811", "beltbuckle": "0x19E1847B", "spurs": "0x142D2BE8", "shirts": "0x2A435E6D"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(381, 159, 'Licarco Ferro', 1, 18, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[1300.475,-1281.312,75.795]", "stats": "[249,17.03,100,26]"}', '{"model":"mp_male","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[2479411171,4271910581,96561259,1694074219,3065185688,null,39295965]","bodySize":127,"pedSize":0.920005}', '{"hat": "0x38262B2E", "shirts": "0xF25E9B82", "boots": "0x5D6DC7F7", "pants": "0x5D288492"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(382, 158, 'Alexandre Bill', 1, 24, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2735.525,-1392.915,46.13]", "stats": "[219,27.36,100,80]"}', '{"pedSize":0.920005,"features":"[-0.7,0.3,0.7,-0.7,-0.4,0.7,0.1,-0.1,0.4,0.5,0.3,-0.1,0.3,0.1,-0.1,0.2,0.2,0.2,0.2,0.0,0.0,0.0,0.3,-0.4,0.0,0.0,0.0,0.0,0.0,0.2,0.0,0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[908431499,731356029,1660566152,1694074219,46507404,712446626,766015793]","bodySize":127,"model":"mp_male"}', '{"hat": "0x1053D06F", "neckwear": "0x1750CBF5", "gloves": "0x1A2D8F40", "shirts": "0x2C288F19", "eyewear": "0x2761A139", "boots": "0x20D85860", "vests": "0x1525E68A", "access": "0x3B7F8161", "spurs": "0x19E1EC40", "beltbuckle": "0x25409ADF", "pants": "0x1D8ADDD1", "gunbelts": "0x620C1BC5"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(385, 98, 'Pablito Cornito', 1, 22, 1, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2585.429,-687.217,41.872]", "stats": "[2,33.6,2,100]"}', '{"features":"[-0.3,0.9,0.2,0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,0.0,0.0,0.0,0.4,-0.6,0.2,0.8,0.3,-0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":125,"pedSize":1.026665,"modSkin":"[2702657477,4099126971,null,null,1864171073,1015527107,382614413]","model":"mp_male"}', '{"vests": "0x1525E68A", "shirts": "0x1D615E9", "gunbelts": "0x620C1BC5", "belts": "0", "boots": "0x1EF2B6A3", "eyewear": "0", "hat": "0x166462F8", "gloves": "0x3033DA22", "pants": "0x106E3B84", "neckwear": "0x1750CBF5", "coats2": "0xE0FD61FA", "suspenders": "0", "masks": "0", "legs": "0", "cloaks": "0", "spats": "0", "beltbuckle": "0", "chaps": "0", "offhand": "0", "ponchos": "0", "spurs": "0", "skirts": "0", "gauntlets": "0", "bracelets": "0", "coats": "0", "neckties": "0", "access": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(386, 150, 'Castela Mask', 11, 43, 842, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "176148", "position": "[1305.623,-1312.218,81.733]", "stats": "[2,33.6,2,100]"}', '{"features":"[0.0,-0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":128,"pedSize":0.920005,"model":"mp_male","modSkin":"[null,505060812,null,null,642477207,null,319152566]"}', '{"gunbelts": "0x1CE0C5ED", "beltbuckle": "0x24936C3E", "boots": "0x151EAB71", "eyewear": "0x14F06EA7", "vests": "0x1525E68A", "neckwear": "0x1C990028", "hat": "0x104B07BD", "gloves": "0x2B8130D7", "pants": "0x12D463B0", "coats2": "0x1DE62579", "coats": "0", "spurs": "0x19E1EC40", "bracelets": "0", "gauntlets": "0", "masks": "0", "shirts": "0x1076A2D4", "cloaks": "0", "access": "0", "suspenders": "0", "chaps": "0", "offhand": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(387, 59, 'Botelho pinto', 13, 45, 1070, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "172378", "position": "[357.64,1507.365,180.063]", "stats": "[0,29.12,0,80]"}', '{"features":"[0.9,-0.6,-0.9,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":127,"pedSize":0.920005,"model":"mp_male","modSkin":"[2151078667,465258498,885240113,202858862,null,null,481122513]"}', '{"gunbelts": "0", "beltbuckle": "0", "eyewear": "0x14F06EA7", "bracelets": "0x2254C72E", "vests": "0", "neckwear": "0x163F4C6E", "hat": "0xB25D8F20", "gloves": "0", "pants": "0x11354899", "spurs": "0", "boots": "0", "belts": "0", "coats2": "0", "access": "0", "coats": "0", "shirts": "0", "masks": "0", "suspenders": "0", "offhand": "0", "gauntlets": "0", "neckties": "0", "cloaks": "0xB3EEC064", "ponchos": "0", "chaps": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(388, 97, 'Barbara Kimber', 1, 31, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[1319.535,-1298.262,76.306]", "stats": "[87,33.6,87,100]"}', '{"features":"[-0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":127,"pedSize":0.920005,"model":"mp_female","modSkin":"[3376063576,121268493,736263364,736263364,928002221]"}', '{"boots": "0x134D7E03", "pants": "0x46390E3D", "shirts": "0x1A8CE361", "hat": "0x1168422C", "gunbelts": "0x100FA02B", "belts": "0x214BD73B", "beltbuckle": "0x1133A823", "neckwear": "0x3028E9CE", "coats2": "0x27DA6CA1"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(389, 161, 'Mary Bee  Cuddy', 1, 25, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[1123.114,-1157.746,69.979]", "stats": "[250,33.6,100,100]"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":127,"modSkin":"[1999601735,2122306480,736263364,736263364,2210319017]","model":"mp_female","pedSize":0.920005}', '{"suspenders": "0x26780573", "beltbuckle": "0x270442E4", "eyewear": "0xB2FCEDC5", "pants": "0x2880F916", "hat": "0", "gloves": "0x126DC683", "boots": "0x134D7E03", "gunbelts": "0x46E3478E", "access": "0x3B6499DF", "neckties": "0x2674895D", "shirts": "0x1E3212F", "coats2": "0x2CDDAE63", "cloaks": "0", "coats": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(390, 77, 'Jonathan Smith', 1, 21, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[1035.769,-1126.181,64.276]", "stats": "[146,9.23,100,0]"}', '{"model":"mp_male","features":"[-0.3,-0.4,0.0,0.1,0.0,0.0,0.0,0.0,0.0,0.2,0.0,-0.5,0.8,-0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.1,-0.8,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":128,"pedSize":1.026665,"modSkin":"[1106971106,0,62321923,3550965899,2501331517,null,282054283]"}', '{"pants": "0x106E3B84", "boots": "0x10E40F4E", "coats": "0xC2242F13"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(391, 160, 'Will Lopes', 1, 27, 4, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "500", "position": "[2772.704,1376.982,67.77]", "stats": "[250,33.6,100,100]"}', '{"model":"mp_male","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[2239035010,2062355027,942003495,1694074219,3065185688,null,282054283]","pedSize":1.0,"bodySize":128}', '{"gunbelts": "0x412B86A", "belts": "0x28FBEC8B", "pants": "0x2324081D", "boots": "0x5F79541D", "access": "0x17920A1E", "bracelets": "0x2254C72E"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(392, 162, 'Jess Galinha', 1, 20, 19, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-302.67,790.161,117.903]", "stats": "[250,33.6,100,100]"}', '{"model":"mp_male","pedSize":0.920005,"bodySize":127,"features":"[0.0,-0.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.8,0.0,0.4,0.2,0.0,0.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[2534355977,83289899,543187419,2226823945,2501331517,712446626,1121209784]"}', '{"pants": "0x1B9F91CD", "coats2": "0x22087A9F", "boots": "0x5720605A", "gunbelts": "0x10CD7D44", "eyewear": "0x58B7F65D", "vests": "0x980657A6", "neckwear": "0x2F263307", "shirts": "0x1D615E9", "gloves": "0", "hat": "0", "belts": "0", "coats": "0", "offhand": "0", "cloaks": "0", "masks": "0", "chaps": "0", "spurs": "0x123BDDCB", "ponchos": "0", "access": "0", "gauntlets": "0", "bracelets": "0", "beltbuckle": "0", "neckties": "0", "suspenders": "0", "skirts": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(393, 134, 'Milton Magnum', 1, 35, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-1019.583,-1840.124,62.242]", "stats": "[250,33.6,100,100]"}', '{"bodySize":127,"model":"mp_male","pedSize":1.026665,"modSkin":"[1309745678,436828730,543187419,2226823945,642477207,null,382614413]","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(394, 163, 'JUNGLE RED', 1, 36, 13, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "80300", "position": "[1318.32,251.847,86.906]", "stats": "[86,11.2,87,0]"}', '{"pedSize":1.0,"modSkin":"[908431499,1788889546,543187419,2226823945,1552505114,null,766015793]","bodySize":127,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male"}', '{"beltbuckle": "0x3FB1B271", "boots": "0x195A47E0", "shirts": "0x4B9D634D", "gunbelts": "0x1CE0C5ED", "neckwear": "0x2F263307", "vests": "0x8EE3FDA4", "pants": "0x1D8ADDD1", "hat": "0x104B07BD", "coats2": "0x5FE9047A", "spurs": "0x42FC0DC"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(396, 154, 'Jean François', 1, 27, 38, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "47400", "position": "[-340.061,796.426,117.177]", "stats": "[224,26.57,100,69]"}', '{"pedSize":1.05333,"modSkin":"[3322561239,3884146271,null,null,2501331517,null,2169749075]","bodySize":128,"features":"[-0.4,0.6,0.2,0.0,0.0,0.0,0.0,0.0,0.8,-0.5,0.0,0.0,0.9,0.1,-0.7,0.0,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.2,0.5,0.7,0.6,0.0,0.0,0.8,0.0,0.0,-0.5,0.0,0.7,0.0,0.0,0.7,0.0]","model":"mp_male"}', '{"gunbelts": "0x620C1BC5", "neckwear": "0", "eyewear": "0x24FAF393", "coats": "0", "boots": "0xC430AF11", "shirts": "0x12801254", "pants": "0xE1B0ABFF", "offhand": "0", "gloves": "0x46CAD525", "coats2": "0xCAB6E0A9", "gauntlets": "0", "spurs": "0x6DF05052", "vests": "0x381EF1D3", "hat": "0x166462F8", "chaps": "0", "neckties": "0x67B0CC14", "beltbuckle": "0x24914BD1", "access": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(397, 74, 'Billy Kimber', 6, 45, 335, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "9236", "position": "[-1816.732,-372.218,166.497]", "stats": "[34,33.6,34,100]"}', '{"features":"[0.0,0.4,0.4,-0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.8,0.0,-0.7,0.0,0.0,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","bodySize":128,"pedSize":1.079995,"modSkin":"[1587165517,186954744,null,null,null,null,1881866345]"}', '{"shirts": "0x1281AB3F", "vests": "0x1525E68A", "belts": "0x748171", "gunbelts": "0x153557", "boots": "0x151EAB71", "gloves": "0x3B94811C", "neckwear": "0x163F4C6E", "pants": "0xA1E505A1", "beltbuckle": "0x16E62CC9", "coats2": "0x1AFCB535", "hat": "0x4FD50D1F", "chaps": "0", "coats": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(398, 165, 'Colton Riggs', 1, 36, 18, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[3001.077,561.215,44.446]", "stats": "[237,25.09,100,62]"}', '{"model":"mp_male","pedSize":1.0,"modSkin":"[3239248279,1942318931,2966572863,181068809,2452638665,3785588988,3717390630]","bodySize":126,"features":"[0.0,0.0,0.0,0.0,0.8,-0.4,0.0,0.1,0.0,0.8,0.0,0.0,-0.5,0.0,0.0,-0.5,0.0,0.0,0.5,-0.9,-0.6,-0.1,-0.9,0.8,0.6,0.0,0.1,0.0,0.0,-0.7,-0.5,0.0,0.0,0.0,0.7,0.0,0.0,0.0,0.0]"}', '{"gunbelts": "0x2F6BC2EB", "pants": "0x5BF04C5B", "coats2": "0x799FB5B0", "hat": "0xB70C089B", "neckwear": "0xFE6C9CCD", "boots": "0x28A567FA", "shirts": "0x2A77805F", "spurs": "0x1EDE4AC0", "beltbuckle": "0xC9EE847B"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(399, 164, 'Leroy J. Gibbs', 1, 41, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-1084.057,-1842.01,58.616]", "stats": "[250,33.6,100,100]"}', '{"model":"mp_male","pedSize":0.994667,"modSkin":"[3518440159,0,2966572863,181068809,642477207,1629650936,768038038]","bodySize":128,"features":"[-0.9,0.9,0.0,0.0,0.0,0.0,0.9,-0.5,-0.5,-0.1,-0.9,0.5,-0.8,0.2,0.9,-0.8,0.9,0.0,0.0,0.0,0.0,0.0,0.0,-0.8,0.0,0.9,0.0,-0.9,0.1,-0.9,0.0,0.0,0.0,-0.9,-0.9,-0.9,-0.9,-0.9,-0.9]"}', '{}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(400, 166, 'Nina Baker', 12, 25, 1011, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "24716", "position": "[1295.107,-1298.18,77.04]", "stats": "[223,11.2,100,0]"}', '{"model":"cs_mollyoshea","pedSize":0.973335,"modSkin":"[3794954484,1096242045,1218117202,1218117202,2836599857,959712255]","bodySize":128,"features":"[-0.5,0.0,-0.3,0.0,0.0,0.0,0.0,0.0,0.7,0.0,-0.9,0.6,0.0,-0.8,0.0,0.0,0.0,0.0,-0.8,0.0,0.0,0.0,0.0,-0.4,0.3,0.8,0.5,0.0,-0.9,-0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"belts": "0x19E84256", "shirts": "0x2D63CE34", "pants": "0x1DC42FF8", "neckties": "0x3A1231D0", "access": "0x46227A5A", "boots": "0x4B516716", "coats2": "0", "gloves": "0", "coats": "0", "beltbuckle": "0", "offhand": "0", "hat": "0x1992EAFC", "eyewear": "0", "spurs": "0", "skirts": "0", "bracelets": "0", "gauntlets": "0", "neckwear": "0", "gunbelts": "0", "masks": "0", "cloaks": "0", "vests": "0", "suspenders": "0", "chaps": "0", "ponchos": "0", "Outfit": "3"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(401, 143, 'Maxixi Coys', 2, 69, 114, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "6162", "position": "[1365.855,-1309.301,77.678]", "stats": "[250,33.6,100,100]"}', '{"model":"mp_male","pedSize":1.0,"modSkin":"[908431499,1785263689,2582128739,2539219498,3065185688,null,1376969807]","bodySize":126,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"beltbuckle": "0xC9FD59CC", "vests": "0x1C493A28", "eyewear": "0xDF6A0B7F", "suspenders": "0x1CB2B388", "hat": "0x68D0EBA5", "pants": "0x225EEA60", "gloves": "0xC2782707", "shirts": "0x16AD55DC", "gunbelts": "0x153557", "spurs": "0x2ECFEAA3", "boots": "0x4E5CB70"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(402, 135, 'Giuseppe Martini', 1, 25, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-1097.57,-1839.998,60.105]", "stats": "[250,33.6,100,100]"}', '{"model":"mp_male","pedSize":1.015999,"modSkin":"[908431499,1025183400,1660566152,1694074219,1552505114,null,354937489]","bodySize":126,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(403, 167, 'John Wayne', 1, 30, 20, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "800", "position": "[2277.181,-1044.955,43.573]", "stats": "[125,33.6,100,100]"}', '{"model":"mp_male","pedSize":0.930671,"modSkin":"[2207881199,1942318931,1272509601,3837101269,612262189,712446626,785798480]","bodySize":126,"features":"[0.0,0.0,0.0,0.2,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"vests": "0x1525E68A", "shirts": "0x167D36E9", "hat": "0x1751D32F", "pants": "0x1395EFA0", "boots": "0x1470CE34"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(404, 91, 'Harry Winston', 1, 32, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-804.318,-1319.047,43.564]", "stats": "[236,33.6,100,100]"}', '{"model":"mp_male","pedSize":1.010666,"modSkin":"[1631383957,395040981,1180660122,2539219498,642477207]","bodySize":128,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(406, 169, 'Ingo Schwittenberg', 1, 33, 1, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "2000", "position": "[1542.46,-1022.759,44.05]", "stats": "[29,12.21,29,5]"}', '{"model":"mp_male","pedSize":0.925338,"modSkin":"[2702657477,864946818,null,null,642477207,null,1073719212]","bodySize":128,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.4,-0.4,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"shirts": "0x16CD2EAC", "hat": "0x27B3E0A", "pants": "0x12D463B0", "coats2": "0x20ED22EA", "boots": "0x12F962EC"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(407, 168, 'Kate Catabriga', 1, 18, 1, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "3700", "position": "[-309.325,757.644,118.109]", "stats": "[1,11.2,1,0]"}', '{"model":"mp_female","pedSize":0.920005,"modSkin":"[2864896169,3055193076,743432389,743432389,3117725108,959712255]","bodySize":126,"features":"[0.0,0.7,0.5,0.0,-0.9,0.0,-0.9,-0.7,0.2,-0.4,0.0,0.6,0.2,0.0,0.0,-0.5,0.2,-0.6,0.9,-0.5,-0.2,0.5,0.4,-0.7,-0.5,-0.1,0.3,0.0,0.0,0.4,0.9,0.0,0.0,0.9,0.0,0.0,0.0,0.0,0.1]"}', '{"gunbelts": "0x449B5878", "hat": "0x1746D236", "pants": "0x5664D0BA", "gloves": "0x8129E92", "shirts": "0x1E3212F", "access": "0x54F497FE", "spurs": "0x21FE84B3", "boots": "0x6498D13D"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(409, 149, 'Jesse James', 11, 30, 761, '{}', 32, '{"hunger": "0", "thirst": "0", "banco": "150046", "position": "[2730.735,-1220.073,49.706]", "stats": "[7,33.6,7,100]"}', '{"model":"mp_male","pedSize":1.079995,"modSkin":"[3620587182,2874852206,1180660122,2539219498,2195072443,712446626,3750364151]","bodySize":127,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"vests": "0x59786AE7", "belts": "0", "eyewear": "0xDF6A0B7F", "shirts": "0x9CB923E0", "neckwear": "0", "coats": "0", "hat": "0x9488C5B1", "pants": "0xE1B0ABFF", "gloves": "0x6EF757A8", "access": "0", "boots": "0xC430AF11", "beltbuckle": "0x6E882D6D", "spurs": "0", "chaps": "0", "masks": "0", "neckties": "0x3E56C2FB", "gunbelts": "0x620C1BC5", "offhand": "0", "coats2": "0xCD5DD253", "gauntlets": "0", "suspenders": "0", "cloaks": "0", "bracelets": "0", "skirts": "0", "ponchos": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(411, 172, 'Don Diablo', 1, 21, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[587.907,1674.579,187.797]", "stats": "[89,19.72,89,38]"}', '{"features":"[-0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,-0.6,0.0,0.0,0.0,0.0,-0.7,0.0,0.0,-0.7,0.0]","model":"mp_male","bodySize":128,"modSkin":"[3753883892,843248893,543187419,2226823945,642477207,1629650936,502538388]","pedSize":1.026665}', '{"beltbuckle": "0x14DCF24E", "gunbelts": "0x1371FF7F", "pants": "0x4D348A92", "hat": "0x104B07BD", "neckwear": "0x1301145F", "vests": "0x1525E68A", "boots": "0x195A47E0", "belts": "0x131D437B", "coats2": "0x1DE62579", "gloves": "0x17241F4", "access": "0x13F53A09", "shirts": "0x10B87936"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(414, 174, 'SANSAO', 1, 22, 17, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[1300.875,-1291.999,76.152]", "stats": "[250,33.6,100,100]"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.4,0.2,0.0,-0.8,0.4,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.5,0.0,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.8,0.5,-0.6,-0.4,0.0,0.0]","bodySize":126,"pedSize":1.026665,"modSkin":"[2702657477,0,null,null,null,712446626,990976242]","model":"mp_male"}', '{"beltbuckle": "0x17B4FFBC", "gunbelts": "0x1CE0C5ED", "pants": "0x2800212A", "hat": "0x9D734702", "gloves": "0x46CAD525", "neckties": "0x67B0CC14", "boots": "0x6C930213", "shirts": "0xEA394419", "coats2": "0x20ED22EA", "coats": "0", "chaps": "0", "masks": "0", "neckwear": "0xBD99C063", "ponchos": "0", "suspenders": "0", "access": "0", "bracelets": "0", "belts": "0xE456C936", "cloaks": "0x3CDEDC38", "gauntlets": "0", "offhand": "0", "vests": "0", "spurs": "0x42FC0DC"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(415, 119, 'Gerald de Rivia', 1, 42, 42, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[363.917,1446.519,178.025]", "stats": "[250,33.6,100,100]"}', '{"features":"[-0.7,0.0,0.0,0.0,0.0,0.0,0.9,0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,0.0,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","pedSize":1.079995,"modSkin":"[2063528470,557173395,543187419,2226823945,642477207,712446626,2706920252]","bodySize":128}', '{"gunbelts": "0x412B86A", "pants": "0xBFC224DC", "bracelets": "0x136BA95C", "hat": "0xB25D8F20", "neckwear": "0x1024C03D", "gloves": "0x16F937E6", "ponchos": "0x312219CA", "offhand": "0x1184AC1D", "boots": "0x23156B7D", "coats2": "0xA0ECA2E7", "spurs": "0x2E85B95C", "vests": "0x374E6E38", "access": "0x47D2DD9D", "belts": "0x34A718CD", "shirts": "0x242B2AA7"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(416, 175, 'Capitolina Pádua', 1, 23, 0, '{}', 16, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[1380.68,-1337.31,77.958]", "stats": "[104,11.2,100,0]"}', '{"features":"[-0.7,0.0,0.3,0.5,-0.7,0.0,0.0,0.0,0.2,0.5,0.0,0.4,-0.9,-0.9,0.0,0.0,-0.7,0.0,0.6,0.1,0.0,0.0,0.0,-0.9,0.0,0.8,0.1,0.0,0.0,-0.2,0.5,0.0,-0.3,0.9,-0.6,0.1,0.8,0.6,0.9]","bodySize":128,"model":"mp_female","modSkin":"[1705365104,2403638681,1218117202,1218117202,2489772761,959712255]","pedSize":0.94667}', '{"hat": "0x3AF49B35", "boots": "0x4CAF9C45", "coats2": "0xEB109047", "shirts": "0xB850E093", "skirts": "0xA517C35D"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(417, 170, 'Mark Mcfield', 15, 35, 2257, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "275539", "position": "[1297.931,-1302.134,77.041]", "stats": "[0,33.26,0,98]"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,-0.9,-0.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":1.0,"bodySize":127,"modSkin":"[3396185070,3924054474,543187419,2226823945,3065185688,null,1855989868]","model":"mp_male"}', '{"beltbuckle": "0x24914BD1", "gunbelts": "0x620C1BC5", "coats": "0", "hat": "0x4AAFCE04", "shirts": "0x12801254", "access": "0", "boots": "0xC430AF11", "spurs": "0x6DF05052", "pants": "0xE1B0ABFF", "gloves": "0x5912ECA0", "suspenders": "0", "coats2": "0xCAB6E0A9", "masks": "0", "legs": "0", "cloaks": "0", "neckwear": "0", "vests": "0x381EF1D3", "chaps": "0", "offhand": "0", "ponchos": "0", "belts": "0x5C32A201", "neckties": "0x67B0CC14", "gauntlets": "0", "bracelets": "0", "spats": "0", "skirts": "0", "eyewear": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(419, 54, 'Diego Ownz', 1, 23, 2, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "1725", "position": "[2722.088,-1238.092,49.882]", "stats": "[24,18.48,25,33]"}', '{"pedSize":0.920005,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","modSkin":"[2702657477,3829475470,543187419,2226823945,2739887825,null,1244870786]","bodySize":125}', '{"pants": "0xCDC7B43E", "gloves": "0", "hat": "0x9EE27673", "suspenders": "0", "gauntlets": "0", "access": "0x965A7D5D", "shirts": "0xF40F041D", "bracelets": "0", "gunbelts": "0", "ponchos": "0", "coats": "0", "vests": "0x2A80328B", "eyewear": "0", "coats2": "0", "belts": "0", "offhand": "0", "boots": "0xD27A4BA4", "masks": "0", "chaps": "0x2F9801A9"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(420, 160, 'Willian Lopez', 1, 27, 7, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2742.622,-1408.492,46.104]", "stats": "[227,33.6,100,100]"}', '{"pedSize":1.010666,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","modSkin":"[1180513553,604645064,885240113,202858862,612262189,null,382614413]","bodySize":128}', '{"pants": "0x12D463B0", "boots": "0x192C2A4B", "hat": "0x262CC9D4", "coats2": "0x26A3702F", "chaps": "0", "coats": "0", "shirts": "0x28BBFD59", "cloaks": "0", "beltbuckle": "0x353C3AD6", "offhand": "0xE0EAD765", "vests": "0x1525E68A", "gauntlets": "0", "neckwear": "0x163F4C6E", "eyewear": "0xB23041AE", "belts": "0", "gloves": "0x24B7D363", "gunbelts": "0x620C1BC5", "spurs": "0x19E1EC40", "access": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(421, 173, 'Jill McBaine', 1, 18, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2105.283,1425.885,150.64]", "stats": "[0,33.6,0,100]"}', '{"pedSize":1.026665,"features":"[0.0,0.0,0.0,-0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.8,0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.9]","model":"mp_female","bodySize":127,"modSkin":"[3386243175,396308894,736263364,736263364,2451302243,959712255]"}', '{"pants": "0x349085A", "boots": "0x16BF0A", "vests": "0x2B9669B2", "coats2": "0x3487C5A7", "coats": "0", "shirts": "0x1F53BB18", "cloaks": "0x631BDE78", "hat": "0x2809B3FE"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(422, 179, 'Belle Starr', 1, 39, 4, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[1888.516,322.166,83.605]", "stats": "[2,11.2,2,0]"}', '{"pedSize":1.05333,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.3,0.0,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_female","bodySize":126,"modSkin":"[2864896169,497657806,743432389,743432389,928002221,1255518018]"}', '{"pants": "0x114B1F63", "coats": "0", "gloves": "0x141973E5", "gunbelts": "0x12D50473", "eyewear": "0", "ponchos": "0", "access": "0", "vests": "0x1077DF15", "masks": "0", "boots": "0x134D7E03", "hat": "0x1232638B", "coats2": "0x11F694A8", "gauntlets": "0", "neckwear": "0x1B34F56D", "shirts": "0x1E3212F", "cloaks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(424, 178, 'Davy Caladett', 1, 18, 1, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "1200", "position": "[2923.53,1382.601,56.309]", "stats": "[137,33.6,100,100]"}', '{"pedSize":1.0,"features":"[0.0,0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.6,0.0,-0.2,0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","modSkin":"[1631383957,2184788560,942003495,1694074219,3065185688,null,2973239026]","bodySize":127}', '{"pants": "0x565DC762", "beltbuckle": "0x5894AC28", "spurs": "0", "coats": "0", "chaps": "0", "neckwear": "0", "gloves": "0x46CAD525", "eyewear": "0", "access": "0", "shirts": "0x423171B6", "cloaks": "0", "neckties": "0x4574F536", "gunbelts": "0x620C1BC5", "masks": "0", "vests": "0x1ED62F2B", "boots": "0x69CABABD", "hat": "0xA7A1A426", "coats2": "0x3B57D2A6", "gauntlets": "0", "ponchos": "0", "belts": "0", "suspenders": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(430, 64, 'Chuva Molhada', 2, 32, 110, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "2500", "position": "[1361.557,-1300.145,77.761]", "stats": "[249,32.41,100,95]"}', '{"pedSize":1.010666,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","modSkin":"[519165173,464056288,1210379577,3723790941]","bodySize":127}', '{"pants": "0xED01EF60", "gunbelts": "0x620C1BC5", "offhand": "0", "boots": "0x20D85860", "hat": "0x17812F51", "access": "0", "bracelets": "0", "gauntlets": "0x7483944C", "belts": "0", "beltbuckle": "0x24914BD1", "coats": "0", "shirts": "0x423171B6", "vests": "0x794A2FAD", "coats2": "0xCAB6E0A9", "eyewear": "0x111AFF82", "spurs": "0x123BDDCB"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(433, 182, 'Django Miles', 1, 35, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-847.565,-1353.367,43.268]", "stats": "[66,11.87,67,3]"}', '{"pedSize":0.94667,"features":"[0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","modSkin":"[3239248279,436828730,1660566152,1694074219,null,null,605652010]","bodySize":126}', '{"pants": "0x262B1D80", "beltbuckle": "0x6E882D6D", "spurs": "0x19E1EC40", "bracelets": "0", "ponchos": "0", "chaps": "0", "masks": "0", "gloves": "0x1A2D8F40", "eyewear": "0x271E132A", "suspenders": "0", "shirts": "0x1D615E9", "belts": "0x3F49FF1B", "neckties": "0", "gunbelts": "0x15AF5CC4", "offhand": "0xE0EAD765", "coats": "0", "neckwear": "0x63EC652B", "boots": "0x69D2FCA3", "hat": "0x707839AB", "coats2": "0x28AB5092", "gauntlets": "0", "cloaks": "0", "access": "0", "vests": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(437, 185, 'James Gray', 1, 23, 18, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "5900", "position": "[3021.179,567.09,44.813]", "stats": "[212,33.6,100,100]"}', '{"modSkin":"[3396185070,3829475470,543187419,2226823945,612262189,712446626,1855989868]","pedSize":0.994667,"model":"mp_male","features":"[0.0,0.8,0.0,-0.7,-0.5,-0.6,-0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.4,-0.1,0.0,-0.8,0.0,-0.6,0.0,0.2,0.0,0.0,0.0,0.0,0.0,0.0,-0.1,-0.6,0.0,0.0,0.0,0.0]","bodySize":128}', '{"beltbuckle": "0", "hat": "0x748886BE", "eyewear": "0", "vests": "0x1525E68A", "chaps": "0", "boots": "0x6A2B9E5", "ponchos": "0", "coats2": "0", "pants": "0x2B59F15B", "shirts": "0x5D049010", "access": "0xECC2276D", "cloaks": "0", "coats": "0", "gunbelts": "0x620C1BC5", "neckties": "0", "offhand": "0", "gauntlets": "0", "belts": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(438, 141, 'Chino Perez', 1, 32, 87, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "28576", "position": "[1326.203,-1301.262,76.249]", "stats": "[164,28.95,100,79]", "posse": "65"}', '{"modSkin":"[519165173,2031283199,62321923,3550965899,3450854762,3776970741,2973239026]","pedSize":0.920005,"model":"mp_male","bodySize":125,"features":"[0.0,0.7,-0.8,-0.7,0.0,0.0,0.0,-0.9,0.4,0.0,0.0,-0.1,0.0,0.0,0.0,0.0,0.5,-0.7,-0.6,0.0,0.0,0.0,0.1,0.0,0.0,0.9,-0.9,0.0,0.0,0.0,-0.8,0.7,-0.9,0.0,-0.7,0.0,-0.1,-0.6,0.5]"}', '{"beltbuckle": "0x1B301155", "belts": "0x8DB52B0E", "vests": "0", "neckwear": "0x14757301", "neckties": "0", "shirts": "0x2FABE159", "suspenders": "0x51C8C0C", "coats": "0", "gunbelts": "0x1C04C393", "eyewear": "0x520C4B95", "spurs": "0x3B330A2A", "chaps": "0x4AD7A8D7", "pants": "0x2C92A26A", "ponchos": "0xBED49D92", "coats2": "0", "offhand": "0", "bracelets": "0", "boots": "0x347B9044", "cloaks": "0", "gauntlets": "0", "hat": "0x17C59C8F", "masks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(439, 187, 'Abigail Earp', 2, 22, 152, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "45772", "position": "[1293.25,-1346.532,77.536]", "stats": "[50,33.6,50,100]", "dog": "A_C_DogHusky_01"}', '{"modSkin":"[510647803,315772104,743432389,743432389,928002221]","pedSize":0.920005,"model":"mp_female","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":126}', '{"gauntlets": "0", "hat": "0x955820EB", "vests": "0x4662B231", "skirts": "0", "pants": "0x1945CE44", "shirts": "0xD1D2C23B", "masks": "0", "boots": "0x16BF0A", "gunbelts": "0x20A31050", "eyewear": "0", "beltbuckle": "0x2F5F76FE", "neckwear": "0x1BA10D1", "spurs": "0x1468A6E1", "belts": "0", "coats": "0", "ponchos": "0", "coats2": "0x1E0250EA", "offhand": "0", "bracelets": "0", "access": "0x46227A5A", "cloaks": "0", "chaps": "0xF48A5999", "gloves": "0x2EBFF2B6", "Outfit": "5"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(440, 117, 'Sebastian Bury', 2, 25, 117, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-268.192,608.113,112.68]", "stats": "[250,33.6,100,100]"}', '{"modSkin":"[2949506350,1414743118,null,null,642477207,null,3750364151]","pedSize":1.05333,"model":"mp_male","bodySize":128,"features":"[-0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"gauntlets": "0", "hat": "0", "cloaks": "0", "chaps": "0", "vests": "0", "bracelets": "0", "coats": "0", "ponchos": "0", "coats2": "0xFE114013", "pants": "0x10051C7", "shirts": "0xBF187D04", "gloves": "0x1A2D8F40", "suspenders": "0", "boots": "0x20D85860", "gunbelts": "0x153557", "offhand": "0", "access": "0", "neckties": "0", "masks": "0", "eyewear": "0", "neckwear": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(441, 181, 'Leopoldo Codorniz', 1, 53, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-606.369,522.384,96.76]", "stats": "[250,13.03,100,8]"}', '{"modSkin":"[3554073945,0,null,null,3508160042,1015527107,4203626976]","pedSize":1.079995,"model":"mp_male","features":"[0.6,0.5,0.4,0.5,0.9,0.8,-0.9,0.0,0.7,0.8,0.7,-0.9,0.0,0.0,0.0,0.2,0.3,0.0,0.0,0.0,0.1,0.0,0.0,0.9,0.5,0.0,-0.8,0.0,0.9,0.4,0.0,0.0,0.0,0.9,0.9,0.0,0.0,0.0,0.0]","bodySize":125}', '{"beltbuckle": "0", "hat": "0x353BBF58", "eyewear": "0x8953AC8", "chaps": "0x15FA70BD", "coats": "0", "vests": "0", "spurs": "0x3BB959DE", "neckwear": "0x163F4C6E", "belts": "0", "coats2": "0", "gloves": "0", "shirts": "0xBF187D04", "pants": "0x1A6D27DD", "cloaks": "0", "boots": "0x151EAB71", "gunbelts": "0x412B86A", "ponchos": "0", "suspenders": "0x1CB2B388", "offhand": "0", "bracelets": "0", "gauntlets": "0", "neckties": "0", "access": "0x3B7F8161"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(442, 184, 'Marcus Howard', 1, 25, 50, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "1400", "position": "[-341.958,763.323,116.629]", "stats": "[250,33.6,100,100]"}', '{"modSkin":"[1209218150,2549744761,1257168263,3623045497,3508160042,null,1743934292]","pedSize":1.015999,"model":"mp_male","bodySize":128,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"gauntlets": "0", "hat": "0x17812F51", "vests": "0x8649EB7D", "neckwear": "0", "pants": "0x5F622EED", "shirts": "0xD105ACDF", "chaps": "0x6223576E", "gunbelts": "0x5261D9F3", "eyewear": "0", "spurs": "0x5A5BEE68", "coats": "0", "belts": "0", "ponchos": "0", "coats2": "0", "offhand": "0x1105E694", "beltbuckle": "0x28C906B9", "access": "0x17920A1E", "cloaks": "0", "gloves": "0x1A2D8F40", "boots": "0x34B705E8", "bracelets": "0", "suspenders": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(443, 188, 'Wayne West', 1, 32, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2555.504,-1160.841,53.696]", "stats": "[250,33.6,100,100]"}', '{"modSkin":"[2230576261,623103571,2362013313,3623045497,2432743988,712446626,502538388]","pedSize":0.994667,"model":"mp_male","features":"[0.0,0.1,0.7,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.2,0.0,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":128}', '{"hat": "0x10106532", "coats2": "0", "coats": "0", "shirts": "0x8ED468DE", "vests": "0", "beltbuckle": "0x18DB3EB3", "eyewear": "0", "suspenders": "0", "access": "0", "masks": "0", "ponchos": "0", "gunbelts": "0x1CE0C5ED", "gloves": "0x582DC308", "neckwear": "0x14757301", "neckties": "0", "chaps": "0", "cloaks": "0", "boots": "0x8D41F3EB", "pants": "0x5043625B", "bracelets": "0", "belts": "0x2330E0ED", "gauntlets": "0", "offhand": "0x1105E694", "spurs": "0x200A7968"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(445, 180, 'Rosi Marry', 1, 32, 190, '{}', 16, '{"hunger": "0", "thirst": "0", "banco": "30", "position": "[-284.102,802.581,119.379]", "stats": "[250,33.6,100,100]", "dog": "A_C_DogPoodle_01"}', '{"bodySize":127,"model":"mp_female","modSkin":"[3103323413,2437706505,900188667,900188667,928002221,959712255]","pedSize":1.0,"features":"[0.5,0.9,0.3,0.3,0.0,0.0,0.0,0.0,0.3,0.2,-0.6,0.0,0.9,0.0,-0.1,-0.5,-0.1,-0.9,-0.8,0.5,-0.9,0.6,0.5,-0.7,0.0,0.5,0.7,0.0,0.0,-0.9,0.0,0.0,0.0,0.0,0.0,0.9,0.0,0.0,0.9]"}', '{"coats2": "0", "vests": "0", "cloaks": "0", "shirts": "0x992B50ED", "boots": "0x134D7E03", "ponchos": "0", "coats": "0", "skirts": "0x5893FD94", "chaps": "0", "hat": "0x1746D236"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(446, 189, 'Toni bala ', 1, 21, 90, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "36801", "position": "[1293.849,-1281.58,75.427]", "stats": "[236,33.6,100,100]", "dog": "A_C_DogHusky_01"}', '{"pedSize":0.962669,"model":"mp_male","features":"[0.0,0.0,0.0,-0.7,0.0,0.0,0.0,0.0,0.0,0.0,-0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":127,"modSkin":"[1106971106,616336951,1210379577,3723790941,612262189,712446626,601768357]"}', '{"spurs": "0x142D2BE8", "belts": "0", "pants": "0xD9641720", "offhand": "0", "chaps": "0", "vests": "0x1E442267", "eyewear": "0", "access": "0x47D2DD9D", "ponchos": "0", "beltbuckle": "0x463678FA", "shirts": "0", "boots": "0x341BC898", "gauntlets": "0", "coats": "0", "cloaks": "0", "masks": "0", "suspenders": "0", "coats2": "0", "gloves": "0", "hat": "0x1632867A", "gunbelts": "0x3DF1A52", "neckties": "0", "neckwear": "0", "bracelets": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(447, 190, 'Richard Andrews', 10, 18, 518, '{}', 16, '{"hunger": "0", "thirst": "0", "banco": "44100", "position": "[1424.323,-1307.962,77.586]", "stats": "[250,33.6,100,100]", "dog": "A_C_Cat_01"}', '{"pedSize":1.005333,"model":"mp_male","features":"[0.0,0.7,0.7,0.0,0.0,0.0,0.0,0.0,-0.6,0.3,-0.5,0.0,0.0,0.4,0.6,0.0,0.4,0.3,0.0,0.0,0.1,0.0,-0.1,0.0,0.0,0.3,0.0,0.5,0.0,0.0,-0.4,-0.7,0.0,-0.6,0.0,0.0,0.0,-0.3,0.0]","modSkin":"[2702657477,83289899,543187419,2226823945,642477207,1629650936,1971724686]","bodySize":126}', '{"gunbelts": "0x1CE0C5ED", "coats2": "0", "vests": "0x59786AE7", "beltbuckle": "0x1B301155", "pants": "0x5F622EED", "shirts": "0x581A73B0", "boots": "0x119D4929", "coats": "0", "spurs": "0", "gloves": "0", "suspenders": "0", "access": "0x361F17DA", "neckwear": "0x1C7A8063", "eyewear": "0", "ponchos": "0", "cloaks": "0", "gauntlets": "0", "chaps": "0", "bracelets": "0", "hat": "0", "offhand": "0", "belts": "0x8DB52B0E", "neckties": "0", "masks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(449, 57, 'Koda', 1, 21, 1, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[3010.044,555.868,44.629]", "stats": "[236,30.69,100,96]"}', '{"bodySize":127,"model":"mp_male","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":0.920005,"modSkin":"[549367063,3705478035,62321923,3550965899,642477207]"}', '{"beltbuckle": "0", "neckties": "0", "shirts": "0", "pants": "0xF9CDB0D9", "gauntlets": "0", "coats2": "0", "coats": "0", "suspenders": "0x1B7E5AA5", "bracelets": "0x136BA95C", "eyewear": "0", "access": "0x17920A1E", "belts": "0xF68F8A60", "gloves": "0", "cloaks": "0", "boots": "0x156828EB"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(451, 117, 'Tadan Lonewolf', 1, 25, 13, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-333.835,-363.7,88.095]", "stats": "[236,33.6,100,100]", "dog": "A_C_DogHusky_01"}', '{"bodySize":128,"model":"mp_male","features":"[0.2,-0.9,0.5,0.0,0.0,0.0,0.0,0.0,0.9,-0.6,-0.4,0.0,0.0,-0.7,-0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.4,0.0,0.0,0.0,-0.3,0.0,0.0,0.0,0.0,0.2,0.0,0.0,-0.7,0.0,0.0]","modSkin":"[1106971106,1912251213,62321923,3550965899,46507404,712446626]","pedSize":1.026665}', '{"coats2": "0", "coats": "0xF011039C", "shirts": "0x16AD55DC", "pants": "0x165A9CDF", "gloves": "0x4B7A10AE", "chaps": "0x3D480DB8", "hat": "0x28487271"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(452, 191, 'Júlio Aurélio', 1, 31, 97, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "4561", "position": "[2316.726,-1181.89,43.338]", "stats": "[235,33.6,100,100]"}', '{"pedSize":0.920005,"model":"mp_male","modSkin":"[1271670893,637847969,1180660122,2539219498,1552505114,null,2054997725]","bodySize":127,"features":"[-0.9,0.0,0.0,0.6,0.0,0.0,0.8,0.0,0.0,0.9,0.0,0.0,0.0,0.0,0.0,0.5,0.0,0.3,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"spurs": "0x17346DD4", "belts": "0", "pants": "0x2A14E8CF", "masks": "0", "coats2": "0", "bracelets": "0", "eyewear": "0x9A1DFEE", "ponchos": "0x8E7E5481", "beltbuckle": "0x16BBC668", "shirts": "0x16CD2EAC", "boots": "0x11044269", "gauntlets": "0", "coats": "0x22A8A5DA", "neckwear": "0x1B63F371", "cloaks": "0", "vests": "0", "gunbelts": "0x29875F42", "offhand": "0", "chaps": "0", "hat": "0x1AFDD7DC"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(454, 192, 'Elideus Henriques Camões', 1, 22, 84, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "24100", "position": "[2323.609,-1142.269,44.559]", "stats": "[192,33.6,100,100]"}', '{"pedSize":1.015999,"model":"mp_male","features":"[0.4,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[3631852132,0,942003495,1694074219,2195072443,1629650936,282054283]","bodySize":124}', '{"shirts": "0x12801254", "pants": "0x225EEA60", "masks": "0", "coats2": "0", "vests": "0x5CECE174", "cloaks": "0", "boots": "0xE222CDCE", "chaps": "0", "ponchos": "0", "coats": "0", "hat": "0x21C75A0F", "eyewear": "0x111AFF82", "neckwear": "0x163F4C6E", "gauntlets": "0", "suspenders": "0", "offhand": "0", "spurs": "0", "bracelets": "0", "access": "0x99E945EF", "gunbelts": "0x412B86A", "gloves": "0", "beltbuckle": "0", "neckties": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(455, 55, 'Paul Smith Zenon', 1, 30, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "13900", "position": "[-302.517,781.231,118.803]", "stats": "[47,33.6,48,100]"}', '{"pedSize":1.037331,"model":"mp_male","features":"[0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.8,-0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":126,"modSkin":"[null,3798985182,null,null,3065185688,null,1658715876]"}', '{"beltbuckle": "0", "belts": "0", "shirts": "0xA594965E", "pants": "0xE1B0ABFF", "boots": "0x38271590", "vests": "0xA2B3AE98", "neckties": "0x95A2D4FB", "access": "0", "gunbelts": "0x620C1BC5", "gloves": "0xD4329873", "spurs": "0x8DB6D5D", "hat": "0x6926E8D5", "coats": "0", "coats2": "0", "chaps": "0", "neckwear": "0x163F4C6E", "offhand": "0", "bracelets": "0", "eyewear": "0", "suspenders": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(458, 155, 'Heron Miles', 1, 20, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2608.941,-1140.411,51.538]", "stats": "[250,32.13,100,93]"}', '{"modSkin":"[3322561239,623103571,null,null,2195072443,null,481122513]","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","pedSize":1.010666,"bodySize":128}', '{"gunbelts": "0x620C1BC5", "access": "0", "beltbuckle": "0x17B4FFBC", "shirts": "0x1F5FA114", "suspenders": "0", "offhand": "0x45B0A0EF", "neckwear": "0x163F4C6E", "vests": "0x1525E68A", "gloves": "0x1A2D8F40", "coats2": "0x78268373", "pants": "0xF294D831", "hat": "0x59F583EB", "eyewear": "0x36451407", "coats": "0", "boots": "0x20D85860", "belts": "0x102F20E6", "ponchos": "0", "cloaks": "0x19A58ECF"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(459, 193, 'Forrest Cassidy', 4, 41, 211, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "61600", "position": "[2693.156,-1196.811,56.39]", "stats": "[212,33.6,100,100]", "dog": "A_C_DogAmericanFoxhound_01"}', '{"bodySize":128,"features":"[-0.5,0.1,-0.8,-0.9,0.3,0.0,0.9,-0.6,0.9,0.0,0.2,0.9,0.9,0.9,-0.8,0.0,0.0,-0.6,0.0,-0.7,0.0,0.1,-0.8,0.9,0.0,0.0,0.0,0.0,0.0,0.5,-0.3,0.0,0.0,0.0,0.0,0.9,0.8,0.0,0.0]","model":"mp_male","pedSize":0.920005,"modSkin":"[3518440159,2665132662,543187419,2226823945,2452638665,1629650936,2816141621]"}', '{"gloves": "0x2D851A19", "masks": "0", "eyewear": "0xDF6A0B7F", "beltbuckle": "0", "belts": "0", "gunbelts": "0", "cloaks": "0", "vests": "0", "shirts": "0x5EACC277", "coats": "0", "suspenders": "0x129DD6FD", "access": "0", "boots": "0xDD40479E", "hat": "0xB396E0D1", "pants": "0xCCB6BBB2", "ponchos": "0", "gauntlets": "0", "neckties": "0", "neckwear": "0", "chaps": "0", "spurs": "0", "offhand": "0", "coats2": "0", "bracelets": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(460, 69, 'Javier Hernandéz', 1, 30, 40, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "28394", "position": "[-269.506,817.108,119.062]", "stats": "[37,33.6,38,100]"}', '{"modSkin":"[1998225129,3676725024,543187419,2226823945,642477207,null,683891516]","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","pedSize":1.005333,"bodySize":128}', '{"gloves": "0x2B8130D7", "masks": "0", "eyewear": "0x520C4B95", "belts": "0x28FBEC8B", "gunbelts": "0x3DF1A52", "cloaks": "0xA7A2AACF", "hat": "0x262CC9D4", "shirts": "0x7EB4ED0E", "coats": "0", "coats2": "0x26A3702F", "ponchos": "0", "offhand": "0x975EC44A", "neckties": "0", "neckwear": "0", "pants": "0x2800212A", "gauntlets": "0", "spurs": "0x390F2B71", "boots": "0x38772DE7", "bracelets": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(461, 109, 'Pedro Davis', 1, 35, 10, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2553.313,-1156.673,53.764]", "stats": "[109,33.6,100,100]"}', '{"modSkin":"[2239035010,0,1519555092,4045206010,3065185688,null,3783314784]","features":"[0.9,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.9,0.0,0.0,0.0,0.9,0.0,0.0,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":124,"pedSize":1.079995,"model":"mp_male"}', '{"neckties": "0", "coats2": "0x1DE62579", "eyewear": "0x3766BB7B", "gloves": "0x1A2D8F40", "masks": "0", "suspenders": "0", "belts": "0x52808E9D", "gauntlets": "0", "coats": "0", "bracelets": "0", "hat": "0x38B3DB72", "neckwear": "0", "beltbuckle": "0", "spurs": "0", "shirts": "0x1D615E9", "gunbelts": "0x620C1BC5", "boots": "0x23F56F2C", "access": "0", "pants": "0x389AB19E", "offhand": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(462, 194, 'Lizander Vuck', 3, 32, 186, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "119919", "position": "[-313.517,810.691,121.976]", "stats": "[239,23.78,100,56]", "dog": "A_C_DogChesBayRetriever_01"}', '{"modSkin":"[3620587182,0,543187419,2226823945,1552505114,712446626,3359587060]","features":"[0.0,0.9,0.0,0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","pedSize":1.0,"bodySize":128}', '{"hat": "0x2D625B41", "bracelets": "0", "gunbelts": "0x153557", "eyewear": "0", "ponchos": "0", "offhand": "0", "coats2": "0xCAB6E0A9", "gloves": "0x24B7D363", "boots": "0xC430AF11", "chaps": "0", "beltbuckle": "0xA9E228BA", "spurs": "0x6DF05052", "vests": "0x381EF1D3", "shirts": "0xCB57BC0", "gauntlets": "0", "access": "0", "cloaks": "0", "belts": "0", "neckwear": "0", "pants": "0xE1B0ABFF", "masks": "0", "coats": "0", "neckties": "0x67B0CC14"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(463, 195, 'Joaquim José', 1, 27, 46, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "56", "position": "[-308.541,678.516,113.692]", "stats": "[242,11.2,100,0]"}', '{"modSkin":"[853589349,1904085443,62321923,3550965899,46507404,null,307184935]","features":"[0.9,0.3,0.0,0.0,0.9,0.0,0.0,0.0,0.2,0.6,0.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.8,0.6,0.6,0.4,0.0,0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":124,"pedSize":1.0,"model":"mp_male"}', '{"masks": "0", "hat": "0", "boots": "0x23156B7D", "chaps": "0", "ponchos": "0", "eyewear": "0x111AFF82", "pants": "0xDAADFF9F", "belts": "0x102F20E6"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(465, 196, 'Sónia Erikson', 1, 27, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[831.033,-1038.221,49.941]", "stats": "[250,33.6,100,100]"}', '{"modSkin":"[1999601735,2296822697,1218117202,1218117202,928002221,959712255]","features":"[-0.5,0.0,0.0,0.0,0.8,0.0,0.0,-0.9,-0.8,0.0,-0.9,0.0,0.0,0.7,0.4,-0.5,0.4,0.3,0.0,-0.4,-0.2,0.1,0.0,-0.6,0.0,0.3,0.0,0.0,0.2,-0.4,0.0,0.0,0.0,0.0,-0.6,-0.1,0.0,-0.3,0.5]","bodySize":127,"pedSize":0.957336,"model":"mp_female"}', '{"shirts": "0x992B50ED", "coats2": "0", "boots": "0xCFC41281", "hat": "0", "pants": "0xAA4ACBB8", "coats": "0", "chaps": "0", "skirts": "0xDFA0DBC1", "belts": "0", "beltbuckle": "0", "gloves": "0", "masks": "0", "gunbelts": "0", "access": "0", "suspenders": "0", "offhand": "0", "gauntlets": "0", "spurs": "0", "bracelets": "0", "neckwear": "0", "neckties": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(466, 198, 'Kalemba Djambe', 1, 42, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-719.54,-1272.144,40.185]", "stats": "[236,0.0,100,0]"}', '{"modSkin":"[732816121,0,62321923,3550965899,null,null,4252816540]","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":1.0,"model":"mp_male"}', '{}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(467, 199, 'Jailson Maul', 1, 24, 25, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "62", "position": "[-390.05,786.654,115.826]", "stats": "[250,24.66,100,100]"}', '{"modSkin":"[2190753742,1305389843,543187419,2226823945,2432743988,null,502538388]","features":"[0.0,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","pedSize":0.957336,"bodySize":126}', '{"shirts": "0x4FE9331E", "coats": "0", "hat": "0x59F583EB", "beltbuckle": "0x353C3AD6", "boots": "0x38271590", "vests": "0x3D55C4CC", "coats2": "0x6207080D", "ponchos": "0", "eyewear": "0", "pants": "0x1D8ADDD1", "gloves": "0x1A2D8F40", "masks": "0", "gunbelts": "0x153557", "spurs": "0x19E1EC40", "access": "0", "suspenders": "0", "neckwear": "0x1301145F"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(468, 198, 'Kalemba Djambe', 1, 42, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "1300", "position": "[-313.024,791.821,117.599]", "stats": "[236,33.6,100,100]"}', '{"bodySize":126,"pedSize":1.026665,"modSkin":"[2479411171,2288776154,885240113,202858862,612262189,null,354937489]","model":"mp_male","features":"[0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"cloaks": "0", "boots": "0x23F56F2C", "gloves": "0", "neckwear": "0", "gunbelts": "0", "pants": "0x1B9F91CD", "vests": "0x374E6E38", "coats": "0", "masks": "0", "hat": "0", "shirts": "0", "chaps": "0", "coats2": "0", "ponchos": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(469, 200, 'Lucios ', 1, 23, 10, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-290.024,746.63,117.906]", "stats": "[250,33.6,100,100]"}', '{"bodySize":128,"pedSize":1.026665,"modSkin":"[3396185070,null,543187419,2226823945,612262189]","model":"mp_male","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"boots": "0xA2A2ADB3", "neckwear": "0x34E62EF6", "pants": "0x83A0B69A", "masks": "0", "gloves": "0", "vests": "0x1525E68A", "gunbelts": "0x2DF2E811", "belts": "0x8D06AD45", "gauntlets": "0", "eyewear": "0", "neckties": "0", "bracelets": "0", "hat": "0x267E3453", "shirts": "0x1D615E9", "beltbuckle": "0x14DCF24E", "access": "0", "coats": "0", "offhand": "0", "suspenders": "0", "ponchos": "0", "chaps": "0", "coats2": "0xCAB6E0A9", "spurs": "0x304FF460"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(470, 201, 'Nickolas Stanfield', 1, 35, 60, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "6300", "position": "[-305.133,777.968,118.717]", "stats": "[193,11.2,100,0]"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","pedSize":1.010666,"bodySize":126,"modSkin":"[2696825467,1385015042,1257168263,3623045497,612262189,null,1971724686]"}', '{"hat": "0x7114E114", "coats": "0", "cloaks": "0", "ponchos": "0", "shirts": "0x339C7959", "offhand": "0", "belts": "0x5C32A201", "coats2": "0x3FA46537", "gunbelts": "0x620C1BC5", "gloves": "0x3033DA22", "chaps": "0", "pants": "0x5F622EED", "gauntlets": "0", "boots": "0x4FC8C87F", "vests": "0", "beltbuckle": "0", "spurs": "0x2ECFEAA3", "suspenders": "0", "eyewear": "0", "access": "0xBA33FEC8", "neckties": "0", "neckwear": "0x163F4C6E"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(471, 202, 'Arthur shelby', 1, 37, 47, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2732.009,-1233.738,50.37]", "stats": "[0,11.2,0,0]"}', '{"bodySize":128,"modSkin":"[908431499,517266857,1660566152,1694074219,612262189,712446626,381599086]","pedSize":1.021332,"model":"mp_male","features":"[0.0,0.9,0.0,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"gunbelts": "0x620C1BC5", "chaps": "0", "shirts": "0x1D615E9", "coats2": "0xE0FD61FA", "coats": "0", "hat": "0x166462F8", "neckwear": "0x163F4C6E", "pants": "0x1D8ADDD1", "cloaks": "0", "boots": "0x119D4929", "ponchos": "0", "masks": "0", "gloves": "0x3033DA22", "vests": "0x1525E68A", "offhand": "0x3A08F9BC", "belts": "0x102F20E6", "suspenders": "0", "access": "0xC0839327", "eyewear": "0", "beltbuckle": "0xDD0F00F4"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(472, 200, 'Reverendo Dave', 1, 23, 50, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "10100", "position": "[1499.908,-1295.106,65.78]", "stats": "[250,33.6,100,100]"}', '{"features":"[-0.2,0.8,-0.7,0.0,0.0,0.0,0.0,0.0,-0.2,0.4,0.0,-0.2,0.0,0.0,0.9,0.4,0.4,0.0,0.0,0.9,0.2,0.0,-0.9,-0.3,-0.2,0.9,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.2,0.0,0.0,0.2]","modSkin":"[2702657477,0,543187419,2226823945,612262189,712446626,481122513]","bodySize":128,"pedSize":1.037331,"model":"mp_male"}', '{"gunbelts": "0", "coats2": "0x2ECFA8D1", "neckties": "0", "cloaks": "0", "offhand": "0", "beltbuckle": "0xF1DF3F9C", "belts": "0", "coats": "0", "hat": "0x4AAFCE04", "eyewear": "0x8953AC8", "bracelets": "0", "gauntlets": "0", "neckwear": "0", "boots": "0x11044269", "suspenders": "0", "shirts": "0", "pants": "0x106E3B84", "vests": "0x6FDAD43F", "masks": "0", "gloves": "0", "chaps": "0", "spurs": "0", "access": "0xC0839327", "ponchos": "0", "skirts": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(474, 180, 'Rosi Marry', 14, 32, 1468, '{}', 16, '{"hunger": "0", "thirst": "0", "banco": "37349", "position": "[1439.567,-1305.759,77.82]", "stats": "[227,11.2,100,0]"}', '{"bodySize":126,"modSkin":"[2916609427,2437706505,900188667,900188667,928002221,959712255]","features":"[-0.9,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,0.0,0.0,0.0,0.0,0.0,-0.5,0.0,0.0,0.0,0.0,0.0,0.9,0.0,0.0,-0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":1.0,"model":"mp_female"}', '{"shirts": "0xD798CC9B", "coats2": "0", "skirts": "0", "hat": "0", "coats": "0", "pants": "0x11FE25C4", "boots": "0x12CB6473", "vests": "0", "chaps": "0", "ponchos": "0", "gunbelts": "0x100FA02B", "eyewear": "0", "neckwear": "0x82872D7", "masks": "0", "offhand": "0", "neckties": "0", "bracelets": "0", "suspenders": "0", "access": "0", "belts": "0", "gauntlets": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(475, 204, 'Cleef Morrow', 1, 30, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-333.091,780.553,115.827]", "stats": "[124,33.6,100,100]"}', '{"bodySize":126,"modSkin":"[1587165517,4146457914,2966572863,181068809,642477207,712446626,231928634]","model":"mp_male","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":0.920005}', '{"eyewear": "0x14F06EA7", "cloaks": "0", "vests": "0x60F698A9", "neckwear": "0", "gloves": "0", "suspenders": "0", "spurs": "0x19E1EC40", "coats2": "0", "hat": "0x262CC9D4", "coats": "0", "ponchos": "0x9469FAEA", "pants": "0xBB2DF633", "beltbuckle": "0x139FCC19", "boots": "0x1A0A710A", "shirts": "0x339C7959", "gunbelts": "0x56DC1321"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(477, 206, 'John Greenwood', 1, 27, 87, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "91", "position": "[-322.863,821.279,118.204]", "stats": "[250,17.69,100,29]"}', '{"features":"[0.0,0.0,0.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[2078925650,3798985182,543187419,2226823945,2432743988,1629650936,785798480]","model":"mp_male","pedSize":0.973335,"bodySize":128}', '{"suspenders": "0", "shirts": "0x1D615E9", "offhand": "0x1184AC1D", "spurs": "0x3BB959DE", "ponchos": "0", "access": "0", "bracelets": "0", "neckties": "0", "gunbelts": "0x319BEEC1", "cloaks": "0", "boots": "0x30539D9C", "coats": "0", "gauntlets": "0", "belts": "0", "pants": "0x90E6861E", "chaps": "0", "masks": "0", "gloves": "0", "eyewear": "0", "vests": "0x1525E68A", "hat": "0x6926E8D5", "neckwear": "0x163F4C6E", "coats2": "0x20ED22EA", "beltbuckle": "0x353C3AD6"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(478, 205, 'Kalunâ', 11, 29, 850, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "206950", "position": "[1353.435,-1306.237,76.937]", "stats": "[228,11.2,100,0]"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[2597378528,3597829160,62321923,3550965899,2432743988]","model":"mp_male","pedSize":1.0,"bodySize":127}', '{"cloaks": "0", "coats": "0", "shirts": "0x29423FD8", "vests": "0x381EF1D3", "ponchos": "0", "chaps": "0", "hat": "0x6D99EFD0", "pants": "0xE1B0ABFF", "coats2": "0xCAB6E0A9", "boots": "0xC430AF11", "neckties": "0x67B0CC14", "gauntlets": "0", "offhand": "0", "spurs": "0x6DF05052", "suspenders": "0", "access": "0", "belts": "0", "gunbelts": "0x10CD7D44", "bracelets": "0", "beltbuckle": "0x24914BD1", "eyewear": "0", "masks": "0", "gloves": "0x2B8130D7", "neckwear": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(479, 207, 'Anna Blanc', 1, 20, 20, '{}', 16, '{"hunger": "0", "thirst": "0", "banco": "5600", "position": "[-283.392,802.966,119.305]", "stats": "[250,33.6,100,100]"}', '{"pedSize":0.925338,"modSkin":"[1705365104,3632881362,743432389,743432389,2489772761,959712255]","model":"mp_female","bodySize":128,"features":"[0.3,0.8,0.7,-0.2,0.0,0.0,0.0,0.0,0.2,0.4,0.1,0.2,0.1,0.0,0.6,0.0,0.0,0.3,0.3,0.0,0.0,0.0,-0.3,-0.7,-0.4,0.3,0.3,0.2,-0.4,0.5,0.0,0.0,0.0,-0.1,0.7,0.0,0.0,0.7,0.0]"}', '{"skirts": "0x117BBF76", "cloaks": "0", "boots": "0x498C261", "gloves": "0x3F1D5D03", "gauntlets": "0", "bracelets": "0", "vests": "0", "shirts": "0x63FE3B43", "masks": "0", "spurs": "0", "chaps": "0", "ponchos": "0", "hat": "0", "neckwear": "0x45B76707", "gunbelts": "0", "beltbuckle": "0", "coats": "0", "access": "0", "coats2": "0x56DF036F", "pants": "0", "belts": "0x214BD73B", "offhand": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(481, 210, 'Pelé', 1, 84, 93, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "36300", "position": "[1335.447,-1312.183,76.524]", "stats": "[250,33.6,100,100]"}', '{"bodySize":127,"modSkin":"[3141741618,1785263689,1773547611,1824319804,46507404,null,983283548]","model":"mp_male","features":"[-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.8,0.9,0.9,0.0,0.9,0.9,0.0,0.0,0.9,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.9,0.9,0.0]","pedSize":0.920005}', '{"coats": "0", "vests": "0", "shirts": "0x4B9D634D", "access": "0", "spurs": "0x1CA207BD", "eyewear": "0x36749686", "coats2": "0", "hat": "0x8B655559", "gunbelts": "0x1CE0C5ED", "pants": "0x262B1D80", "boots": "0x151EAB71", "belts": "0", "chaps": "0", "cloaks": "0", "offhand": "0", "gloves": "0x1A2D8F40", "neckties": "0", "beltbuckle": "0x14DCF24E"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(482, 55, 'Jim Bigfoot', 2, 38, 124, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "4584", "position": "[1294.529,-1285.574,75.615]", "stats": "[87,11.2,88,0]"}', '{"bodySize":125,"modSkin":"[3214407841,0,885240113,202858862,null,null,185164474]","model":"mp_male","features":"[0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":1.074662}', '{"suspenders": "0", "shirts": "0", "offhand": "0", "spurs": "0x1F801AA6", "chaps": "0", "access": "0", "belts": "0", "cloaks": "0", "boots": "0x192C2A4B", "vests": "0x6B61369F", "coats": "0", "ponchos": "0", "pants": "0x1D8ADDD1", "masks": "0", "gloves": "0x1A2D8F40", "eyewear": "0", "gunbelts": "0x620C1BC5", "hat": "0xBB959BC0", "neckwear": "0x163F4C6E", "coats2": "0", "beltbuckle": "0xF52F775C"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(483, 203, 'Yamka', 1, 20, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2555.055,-1161.077,53.622]", "stats": "[250,33.6,100,100]"}', '{"pedSize":0.920005,"modSkin":"[1974431363,617200186,923281039,923281039,3117725108]","model":"mp_female","features":"[0.0,0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.8,-0.2,0.2,0.0,0.0,0.2,0.1,0.0,0.0,0.0,0.2,-0.3,0.0,0.0,0.1,0.0,0.0,0.2,0.0,0.0,0.0,0.4,0.2,0.0,0.4,0.2,0.0]","bodySize":126}', '{}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(484, 203, 'Yamka', 6, 20, 318, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "1500", "position": "[1382.831,-1317.989,77.172]", "stats": "[250,11.2,100,0]", "dog": "A_C_DogCollie_01"}', '{"features":"[0.0,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.3,0.1,0.0,0.0,0.3,0.3,0.1,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.1,0.0,0.0,0.1,0.0,-0.1,0.2,0.2,0.0,0.0,0.2,0.4,0.0,0.2,0.4,0.0]","modSkin":"[1974431363,617200186,900188667,900188667,3117725108]","model":"mp_female","pedSize":0.925338,"bodySize":126}', '{"neckties": "0x16966AD9", "gauntlets": "0", "shirts": "0x118B1F87", "coats": "0", "skirts": "0xB22B80D7", "coats2": "0x248DFE12", "pants": "0", "bracelets": "0", "boots": "0x134D7E03", "vests": "0", "access": "0", "gloves": "0x44973F0F", "cloaks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(485, 186, 'Benjamin Bogue', 1, 23, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2323.41,-1275.748,45.62]", "stats": "[250,33.6,100,100]"}', '{"bodySize":128,"modSkin":"[2702657477,1772409497,543187419,2226823945,612262189,712446626,2549723902]","model":"mp_male","features":"[0.0,0.9,0.6,-0.1,-0.8,0.0,-0.7,0.3,0.0,-0.5,-0.9,0.2,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.5,0.0,0.5,0.6,0.8,0.0,-0.7,0.0,0.2,0.6,0.1,0.0,-0.8,0.9,0.4,0.6,0.0]","pedSize":0.973335}', '{"suspenders": "0x3BDE2985", "shirts": "0x521B2637", "offhand": "0", "chaps": "0", "access": "0x47D2DD9D", "bracelets": "0", "neckties": "0x3AD5725E", "boots": "0x1EF2B6A3", "gauntlets": "0", "coats": "0", "belts": "0", "gloves": "0", "vests": "0", "eyewear": "0xE1A7209B", "coats2": "0", "hat": "0x166462F8", "gunbelts": "0", "pants": "0x4D348A92", "beltbuckle": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(486, 211, 'Eduardo Murilo', 11, 31, 899, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "10000", "position": "[1301.153,-1276.292,76.008]", "stats": "[250,20.84,100,43]", "dog": "A_C_DogBluetickCoonhound_01", "posse": "64"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[853589349,1385015042,null,null,null,null,481122513]","model":"mp_male","pedSize":0.941337,"bodySize":126}', '{"bracelets": "0", "gunbelts": "0x1BD4BEC7", "pants": "0x225EEA60", "ponchos": "0", "offhand": "0", "coats2": "0", "suspenders": "0", "boots": "0x115D47FD", "chaps": "0", "beltbuckle": "0", "spurs": "0x19E1EC40", "vests": "0x1E442267", "shirts": "0", "gauntlets": "0", "access": "0x47D2DD9D", "cloaks": "0xA7A2AACF", "eyewear": "0x1A5EDE5B", "belts": "0", "coats": "0", "masks": "0", "hat": "0x23582134", "neckties": "0", "gloves": "0x1A2D8F40", "neckwear": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(487, 164, 'Leroy J. Gibbs', 12, 41, 994, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "108300", "position": "[1359.389,-1304.689,77.763]", "stats": "[195,30.35,100,85]"}', '{"modSkin":"[null,39008355,null,null,642477207,null,768038038]","bodySize":128,"pedSize":1.0,"features":"[-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male"}', '{"bracelets": "0", "gunbelts": "0x620C1BC5", "eyewear": "0x3766BB7B", "ponchos": "0", "offhand": "0", "coats2": "0xCAB6E0A9", "gloves": "0", "boots": "0x85EEDF53", "chaps": "0", "vests": "0x1525E68A", "shirts": "0x12801254", "coats": "0", "access": "0", "cloaks": "0", "belts": "0x8D06AD45", "hat": "0x60CB0086", "pants": "0xE1B0ABFF", "neckties": "0x67B0CC14", "beltbuckle": "0x24914BD1", "spurs": "0xF3ED74DB", "gauntlets": "0", "masks": "0", "suspenders": "0", "neckwear": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(488, 209, 'Samuel Redwood', 1, 23, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "2650", "position": "[2661.217,-1212.183,53.478]", "stats": "[140,29.45,100,81]"}', '{"modSkin":"[908431499,3542307388,1180660122,2539219498,1552505114,712446626,180350727]","model":"mp_male","pedSize":1.079995,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.7,0.0,0.8,0.0,0.9,0.0,0.5,0.0,0.0,0.9,0.7,0.0,0.0]","bodySize":126}', '{"bracelets": "0xE94B5518", "gunbelts": "0x37F6222", "pants": "0xAB17B6", "neckties": "0", "offhand": "0", "coats2": "0x26FFF6A7", "gloves": "0", "boots": "0x35C87ED", "chaps": "0", "beltbuckle": "0x4B046666", "spurs": "0x142D2BE8", "vests": "0x6B61369F", "shirts": "0x7EB4ED0E", "gauntlets": "0", "access": "0", "cloaks": "0", "belts": "0", "eyewear": "0x9A1DFEE", "suspenders": "0", "hat": "0x17812F51", "ponchos": "0", "coats": "0", "neckwear": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(489, 212, 'Javier Perez', 1, 32, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-901.96,-1815.884,62.919]", "stats": "[249,33.6,100,100]"}', '{"modSkin":"[1108478392,1385015042,1588167928,1535332499,46507404,712446626]","pedSize":0.920005,"bodySize":127,"features":"[-0.9,0.0,-0.4,0.0,0.0,-0.3,-0.9,-0.7,-0.9,0.0,0.0,0.0,0.0,0.0,-0.5,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,-0.9,0.0,-0.8,0.9,0.0,0.0,0.0,0.0,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male"}', '{}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(490, 212, 'Javier Perez', 4, 32, 242, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "29500", "position": "[2472.272,-1334.385,46.819]", "stats": "[229,33.6,100,100]", "posse": "65"}', '{"modSkin":"[1108478392,3945400824,62321923,3550965899,3065185688,712446626,1692876447]","bodySize":127,"model":"mp_male","features":"[0.0,0.0,0.0,0.0,0.0,0.0,-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":0.920005}', '{"hat": "0xA9C5BAFF", "ponchos": "0x9D875AF8", "shirts": "0x3115A1EB", "vests": "0", "bracelets": "0", "gunbelts": "0x3D55DEC7", "pants": "0xF19F23A8", "masks": "0", "coats2": "0", "boots": "0x6A2B9E5", "chaps": "0", "beltbuckle": "0", "spurs": "0x19E1EC40", "gauntlets": "0", "access": "0xECC2276D", "cloaks": "0", "belts": "0", "coats": "0", "neckwear": "0x1024C03D", "offhand": "0", "suspenders": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(492, 174, 'zSANSAOz', 1, 22, 45, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "41300", "position": "[1068.987,-1219.512,70.467]", "stats": "[250,11.2,100,0]"}', '{"modSkin":"[2640330835,3067839996,942003495,1694074219,46507404,null,185164474]","pedSize":1.026665,"bodySize":126,"features":"[0.0,0.0,0.0,0.0,-0.3,-0.3,0.0,0.0,0.3,0.4,0.2,0.0,0.0,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male"}', '{"bracelets": "0", "gunbelts": "0x29875F42", "eyewear": "0", "neckwear": "0x24F81EAB", "offhand": "0", "coats2": "0", "suspenders": "0", "boots": "0xC08EA183", "beltbuckle": "0xA0649C75", "spurs": "0xEB8E1070", "gauntlets": "0", "access": "0", "cloaks": "0", "belts": "0xE456C936", "gloves": "0xF4063FC8", "ponchos": "0", "hat": "0xB16BB2D6", "coats": "0x29057A69", "pants": "0xE3CFC09B", "neckties": "0x127CBB85"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(493, 206, 'Santiago Álvarez', 11, 28, 711, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "11800", "position": "[2807.513,1344.177,71.532]", "stats": "[240,33.6,100,100]", "dog": "A_C_DogLab_01", "posse": "65"}', '{"modSkin":"[1515865449,0,62321923,3550965899,2432743988,1629650936,587465329]","pedSize":0.94667,"bodySize":125,"features":"[0.9,0.0,0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male"}', '{"bracelets": "0", "gunbelts": "0x15AF5CC4", "eyewear": "0", "neckwear": "0x288E2953", "offhand": "0", "coats2": "0", "gloves": "0", "boots": "0xA19AE06", "chaps": "0", "beltbuckle": "0", "spurs": "0x34B7E7AC", "vests": "0", "shirts": "0x339C7959", "gauntlets": "0", "access": "0xA7F25A45", "cloaks": "0", "belts": "0x4AFD259B", "coats": "0", "neckties": "0", "hat": "0xA9C5BAFF", "suspenders": "0x51C8C0C", "pants": "0x39BE63A6", "ponchos": "0xFBC2A22C"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(494, 213, 'Horácio Pires Peres', 1, 23, 72, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "18150", "position": "[1322.881,-1295.669,77.004]", "stats": "[224,29.81,100,83]", "posse": "64"}', '{"modSkin":"[31952749,465258498,543187419,2226823945,null,null,282054283]","bodySize":125,"pedSize":0.936004,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male"}', '{"gunbelts": "0x15AF5CC4", "pants": "0xF294D831", "ponchos": "0", "masks": "0", "coats2": "0", "suspenders": "0", "boots": "0x119D4929", "chaps": "0", "beltbuckle": "0x139FCC19", "spurs": "0x123BDDCB", "vests": "0", "shirts": "0x1D615E9", "coats": "0xA957F05", "cloaks": "0", "hat": "0x2D625B41", "eyewear": "0xDF6A0B7F", "neckwear": "0x26BD2469", "gloves": "0x3033DA22"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(495, 214, 'António Ribeiro', 1, 28, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "14000", "position": "[-146.909,564.198,114.168]", "stats": "[207,33.6,100,100]"}', '{"modSkin":"[1154037934,39008355,1834492501,2968922921,1552505114,712446626,298392309]","bodySize":128,"model":"mp_male","features":"[-0.4,-0.5,0.8,0.2,0.0,0.0,0.0,0.0,0.0,0.2,0.0,0.0,0.0,0.0,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.8,0.0,0.0,0.0,0.7,0.0,0.0,0.3,0.1,0.0,0.0,0.1,0.0,0.0]","pedSize":0.968002}', '{"hat": "0x17812F51", "vests": "0", "shirts": "0x2CA82A1F", "coats": "0x29057A69", "pants": "0x156C6CAE", "boots": "0x195A47E0", "chaps": "0", "coats2": "0", "gunbelts": "0x620C1BC5", "ponchos": "0x9D875AF8", "bracelets": "0", "beltbuckle": "0x14DCF24E", "neckties": "0", "gauntlets": "0", "belts": "0x83BC9AB5", "offhand": "0", "spurs": "0", "suspenders": "0x1CB2B388", "masks": "0", "access": "0x17920A1E", "gloves": "0x10BD09BD", "neckwear": "0x163F4C6E", "eyewear": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(496, 215, 'Jonas Jameson', 1, 23, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-733.194,-1340.304,44.571]", "stats": "[249,33.6,100,100]"}', '{"modSkin":"[1209218150,2213512467,1180660122,2539219498,null,null,1717239876]","pedSize":0.984001,"model":"mp_male","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":128}', '{"spurs": "0", "vests": "0x1525E68A", "shirts": "0x210E2D6", "coats": "0", "eyewear": "0", "ponchos": "0", "cloaks": "0", "masks": "0", "coats2": "0x1DE62579", "gauntlets": "0", "pants": "0x5F622EED", "hat": "0x267E3453", "boots": "0x1F5A64A3", "chaps": "0xC5069CFA", "bracelets": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(497, 216, 'Clepe ShinZon', 9, 47, 489, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "28599", "position": "[-3616.166,-2632.188,-12.45]", "stats": "[123,33.6,100,100]"}', '{"modSkin":"[2702657477,1181206804,1660566152,1694074219,2195072443,null,518502517]","pedSize":1.079995,"model":"mp_male","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.5,0.0,-0.6,0.0,0.0,0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":128}', '{"hat": "0x38B3DB72", "shirts": "0", "gloves": "0x2B8130D7", "coats2": "0", "pants": "0x1D8ADDD1", "neckwear": "0x288E2953", "boots": "0xA4A10C08", "vests": "0x980657A6", "coats": "0", "eyewear": "0", "gunbelts": "0x620C1BC5", "offhand": "0", "gauntlets": "0", "belts": "0x131D437B", "access": "0x17920A1E", "beltbuckle": "0x17B4FFBC", "chaps": "0", "spurs": "0x47929C28", "suspenders": "0", "ponchos": "0", "neckties": "0", "cloaks": "0", "masks": "0", "bracelets": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(498, 217, 'Filipe Vaz Pinto', 1, 38, 92, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "48240", "position": "[1296.254,-1295.312,77.032]", "stats": "[113,11.2,100,0]"}', '{"bodySize":128,"modSkin":"[2702657477,39008355,543187419,2226823945,2432743988,712446626,481122513]","features":"[0.0,0.5,0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.8,0.5,0.0,0.0,0.0,0.0,0.0,0.3,0.0,0.0,0.0,0.0,-0.4,-0.6,0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":0.989334,"model":"mp_male"}', '{"hat": "0x6B62E5C5", "coats": "0", "masks": "0", "access": "0xECC2276D", "cloaks": "0x208DA39A", "suspenders": "0", "ponchos": "0", "beltbuckle": "0x18DB3EB3", "neckties": "0", "neckwear": "0x163F4C6E", "shirts": "0x16AD55DC", "gloves": "0x3033DA22", "belts": "0", "gunbelts": "0x620C1BC5", "offhand": "0", "gauntlets": "0", "chaps": "0", "pants": "0x2800212A", "coats2": "0x5FE9047A", "boots": "0x192C2A4B", "vests": "0x1B53FA5", "spurs": "0x86BB8180", "eyewear": "0", "bracelets": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(499, 218, 'Bennys  Pereira', 1, 47, 47, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "4550", "position": "[1295.012,-1298.669,77.04]", "stats": "[250,11.2,100,0]"}', '{"bodySize":124,"modSkin":"[1861339516,465258498,null,null,null,null,382614413]","features":"[0.0,0.1,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":1.0,"model":"mp_male"}', '{"hat": "0x23E9E17", "shirts": "0x18015DB4", "coats": "0x1F79CDC8", "pants": "0x12D463B0", "coats2": "0", "cloaks": "0", "gloves": "0x16DEB1F", "boots": "0x10E40F4E", "vests": "0", "chaps": "0x191D455F", "ponchos": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(500, 202, 'Arthur Shelb', 7, 25, 387, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "97400", "position": "[1076.501,-1052.84,68.706]", "stats": "[0,28.36,0,77]", "posse": "73"}', '{"pedSize":1.021332,"bodySize":128,"features":"[0.0,0.9,0.2,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.2,0.0,-0.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","modSkin":"[2344699549,470018738,942003495,1694074219,46507404,null,481122513]"}', '{"chaps": "0", "pants": "0x2B7A1F6C", "ponchos": "0x8E7E5481", "vests": "0xFA506620", "suspenders": "0", "beltbuckle": "0xF99B34CF", "spurs": "0x1CA207BD", "gunbelts": "0x620C1BC5", "coats": "0", "gloves": "0x1A2D8F40", "coats2": "0", "neckwear": "0", "boots": "0xFD985535", "shirts": "0xE5F4BDB2", "hat": "0x65BCB477", "bracelets": "0", "neckties": "0x67B0CC14", "gauntlets": "0", "belts": "0x102F20E6", "offhand": "0x3A08F9BC", "access": "0x13F53A09", "cloaks": "0", "masks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(501, 219, 'Marco Levinsk', 1, 37, 16, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "2354", "position": "[-99.347,432.822,112.507]", "stats": "[226,11.2,100,0]"}', '{"pedSize":0.94667,"bodySize":126,"features":"[0.0,-0.9,0.0,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.7,-0.3,0.0,0.0,0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","modSkin":"[128860735,1769735681,null,null,2195072443,null,1882197063]"}', '{"gunbelts": "0x620C1BC5", "coats": "0", "vests": "0x1525E68A", "bracelets": "0", "beltbuckle": "0x17B4FFBC", "gauntlets": "0", "belts": "0x83BC9AB5", "cloaks": "0", "chaps": "0", "pants": "0xC21EAA28", "gloves": "0x51B81B7B", "masks": "0", "access": "0", "neckwear": "0x2108DC4D", "ponchos": "0", "spurs": "0x82501863", "coats2": "0x478E78C9", "eyewear": "0", "boots": "0x539830B7", "shirts": "0x16AD55DC"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(502, 112, 'Gonne', 1, 26, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-762.807,-1291.549,43.915]", "stats": "[250,33.6,100,100]"}', '{"modSkin":"[1106971106,0,62321923,3550965899,2195072443,null,282054283]","bodySize":128,"model":"mp_male","pedSize":1.079995,"features":"[0.0,0.0,0.5,0.0,0.0,-0.8,0.0,-0.1,0.7,0.5,0.8,-0.3,0.5,0.2,0.0,0.0,0.0,-0.5,0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(503, 220, 'Bud Kenway', 5, 23, 295, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-308.14,776.61,118.674]", "stats": "[249,32.44,100,95]"}', '{"modSkin":"[1209218150,0,1834492501,2968922921,46507404,712446626,323985567]","bodySize":128,"model":"mp_male","pedSize":0.973335,"features":"[0.1,0.9,-0.1,0.5,0.0,-0.8,-0.3,0.0,0.0,0.0,-0.4,-0.3,-0.3,0.3,-0.2,0.0,0.8,0.0,0.0,0.0,0.0,0.0,0.0,-0.4,0.1,0.3,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"belts": "0x2330E0ED", "masks": "0", "spurs": "0", "pants": "0x1D8ADDD1", "shirts": "0x4B9D634D", "gloves": "0x3033DA22", "hat": "0x38262B2E", "coats2": "0x1193B64F", "coats": "0", "access": "0", "gunbelts": "0x10CD7D44", "offhand": "0", "boots": "0x20D85860", "gauntlets": "0", "ponchos": "0", "suspenders": "0", "cloaks": "0", "eyewear": "0", "neckwear": "0", "neckties": "0", "bracelets": "0", "chaps": "0", "vests": "0xDAF9867", "beltbuckle": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(504, 222, 'Marks Bil', 10, 25, 656, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "248996", "position": "[1323.915,-1297.663,76.426]", "stats": "[74,11.2,74,0]", "dog": "A_C_DogLab_01"}', '{"modSkin":"[908431499,39008355,1660566152,1694074219,642477207,null,75152474]","bodySize":127,"model":"mp_male","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":0.973335}', '{"neckwear": "0", "spurs": "0x17346DD4", "pants": "0x205D1C26", "shirts": "0x10B87936", "gloves": "0x1A2D8F40", "hat": "0xA09665BA", "coats2": "0", "coats": "0x29057A69", "access": "0", "gauntlets": "0", "boots": "0x192C2A4B", "bracelets": "0", "ponchos": "0x27377915", "gunbelts": "0x153557", "cloaks": "0x19A58ECF", "chaps": "0", "belts": "0x102F20E6", "neckties": "0", "suspenders": "0", "offhand": "0", "vests": "0", "beltbuckle": "0x17B4FFBC", "eyewear": "0x271E132A"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(505, 223, 'Scott Rivera', 6, 26, 314, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "8500", "position": "[-343.278,768.411,116.329]", "stats": "[2,33.58,2,100]"}', '{"modSkin":"[1515865449,843248893,62321923,3550965899,1552505114,712446626,382614413]","bodySize":128,"model":"mp_male","pedSize":1.0,"features":"[-0.1,0.0,0.0,0.0,0.0,-0.5,-0.4,-0.2,0.0,-0.8,-0.2,0.0,-0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,-0.9,-0.9]"}', '{"neckwear": "0", "masks": "0", "spurs": "0x200A7968", "pants": "0x58584555", "shirts": "0", "gloves": "0x1A2D8F40", "hat": "0", "coats2": "0x1A84E2DB", "coats": "0", "access": "0", "offhand": "0", "boots": "0x9D19C2DD", "ponchos": "0", "belts": "0", "gunbelts": "0x2FDA7221", "eyewear": "0", "gauntlets": "0", "chaps": "0", "cloaks": "0x7D0FD5A2", "suspenders": "0", "vests": "0x1B53FA5", "beltbuckle": "0", "neckties": "0"}', 1);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(506, 221, 'Adahy Alo', 1, 18, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-307.347,797.239,118.931]", "stats": "[250,33.6,100,100]"}', '{"modSkin":"[519165173,0,1588167928,1535332499,3096645940,null,282054283]","bodySize":127,"model":"mp_male","pedSize":0.973335,"features":"[0.0,0.2,-0.9,0.0,0.2,0.1,0.0,0.0,0.0,0.0,0.1,0.9,0.0,0.0,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"neckwear": "0", "pants": "0xCEFD6664", "shirts": "0xFFD9E648", "hat": "0", "coats2": "0", "coats": "0", "suspenders": "0", "gauntlets": "0", "boots": "0xC1644333", "access": "0x29A9AE4D", "ponchos": "0", "belts": "0x131D437B", "cloaks": "0", "eyewear": "0", "bracelets": "0x2254C72E", "neckties": "0", "gunbelts": "0", "chaps": "0", "vests": "0", "beltbuckle": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(507, 224, 'RafAO Shelby', 3, 31, 175, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "9000", "position": "[1296.433,-1291.557,76.353]", "stats": "[124,33.6,100,100]"}', '{"modSkin":"[2702657477,470018738,null,null,3508160042]","bodySize":126,"model":"mp_male","pedSize":1.010666,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"neckwear": "0x1750CBF5", "boots": "0x1EF2B6A3", "shirts": "0x1D615E9", "gloves": "0x3CC9875A", "cloaks": "0", "coats2": "0xC27D27F9", "hat": "0x166462F8", "gunbelts": "0x620C1BC5", "pants": "0x106E3B84", "vests": "0x1525E68A", "coats": "0", "eyewear": "0x1A5EDE5B"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(508, 225, 'Juan Bravo ', 2, 30, 276, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "25395", "position": "[-308.542,776.059,118.712]", "stats": "[250,11.2,100,0]"}', '{"modSkin":"[2706816031,613297523,1660566152,1694074219,2452638665,3776970741,307184935]","bodySize":127,"model":"mp_male","features":"[0.0,0.0,0.0,0.0,0.5,0.0,0.0,0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":1.010666}', '{"belts": "0x5C32A201", "spurs": "0x1F801AA6", "pants": "0x19CB5254", "ponchos": "0", "chaps": "0", "coats2": "0x1FB51BD6", "hat": "0x17812F51", "boots": "0x1A0A710A", "cloaks": "0", "vests": "0x1ED62F2B", "coats": "0", "gunbelts": "0x2E7B7D68", "beltbuckle": "0x17B4FFBC", "neckwear": "0", "masks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(509, 208, 'Jax Teller', 2, 23, 206, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "3547", "position": "[-338.287,764.83,116.555]", "stats": "[125,33.6,100,100]"}', '{"modSkin":"[1723194916,0,2196852103,2539219498,3508160042,null,481122513]","bodySize":128,"model":"mp_male","pedSize":1.026665,"features":"[0.0,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"chaps": "0", "coats2": "0x7E124755", "vests": "0x59786AE7", "hat": "0x17812F51", "boots": "0x156828EB", "shirts": "0x215112", "coats": "0", "pants": "0x27043E32", "cloaks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(510, 226, 'Agostinho Tavares', 1, 27, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-974.793,-1466.427,53.797]", "stats": "[0,33.6,0,100]"}', '{"model":"mp_male","modSkin":"[2706816031,576291658,2966572863,181068809,2432743988,null,298392309]","features":"[-0.3,0.9,0.5,0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":0.930671}', '{"masks": "0", "pants": "0x2632C994", "shirts": "0x75DBBC81", "hat": "0x21C75A0F", "coats2": "0", "coats": "0x5D4207A", "access": "0x7241EEE5", "gauntlets": "0", "boots": "0x151EAB71", "ponchos": "0", "bracelets": "0", "eyewear": "0x2761A139", "neckties": "0", "chaps": "0", "cloaks": "0", "vests": "0x7E20CD0", "suspenders": "0"}', 1);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(511, 227, 'Eduardo Quintero', 11, 32, 866, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "79100", "position": "[1364.383,-1285.841,77.199]", "stats": "[73,9.72,74,27]"}', '{"modSkin":"[2063814808,719802851,1272509601,3837101269,642477207,null,2339538374]","bodySize":128,"model":"mp_male","features":"[-0.2,0.0,0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.8,-0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":1.026665}', '{"belts": "0x3F49FF1B", "spurs": "0x3BC03131", "pants": "0xE1B0ABFF", "shirts": "0x12801254", "hat": "0x1751D32F", "coats2": "0xCAB6E0A9", "coats": "0", "suspenders": "0x1A36F21A", "offhand": "0", "boots": "0xC430AF11", "neckwear": "0", "ponchos": "0", "gunbelts": "0x1CE0C5ED", "chaps": "0", "eyewear": "0", "cloaks": "0", "neckties": "0x67B0CC14", "access": "0x3B7F8161", "gauntlets": "0", "vests": "0xE37E0D13", "beltbuckle": "0x24914BD1", "bracelets": "0", "gloves": "0x3B94811C"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(512, 228, 'Marcos Guerra', 1, 30, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "1500", "position": "[2310.767,1070.748,86.961]", "stats": "[152,11.2,2,0]"}', '{"modSkin":"[519165173,593266682,62321923,3550965899,2432743988,null,2587879296]","bodySize":128,"model":"mp_male","pedSize":1.005333,"features":"[0.0,0.0,0.0,-0.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.6,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.9,0.0,0.0,0.0,0.7,0.0,0.0,0.0,0.0,0.0]"}', '{"belts": "0x83BC9AB5", "masks": "0", "pants": "0x389AB19E", "shirts": "0x40E7AA58", "gloves": "0x24B7D363", "hat": "0x104B07BD", "coats2": "0x26A3702F", "coats": "0", "access": "0", "gauntlets": "0", "boots": "0x119D4929", "ponchos": "0", "chaps": "0x6223576E", "gunbelts": "0x620C1BC5", "neckwear": "0x1750CBF5", "cloaks": "0", "vests": "0x1B53FA5", "beltbuckle": "0x17B4FFBC"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(513, 229, 'Augusto Meirelles', 6, 35, 335, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "13400", "position": "[-408.006,768.009,115.245]", "stats": "[103,11.2,100,0]"}', '{"modSkin":"[2344699549,0,1257168263,3623045497,null,712446626,481122513]","bodySize":128,"model":"mp_male","pedSize":0.94667,"features":"[0.0,0.9,0.0,0.0,0.0,0.0,-0.1,0.0,-0.9,0.3,0.0,0.8,-0.2,-0.3,-0.9,-0.3,0.1,-0.6,0.1,0.6,0.0,0.0,-0.7,0.6,-0.6,-0.4,0.0,0.0,-0.9,0.0,0.9,0.0,0.9,0.0,0.1,0.0,-0.1,0.0,0.0]"}', '{"spurs": "0x47929C28", "boots": "0x38271590", "coats": "0", "shirts": "0x40E7AA58", "cloaks": "0", "hat": "0x12BD5208", "coats2": "0x26FFF6A7", "pants": "0xE3CFC09B", "chaps": "0", "skirts": "0", "ponchos": "0", "vests": "0x77F0D7CB", "gunbelts": "0x15AF5CC4", "neckwear": "0x1C990028", "offhand": "0xE459A084", "access": "0", "eyewear": "0", "belts": "0", "gauntlets": "0", "beltbuckle": "0x18F5C8D7", "bracelets": "0", "masks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(515, 231, 'Esteban Guadalupe', 3, 32, 179, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "15400", "position": "[-307.38,793.544,117.874]", "stats": "[250,33.6,100,100]"}', '{"modSkin":"[1108478392,664756881,62321923,3550965899,3065185688,712446626,3926915906]","bodySize":128,"model":"mp_male","features":"[-0.9,0.0,0.3,0.6,0.0,0.0,0.0,0.0,0.6,0.2,0.8,0.5,0.0,0.0,0.7,0.6,0.0,0.4,0.0,0.6,0.2,0.2,0.0,0.6,0.0,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.9,0.0,0.0]","pedSize":0.941337}', '{"belts": "0x3534FA0B", "spurs": "0", "pants": "0x1395EFA0", "shirts": "0x10F143F", "hat": "0x3E8135EB", "coats2": "0", "coats": "0", "access": "0x4355B247", "offhand": "0", "boots": "0x1C0B7ADB", "cloaks": "0", "ponchos": "0x8CA1F61D", "suspenders": "0", "bracelets": "0", "eyewear": "0", "gauntlets": "0", "neckties": "0", "gunbelts": "0x23396D4", "chaps": "0", "vests": "0xC80366AD", "beltbuckle": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(516, 232, 'Bruno Rango', 1, 26, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-755.936,-1278.536,43.775]", "stats": "[250,33.6,100,100]"}', '{"modSkin":"[2949506350,731356029,null,null,null,null,133965099]","bodySize":125,"model":"mp_male","features":"[-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,0.0,0.0,-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":1.037331}', '{"shirts": "0x1D615E9", "coats2": "0x1FB51BD6", "vests": "0x3D55C4CC", "coats": "0", "access": "0", "spurs": "0xF30441AF", "boots": "0x30BED3D", "gloves": "0x6EF757A8", "hat": "0", "eyewear": "0", "gunbelts": "0x620C1BC5", "pants": "0x3C9ADC2", "beltbuckle": "0x30186D1D"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(517, 232, 'Bruno Rango', 3, 26, 184, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "4600", "position": "[-325.536,760.049,121.671]", "stats": "[250,33.6,100,100]"}', '{"modSkin":"[2949506350,0,2966572863,181068809,612262189,712446626,2235804659]","bodySize":128,"model":"mp_male","pedSize":1.037331,"features":"[-0.9,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,-0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"spurs": "0xFB85B05F", "boots": "0x195A47E0", "shirts": "0xA594965E", "gloves": "0xBF9BA26E", "gunbelts": "0x620C1BC5", "coats2": "0x7596B65E", "pants": "0xE3CFC09B", "coats": "0", "hat": "0x707839AB", "vests": "0", "beltbuckle": "0x18DB3EB3", "chaps": "0", "offhand": "0x8F24B3D6", "neckties": "0", "neckwear": "0xFE6C9CCD", "suspenders": "0", "access": "0x469B5DE4", "bracelets": "0x2254C72E", "cloaks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(519, 234, 'Fox Macrey', 1, 25, 20, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[1323.892,-1320.55,77.9]", "stats": "[224,29.27,100,81]"}', '{"modSkin":"[1309745678,68409628,942003495,1694074219,642477207,null,146025810]","bodySize":126,"model":"mp_male","pedSize":1.010666,"features":"[0.0,-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.2,0.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"coats2": "0", "ponchos": "0", "coats": "0x29057A69", "hat": "0", "chaps": "0", "cloaks": "0", "boots": "0x1C0B7ADB", "vests": "0x1525E68A", "shirts": "0x1E108CF0", "pants": "0x10051C7"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(520, 233, 'Manel Antonio', 1, 25, 60, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "2700", "position": "[-269.19,802.04,119.184]", "stats": "[129,32.73,100,96]"}', '{"modSkin":"[2344699549,470018738,543187419,2226823945,46507404,null,298392309]","bodySize":126,"model":"mp_male","pedSize":1.0,"features":"[0.6,0.8,0.5,0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"pants": "0xE1B0ABFF", "shirts": "0x12801254", "chaps": "0", "coats2": "0xCAB6E0A9", "ponchos": "0", "cloaks": "0", "boots": "0xC430AF11", "coats": "0", "hat": "0xB72204C6", "vests": "0x381EF1D3", "bracelets": "0", "gauntlets": "0", "spurs": "0x6DF05052", "belts": "0xD8C0B763", "suspenders": "0xF1DC0761", "offhand": "0", "neckties": "0x67B0CC14", "gloves": "0x3033DA22", "beltbuckle": "0x24914BD1", "gunbelts": "0x2DF2E811"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(522, 136, 'Daemon James', 10, 25, 593, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "564665", "position": "[1415.549,-1297.603,77.569]", "stats": "[152,33.6,2,100]"}', '{"modSkin":"[2702657477,2213512467,543187419,2226823945,1552505114,null,2543734778]","bodySize":128,"model":"mp_male","features":"[0.0,0.9,-0.4,0.0,-0.2,0.0,0.0,-0.6,-0.3,-0.6,-0.5,0.3,-0.1,-0.2,-0.2,0.0,0.3,-0.4,0.0,0.2,0.0,0.0,0.0,0.0,-0.6,-0.1,0.0,0.0,-0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":1.0}', '{"gauntlets": "0", "eyewear": "0xF3F08F5F", "belts": "0x359554C3", "spurs": "0xFB85B05F", "gloves": "0", "offhand": "0", "shirts": "0xA2D997A", "pants": "0x10051C7", "coats2": "0xFB70E03C", "access": "0x96B937D3", "beltbuckle": "0xFA0C22EC", "hat": "0x6B62E5C5", "coats": "0", "boots": "0xF98F89D3", "vests": "0", "gunbelts": "0x620C1BC5", "neckties": "0", "chaps": "0", "cloaks": "0", "ponchos": "0", "suspenders": "0xE23D9F4", "skirts": "0", "bracelets": "0", "neckwear": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(523, 236, 'Mark Maverick', 1, 30, 10, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-1791.962,-364.33,161.942]", "stats": "[250,33.6,100,100]"}', '{"modSkin":"[2230576261,557173395,null,null,642477207,712446626,323985567]","bodySize":128,"model":"mp_male","pedSize":1.05333,"features":"[-0.3,-0.4,0.0,0.0,0.0,0.0,-0.2,0.0,0.0,0.0,0.0,0.9,0.0,0.0,-0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"cloaks": "0", "ponchos": "0", "coats2": "0x1DE62579", "masks": "0", "hat": "0x6926E8D5", "chaps": "0", "coats": "0", "boots": "0x23F56F2C", "vests": "0x1525E68A", "shirts": "0x1D615E9", "pants": "0xE1B0ABFF", "gauntlets": "0", "eyewear": "0x47AF47AC", "belts": "0xC0C7EB2A", "spurs": "0x82501863", "gloves": "0xA4613197", "offhand": "0", "access": "0", "neckwear": "0x1750CBF5", "beltbuckle": "0", "suspenders": "0", "gunbelts": "0", "neckties": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(524, 237, 'Hanck Donatto', 14, 28, 1438, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "198600", "position": "[1827.556,-1271.402,43.366]", "stats": "[250,33.6,100,100]"}', '{"modSkin":"[1998225129,470018738,543187419,2226823945,null,712446626,502538388]","bodySize":126,"model":"mp_male","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":1.0}', '{"eyewear": "0x9A1DFEE", "vests": "0xDAF9867", "boots": "0xC430AF11", "suspenders": "0", "bracelets": "0", "ponchos": "0", "pants": "0xE1B0ABFF", "masks": "0", "neckties": "0x67B0CC14", "chaps": "0", "cloaks": "0", "neckwear": "0", "access": "0", "offhand": "0", "spurs": "0x6DF05052", "coats2": "0xCAB6E0A9", "hat": "0xB72204C6", "belts": "0", "gauntlets": "0", "gloves": "0x10BD09BD", "beltbuckle": "0x24914BD1", "coats": "0", "shirts": "0x12801254", "gunbelts": "0x620C1BC5"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(525, 239, 'Howard Hassfarben', 11, 21, 864, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "54175", "position": "[2540.78,-1181.89,53.31]", "stats": "[236,30.96,100,88]", "dog": "A_C_DogLab_01"}', '{"modSkin":"[2696825467,623103571,null,null,3065185688,712446626,1239485608]","bodySize":128,"model":"mp_male","features":"[0.0,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":1.0}', '{"hat": "0x17812F51", "shirts": "0x242B2AA7", "vests": "0x74790121", "chaps": "0", "coats2": "0x7E124755", "cloaks": "0", "boots": "0x37BBDB6E", "pants": "0x106E3B84", "ponchos": "0", "coats": "0", "offhand": "0", "eyewear": "0x14F06EA7", "gauntlets": "0", "spurs": "0x123BDDCB", "gunbelts": "0x10CD7D44", "beltbuckle": "0xFE7D89E8", "gloves": "0x3033DA22", "access": "0", "belts": "0x359554C3", "neckwear": "0xF147518", "bracelets": "0", "masks": "0", "neckties": "0", "suspenders": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(526, 240, 'Foguinho de Jesus', 1, 25, 75, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "22500", "position": "[1412.677,-1269.255,78.346]", "stats": "[195,11.2,100,0]"}', '{"modSkin":"[1309745678,470018738,543187419,2226823945,3065185688,null,601768357]","bodySize":126,"model":"mp_male","pedSize":0.973335,"features":"[0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"beltbuckle": "0x14DCF24E", "eyewear": "0x24FAF393", "coats2": "0x2C57CD94", "ponchos": "0", "spurs": "0x123BDDCB", "gloves": "0x10BD09BD", "coats": "0", "gunbelts": "0x10CD7D44", "hat": "0x12457545", "chaps": "0", "cloaks": "0", "boots": "0x11B7CAB1", "vests": "0x1525E68A", "shirts": "0x1BD7A3BD", "pants": "0x3383A8DC"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(527, 242, 'Theodore Willow', 1, 52, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-355.203,689.97,116.803]", "stats": "[249,11.2,100,0]"}', '{"features":"[0.8,0.0,0.0,0.0,0.4,0.1,0.3,0.0,0.0,0.8,0.5,0.0,0.0,0.0,0.8,0.6,0.6,0.0,0.0,0.0,0.0,0.0,0.0,-0.4,0.9,0.0,0.0,0.9,0.9,0.9,0.3,0.3,0.2,0.4,0.2,0.0,0.0,0.0,0.0]","modSkin":"[913546243,571455569,543187419,2226823945,1552505114,1629650936,766301466]","pedSize":1.069329,"bodySize":125,"model":"mp_male"}', '{"chaps": "0", "eyewear": "0xDF6A0B7F", "coats2": "0", "cloaks": "0x98FC9472", "suspenders": "0", "ponchos": "0", "shirts": "0x15298CA8", "hat": "0", "gauntlets": "0", "belts": "0", "spurs": "0x142D2BE8", "masks": "0", "gunbelts": "0x1F9ED1AA", "vests": "0", "beltbuckle": "0", "pants": "0x17343A4", "neckties": "0x4574F536", "access": "0", "boots": "0x119D4929", "coats": "0x53CE9176", "bracelets": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(528, 241, 'James Senna', 11, 34, 830, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "27", "position": "[1409.612,-1297.746,77.672]", "stats": "[23,33.6,23,100]"}', '{"model":"mp_male","pedSize":1.026665,"modSkin":"[908431499,39008355,543187419,2226823945,3450854762,null,382614413]","bodySize":126,"features":"[0.0,0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"eyewear": "0", "vests": "0xDAF9867", "boots": "0x20D85860", "suspenders": "0", "gunbelts": "0x2DF2E811", "coats2": "0x26A3702F", "access": "0", "cloaks": "0", "ponchos": "0", "pants": "0x389AB19E", "hat": "0", "coats": "0", "shirts": "0x1D615E9", "gloves": "0x10BD09BD", "gauntlets": "0", "neckwear": "0", "belts": "0", "masks": "0", "offhand": "0", "bracelets": "0", "chaps": "0", "beltbuckle": "0x14DCF24E", "spurs": "0", "neckties": "0x67B0CC14"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(530, 243, 'Harvey Mccoy', 10, 26, 659, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "48200", "position": "[-345.859,666.074,114.795]", "stats": "[231,33.6,100,100]"}', '{"model":"mp_male","pedSize":1.026665,"modSkin":"[1998225129,0,2362013313,3623045497,642477207,712446626,605652010]","bodySize":128,"features":"[0.0,0.0,0.5,0.5,-0.9,-0.9,0.0,-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.5,-0.4,-0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"eyewear": "0", "vests": "0x1B53FA5", "boots": "0xEC428525", "suspenders": "0", "bracelets": "0", "coats": "0", "pants": "0x389AB19E", "neckties": "0", "chaps": "0", "cloaks": "0", "neckwear": "0xC666D6DD", "coats2": "0x7E124755", "belts": "0", "gauntlets": "0", "hat": "0x6B62E5C5", "ponchos": "0", "beltbuckle": "0x6E882D6D", "gunbelts": "0x620C1BC5", "shirts": "0xF503D594", "gloves": "0xEADA5149", "access": "0", "offhand": "0", "spurs": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(531, 244, 'Zé das Noites', 19, 60, 3625, '{}', 17, '{"hunger": "0", "thirst": "0", "banco": "442526", "position": "[1330.03,-1277.237,79.496]", "stats": "[250,33.6,100,100]", "posse": "63"}', '{"modSkin":"[2949506350,0,0,0,642477207,0,4234219349]","pedSize":0.973335,"model":"mp_male","bodySize":128,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"eyewear": "0x2761A139", "cloaks": "0", "boots": "0x156828EB", "neckwear": "0x24F81EAB", "hat": "0x10A61A45", "coats2": "0x1E8C190B", "access": "0", "gloves": "0x3033DA22", "coats": "0", "pants": "0x5F622EED", "offhand": "0", "belts": "0", "shirts": "0x581A73B0", "gunbelts": "0x319BEEC1", "vests": "0", "spurs": "0", "ponchos": "0", "beltbuckle": "0", "gauntlets": "0", "neckties": "0x4574F536", "masks": "0", "suspenders": "0x3BDE2985"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(532, 238, 'Paul Arigon', 1, 24, 55, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "4400", "position": "[-273.034,807.128,119.292]", "stats": "[2,33.6,2,100]"}', '{"modSkin":"[519165173,2062355027,1210379577,3723790941,612262189,null,382614413]","pedSize":0.920005,"model":"mp_male","bodySize":128,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"eyewear": "0", "vests": "0", "boots": "0x24CBC01D", "gauntlets": "0", "access": "0", "ponchos": "0", "pants": "0x2800212A", "masks": "0", "neckties": "0", "chaps": "0", "cloaks": "0", "neckwear": "0x1024C03D", "spurs": "0", "coats2": "0x1DE62579", "hat": "0x104B07BD", "gunbelts": "0x450CB6", "suspenders": "0", "beltbuckle": "0", "coats": "0", "shirts": "0", "gloves": "0x1A2D8F40"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(533, 245, 'Kirk Sushi\'s', 1, 27, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-762.223,-1291.758,43.816]", "stats": "[249,33.6,100,100]"}', '{"modSkin":"[1309745678,null,1180660122,2539219498,642477207]","pedSize":0.968002,"model":"mp_male","bodySize":128,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"hat": "0x23582134", "vests": "0", "shirts": "0x16AD55DC"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(534, 245, 'Kirk Sushi\'s', 1, 27, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-299.711,755.129,118.348]", "stats": "[72,33.5,72,100]"}', '{"modSkin":"[1309745678,0,null,null,642477207,3785588988,1036166436]","pedSize":1.026665,"model":"mp_male","bodySize":128,"features":"[0.0,0.0,0.0,0.0,0.0,-0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.2,-0.3,0.0,0.0,0.0,0.0,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"hat": "0x104B07BD", "shirts": "0x3AC92C5A", "pants": "0x3C9ADC2", "eyewear": "0", "vests": "0x1525E68A", "boots": "0x16BDB756", "gauntlets": "0", "access": "0", "coats": "0", "neckties": "0", "chaps": "0", "neckwear": "0", "spurs": "0x69E5678E", "coats2": "0x11C9B2BA", "belts": "0x83BC9AB5", "gunbelts": "0x15AF5CC4", "offhand": "0", "beltbuckle": "0x17B4FFBC", "gloves": "0x1A2D8F40"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(535, 246, 'Syller Bennett', 1, 33, 36, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[3020.424,554.38,44.618]", "stats": "[211,11.2,100,0]"}', '{"modSkin":"[908431499,1772409497,942003495,1694074219,2501331517,1629650936,298392309]","pedSize":1.010666,"model":"mp_male","bodySize":126,"features":"[0.3,0.6,0.5,0.4,0.4,0.3,0.3,0.3,0.0,-0.2,0.0,-0.7,0.1,0.0,0.2,0.2,0.0,0.0,0.0,0.0,0.3,0.1,0.0,-0.6,0.0,-0.2,0.0,0.0,0.0,0.2,-0.1,0.2,0.0,-0.1,0.0,0.0,0.5,0.0,0.0]"}', '{"chaps": "0x15FA70BD", "cloaks": "0", "boots": "0x115D47FD", "coats2": "0x95EBBEFD", "hat": "0x38B3DB72", "ponchos": "0", "pants": "0x5F622EED", "coats": "0", "shirts": "0x2037C6AB", "vests": "0x1525E68A"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(536, 247, 'Schott Marshall', 3, 23, 170, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "17400", "position": "[2632.906,-1292.35,52.182]", "stats": "[250,28.49,100,77]"}', '{"model":"mp_male","pedSize":1.026665,"modSkin":"[3396185070,0,942003495,1694074219,2452638665,3785588988,1262135006]","bodySize":128,"features":"[0.0,0.0,0.0,0.0,0.7,0.1,0.3,-0.7,0.0,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"vests": "0x381EF1D3", "boots": "0xC430AF11", "gauntlets": "0", "coats2": "0xCAB6E0A9", "hat": "0xB49F56B6", "beltbuckle": "0x24914BD1", "coats": "0", "pants": "0xE1B0ABFF", "masks": "0", "belts": "0xCB1596B4", "shirts": "0x12801254", "gloves": "0", "neckwear": "0", "cloaks": "0", "gunbelts": "0x2F6BC2EB", "chaps": "0", "neckties": "0x67B0CC14", "spurs": "0x6DF05052"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(537, 248, 'Lucas Roman ', 10, 22, 534, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "405342", "position": "[1439.787,-1299.274,77.891]", "stats": "[250,33.6,100,100]"}', '{"model":"mp_male","pedSize":1.069329,"modSkin":"[1209218150,864946818,543187419,2226823945,642477207,null,481122513]","bodySize":126,"features":"[0.4,0.4,0.0,0.2,0.1,-0.1,0.2,0.1,0.4,0.2,0.0,0.0,0.0,0.4,0.0,-0.2,0.4,-0.3,-0.3,0.0,0.0,0.0,0.0,0.5,0.2,0.0,0.5,0.0,-0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"eyewear": "0x14F06EA7", "vests": "0x1525E68A", "boots": "0xFE83E8FF", "gauntlets": "0", "access": "0", "coats": "0", "pants": "0x1D8ADDD1", "masks": "0", "neckties": "0x1D4EE78A", "chaps": "0", "cloaks": "0", "neckwear": "0x163F4C6E", "belts": "0", "spurs": "0x123BDDCB", "coats2": "0x1DE62579", "hat": "0x104B07BD", "bracelets": "0", "gunbelts": "0x620C1BC5", "suspenders": "0", "beltbuckle": "0x10443A0F", "offhand": "0", "shirts": "0x1D615E9", "gloves": "0", "ponchos": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(539, 90, 'Johnny Marston', 4, 34, 237, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "64964", "position": "[-1812.47,-372.302,166.581]", "stats": "[63,33.6,63,100]"}', '{"model":"mp_male","pedSize":1.079995,"modSkin":"[2702657477,39008355,543187419,2226823945,642477207,712446626,1063184222]","bodySize":126,"features":"[0.0,0.0,0.0,0.0,-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.3,-0.1,0.4,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"shirts": "0x1D615E9", "vests": "0x59786AE7", "eyewear": "0", "boots": "0x195A47E0", "gauntlets": "0", "bracelets": "0", "coats": "0", "pants": "0xC21EAA28", "neckties": "0", "cloaks": "0", "neckwear": "0x163F4C6E", "access": "0", "spurs": "0xFEFE4C76", "coats2": "0xC5D5D820", "belts": "0xCB1596B4", "hat": "0x59F583EB", "suspenders": "0", "offhand": "0", "beltbuckle": "0xD0B13749", "gloves": "0x46CAD525", "gunbelts": "0x153557", "ponchos": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(540, 249, 'Thomas Mcfield', 14, 30, 1649, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "398000", "position": "[2513.681,-1306.876,48.97]", "stats": "[250,33.6,100,100]"}', '{"modSkin":"[3396185070,436828730,543187419,2226823945,642477207,null,481122513]","pedSize":1.015999,"model":"mp_male","bodySize":128,"features":"[0.0,0.2,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"chaps": "0", "cloaks": "0", "boots": "0xC430AF11", "coats2": "0xCAB6E0A9", "hat": "0x943609EF", "ponchos": "0", "pants": "0xE1B0ABFF", "vests": "0x381EF1D3", "shirts": "0x12801254", "coats": "0", "beltbuckle": "0x24914BD1", "neckties": "0x67B0CC14", "offhand": "0", "gauntlets": "0", "eyewear": "0", "suspenders": "0", "belts": "0", "spurs": "0x6DF05052", "gunbelts": "0x2DF2E811", "gloves": "0x24B7D363", "access": "0", "bracelets": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(541, 187, 'Jesse James', 1, 35, 94, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "6340", "position": "[-277.865,742.69,117.294]", "stats": "[171,11.2,100,0]"}', '{"modSkin":"[908431499,323285657,942003495,1694074219,642477207,null,307184935]","pedSize":0.973335,"model":"mp_male","bodySize":128,"features":"[0.0,0.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.9,0.0,0.5,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.5,0.0,-0.9,0.5,-0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"eyewear": "0", "vests": "0x1525E68A", "boots": "0xA19AE06", "gauntlets": "0", "bracelets": "0", "coats": "0", "pants": "0x10051C7", "chaps": "0x946FA489", "cloaks": "0", "neckwear": "0x1301145F", "spurs": "0x1EDE4AC0", "coats2": "0x20ED22EA", "hat": "0x190DD37", "gloves": "0x1A2D8F40", "access": "0", "offhand": "0", "beltbuckle": "0x24936C3E", "shirts": "0", "gunbelts": "0x1CE0C5ED"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(543, 250, 'Cleiton BlackGold', 10, 32, 560, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "12100", "position": "[-316.958,785.169,117.319]", "stats": "[250,33.6,100,100]", "posse": "63"}', '{"features":"[0.0,0.4,0.3,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[908431499,465258498,1660566152,1694074219,3065185688,null,298392309]","pedSize":1.0,"bodySize":124,"model":"mp_male"}', '{"coats": "0", "coats2": "0xC5D5D820", "shirts": "0x1D615E9", "vests": "0x1525E68A", "hat": "0x9D734702", "pants": "0x106E3B84", "boots": "0x119D4929", "gauntlets": "0", "cloaks": "0", "ponchos": "0", "chaps": "0", "beltbuckle": "0x6E882D6D", "offhand": "0", "gloves": "0xF3BB414C", "spurs": "0xF30441AF", "eyewear": "0x14F06EA7", "suspenders": "0x3BDE2985", "gunbelts": "0x620C1BC5", "bracelets": "0", "access": "0", "masks": "0", "neckwear": "0", "neckties": "0", "belts": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(544, 230, 'Richard Lincoln', 5, 35, 265, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "81500", "position": "[-218.688,814.184,124.277]", "stats": "[164,31.57,100,91]"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.8,0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[null,1305389843,1180660122,2539219498,1864171073,null,841976497]","pedSize":1.015999,"bodySize":126,"model":"mp_male"}', '{"coats": "0", "shirts": "0x12801254", "gloves": "0x46CAD525", "neckties": "0x67B0CC14", "boots": "0xC430AF11", "vests": "0x381EF1D3", "coats2": "0xCAB6E0A9", "gunbelts": "0x319BEEC1", "pants": "0xE1B0ABFF", "beltbuckle": "0x24914BD1", "hat": "0x166462F8", "spurs": "0x6DF05052"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(545, 251, 'Buffalo Bill', 2, 18, 112, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[1009.76,-1179.917,65.598]", "stats": "[201,11.2,100,0]"}', '{"features":"[0.0,0.0,0.3,0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[2949506350,3829475470,543187419,2226823945,642477207,null,1855989868]","pedSize":1.0,"bodySize":128,"model":"mp_male"}', '{"coats": "0", "shirts": "0x1D615E9", "cloaks": "0", "hat": "0x17812F51", "ponchos": "0", "coats2": "0x1DE62579", "pants": "0x2800212A", "chaps": "0", "boots": "0x192C2A4B"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(546, 252, 'Matulele BlackGold', 1, 28, 40, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2555.352,-1160.896,53.676]", "stats": "[250,33.6,100,100]"}', '{"features":"[0.9,0.0,0.0,0.0,0.0,0.9,0.0,0.0,0.8,0.0,0.8,0.9,0.9,0.9,0.0,0.9,0.9,0.8,0.7,0.0,0.8,0.0,0.0,0.9,0.9,0.0,0.0,0.9,0.0,0.8,0.8,0.8,0.9,0.7,0.8,0.4,0.6,0.5,0.5]","model":"mp_male","pedSize":0.973335,"bodySize":125,"modSkin":"[1280680363,516967315,543187419,2226823945,642477207,402451886,348235608]"}', '{"coats": "0x7386B340", "beltbuckle": "0", "cloaks": "0", "hat": "0", "offhand": "0", "vests": "0", "coats2": "0", "belts": "0", "pants": "0x1D9655D4", "gunbelts": "0", "shirts": "0", "gauntlets": "0", "gloves": "0x1A2D8F40", "neckwear": "0", "bracelets": "0", "boots": "0x16F1960A", "masks": "0", "suspenders": "0", "ponchos": "0", "neckties": "0", "spurs": "0x1CA207BD", "chaps": "0", "eyewear": "0x25C51838", "access": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(547, 193, 'Alexi Strawberry', 1, 31, 91, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "59200", "position": "[2550.262,-1163.971,53.763]", "stats": "[250,33.6,100,100]"}', '{"features":"[0.0,0.9,0.6,0.3,0.2,0.0,0.0,0.0,0.0,0.7,0.3,-0.3,0.5,0.5,0.5,0.5,0.7,0.7,0.7,0.4,0.3,0.5,-0.5,0.9,0.0,0.9,0.8,0.0,0.0,0.6,0.0,0.0,0.0,0.9,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","pedSize":1.079995,"bodySize":126,"modSkin":"[1209218150,780520050,543187419,2226823945,642477207,1629650936,180350727]"}', '{"coats": "0", "beltbuckle": "0", "cloaks": "0", "hat": "0x11FBAE5", "masks": "0", "coats2": "0x1A84E2DB", "shirts": "0x581A73B0", "gauntlets": "0", "gloves": "0xA4613197", "neckwear": "0", "bracelets": "0", "boots": "0xEE7182D2", "eyewear": "0", "belts": "0", "ponchos": "0", "chaps": "0", "gunbelts": "0", "pants": "0x7E8FACCF", "offhand": "0", "access": "0", "spurs": "0", "vests": "0x1525E68A", "neckties": "0", "suspenders": "0xBF44221E"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(548, 253, 'Pedro Viera', 11, 25, 830, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "18814", "position": "[1306.428,-1308.268,76.818]", "stats": "[238,28.63,100,78]", "posse": "64"}', '{"features":"[0.0,0.4,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.9,-0.4,0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[1757924776,1709198387,543187419,2226823945,2739887825,null,3491375629]","pedSize":1.026665,"bodySize":125,"model":"mp_male"}', '{"coats": "0", "beltbuckle": "0", "neckties": "0", "hat": "0x44C13949", "masks": "0", "vests": "0", "coats2": "0", "cloaks": "0", "shirts": "0x5728618C", "gauntlets": "0", "gloves": "0x46CAD525", "neckwear": "0", "eyewear": "0", "boots": "0x131BBCE7", "belts": "0x85D1A6E7", "suspenders": "0", "ponchos": "0", "pants": "0x22E7E81D", "gunbelts": "0", "chaps": "0x3E0677D4", "offhand": "0", "access": "0", "bracelets": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(549, 254, 'James Bill', 1, 35, 34, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "100", "position": "[2290.3,1231.658,103.428]", "stats": "[222,0.0,100,0]"}', '{"features":"[0.9,0.3,0.8,0.2,0.9,0.5,0.1,0.6,-0.1,0.5,0.3,0.4,0.4,0.2,0.2,0.2,0.2,0.0,0.0,0.0,0.2,0.3,0.2,-0.9,-0.2,-0.7,0.5,0.0,0.0,0.6,0.1,0.1,0.1,0.0,0.0,0.0,0.1,0.2,0.0]","model":"mp_male","pedSize":1.026665,"bodySize":126,"modSkin":"[1209218150,332623772,543187419,2226823945,642477207,712446626,298392309]"}', '{"coats": "0", "cloaks": "0", "hat": "0x146C035C", "vests": "0", "coats2": "0x28AB5092", "shirts": "0x1D615E9", "gauntlets": "0", "gloves": "0x10BD09BD", "neckwear": "0x1024C03D", "bracelets": "0", "boots": "0x131BBCE7", "spurs": "0x123BDDCB", "suspenders": "0", "ponchos": "0", "eyewear": "0x14F06EA7", "gunbelts": "0x23396D4", "pants": "0x3C9ADC2", "chaps": "0", "access": "0x13F53A09"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(550, 255, 'Caipira Rock', 16, 18, 2417, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "274911", "position": "[1353.3,-1313.254,76.682]", "stats": "[250,21.58,100,46]", "dog": "A_C_DogLab_01"}', '{"features":"[-0.4,-0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","pedSize":0.973335,"bodySize":128,"modSkin":"[2696825467,3770895777,3126420045,2328978452,2501331517,null,4234219349]"}', '{"coats": "0", "shirts": "0x12801254", "gloves": "0xEADA5149", "boots": "0xC430AF11", "coats2": "0xCAB6E0A9", "gunbelts": "0x5261D9F3", "pants": "0xE1B0ABFF", "hat": "0xA7A1A426", "chaps": "0", "ponchos": "0", "vests": "0x941D725E", "neckties": "0x67B0CC14", "beltbuckle": "0x24914BD1", "spurs": "0x123BDDCB", "belts": "0", "neckwear": "0", "gauntlets": "0", "offhand": "0", "access": "0", "suspenders": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(551, 256, 'Rafaela Vieira', 2, 23, 125, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "14400", "position": "[2608.54,-1298.044,52.18]", "stats": "[209,16.79,100,25]"}', '{"features":"[0.0,0.9,0.9,0.9,-0.9,0.0,0.0,-0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.6,-0.9,0.0,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.1,0.0,0.0,0.0,0.0,0.0]","modSkin":"[2864896169,315772104,736263364,736263364,869083847,959712255]","pedSize":0.920005,"bodySize":127,"model":"mp_female"}', '{"coats": "0", "shirts": "0x193FCEC4", "cloaks": "0", "boots": "0x19E17B75", "vests": "0", "coats2": "0", "pants": "0x1B8A6854", "hat": "0x1481E304", "chaps": "0", "gloves": "0", "gauntlets": "0", "eyewear": "0", "masks": "0", "bracelets": "0", "suspenders": "0", "access": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(552, 258, 'John Holliday', 1, 18, 55, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "4400", "position": "[513.602,-537.635,73.579]", "stats": "[250,11.2,100,0]"}', '{"modSkin":"[2063814808,1760777841,2362013313,3623045497,642477207,null,1063184222]","model":"mp_male","features":"[0.8,0.4,0.0,0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":128,"pedSize":0.989334}', '{"hat": "0", "neckwear": "0", "pants": "0x389AB19E", "cloaks": "0", "shirts": "0x16CD2EAC", "eyewear": "0", "vests": "0x1525E68A", "coats2": "0", "chaps": "0", "boots": "0x1F5A64A3", "masks": "0", "gloves": "0", "neckties": "0", "suspenders": "0", "belts": "0", "coats": "0", "access": "0x13F53A09"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(553, 267, 'Billy Wayne', 2, 33, 144, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "5300", "position": "[523.246,-528.333,76.28]", "stats": "[250,33.6,100,100]", "posse": "64"}', '{"pedSize":1.037331,"modSkin":"[2696825467,864946818,3126420045,2328978452,2432743988,1629650936,1063184222]","model":"mp_male","features":"[-0.1,0.3,0.2,0.7,0.3,0.4,0.0,0.0,0.3,0.2,0.2,0.2,0.3,0.3,0.1,0.3,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.2,0.2,0.1,0.0,0.0,0.0,0.5,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":128}', '{"beltbuckle": "0x5894AC28", "eyewear": "0", "suspenders": "0", "access": "0", "masks": "0", "boots": "0x24CBC01D", "ponchos": "0", "gunbelts": "0x56DC1321", "offhand": "0x7553D5ED", "hat": "0x4FD50D1F", "neckwear": "0x1C990028", "vests": "0x5BB21D42", "coats": "0", "chaps": "0x6223576E", "neckties": "0", "cloaks": "0xDC2F9ADF", "pants": "0x2800212A", "bracelets": "0", "coats2": "0x20ED22EA", "gauntlets": "0xDE388F77", "belts": "0x515EBD62", "shirts": "0x1F5FA114", "gloves": "0x1A2D8F40", "spurs": "0x15076986"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(554, 252, 'Lima Mey', 8, 29, 427, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2707.418,-1215.022,51.748]", "stats": "[250,33.6,100,100]"}', '{"modSkin":"[null,0,null,null,null,null,4197281720]","pedSize":1.0,"model":"mp_male","bodySize":128,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"coats2": "0", "pants": "0xE5EB6137", "neckwear": "0", "hat": "0xBFD04BB8", "gauntlets": "0", "coats": "0x5D4207A", "boots": "0xF8B77317", "access": "0", "gloves": "0x1C7ACBA7", "bracelets": "0x5D60E31", "ponchos": "0", "gunbelts": "0x2F6BC2EB", "cloaks": "0", "eyewear": "0x2761A139", "suspenders": "0", "spurs": "0x123BDDCB", "chaps": "0", "offhand": "0", "belts": "0", "shirts": "0", "beltbuckle": "0", "vests": "0", "neckties": "0x1D4EE78A", "masks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(555, 274, 'Redy Fallagrosso', 3, 24, 190, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "3700", "position": "[1339.141,-219.14,102.189]", "stats": "[250,11.2,100,0]", "dog": "A_C_DogAmericanFoxhound_01"}', '{"model":"mp_male","modSkin":"[1106971106,1203810198,62321923,3550965899,1864171073,null,1204379617]","bodySize":127,"pedSize":0.920005,"features":"[0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"shirts": "0", "pants": "0x225EEA60", "neckwear": "0", "spurs": "0", "gloves": "0", "coats": "0xF011039C", "gunbelts": "0", "masks": "0", "coats2": "0", "ponchos": "0", "cloaks": "0", "boots": "0x268C3A9A", "chaps": "0", "vests": "0", "hat": "0x9376514E", "access": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(556, 241, 'Frank Morris', 14, 30, 1498, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "272042", "position": "[1382.701,-1337.495,78.21]", "stats": "[234,33.6,100,100]", "posse": "67"}', '{"model":"mp_male","modSkin":"[908431499,34917246,942003495,1694074219,null,null,282054283]","bodySize":126,"pedSize":1.05333,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"belts": "0", "beltbuckle": "0x17B4FFBC", "neckties": "0", "boots": "0xAEB3EEDD", "gauntlets": "0", "chaps": "0", "pants": "0xE1B0ABFF", "gloves": "0x2B8130D7", "shirts": "0x110DED53", "coats": "0", "eyewear": "0x36451407", "gunbelts": "0x2DF2E811", "hat": "0x166462F8", "coats2": "0xB18805FA", "cloaks": "0", "ponchos": "0", "vests": "0xDAF9867", "access": "0", "neckwear": "0", "bracelets": "0", "spurs": "0xF30441AF", "offhand": "0", "suspenders": "0x129DD6FD", "skirts": "0", "masks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(557, 280, 'Fernando Pessoa', 1, 25, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-311.374,802.548,118.98]", "stats": "[200,33.6,50,100]"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":127,"modSkin":"[1723194916,1643025786,942003495,1694074219,3065185688]","model":"mp_male","pedSize":1.0}', '{"neckties": "0x22D12FEF", "access": "0", "hat": "0x262CC9D4", "coats2": "0x8817C6B0", "belts": "0", "coats": "0", "pants": "0x1D8ADDD1", "shirts": "0x9CB923E0", "cloaks": "0", "boots": "0x1EF2B6A3", "eyewear": "0x2761A139", "chaps": "0", "spurs": "0", "vests": "0", "gloves": "0", "gauntlets": "0", "suspenders": "0x129DD6FD", "beltbuckle": "0", "gunbelts": "0", "bracelets": "0", "ponchos": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(558, 279, 'James Black', 10, 20, 604, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "30926", "position": "[1309.435,-1285.147,75.826]", "stats": "[236,33.6,100,100]", "posse": "67"}', '{"features":"[0.0,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.4,0.0,-0.8,0.0,0.0,0.0,-0.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[2696825467,1175610162,3126420045,2328978452,642477207,712446626,382614413]","bodySize":128,"model":"mp_male","pedSize":0.973335}', '{"masks": "0", "access": "0xA0800EEA", "neckwear": "0x1750CBF5", "hat": "0x17C59C8F", "suspenders": "0", "neckties": "0", "belts": "0x52808E9D", "boots": "0x58F9C97", "coats": "0", "pants": "0x10051C7", "shirts": "0x1281AB3F", "cloaks": "0", "gunbelts": "0x23396D4", "eyewear": "0", "chaps": "0", "spurs": "0x5000826C", "gauntlets": "0", "gloves": "0x4B7A10AE", "vests": "0x59786AE7", "offhand": "0", "beltbuckle": "0x3B9A6C0E", "ponchos": "0x19A9DDFA", "bracelets": "0", "coats2": "0x16D8F2FF"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(559, 282, 'Ze Pilintra', 11, 45, 887, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "113500", "position": "[1372.919,-1313.951,77.294]", "stats": "[250,21.9,100,48]", "posse": "69"}', '{"features":"[0.0,0.0,-0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[3396185070,628640804,2196852103,2539219498,642477207,1629650936]","bodySize":128,"model":"mp_male","pedSize":1.026665}', '{"coats": "0", "pants": "0x1A97ED82", "shirts": "0", "offhand": "0", "neckwear": "0x23D3429C", "eyewear": "0", "chaps": "0", "hat": "0x12BD5208", "gunbelts": "0x1CE0C5ED", "beltbuckle": "0x10443A0F", "vests": "0xF50220C5", "cloaks": "0", "boots": "0x195A47E0", "coats2": "0x1E8C190B", "spurs": "0x304FF460", "masks": "0", "belts": "0x1D8F49A6", "bracelets": "0", "access": "0x790DCD14", "gloves": "0", "gauntlets": "0", "neckties": "0", "ponchos": "0", "suspenders": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(560, 281, 'Kenai', 13, 21, 1156, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "42902", "position": "[2409.882,-1211.505,45.735]", "stats": "[211,11.2,100,0]", "posse": "66"}', '{"features":"[0.3,0.0,-0.1,-0.6,0.0,0.1,0.6,0.0,0.3,-0.2,0.6,0.5,0.6,0.0,0.4,0.0,0.0,0.1,0.0,0.3,0.0,0.0,0.2,-0.8,0.7,0.2,0.0,0.0,0.0,0.8,0.3,0.8,0.0,0.2,0.2,0.3,0.2,0.0,0.0]","modSkin":"[1108478392,254066903,1210379577,3723790941,3096645940,712446626,0]","bodySize":128,"model":"mp_male","pedSize":1.079995}', '{"masks": "0", "access": "0x5B5591A4", "neckwear": "0x21716DBC", "gunbelts": "0x5DD9EBFB", "coats2": "0", "belts": "0", "coats": "0x482CCCEC", "pants": "0x35F9C75F", "cloaks": "0", "eyewear": "0", "chaps": "0", "spurs": "0", "suspenders": "0", "gloves": "0x4B7A10AE", "gauntlets": "0x166A3B1B", "shirts": "0x58215FE1", "beltbuckle": "0xE60C5916", "offhand": "0", "bracelets": "0", "boots": "0xFC7B8E23", "hat": "0", "vests": "0", "ponchos": "0", "neckties": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(561, 280, 'Fernando Pessoa', 1, 25, 39, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "1300", "position": "[2944.654,1309.062,44.484]", "stats": "[2,33.6,2,100]"}', '{"features":"[0.0,0.1,0.1,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":127,"modSkin":"[1998225129,470018738,543187419,2226823945,612262189,null,1092082138]","model":"mp_male","pedSize":1.0}', '{"coats": "0", "pants": "0x1D8ADDD1", "coats2": "0xE8E42DC0", "boots": "0x23F56F2C", "eyewear": "0x3766BB7B", "shirts": "0x9CB923E0", "hat": "0x262CC9D4", "neckties": "0x22D12FEF"}', 1);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(562, 283, 'Beatrice Silver', 1, 21, 30, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2518.956,-1313.272,48.868]", "stats": "[250,33.6,100,100]"}', '{"features":"[0.5,0.4,-0.1,0.0,0.0,0.0,0.0,-0.4,0.0,0.0,-0.6,-0.3,-0.8,0.0,0.0,-0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,-0.4,-0.2,0.0,0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[1512523378,2561969623,2458758467,2458758467,2451302243,1255518018]","bodySize":127,"model":"mp_female","pedSize":0.920005}', '{"access": "0", "neckwear": "0x1BA10D1", "gunbelts": "0x449B5878", "shirts": "0xAEF04D6C", "skirts": "0", "belts": "0", "coats": "0", "pants": "0x933020F3", "cloaks": "0", "vests": "0", "eyewear": "0", "chaps": "0", "spurs": "0x41D63E68", "beltbuckle": "0x95DF5D94", "gloves": "0x8129E92", "gauntlets": "0", "offhand": "0", "ponchos": "0", "boots": "0x176667FC", "hat": "0x1D286F3E", "coats2": "0xF22AE177"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(563, 250, 'Cleiton BlackGold', 1, 32, 10, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-314.841,791.297,117.378]", "stats": "[117,28.49,100,77]"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[400853596,386766442,543187419,2226823945,null,null,484622924]","bodySize":126,"model":"mp_male","pedSize":0.941337}', '{"coats": "0", "pants": "0x106E3B84", "cloaks": "0", "gunbelts": "0x620C1BC5", "gloves": "0x3033DA22", "coats2": "0xC33E2966", "hat": "0x9D734702", "beltbuckle": "0x6E882D6D", "vests": "0x59786AE7", "shirts": "0x339C7959", "boots": "0x119D4929", "neckties": "0x22D12FEF"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(564, 284, 'Pablo Chan', 10, 30, 584, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "1300", "position": "[2510.624,-1461.993,46.321]", "stats": "[250,33.6,100,100]"}', '{"features":"[0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[3700270266,723076113,1180660122,2539219498,3065185688,null,0]","bodySize":126,"model":"mp_male","pedSize":1.005333}', '{"coats": "0", "pants": "0x1D8ADDD1", "cloaks": "0", "spurs": "0x123BDDCB", "gloves": "0x10BD09BD", "coats2": "0", "hat": "0x198A0445", "ponchos": "0", "boots": "0x119D4929", "vests": "0", "shirts": "0x1D615E9", "chaps": "0", "eyewear": "0", "neckwear": "0", "gauntlets": "0", "beltbuckle": "0x139FCC19", "neckties": "0", "gunbelts": "0x10CD7D44", "belts": "0", "bracelets": "0", "offhand": "0", "access": "0", "masks": "0", "suspenders": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(565, 285, 'Billy Brown', 1, 33, 24, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2940.781,581.927,44.412]", "stats": "[193,33.6,100,100]"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":125,"modSkin":"[400853596,2120703472,885240113,202858862,612262189,null,601768357]","model":"mp_male","pedSize":1.021332}', '{"coats": "0", "pants": "0x2965D2A1", "coats2": "0", "cloaks": "0xA7A2AACF", "boots": "0x115D47FD", "vests": "0x38F7760D", "shirts": "0x6AA0AB48", "hat": "0x1632867A", "belts": "0", "suspenders": "0", "bracelets": "0", "gunbelts": "0x2FDA7221", "chaps": "0", "masks": "0", "neckwear": "0x163F4C6E", "gloves": "0x89E61A24", "spurs": "0", "eyewear": "0x14F06EA7"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(566, 286, 'Jacinto Tonto', 5, 25, 258, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "19900", "position": "[2489.329,-1465.069,46.048]", "stats": "[250,33.6,100,100]"}', '{"features":"[0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[2534355977,39008355,3126420045,2328978452,46507404,null,0]","bodySize":126,"model":"mp_male","pedSize":1.0}', '{"coats": "0", "pants": "0x5151D24C", "coats2": "0x3EAFAB30", "boots": "0x11044269", "vests": "0x6FDAD43F", "shirts": "0x1D615E9", "hat": "0x6F22202", "spurs": "0", "eyewear": "0", "masks": "0", "suspenders": "0", "neckwear": "0", "gloves": "0x582DC308", "chaps": "0", "gunbelts": "0x2DF2E811", "neckties": "0", "bracelets": "0", "ponchos": "0", "beltbuckle": "0", "offhand": "0xFC803D89", "cloaks": "0", "belts": "0", "gauntlets": "0", "access": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(567, 289, 'Marquis Mannix', 4, 25, 227, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "30000", "position": "[2512.594,-1310.011,48.954]", "stats": "[250,33.6,100,100]"}', '{"features":"[0.0,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":126,"modSkin":"[487821771,719802851,1588167928,1535332499,1864171073,null,382614413]","model":"mp_male","pedSize":1.0}', '{"shirts": "0x12801254", "boots": "0xC430AF11", "coats2": "0xCAB6E0A9", "chaps": "0", "pants": "0xE1B0ABFF", "ponchos": "0", "hat": "0x6926E8D5", "vests": "0x381EF1D3", "coats": "0", "cloaks": "0", "gloves": "0x3033DA22", "neckwear": "0", "belts": "0", "gunbelts": "0x620C1BC5", "bracelets": "0", "offhand": "0x671CD014", "beltbuckle": "0x24914BD1", "gauntlets": "0", "eyewear": "0", "neckties": "0x67B0CC14", "spurs": "0x6DF05052"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(568, 290, 'Jhon Hardin', 5, 26, 270, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "14206", "position": "[-355.933,704.095,116.936]", "stats": "[178,11.2,100,0]"}', '{"features":"[0.0,0.0,0.4,0.0,0.6,0.0,0.0,0.0,0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":126,"modSkin":"[1309745678,470018738,2362013313,3623045497,1864171073,null,382614413]","model":"mp_male","pedSize":1.031998}', '{"access": "0", "gunbelts": "0", "coats2": "0x20ED22EA", "belts": "0xE8BAAC7C", "coats": "0", "pants": "0x169E4BBE", "cloaks": "0", "chaps": "0", "spurs": "0x123BDDCB", "shirts": "0x3115A1EB", "gloves": "0x10BD09BD", "vests": "0x381EF1D3", "offhand": "0", "beltbuckle": "0x139FCC19", "boots": "0x151EAB71", "hat": "0x9D734702", "ponchos": "0", "eyewear": "0xB72097D4"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(569, 281, 'Bob Makoey', 1, 76, 52, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2721.121,-1226.317,50.304]", "stats": "[1,33.6,1,100]"}', '{"features":"[-0.3,0.0,0.4,0.3,-0.2,0.0,0.1,0.0,-0.9,0.5,-0.7,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.1,0.0,0.0,0.0,0.9,0.9,0.9,0.0,0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.3,0.0,0.3]","bodySize":125,"modSkin":"[2702657477,3866220133,1272509601,3837101269,642477207,null,3750146482]","model":"mp_male","pedSize":0.936004}', '{"neckwear": "0x34E62EF6", "gunbelts": "0", "access": "0x17920A1E", "gloves": "0", "suspenders": "0", "eyewear": "0xF193AFD2", "chaps": "0", "pants": "0x225EEA60", "offhand": "0x1184AC1D", "beltbuckle": "0x14DCF24E", "hat": "0x17111C42", "masks": "0", "gauntlets": "0", "bracelets": "0", "spurs": "0", "ponchos": "0", "vests": "0", "coats2": "0x3E3FE988", "shirts": "0x1F0C2FE4", "belts": "0xE456C936", "coats": "0", "boots": "0x1BB1DE12", "neckties": "0x22D12FEF", "cloaks": "0"}', 1);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(570, 291, 'Madruga Nascimento', 2, 36, 110, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "4000", "position": "[1380.101,-1378.162,79.063]", "stats": "[56,11.2,56,0]"}', '{"features":"[-0.6,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.2,-0.3,0.0,0.0,0.0,0.0,0.4,0.6,0.5,0.8,-0.8,0.0,0.6,0.8,0.3,0.4,-0.6,0.5,0.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":127,"modSkin":"[549367063,1517957121,1210379577,3723790941,612262189,712446626,983283548]","model":"mp_male","pedSize":0.930671}', '{"chaps": "0", "access": "0x13F53A09", "eyewear": "0x111AFF82", "pants": "0x106E3B84", "hat": "0x10106532", "boots": "0x119D4929", "gauntlets": "0", "vests": "0x1525E68A", "belts": "0xF68F8A60", "coats": "0", "spurs": "0x123BDDCB", "neckties": "0x261662B8", "coats2": "0x20ED22EA", "gunbelts": "0x153557", "gloves": "0x1A2D8F40", "beltbuckle": "0x139FCC19", "shirts": "0x1281AB3F"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(571, 293, 'Eustacio Vankover', 3, 24, 169, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2373.752,-1406.136,45.705]", "stats": "[105,11.2,100,0]"}', '{"pedSize":0.957336,"bodySize":126,"features":"[0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","modSkin":"[2344699549,3829475470,1272509601,3837101269,1552505114,null,3521221739]"}', '{"eyewear": "0", "belts": "0x513BD1F6", "suspenders": "0", "pants": "0xE3CFC09B", "offhand": "0", "cloaks": "0", "gunbelts": "0", "shirts": "0x43270B6C", "spurs": "0x5DA17495", "masks": "0", "beltbuckle": "0x139FCC19", "hat": "0x67714F5E", "gauntlets": "0", "coats": "0", "vests": "0xA7A8CF36", "coats2": "0x6517DD5A", "neckwear": "0x91DDC109", "gloves": "0x3033DA22", "ponchos": "0", "access": "0", "boots": "0x38271590"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(572, 295, 'Walker McGregor', 19, 18, 3318, '{}', 16, '{"hunger": "0", "thirst": "0", "banco": "443425", "position": "[1422.071,-1309.071,77.549]", "stats": "[245,33.6,100,100]", "posse": "68"}', '{"bodySize":126,"features":"[-0.1,-0.3,0.2,0.0,0.0,-0.3,0.2,0.0,-0.3,-0.3,-0.1,0.0,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.5,0.0,0.0,0.0,-0.5,0.5,0.0,-0.6,-0.9,0.0,0.0,0.0,0.0,-0.5,0.0,0.0,-0.5,0.0]","pedSize":0.962669,"model":"mp_male","modSkin":"[2207881199,2821365455,543187419,2226823945,1864171073,712446626,1063184222]"}', '{"hat": "0", "belts": "0x7DB2AADF", "suspenders": "0", "pants": "0x5F622EED", "offhand": "0", "cloaks": "0", "shirts": "0x1D615E9", "chaps": "0", "masks": "0", "beltbuckle": "0xFE7D89E8", "eyewear": "0", "coats2": "0", "access": "0x29A9AE4D", "neckwear": "0xFE38E6F8", "boots": "0x5720605A", "ponchos": "0x9D875AF8", "coats": "0", "vests": "0", "gauntlets": "0", "bracelets": "0", "spurs": "0", "gunbelts": "0x620C1BC5", "gloves": "0x7AFC07AF", "neckties": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(573, 292, 'Clarice Rousseau', 8, 25, 443, '{}', 16, '{"hunger": "0", "thirst": "0", "banco": "22600", "position": "[2725.84,-1237.92,49.887]", "stats": "[250,11.2,100,0]"}', '{"bodySize":126,"features":"[0.0,0.0,0.9,0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.1,0.0,0.7,0.0,0.0,0.2,0.0,0.0,0.0,0.0,0.5,0.0,0.0,0.5,0.0]","pedSize":0.94667,"model":"mp_female","modSkin":"[510647803,1096242045,1814410998,1814410998,1647937151,959712255]"}', '{"chaps": "0", "hat": "0", "pants": "0", "coats2": "0", "coats": "0", "boots": "0x134D7E03", "shirts": "0xDC41C456", "ponchos": "0", "vests": "0", "skirts": "0x5893FD94", "bracelets": "0", "gloves": "0x72D91B96", "cloaks": "0", "offhand": "0", "eyewear": "0", "masks": "0", "belts": "0x20106F59", "suspenders": "0", "gauntlets": "0", "neckwear": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(574, 294, 'NesZao Kastro', 5, 27, 275, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "3450.9999999999982", "position": "[1372.943,-861.642,69.364]", "stats": "[110,33.6,100,100]"}', '{"model":"mp_male","features":"[-0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":0.94667,"bodySize":127,"modSkin":"[1309745678,3829475470,1660566152,1694074219,2432743988,null,382614413]"}', '{"boots": "0xEE7182D2", "pants": "0xC21EAA28", "offhand": "0xFE584139", "cloaks": "0", "gunbelts": "0x29875F42", "shirts": "0xDBB2BDA2", "spurs": "0xFF093F0", "masks": "0", "beltbuckle": "0", "chaps": "0", "gauntlets": "0", "eyewear": "0", "vests": "0", "coats": "0", "neckwear": "0x32F78342", "gloves": "0xA1B49D40", "ponchos": "0", "hat": "0xA4D1F405", "coats2": "0x7596B65E", "belts": "0xCC933469", "bracelets": "0", "suspenders": "0", "neckties": "0", "access": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(575, 286, 'Jacinto Taranto', 1, 25, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-1099.47,-1839.129,60.327]"}', '{"model":"mp_male","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":1.079995,"bodySize":125,"modSkin":"[732816121,null,543187419,2226823945]"}', '{}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(576, 297, 'Helsinqui Shelby', 10, 30, 515, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "3662", "position": "[1315.24,-1300.054,76.216]", "stats": "[203,11.2,100,0]"}', '{"bodySize":126,"features":"[0.0,0.6,0.4,0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,-0.8,0.0,-0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":1.0,"model":"mp_male","modSkin":"[2105189191,576291658,543187419,2226823945,642477207,null,605652010]"}', '{"boots": "0x115D47FD", "belts": "0x2330E0ED", "pants": "0x3C9ADC2", "offhand": "0", "coats": "0", "gunbelts": "0x1371FF7F", "shirts": "0x29423FD8", "spurs": "0x142D2BE8", "masks": "0", "beltbuckle": "0x17B4FFBC", "gauntlets": "0", "access": "0x469B5DE4", "coats2": "0x2D6D08AB", "bracelets": "0", "gloves": "0x16DEB1F", "hat": "0x166462F8", "vests": "0", "eyewear": "0x14F06EA7", "cloaks": "0", "ponchos": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(577, 298, 'Cauã Iberê', 1, 31, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2550.355,-1164.354,53.604]", "stats": "[250,33.6,100,100]"}', '{"bodySize":128,"features":"[0.9,-0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.8,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":0.920005,"model":"mp_male","modSkin":"[2468666270,889049917,1257168263,3623045497,612262189,null,0]"}', '{"shirts": "0x10DA80F1", "boots": "0", "gauntlets": "0", "suspenders": "0", "bracelets": "0", "ponchos": "0xC715C9B1", "hat": "0", "belts": "0x295A6FF5", "pants": "0x4A8ADF9A", "gunbelts": "0", "access": "0x29A9AE4D"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(578, 190, 'Epitácio Pessoa', 1, 33, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2555.352,-1160.896,53.683]", "stats": "[250,33.6,100,100]"}', '{"model":"mp_male","features":"[0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.5,0.0,0.0,0.0,-0.5,-0.3,-0.4,-0.9,-0.6,0.0]","pedSize":0.978668,"bodySize":128,"modSkin":"[908431499,2841000722,2196852103,2539219498,46507404,null,3750364151]"}', '{}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(579, 221, 'Jack Cliff', 7, 24, 392, '{}', 16, '{"hunger": "0", "thirst": "0", "banco": "20400", "position": "[1403.756,-1287.661,78.172]", "stats": "[179,33.6,100,100]"}', '{"features":"[-0.4,0.2,0.6,0.0,-0.5,0.0,-0.7,-0.2,-0.2,0.0,-0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","pedSize":1.0,"bodySize":126,"modSkin":"[2078925650,470018738,543187419,2226823945,2432743988,null,481122513]"}', '{"pants": "0x1D8ADDD1", "gloves": "0", "neckties": "0", "neckwear": "0x3531294B", "belts": "0", "gunbelts": "0", "shirts": "0x3A320688", "boots": "0x30539D9C", "gauntlets": "0", "suspenders": "0", "spurs": "0", "coats": "0", "access": "0xA0800EEA", "offhand": "0", "beltbuckle": "0", "hat": "0x262CC9D4", "coats2": "0x20ED22EA", "bracelets": "0", "eyewear": "0xCC38E51D", "vests": "0xDA8F269E", "cloaks": "0", "masks": "0", "chaps": "0", "ponchos": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(580, 239, 'Howard Hassfarben', 1, 21, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-748.605,-1297.992,43.224]", "stats": "[249,33.6,100,100]"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":1.0,"modSkin":"[null,351009507,null,null,null,null,298392309]","model":"mp_male"}', '{"hat": "0x17812F51", "shirts": "0x1D615E9", "vests": "0x1525E68A", "spurs": "0x390F2B71", "gloves": "0xD4329873", "neckties": "0", "neckwear": "0xF147518", "belts": "0", "gunbelts": "0x10CD7D44", "boots": "0x192C2A4B", "coats2": "0x7596B65E", "suspenders": "0", "chaps": "0", "beltbuckle": "0x139FCC19", "coats": "0", "pants": "0xF294D831", "gauntlets": "0", "eyewear": "0x14F06EA7"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(581, 300, 'Patricia Winchester', 1, 22, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-1099.392,-1838.766,60.084]", "stats": "[250,33.6,100,100]"}', '{"pedSize":1.079995,"model":"mp_female","features":"[-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[1842079617]","bodySize":128}', '{}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(582, 220, 'Bud Kenway ', 14, 24, 1231, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "183600", "position": "[1426.588,-1307.907,77.577]", "stats": "[250,33.6,100,100]", "posse": "67"}', '{"pedSize":0.973335,"bodySize":128,"features":"[0.2,0.3,0.2,0.2,0.9,-0.7,0.0,0.0,0.0,0.0,0.0,-0.7,-0.3,0.0,0.0,-0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[1209218150,323285657,1834492501,2968922921,642477207,null,323985567]","model":"mp_male"}', '{"cloaks": "0", "coats2": "0", "eyewear": "0", "pants": "0xE1B0ABFF", "hat": "0", "boots": "0x20D85860", "gauntlets": "0x166A3B1B", "vests": "0xF0B25E6D", "beltbuckle": "0x17B4FFBC", "coats": "0", "spurs": "0", "offhand": "0", "access": "0", "shirts": "0x32C5705D", "gunbelts": "0x2F6BC2EB", "belts": "0x359554C3", "suspenders": "0", "gloves": "0x3033DA22", "neckties": "0", "bracelets": "0", "masks": "0", "neckwear": "0x3C4AA36E", "ponchos": "0", "chaps": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(584, 301, 'Reuben Montoya', 12, 45, 964, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "99455", "position": "[1881.678,-832.756,42.829]", "stats": "[250,33.6,100,100]"}', '{"pedSize":1.015999,"features":"[-0.1,0.8,0.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.2,0.0,0.0,0.1,0.0,0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","modSkin":"[2344699549,2311914035,543187419,2226823945,2739887825,null,502538388]","bodySize":126}', '{"coats": "0", "pants": "0x33FE4F72", "boots": "0x15E08C22", "coats2": "0x79C0D490", "shirts": "0", "eyewear": "0x3766BB7B", "neckwear": "0x288E2953", "gauntlets": "0", "offhand": "0", "spurs": "0x142D2BE8", "belts": "0", "bracelets": "0", "beltbuckle": "0x16BBC668", "access": "0xB20534B6", "gloves": "0x2920359", "suspenders": "0xDB56B881", "gunbelts": "0x15AF5CC4", "vests": "0x1525E68A", "hat": "0", "neckties": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(585, 302, 'Akin', 2, 25, 119, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "5900", "position": "[1364.905,-1321.29,77.261]", "stats": "[250,33.6,100,100]"}', '{"pedSize":1.026665,"features":"[-0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":128,"modSkin":"[2304776279,3386814586,96561259,1694074219,612262189,null,0]","model":"mp_male"}', '{"chaps": "0", "cloaks": "0", "coats2": "0", "eyewear": "0", "pants": "0x2800212A", "hat": "0x262CC9D4", "boots": "0x24CBC01D", "gauntlets": "0", "vests": "0x1525E68A", "beltbuckle": "0", "coats": "0", "spurs": "0x82501863", "neckties": "0", "belts": "0x5C32A201", "ponchos": "0", "shirts": "0x1D615E9", "bracelets": "0", "access": "0", "offhand": "0", "gloves": "0", "suspenders": "0", "gunbelts": "0x620C1BC5"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(586, 298, 'Willy Miller', 8, 31, 449, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "3600", "position": "[2384.61,-1323.483,45.436]", "stats": "[250,33.6,100,100]"}', '{"pedSize":0.957336,"bodySize":128,"model":"mp_male","modSkin":"[2534355977,1642850383,543187419,2226823945,46507404,null,1457766250]","features":"[0.0,-0.5,0.6,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"chaps": "0x25BF1052", "cloaks": "0", "coats2": "0", "eyewear": "0", "pants": "0x1DDA04F5", "hat": "0xBB959BC0", "boots": "0x115D47FD", "gauntlets": "0", "ponchos": "0", "beltbuckle": "0xF99B34CF", "coats": "0x178CBCFD", "spurs": "0x19E1EC40", "neckties": "0", "offhand": "0", "suspenders": "0", "access": "0x13F53A09", "neckwear": "0x2108DC4D", "belts": "0xA9FE6F40", "gunbelts": "0x450C9136", "shirts": "0x2037C6AB", "vests": "0", "masks": "0", "gloves": "0", "bracelets": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(587, 303, 'Xina de Jesus', 4, 33, 220, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "28800", "position": "[1416.846,-1267.711,78.913]", "stats": "[57,33.6,57,100]", "dog": "A_C_DogLab_01"}', '{"pedSize":0.920005,"bodySize":128,"features":"[0.5,0.5,0.5,0.5,0.0,0.0,0.0,0.0,0.5,0.5,0.0,0.0,0.0,0.0,0.5,0.0,0.0,0.5,0.7,0.0,0.0,0.0,0.0,0.1,0.4,0.2,0.6,0.0,0.0,0.3,0.0,0.0,0.0,0.3,0.2,0.0,0.4,0.2,0.0]","modSkin":"[361543666,668390569,1180660122,2539219498,1552505114,1015527107,1037532367]","model":"mp_male"}', '{"coats": "0", "chaps": "0", "cloaks": "0", "coats2": "0x1DE62579", "pants": "0x10051C7", "hat": "0x1053D06F", "boots": "0x16BDB756", "vests": "0x1525E68A", "shirts": "0x10DA80F1", "offhand": "0x36BB8305", "eyewear": "0x3766BB7B", "spurs": "0x1F801AA6", "gloves": "0x1A2D8F40", "belts": "0x359554C3", "beltbuckle": "0x139FCC19", "access": "0", "bracelets": "0", "gunbelts": "0x620C1BC5", "gauntlets": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(588, 296, 'Krivoz Sernef', 6, 31, 313, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "4400", "position": "[2795.921,-1160.115,48.05]", "stats": "[250,33.6,100,100]"}', '{"pedSize":1.026665,"model":"mp_male","bodySize":126,"modSkin":"[1209218150,571455569,1660566152,1694074219,642477207,null,1881866345]","features":"[0.0,0.4,0.4,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"chaps": "0x191D455F", "cloaks": "0", "coats2": "0x7E124755", "eyewear": "0", "pants": "0x262B1D80", "hat": "0x943609EF", "boots": "0x30539D9C", "gauntlets": "0", "vests": "0", "offhand": "0xE0EAD765", "coats": "0", "spurs": "0x19E1EC40", "shirts": "0xADE2DA99", "access": "0", "bracelets": "0", "gunbelts": "0x153557", "ponchos": "0", "beltbuckle": "0x353C3AD6", "belts": "0x359554C3", "gloves": "0x46CAD525"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(589, 305, 'Hilly Boe', 1, 18, 10, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-384.381,752.969,115.489]", "stats": "[2,33.6,2,100]"}', '{"pedSize":0.920005,"bodySize":127,"model":"mp_male","modSkin":"[2112676615,2482891161,1257168263,3623045497,2432743988,402451886,1457766250]","features":"[0.7,0.9,-0.5,0.0,0.0,0.8,0.6,0.6,0.0,0.0,0.9,0.6,0.3,0.2,0.6,0.4,0.6,0.5,0.5,0.2,0.5,0.4,0.7,-0.8,0.4,-0.4,0.2,0.4,0.5,0.4,0.3,0.2,0.4,0.3,0.0,0.0,0.2,0.2,0.2]"}', '{"coats": "0", "chaps": "0", "cloaks": "0", "coats2": "0x5A17DB8A", "pants": "0x21FCD89B", "boots": "0x10E40F4E", "ponchos": "0", "vests": "0x379A3955", "shirts": "0x6040E46", "hat": "0x2542A345"}', 1);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(590, 304, 'Desiree', 1, 29, 30, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "3800", "position": "[1385.691,-1371.42,79.561]", "stats": "[204,2.49,100,0]"}', '{"pedSize":0.94667,"bodySize":126,"features":"[0.7,0.6,0.6,0.2,0.0,0.0,0.0,0.0,-0.2,-0.1,0.0,0.0,0.0,0.5,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.7,0.0,0.0,0.0,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[155034777,1609951869,2490861465,2490861465,2451302243]","model":"mp_female"}', '{"chaps": "0", "cloaks": "0", "coats2": "0x2582BB98", "eyewear": "0", "neckwear": "0", "hat": "0", "boots": "0x6498D13D", "gauntlets": "0", "vests": "0x181687A5", "offhand": "0", "coats": "0", "spurs": "0x26CA9075", "neckties": "0", "pants": "0x1F1064F6", "shirts": "0x3FFDB97F", "gunbelts": "0x46E3478E", "ponchos": "0", "bracelets": "0", "beltbuckle": "0", "skirts": "0", "access": "0x3D9B900C", "suspenders": "0", "gloves": "0x44973F0F"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(591, 144, 'Joseph Klimber', 12, 25, 975, '{}', 16, '{"hunger": "0", "thirst": "0", "banco": "155082", "position": "[2648.464,-1204.377,53.33]", "stats": "[250,33.6,100,100]"}', '{"pedSize":1.0,"bodySize":126,"features":"[-0.1,0.7,-0.4,0.8,-0.9,-0.8,0.0,0.0,-0.6,-0.9,-0.5,0.9,0.8,-0.7,-0.7,0.9,0.0,0.3,-0.8,0.0,0.4,0.0,0.0,-0.4,0.0,0.0,-0.2,0.0,-0.1,-0.9,0.0,0.0,0.2,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[2949506350,3829475470,2362013313,3623045497,1864171073,1015527107,1855989868]","model":"mp_male"}', '{"coats": "0", "coats2": "0xCAB6E0A9", "eyewear": "0x1A5EDE5B", "vests": "0x1525E68A", "pants": "0x1D8ADDD1", "hat": "0x2E879A52", "boots": "0x119D4929", "shirts": "0x581A73B0", "suspenders": "0x129DD6FD", "belts": "0", "gloves": "0xD4329873", "chaps": "0", "beltbuckle": "0", "gunbelts": "0", "spurs": "0x19E1EC40", "gauntlets": "0", "access": "0", "neckties": "0x4574F536", "bracelets": "0x136BA95C", "cloaks": "0", "ponchos": "0", "masks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(592, 66, 'Tom Deperto', 12, 54, 982, '{}', 1, '{"hunger": "0", "thirst": "0", "banco": "133600", "position": "[1459.696,-1846.337,54.137]", "stats": "[130,33.6,100,100]", "dog": "A_C_DogLab_01", "posse": "70"}', '{"pedSize":1.069329,"model":"mp_male","features":"[0.5,-0.9,0.3,0.1,0.0,0.0,0.0,0.4,0.3,0.3,-0.4,-0.3,0.3,0.4,-0.4,0.6,0.5,0.0,0.3,0.0,0.2,0.0,0.0,0.3,0.0,0.0,0.0,-0.4,0.3,0.2,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.2,0.0]","modSkin":"[1631383957,1037287971,942003495,1694074219,2432743988,3785588988,841976497]","bodySize":126}', '{"coats": "0", "spurs": "0x5000826C", "coats2": "0x735679D7", "vests": "0xF3046311", "gunbelts": "0x10CD7D44", "pants": "0xC8379176", "neckwear": "0x1024C03D", "hat": "0x8F0DC2A9", "boots": "0xEB58821C", "shirts": "0x200976EB", "ponchos": "0x8E7E5481", "beltbuckle": "0x3358AD46", "chaps": "0x44B24E3C", "access": "0x620114AF", "belts": "0xDA310F65", "suspenders": "0x1A36F21A"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(593, 306, 'Billy The Kid', 4, 23, 232, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2537.917,-256.609,42.384]", "stats": "[94,11.2,95,0]", "posse": "67"}', '{"pedSize":1.015999,"model":"mp_male","features":"[-0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[2105189191,null,1180660122,2539219498,642477207]","bodySize":126}', '{"chaps": "0", "cloaks": "0", "coats2": "0x3EAFAB30", "eyewear": "0", "neckwear": "0x288E2953", "hat": "0x267E3453", "boots": "0x20D85860", "gauntlets": "0", "ponchos": "0", "offhand": "0", "coats": "0", "spurs": "0x123BDDCB", "neckties": "0", "gloves": "0", "access": "0", "suspenders": "0", "belts": "0x8F814E7C", "bracelets": "0", "beltbuckle": "0x9711F75C", "pants": "0x1D8ADDD1", "gunbelts": "0x23396D4", "masks": "0", "shirts": "0xFBF601D3"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(594, 307, 'Sora Onawa', 1, 21, 30, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-375.931,800.409,115.832]", "stats": "[223,16.25,100,23]"}', '{"modSkin":"[4272525172,4134361312,2147668216,2147668216,2210319017,959712255]","features":"[0.0,0.9,0.8,-0.9,0.0,0.0,0.0,0.0,-0.9,-0.9,0.0,0.0,0.0,0.9,0.9,-0.9,0.0,0.0,0.0,-0.9,0.0,0.0,0.9,-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.9,0.0,0.9,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":0.920005,"bodySize":127,"model":"mp_female"}', '{"shirts": "0x7AE36EE2", "eyewear": "0", "skirts": "0", "ponchos": "0", "chaps": "0", "boots": "0x16644E3C", "bracelets": "0", "cloaks": "0", "hat": "0", "gunbelts": "0", "vests": "0", "gauntlets": "0", "masks": "0", "coats2": "0", "pants": "0x49B46071", "belts": "0", "suspenders": "0", "offhand": "0", "gloves": "0", "neckties": "0", "access": "0x18C3AA6B", "coats": "0", "neckwear": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(595, 307, 'Sora Onawa', 1, 21, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-772.608,-1327.751,43.662]", "stats": "[250,33.6,100,100]"}', '{"modSkin":"[4272525172,2859896933,1900360573,1900360573,3450854762]","features":"[0.0,-0.9,0.0,-0.9,-0.9,-0.9,-0.9,-0.1,-0.9,-0.9,0.0,0.0,-0.9,-0.9,0.9,-0.9,0.0,0.0,0.0,-0.9,0.0,0.0,0.0,-0.9,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,0.0,0.9,-0.9,-0.9,0.0,-0.9,0.0,0.0]","model":"mp_female","bodySize":127,"pedSize":0.920005}', '{}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(596, 308, 'Javier MacField', 1, 33, 71, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "1600", "position": "[2792.696,1341.826,71.328]", "stats": "[232,11.2,100,0]"}', '{"bodySize":126,"pedSize":1.047997,"modSkin":"[3239248279,68409628,942003495,1694074219,3065185688,712446626,1713580799]","features":"[0.4,0.4,0.4,0.3,0.6,0.0,0.4,0.5,0.3,0.3,0.3,0.2,0.7,0.4,0.1,0.6,0.0,0.8,0.6,0.3,0.5,0.4,0.4,0.6,0.3,0.5,0.2,0.8,0.6,0.7,0.1,0.4,0.0,0.3,0.2,0.3,0.2,0.2,0.0]","model":"mp_male"}', '{"hat": "0x23EF6BE9", "pants": "0x205D1C26", "ponchos": "0", "vests": "0", "coats": "0", "cloaks": "0", "chaps": "0", "coats2": "0x2CBA00CF", "shirts": "0x3A320688", "boots": "0x1ED5D45F"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(597, 309, 'Fabio Velloso', 11, 28, 733, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "180800", "position": "[2629.551,-1222.852,60.12]", "stats": "[0,28.88,0,79]"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","bodySize":126,"pedSize":0.984001,"modSkin":"[1309745678,429332843,1180660122,2539219498,642477207,null,382614413]"}', '{"belts": "0x2330E0ED", "offhand": "0", "hat": "0x748886BE", "bracelets": "0", "ponchos": "0", "pants": "0x1D8ADDD1", "spurs": "0xFEFE4C76", "coats": "0", "coats2": "0xCAB6E0A9", "access": "0x847E935E", "beltbuckle": "0x24914BD1", "neckties": "0x67B0CC14", "gunbelts": "0x5261D9F3", "masks": "0", "boots": "0x64106871", "vests": "0xE37E0D13", "gauntlets": "0xDE388F77", "neckwear": "0", "cloaks": "0", "chaps": "0", "suspenders": "0", "shirts": "0x12801254", "gloves": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(598, 311, 'Tiringa Del Fuego', 4, 34, 207, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "29370", "position": "[1236.953,-1304.345,83.659]", "stats": "[250,33.6,100,100]"}', '{"features":"[0.0,0.0,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","bodySize":125,"pedSize":0.978668,"modSkin":"[2606315044,436828730,1588167928,1535332499,3065185688,null,2089978915]"}', '{"belts": "0", "offhand": "0", "hat": "0x12BD5208", "bracelets": "0", "ponchos": "0", "vests": "0x1B53FA5", "spurs": "0x2D1A92B1", "gauntlets": "0", "coats2": "0x18FFB807", "boots": "0x16BDB756", "beltbuckle": "0x17B4FFBC", "eyewear": "0", "gunbelts": "0x5234B892", "masks": "0", "pants": "0x1A0CD667", "access": "0", "gloves": "0", "neckwear": "0x1B63F371", "cloaks": "0xA7A2AACF", "suspenders": "0", "chaps": "0", "shirts": "0x25D9BB59", "coats": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(599, 310, 'Jhon McGarry', 6, 29, 325, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "16647", "position": "[-258.594,804.524,119.053]", "stats": "[213,33.6,100,100]"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","bodySize":127,"pedSize":0.978668,"modSkin":"[1106971106,399469078,1210379577,3723790941,2501331517,null,382614413]"}', '{"offhand": "0", "hat": "0x158C36FC", "bracelets": "0", "ponchos": "0", "vests": "0x5DDCE240", "gloves": "0x1A2D8F40", "coats": "0", "coats2": "0x3FE0A71C", "access": "0", "beltbuckle": "0xE1596BF", "eyewear": "0x111AFF82", "gunbelts": "0x620C1BC5", "pants": "0xAB17B6", "cloaks": "0", "chaps": "0", "boots": "0x1EF2B6A3", "shirts": "0x2037C6AB", "spurs": "0", "gauntlets": "0", "neckties": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(600, 312, 'Cleytinho Penatorta', 7, 18, 367, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "28306", "position": "[1330.718,-1375.84,80.43]", "stats": "[137,11.2,100,0]"}', '{"bodySize":126,"pedSize":0.920005,"modSkin":"[1106971106,843248893,62321923,3550965899,3065185688,null,0]","model":"mp_male","features":"[-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"cloaks": "0", "ponchos": "0", "coats2": "0xC4598EBC", "pants": "0x1D85F2D", "hat": "0x16628DAF", "coats": "0", "shirts": "0x18015DB4", "masks": "0", "vests": "0", "gunbelts": "0x412B86A", "bracelets": "0x136BA95C", "gauntlets": "0", "neckwear": "0x2108DC4D", "beltbuckle": "0", "belts": "0x4AFD259B", "spurs": "0", "suspenders": "0x129DD6FD", "boots": "0", "offhand": "0", "eyewear": "0", "access": "0x5B5591A4", "chaps": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(601, 314, 'Bill Oliveira', 8, 35, 448, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "28900", "position": "[1342.536,-1311.668,76.508]", "stats": "[147,11.2,100,0]", "posse": "72"}', '{"bodySize":128,"modSkin":"[908431499,489478938,543187419,2226823945,3096645940,null,381599086]","pedSize":1.005333,"model":"mp_male","features":"[0.0,0.7,0.4,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"vests": "0x3D55C4CC", "masks": "0", "coats2": "0xCAB6E0A9", "pants": "0x58584555", "hat": "0x1751D32F", "coats": "0", "shirts": "0x12801254", "cloaks": "0", "boots": "0x119D4929", "ponchos": "0", "chaps": "0", "offhand": "0", "beltbuckle": "0x24914BD1", "eyewear": "0", "bracelets": "0", "neckwear": "0", "gauntlets": "0", "belts": "0", "gunbelts": "0x3D55DEC7", "access": "0", "spurs": "0x19E1EC40", "neckties": "0x67B0CC14"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(602, 313, 'John Oliveira', 13, 30, 1088, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "30400", "position": "[1309.019,-1282.189,76.08]", "stats": "[20,11.2,21,0]", "posse": "72"}', '{"bodySize":128,"pedSize":1.026665,"modSkin":"[2230576261,470018738,543187419,2226823945,46507404,null,1063184222]","model":"mp_male","features":"[0.0,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"vests": "0x3D55C4CC", "ponchos": "0", "gunbelts": "0x319BEEC1", "gauntlets": "0", "coats": "0", "offhand": "0", "spurs": "0x2D1A92B1", "beltbuckle": "0x24914BD1", "cloaks": "0", "gloves": "0", "coats2": "0xCAB6E0A9", "belts": "0", "eyewear": "0x24FAF393", "pants": "0x58584555", "neckties": "0x67B0CC14", "neckwear": "0", "hat": "0x2542A345", "access": "0", "masks": "0", "shirts": "0x12801254", "chaps": "0", "boots": "0x119D4929", "bracelets": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(603, 295, 'Lua Jessie', 1, 23, 12, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[1555.655,-704.4,45.84]", "stats": "[250,24.86,100,71]"}', '{"bodySize":126,"modSkin":"[1842079617,1847208808,736263364,736263364,3450854762,959712255]","pedSize":0.920005,"model":"mp_female","features":"[0.0,-0.7,-0.4,0.0,0.0,0.0,0.0,0.0,0.9,-0.9,0.0,0.4,0.0,0.0,-0.9,-0.9,0.0,0.0,0.0,0.0,0.2,0.0,0.0,-0.5,-0.4,-0.5,0.0,0.0,0.0,-0.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"cloaks": "0", "ponchos": "0", "gunbelts": "0x293B4AEA", "gauntlets": "0", "coats": "0", "skirts": "0xE0A0F616", "vests": "0", "coats2": "0", "belts": "0xA4D7BB7F", "pants": "0x349085A", "masks": "0xB80D6880", "bracelets": "0x64D71DBC", "neckwear": "0x268143A1", "hat": "0x1A1AE3AE", "access": "0x78735E90", "boots": "0", "gloves": "0", "chaps": "0", "shirts": "0x917F36B2", "offhand": "0", "suspenders": "0x18C9A744"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(604, 247, 'Jordan Marshall', 8, 29, 429, '{}', 16, '{"hunger": "0", "thirst": "0", "banco": "37700", "position": "[1461.026,-1350.416,78.016]", "stats": "[216,29.65,100,82]"}', '{"pedSize":1.026665,"bodySize":126,"features":"[0.0,0.8,0.1,0.2,0.5,0.0,0.1,0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","modSkin":"[3620587182,351009507,543187419,2226823945,642477207,1629650936,1389714514]"}', '{"coats2": "0", "chaps": "0", "suspenders": "0xE6D47324", "coats": "0", "offhand": "0", "beltbuckle": "0xF52F775C", "belts": "0x8DB52B0E", "boots": "0x119D4929", "spurs": "0xFEFE4C76", "gauntlets": "0xB2303767", "shirts": "0x581A73B0", "access": "0", "bracelets": "0", "cloaks": "0", "gloves": "0", "eyewear": "0x24FAF393", "gunbelts": "0x2DF2E811", "vests": "0x59786AE7", "hat": "0x2490B32C", "neckties": "0", "pants": "0x5F622EED", "neckwear": "0x24F81EAB"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(605, 251, 'Jonh Jonh', 1, 25, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-1028.008,-1847.143,61.405]", "stats": "[250,33.6,100,100]"}', '{"pedSize":1.0,"bodySize":128,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","modSkin":"[908431499,3829475470,543187419,2226823945,642477207,null,1658715876]"}', '{}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(606, 317, 'Jamal de Jesus', 1, 33, 62, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2681.916,-1289.019,51.631]", "stats": "[250,33.6,100,100]"}', '{"pedSize":0.920005,"bodySize":128,"features":"[0.7,0.5,0.0,0.0,-0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","modSkin":"[1396052485,1522562790,3212342147,1936785526,3508160042,null,1881866345]"}', '{"coats2": "0", "gunbelts": "0x2FDA7221", "suspenders": "0", "eyewear": "0x2761A139", "offhand": "0", "bracelets": "0x136BA95C", "belts": "0xE456C936", "boots": "0x14674A6B", "spurs": "0x3BB959DE", "shirts": "0x3C7C96D9", "neckwear": "0x1A7BE5DC", "chaps": "0x51256722", "cloaks": "0", "coats": "0", "ponchos": "0", "vests": "0x1525E68A", "hat": "0x565C1063", "beltbuckle": "0x17B4FFBC", "pants": "0x2C92A26A"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(607, 316, 'Anastácia Berrycloth', 6, 41, 310, '{}', 16, '{"hunger": "0", "thirst": "0", "banco": "49450", "position": "[1399.117,-1377.247,81.232]", "stats": "[250,19.63,100,45]"}', '{"pedSize":0.94667,"bodySize":128,"features":"[-0.9,-0.3,0.9,-0.9,0.0,0.0,0.0,0.0,-0.9,0.1,0.1,0.8,-0.7,0.0,0.9,-0.9,-0.2,0.0,-0.1,0.0,0.0,0.0,-0.2,-0.8,0.4,0.3,0.6,0.0,0.0,-0.7,0.0,0.0,0.0,-0.9,0.0,0.0,0.0,0.0,0.9]","model":"mp_female","modSkin":"[553014285,1895061720,186465082,186465082,3117725108,959712255]"}', '{"coats2": "0", "chaps": "0", "suspenders": "0", "coats": "0", "cloaks": "0", "beltbuckle": "0", "belts": "0x2261948E", "boots": "0x64CC4C82", "spurs": "0", "gauntlets": "0", "neckwear": "0", "skirts": "0xDFA0DBC1", "shirts": "0x917F36B2", "access": "0", "gunbelts": "0", "eyewear": "0", "ponchos": "0", "pants": "0", "bracelets": "0", "gloves": "0x8A97297E", "offhand": "0", "vests": "0", "hat": "0x7283FEBE", "neckties": "0", "masks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(608, 318, 'Annie LeLouise', 11, 27, 811, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "76000", "position": "[1330.896,-1287.831,80.14]", "stats": "[226,33.6,100,100]"}', '{"pedSize":0.920005,"bodySize":127,"features":"[0.0,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,0.0,0.0,0.2,0.0,0.4,-0.2,0.0,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.5,0.4,0.3,-0.9,-0.9,0.0,0.0,0.0,-0.1,0.9,0.9,0.0,0.8,0.9]","model":"mp_female","modSkin":"[1705365104,1176805492,736263364,736263364,928002221,959712255]"}', '{"coats2": "0", "gunbelts": "0x449B5878", "coats": "0", "offhand": "0", "beltbuckle": "0x4592F159", "belts": "0x214BD73B", "boots": "0xCFC41281", "spurs": "0x1468A6E1", "gauntlets": "0", "shirts": "0x25A3E045", "access": "0x46227A5A", "neckwear": "0x37F82E59", "chaps": "0", "gloves": "0xCA9AB424", "eyewear": "0", "vests": "0", "hat": "0x19E100C6", "neckties": "0", "pants": "0x629831E5", "suspenders": "0", "cloaks": "0", "masks": "0", "bracelets": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(609, 321, 'Zeca Pimenta', 6, 40, 338, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "7700", "position": "[2736.444,-1218.308,56.847]", "stats": "[39,8.11,2,0]"}', '{"pedSize":0.962669,"bodySize":127,"features":"[0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","modSkin":"[3612371611,373664797,543187419,2226823945,3065185688]"}', '{"coats2": "0x2C79E816", "gunbelts": "0", "shirts": "0x2CD2CB71", "eyewear": "0x14F06EA7", "cloaks": "0", "ponchos": "0", "pants": "0x2632C994", "boots": "0x11A11C2E", "hat": "0x1C5E2855", "coats": "0", "masks": "0", "bracelets": "0", "access": "0", "neckwear": "0", "gloves": "0", "belts": "0", "vests": "0", "suspenders": "0", "chaps": "0", "beltbuckle": "0", "neckties": "0", "gauntlets": "0", "offhand": "0", "spurs": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(610, 323, 'Peter Rabbit', 16, 31, 2603, '{}', 16, '{"hunger": "0", "thirst": "0", "banco": "228700", "position": "[1429.974,-1289.014,77.945]", "stats": "[92,32.25,93,94]"}', '{"pedSize":0.962669,"bodySize":128,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","modSkin":"[2230576261,505060812,1272509601,3837101269,1552505114,null,502538388]"}', '{"chaps": "0", "shirts": "0x581A73B0", "suspenders": "0x3BDE2985", "access": "0xECD9854C", "beltbuckle": "0", "gunbelts": "0x5261D9F3", "boots": "0x119D4929", "spurs": "0x123BDDCB", "pants": "0x5F622EED", "gauntlets": "0", "vests": "0x59786AE7", "gloves": "0", "neckwear": "0x24F81EAB", "coats2": "0x179F6D87", "coats": "0", "belts": "0x8DB52B0E", "hat": "0x89FDD91B", "bracelets": "0", "masks": "0", "cloaks": "0", "neckties": "0", "eyewear": "0x3BA1A0E0", "offhand": "0", "ponchos": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(611, 324, 'Vini Pampa', 4, 33, 214, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "4600", "position": "[2697.915,-1249.977,50.304]", "stats": "[248,33.6,100,100]"}', '{"pedSize":1.063996,"bodySize":128,"features":"[-0.2,-0.2,0.9,0.9,0.1,0.0,0.0,0.0,0.0,0.0,0.0,-0.1,0.9,-0.6,-0.3,0.0,0.8,-0.8,-0.3,0.0,0.0,0.0,0.0,0.0,0.4,0.9,-0.9,0.1,-0.6,0.0,0.1,0.0,0.0,0.0,0.6,0.0,0.0,0.0,0.0]","model":"mp_male","modSkin":"[1209218150,373664797,3126420045,2328978452,612262189,1015527107,4006182275]"}', '{"gunbelts": "0", "hat": "0", "shirts": "0xD2E4CE50", "suspenders": "0xEBBBEA15", "boots": "0x1BB1DE12", "vests": "0", "pants": "0x1700ADD7"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(612, 319, 'Tony Oliveira', 1, 28, 10, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2793.132,-1180.664,47.803]", "stats": "[250,33.6,100,100]"}', '{"pedSize":1.0,"bodySize":126,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","modSkin":"[908431499,null,2582128739,2539219498,3065185688,712446626]"}', '{"coats2": "0x62171038", "chaps": "0", "shirts": "0xDE414EC0", "boots": "0x594AD9D6", "gloves": "0", "cloaks": "0", "ponchos": "0", "masks": "0", "coats": "0", "gunbelts": "0x15AF5CC4", "beltbuckle": "0", "vests": "0", "hat": "0x59F583EB", "spurs": "0x1EDE4AC0", "pants": "0xC8379176"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(613, 325, 'Billy Creed', 10, 26, 593, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "183472", "position": "[-1955.273,1873.424,246.605]", "stats": "[250,30.56,100,86]"}', '{"pedSize":1.063996,"bodySize":127,"features":"[0.1,-0.8,0.5,0.0,0.0,0.4,-0.3,-0.2,0.9,-0.1,0.0,0.5,0.0,0.0,-0.8,0.1,0.8,0.0,-0.4,0.0,0.0,-0.2,-0.1,-0.8,0.2,0.5,0.0,0.0,0.0,0.0,0.6,0.2,0.5,0.9,0.0,0.0,-0.9,0.0,0.0]","model":"mp_male","modSkin":"[2844888862,254066903,1519555092,4045206010,46507404,1629650936,0]"}', '{"shirts": "0x16AD55DC", "vests": "0", "boots": "0x10E40F4E", "cloaks": "0", "hat": "0x38B3DB72", "coats2": "0", "coats": "0x105F0147", "ponchos": "0x8E7E5481", "pants": "0x2800212A", "neckwear": "0x1F7BE8DB", "gunbelts": "0x1BD4BEC7", "chaps": "0", "suspenders": "0", "offhand": "0", "gauntlets": "0", "masks": "0", "spurs": "0", "gloves": "0x2B8130D7", "access": "0x47D2DD9D", "belts": "0x131D437B", "eyewear": "0", "beltbuckle": "0x1B301155", "bracelets": "0", "neckties": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(614, 322, 'Owen Shaw', 6, 18, 314, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "30065", "position": "[-1814.723,-382.625,161.216]", "stats": "[17,33.6,18,100]"}', '{"pedSize":0.973335,"bodySize":126,"features":"[0.0,0.9,0.0,0.9,0.0,0.5,0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","modSkin":"[908431499,1209776412,2196852103,2539219498,612262189,712446626,146025810]"}', '{"coats2": "0x68958A76", "gunbelts": "0x319BEEC1", "suspenders": "0", "eyewear": "0", "offhand": "0x83A1891D", "bracelets": "0", "belts": "0x102F20E6", "boots": "0x432FFAD1", "spurs": "0x1EDE4AC0", "gauntlets": "0", "masks": "0", "shirts": "0x1D615E9", "access": "0", "chaps": "0xCA15F79C", "neckwear": "0x163F4C6E", "ponchos": "0", "beltbuckle": "0x17B4FFBC", "coats": "0", "cloaks": "0", "gloves": "0x1A2D8F40", "vests": "0x38F7760D", "hat": "0x6B62E5C5", "neckties": "0", "pants": "0x67A0299F"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(615, 326, 'Aurélio Pinto', 8, 82, 415, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "14600", "position": "[1371.843,-1320.76,77.39]", "stats": "[230,11.2,100,0]", "posse": "67"}', '{"pedSize":0.973335,"bodySize":127,"features":"[0.7,0.0,0.9,0.9,0.9,0.9,0.9,0.9,0.7,0.9,0.9,-0.9,0.9,0.9,-0.8,0.9,0.9,0.9,0.9,0.9,-0.3,-0.8,-0.7,0.9,0.9,0.9,-0.8,0.7,0.9,0.9,-0.7,-0.9,0.9,-0.8,0.4,0.1,0.0,0.1,-0.8]","model":"mp_male","modSkin":"[2888393714,1785263689,2196852103,2539219498,642477207,402451886,773929310]"}', '{"coats2": "0", "chaps": "0", "shirts": "0x1281AB3F", "boots": "0x21C0BD17", "coats": "0x1377C4A2", "hat": "0x267E3453", "pants": "0x2965D2A1", "ponchos": "0", "neckwear": "0x288E2953", "cloaks": "0", "bracelets": "0x136BA95C", "gunbelts": "0x1CE0C5ED", "suspenders": "0", "offhand": "0x1105E694", "gauntlets": "0", "masks": "0", "access": "0x13F53A09", "spurs": "0x1A7F9150", "eyewear": "0x2761A139", "neckties": "0x17C3C613", "belts": "0x28FBEC8B", "gloves": "0x16F937E6", "beltbuckle": "0x2087F4FB", "vests": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(616, 320, 'Yoki', 1, 20, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2555.201,-1160.573,53.728]", "stats": "[250,33.6,100,100]"}', '{"pedSize":1.026665,"bodySize":126,"features":"[0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.4,0.4,0.0,-0.9,0.0,0.3,0.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.5,0.0,0.0,0.0,0.0,0.0,-0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","modSkin":"[2702657477,3026895863,3126420045,2328978452,612262189,712446626,1717239876]"}', '{"coats2": "0", "chaps": "0", "shirts": "0", "coats": "0", "cloaks": "0", "ponchos": "0", "vests": "0", "hat": "0", "boots": "0", "pants": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(617, 327, 'Jhony Walker', 13, 27, 1160, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "1300", "position": "[2625.936,-1420.643,46.401]", "stats": "[250,25.67,100,65]"}', '{"pedSize":1.0,"bodySize":126,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,-0.9,0.1,0.0,0.0,-0.1,-0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","modSkin":"[1209218150,2789684254,2362013313,3623045497,1552505114,712446626,382614413]"}', '{"coats2": "0", "chaps": "0", "hat": "0xB72204C6", "shirts": "0x84AAD721", "vests": "0xB2F1CDBC", "coats": "0", "boots": "0xA4A10C08", "pants": "0x1A97ED82", "gunbelts": "0x153557", "suspenders": "0x1A36F21A", "gloves": "0", "offhand": "0", "bracelets": "0", "belts": "0", "spurs": "0x3EFA634D", "gauntlets": "0", "access": "0", "neckwear": "0x212096F0", "eyewear": "0", "beltbuckle": "0x353C3AD6", "masks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(618, 319, 'Tony Oliveira', 9, 28, 485, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "42200", "position": "[1294.798,-1293.782,77.032]", "stats": "[230,11.2,100,0]", "posse": "72"}', '{"pedSize":1.0,"bodySize":126,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","modSkin":"[908431499,1165891494,2196852103,2539219498,612262189,null,1658715876]"}', '{"coats2": "0x2937230", "gunbelts": "0x620C1BC5", "suspenders": "0x3BDE2985", "gloves": "0", "cloaks": "0", "beltbuckle": "0", "belts": "0x738A0258", "boots": "0x23F56F2C", "spurs": "0x3BB959DE", "gauntlets": "0", "shirts": "0x1D615E9", "access": "0", "coats": "0", "ponchos": "0", "chaps": "0", "offhand": "0", "eyewear": "0", "bracelets": "0", "vests": "0x59786AE7", "hat": "0x104B07BD", "neckties": "0", "pants": "0xE1B0ABFF", "neckwear": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(619, 328, 'Luzia de Maria', 4, 30, 234, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "42922", "position": "[2571.529,-1148.826,50.966]", "stats": "[173,33.6,100,100]"}', '{"pedSize":0.920005,"bodySize":127,"features":"[0.9,0.2,0.4,-0.8,0.0,0.0,0.0,0.0,0.0,0.5,0.9,-0.6,0.5,-0.5,0.5,0.3,0.5,0.4,0.9,0.0,0.0,0.1,0.0,0.0,0.0,0.0,0.0,0.0,-0.3,-0.8,0.0,0.0,0.0,0.8,0.9,0.9,0.9,0.9,0.9]","model":"mp_female","modSkin":"[1705365104,1377126878,1218117202,1218117202,3117725108,1255518018]"}', '{"hat": "0x91BAC3BA", "skirts": "0", "chaps": "0", "shirts": "0x2AA2E3FC", "vests": "0x299E176", "ponchos": "0", "coats": "0", "cloaks": "0", "pants": "0x46390E3D", "coats2": "0xEB109047", "boots": "0xCFC41281", "beltbuckle": "0x8E196FD4", "spurs": "0xE00F9857", "gauntlets": "0", "gunbelts": "0x46E3478E", "access": "0", "eyewear": "0x5EBCF4A9", "bracelets": "0", "gloves": "0x44973F0F", "belts": "0", "neckwear": "0x3028E9CE", "masks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(620, 329, 'Wafer Vitarela', 6, 57, 350, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "35600", "position": "[2725.018,-1253.96,49.88]", "stats": "[241,33.6,100,100]"}', '{"pedSize":0.952003,"bodySize":128,"features":"[-0.2,0.9,0.9,0.1,-0.6,0.2,0.5,0.9,-0.6,0.6,0.5,-0.5,-0.7,-0.5,0.4,0.1,-0.3,0.6,0.8,-0.9,0.0,0.0,-0.5,0.0,-0.6,-0.1,-0.6,0.0,0.0,0.0,-0.7,0.0,0.9,0.0,0.0,0.0,-0.1,0.0,0.0]","model":"mp_male","modSkin":"[2078925650,3866220133,1272509601,3837101269,2452638665,null,1522736310]"}', '{"ponchos": "0", "shirts": "0x28BBFD59", "cloaks": "0", "pants": "0x1B9F91CD", "coats2": "0", "coats": "0", "chaps": "0", "hat": "0", "boots": "0x10E40F4E", "vests": "0", "gauntlets": "0", "belts": "0", "gloves": "0", "beltbuckle": "0", "neckties": "0", "spurs": "0", "access": "0xA8E8FD6C", "neckwear": "0", "offhand": "0", "suspenders": "0", "gunbelts": "0x5234B892", "masks": "0", "eyewear": "0", "bracelets": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(621, 330, 'James Maverick', 11, 38, 828, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "131000", "position": "[1354.452,-1297.414,76.655]", "stats": "[220,33.6,100,100]"}', '{"pedSize":1.0,"bodySize":127,"features":"[-0.5,-0.5,0.0,0.0,0.0,0.0,0.0,0.0,-0.7,-0.7,-0.5,0.0,0.0,0.0,-0.5,0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.5,0.0,0.5,0.5,-0.5,-0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","modSkin":"[908431499,623103571,2582128739,2539219498,642477207,null,1114869792]"}', '{"coats2": "0xCAB6E0A9", "gunbelts": "0x620C1BC5", "suspenders": "0", "coats": "0", "cloaks": "0", "bracelets": "0", "belts": "0x85D1A6E7", "boots": "0x85EEDF53", "spurs": "0xF30441AF", "gauntlets": "0", "shirts": "0x521B2637", "access": "0", "ponchos": "0", "beltbuckle": "0x24914BD1", "gloves": "0", "offhand": "0", "chaps": "0", "vests": "0", "hat": "0x707839AB", "neckties": "0x67B0CC14", "pants": "0xE1B0ABFF", "eyewear": "0", "neckwear": "0", "masks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(622, 331, 'Berham Brandbarlett', 1, 30, 64, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "16000", "position": "[2501.413,-1441.345,46.286]", "stats": "[241,32.81,100,96]"}', '{"pedSize":0.973335,"bodySize":126,"features":"[0.5,0.2,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.5,-0.4,0.0,0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","modSkin":"[908431499,1468572749,1660566152,1694074219,2501331517,1629650936,2587879296]"}', '{"coats2": "0", "chaps": "0", "coats": "0", "cloaks": "0", "bracelets": "0x136BA95C", "belts": "0", "boots": "0x8239E741", "spurs": "0x3BC03131", "gauntlets": "0", "shirts": "0x5AE17823", "access": "0x3B7F8161", "neckwear": "0xE5C9E5C8", "eyewear": "0", "ponchos": "0", "gunbelts": "0x5DD9EBFB", "vests": "0x60F698A9", "hat": "0x709A8B97", "beltbuckle": "0x99AEAFF", "pants": "0x1B9F91CD", "offhand": "0", "suspenders": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(623, 333, 'Billy Henry', 14, 26, 1412, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "267882", "position": "[2541.082,-1217.647,53.313]", "stats": "[195,30.08,100,84]", "posse": "73"}', '{"pedSize":0.952003,"bodySize":128,"features":"[-0.7,0.4,-0.5,-0.2,-0.6,0.0,0.0,0.0,0.0,0.0,0.0,-0.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,-0.7,-0.6,0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","modSkin":"[2702657477,555297777,1257168263,3623045497,642477207,null,307184935]"}', '{"coats2": "0xC5D5D820", "chaps": "0", "coats": "0", "shirts": "0", "vests": "0xDAF9867", "hat": "0x166462F8", "boots": "0x38772DE7", "pants": "0x12D463B0", "access": "0", "offhand": "0", "masks": "0", "neckwear": "0", "bracelets": "0", "gunbelts": "0x620C1BC5", "eyewear": "0xE1A7209B", "neckties": "0", "suspenders": "0", "gloves": "0", "beltbuckle": "0x24914BD1", "ponchos": "0", "cloaks": "0", "belts": "0x131D437B", "spurs": "0", "gauntlets": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(624, 332, 'Frank Gray', 7, 32, 397, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "21217", "position": "[1365.374,-1309.466,77.458]", "stats": "[227,33.6,100,100]"}', '{"pedSize":0.984001,"bodySize":126,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","modSkin":"[2207881199,2116383364,543187419,2226823945,3065185688,null,3128266259]"}', '{"hat": "0x748886BE", "coats2": "0xCAB6E0A9", "gunbelts": "0x620C1BC5", "eyewear": "0", "offhand": "0", "beltbuckle": "0x24914BD1", "belts": "0", "boots": "0x20D85860", "spurs": "0", "gauntlets": "0", "shirts": "0x1D615E9", "access": "0", "neckwear": "0", "chaps": "0", "ponchos": "0", "cloaks": "0", "pants": "0x389AB19E", "coats": "0", "gloves": "0x6EF757A8", "vests": "0x381EF1D3", "neckties": "0x67B0CC14", "masks": "0", "bracelets": "0", "suspenders": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(625, 334, 'Paul Carson', 15, 18, 1968, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "160900", "position": "[1429.308,-1286.388,79.466]", "stats": "[246,11.2,100,0]", "posse": "74"}', '{"pedSize":0.973335,"bodySize":127,"features":"[0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","modSkin":"[1772543053,555297777,62321923,3550965899,1552505114,null,0]"}', '{"coats2": "0x7E124755", "shirts": "0x65C1B5F6", "vests": "0x1525E68A", "coats": "0", "gauntlets": "0", "chaps": "0", "cloaks": "0", "hat": "0x17812F51", "boots": "0x38772DE7", "pants": "0x5151D24C", "gunbelts": "0x620C1BC5", "access": "0", "gloves": "0xD4329873", "eyewear": "0", "spurs": "0", "neckties": "0x3E56C2FB", "masks": "0", "ponchos": "0", "neckwear": "0", "bracelets": "0", "suspenders": "0", "belts": "0x359554C3", "beltbuckle": "0", "offhand": "0", "skirts": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(626, 335, 'Lilith Vanhord Vaquejada', 15, 23, 1968, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "149276", "position": "[1309.461,-1296.296,75.941]", "stats": "[250,32.04,100,93]", "posse": "73"}', '{"pedSize":1.026665,"bodySize":128,"features":"[0.0,0.1,0.0,-0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.2,-0.3,-0.2,-0.1,0.0,0.2,0.0,-0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_female","modSkin":"[1705365104,1096242045,2458758467,2458758467,3450854762]"}', '{"boots": "0x2A63DFD4", "gloves": "0x3F1D5D03", "skirts": "0", "shirts": "0x2D63CE34", "coats": "0", "hat": "0x9F557DE7", "spurs": "0x1468A6E1", "pants": "0x1FBCC141", "coats2": "0", "gunbelts": "0x100FA02B", "vests": "0", "eyewear": "0", "chaps": "0", "suspenders": "0", "ponchos": "0", "beltbuckle": "0x4839939E", "neckwear": "0x1BA10D1", "cloaks": "0", "bracelets": "0", "offhand": "0", "gauntlets": "0", "masks": "0", "access": "0", "neckties": "0", "belts": "0x214BD73B"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(627, 125, 'Lucius', 3, 0, 160, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "42100", "position": "[1303.832,-1291.088,75.951]", "stats": "[250,33.6,100,100]"}', '{"pedSize":1.069329,"features":"[0.0,0.7,0.0,0.0,0.9,0.0,0.0,0.0,-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.9,0.0,0.0,0.5,0.0,0.0,0.0,0.0,-0.1,0.0,-0.9,0.0,-0.9,-0.9,-0.9,-0.9,-0.9,-0.9,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","modSkin":"[2063814808,3907997116,1180660122,2539219498,642477207,1629650936,1692876447]","bodySize":127}', '{"boots": "0x38772DE7", "gauntlets": "0", "shirts": "0x8B648137", "cloaks": "0", "pants": "0xF294D831", "coats2": "0xCAB6E0A9", "chaps": "0", "ponchos": "0", "belts": "0xCC933469", "neckties": "0x188D7769", "coats": "0", "hat": "0x6EF4B2CD", "vests": "0x1525E68A", "gloves": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(628, 336, 'Daren Shappa', 1, 25, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[1372.409,-1345.982,77.472]", "stats": "[226,11.2,100,0]"}', '{"model":"mp_male","features":"[0.0,-0.1,-0.9,0.7,-0.5,0.0,-0.8,0.0,-0.9,-0.8,0.0,0.4,0.0,0.0,0.0,0.8,0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.8,0.0,0.0,0.9,0.0,0.0,0.0,0.0,-0.5,0.0,0.0,0.0,0.0,0.5,0.0,0.0]","pedSize":1.026665,"modSkin":"[1901130586,4262388214,885240113,202858862,3065185688,null,2031577909]","bodySize":126}', '{"suspenders": "0", "neckwear": "0x212096F0", "eyewear": "0", "pants": "0xD09CEA7C", "vests": "0", "boots": "0x3F07A550", "masks": "0", "gunbelts": "0", "offhand": "0", "neckties": "0", "belts": "0x3534FA0B", "bracelets": "0x2254C72E", "chaps": "0x44B24E3C", "ponchos": "0xBED49D92", "gauntlets": "0x166A3B1B", "shirts": "0x6E4D22C1", "spurs": "0", "gloves": "0", "coats": "0", "coats2": "0xC7A051B4", "access": "0x96B937D3", "beltbuckle": "0", "hat": "0x1FE651E5", "cloaks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(629, 337, 'Jake Carter', 1, 25, 55, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[1323.145,-1364.131,79.021]", "stats": "[136,11.2,100,0]"}', '{"pedSize":1.0,"features":"[0.0,0.0,0.0,0.0,0.0,0.5,0.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","modSkin":"[2207881199,429332843,1180660122,2539219498,612262189,null,0]","bodySize":128}', '{"gauntlets": "0", "belts": "0", "coats2": "0x95EBBEFD", "neckwear": "0x1C990028", "suspenders": "0", "pants": "0xE3CFC09B", "offhand": "0", "masks": "0xA6F0AE12", "ponchos": "0", "gunbelts": "0x620C1BC5", "hat": "0x364D0E72", "spurs": "0", "gloves": "0", "boots": "0x195A47E0", "eyewear": "0", "vests": "0x374E6E38", "bracelets": "0", "shirts": "0x1D615E9", "coats": "0", "chaps": "0", "cloaks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(630, 73, 'Dingu Men', 1, 56, 90, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "3200", "position": "[2559.193,-1317.148,49.284]", "stats": "[250,16.8,100,29]"}', '{"model":"mp_male","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":1.069329,"modSkin":"[732816121,3644947867,885240113,202858862,null,null,4234219349]","bodySize":127}', '{"access": "0", "eyewear": "0", "neckwear": "0", "cloaks": "0", "belts": "0", "pants": "0xED01EF60", "beltbuckle": "0x5FE96AD9", "coats": "0", "boots": "0x20D85860", "hat": "0x17111C42", "offhand": "0", "vests": "0xED0D599", "coats2": "0xCAB6E0A9", "shirts": "0xFCA7C563", "gunbelts": "0x2DF2E811"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(631, 339, 'Zetrovao Nascimento', 1, 35, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2589.724,-450.498,42.348]", "stats": "[250,33.6,100,100]"}', '{"pedSize":0.94667,"features":"[-0.4,0.6,0.4,0.1,0.8,0.3,0.9,0.7,0.4,0.4,0.3,0.3,0.3,0.2,0.2,0.2,0.2,0.3,0.0,0.5,0.4,-0.4,0.6,0.0,0.0,0.1,0.0,0.0,-0.5,-0.1,0.0,0.0,0.6,0.7,0.0,0.0,-0.7,0.0,0.0]","model":"mp_male","modSkin":"[2888393714,664756881,2196852103,2539219498,2195072443,712446626,605652010]","bodySize":127}', '{}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(632, 283, 'Beatrice Silver', 1, 21, 10, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[1361.754,-1378.828,79.366]", "stats": "[239,33.6,100,100]"}', '{"pedSize":0.920005,"features":"[-0.1,0.0,0.0,0.0,0.0,0.0,0.0,-0.8,-0.4,-0.5,-0.5,0.0,-0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.8,-0.2,0.8,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_female","modSkin":"[1512523378,617200186,3251571649,3251571649,2451302243,1255518018]","bodySize":127}', '{"spurs": "0x41D63E68", "shirts": "0x60A8561A", "neckwear": "0x47F2E07", "hat": "0x1D286F3E", "gunbelts": "0x449B5878", "vests": "0x3161BA3B", "access": "0", "offhand": "0", "gauntlets": "0", "masks": "0", "coats": "0", "boots": "0x176667FC", "beltbuckle": "0x1D43574", "eyewear": "0", "neckties": "0", "coats2": "0x7E4AE849", "pants": "0x46390E3D", "gloves": "0x44973F0F"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(633, 340, 'Wyatt Maverick', 1, 31, 81, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "90500", "position": "[1590.755,-1428.917,56.165]", "stats": "[250,32.8,100,100]"}', '{"model":"mp_male","features":"[0.0,0.0,0.0,0.0,0.0,-0.5,0.0,-0.5,0.0,-0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.2,0.0,0.0,-0.8,0.0,0.0,0.0,0.0,-0.5,0.0,0.0,0.0,0.0,-0.5,0.0,0.0,0.0,0.0,0.0]","pedSize":1.015999,"modSkin":"[2949506350,719802851,1660566152,1694074219,612262189,1629650936,605652010]","bodySize":126}', '{"ponchos": "0", "shirts": "0x92071A86", "cloaks": "0", "pants": "0xC21EAA28", "coats2": "0x7596B65E", "chaps": "0", "boots": "0x4FC8C87F", "coats": "0", "vests": "0x1525E68A", "spurs": "0x4C00FA6D", "gunbelts": "0x620C1BC5", "suspenders": "0", "access": "0", "offhand": "0", "gauntlets": "0", "masks": "0", "hat": "0xB16BB2D6", "eyewear": "0x47AF47AC", "neckties": "0", "beltbuckle": "0x16BBC668", "belts": "0", "gloves": "0xEADA5149"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(634, 341, 'Kange Pena vermelha ', 1, 22, 78, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "27000", "position": "[1444.774,-1389.931,79.546]", "stats": "[239,11.2,100,0]"}', '{"pedSize":1.079995,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","modSkin":"[2597378528,3597829160,1807137864,3550965899,612262189]","bodySize":126}', '{"gauntlets": "0", "belts": "0xCB1596B4", "coats2": "0", "neckwear": "0xE8BD99CB", "pants": "0x169E4BBE", "offhand": "0x6283DA19", "masks": "0", "beltbuckle": "0xE780E835", "ponchos": "0", "access": "0x847E935E", "cloaks": "0", "gunbelts": "0x1C04C393", "hat": "0", "spurs": "0", "gloves": "0xCB8354AB", "boots": "0x48391E97", "eyewear": "0", "vests": "0", "chaps": "0", "shirts": "0x4F487494", "coats": "0", "bracelets": "0xE94B5518"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(635, 342, 'Joaquin Murrieta', 3, 30, 155, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "90700", "position": "[1370.861,-1319.842,77.363]", "stats": "[191,33.6,100,100]"}', '{"pedSize":0.925338,"features":"[0.1,-0.4,0.3,0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.1,0.0,0.0,0.9,0.8,-0.5,-0.5,-0.2,0.0,0.9,0.4,-0.2,0.9,0.9,0.9,0.9,0.9,0.9]","model":"mp_male","modSkin":"[2063528470,3600240431,543187419,2226823945,612262189,1629650936,111379000]","bodySize":125}', '{"hat": "0x3E8135EB", "chaps": "0x430F81E6", "shirts": "0xA5C838E6", "vests": "0", "ponchos": "0x526244AF", "coats": "0", "pants": "0x58E11937", "coats2": "0", "boots": "0x2679AC3C", "gauntlets": "0", "belts": "0xD8C0B763", "neckwear": "0x24F81EAB", "suspenders": "0", "offhand": "0xBE6D38BA", "masks": "0", "beltbuckle": "0x461EEE19", "access": "0", "gunbelts": "0x5234B892", "spurs": "0xF601515C", "gloves": "0x6DBFED37", "eyewear": "0", "bracelets": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(636, 343, 'Blanka D\'Lacier', 1, 22, 30, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2736.767,-1275.35,49.296]", "stats": "[250,22.5,100,50]"}', '{"features":"[0.0,0.2,0.7,0.4,0.0,0.0,0.0,0.0,0.7,0.6,0.0,0.6,0.6,-0.9,-0.7,0.0,0.9,0.2,0.4,0.7,-0.1,0.1,0.4,0.0,-0.4,0.8,0.0,0.9,0.0,0.8,0.6,0.9,0.6,0.2,0.2,0.1,0.2,0.0,0.1]","model":"mp_female","pedSize":0.925338,"bodySize":127,"modSkin":"[817220090,681141339,1218117202,1218117202,2489772761,1718707833]"}', '{"coats": "0", "gloves": "0x44973F0F", "skirts": "0x483D89AA", "boots": "0x1B844230", "eyewear": "0x37B27474", "ponchos": "0x2A0F3B63", "shirts": "0x1E3212F", "cloaks": "0", "pants": "0", "coats2": "0", "hat": "0x258FC019"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(637, 338, 'Nala Carter', 1, 25, 69, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2207.349,46.826,58.797]", "stats": "[200,11.2,100,0]"}', '{"features":"[0.0,0.0,0.0,-0.8,0.0,0.0,0.0,0.0,0.1,0.5,-0.9,0.0,0.0,0.0,0.9,-0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.6,-0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[2864896169,1620016488,1218117202,1218117202,3117725108,959712255]","pedSize":0.973335,"bodySize":126,"model":"mp_female"}', '{"belts": "0", "coats": "0x6C8CA0BE", "neckwear": "0", "suspenders": "0", "pants": "0x44FFB1FE", "offhand": "0", "masks": "0", "beltbuckle": "0", "ponchos": "0", "access": "0", "cloaks": "0", "gunbelts": "0", "hat": "0x4EC9890F", "spurs": "0", "gloves": "0x3F1D5D03", "skirts": "0", "boots": "0x134D7E03", "shirts": "0x154CC1F7", "vests": "0", "chaps": "0", "coats2": "0", "eyewear": "0x1890826"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(638, 344, 'Aurora Santi', 1, 25, 84, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "29200", "position": "[2580.261,-1202.235,53.881]", "stats": "[1,30.47,1,86]"}', '{"features":"[0.0,0.9,0.9,0.0,0.0,0.0,0.0,0.0,0.0,-0.6,0.3,0.0,0.6,0.0,0.7,0.5,0.5,0.8,0.5,-0.4,0.0,-0.2,-0.1,0.2,-0.1,0.8,0.8,0.8,-0.6,-0.8,0.0,0.0,0.0,0.4,0.7,0.3,-0.8,-0.6,-0.6]","modSkin":"[3145763044,1141776368,743432389,743432389,2836599857,1255518018]","pedSize":0.957336,"bodySize":127,"model":"mp_female"}', '{"coats2": "0", "neckwear": "0", "pants": "0", "masks": "0", "beltbuckle": "0", "ponchos": "0", "access": "0", "cloaks": "0", "gunbelts": "0", "hat": "0", "spurs": "0", "gloves": "0", "skirts": "0x49FEA7A", "boots": "0x134D7E03", "shirts": "0x53BF57C7", "vests": "0", "eyewear": "0", "coats": "0", "belts": "0x2E4B59AA", "offhand": "0", "chaps": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(639, 345, 'Belle Dalton', 1, 64, 67, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "1833", "position": "[2279.969,-1369.872,45.555]", "stats": "[0,33.6,0,100]"}', '{"features":"[0.0,-0.4,0.0,0.1,0.1,0.0,0.0,0.0,0.9,0.9,0.0,0.0,0.0,0.0,0.9,0.9,-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.9,0.0,0.0,0.8,-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","pedSize":0.973335,"bodySize":124,"modSkin":"[1587165517,324253830,543187419,2226823945,1864171073,712446626,4243253661]"}', '{"hat": "0x146C035C", "pants": "0x332F851C", "boots": "0x151EAB71", "vests": "0x1525E68A", "shirts": "0xF4BB3A42", "beltbuckle": "0", "eyewear": "0", "gauntlets": "0", "belts": "0", "access": "0", "masks": "0", "neckwear": "0", "chaps": "0", "spurs": "0", "gunbelts": "0", "neckties": "0", "offhand": "0", "ponchos": "0", "coats2": "0x1DE62579", "cloaks": "0", "coats": "0", "suspenders": "0"}', 1);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(640, 346, 'Leoncio Picatwofly', 5, 25, 255, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "1100", "position": "[71.268,-445.563,73.073]", "stats": "[202,11.2,100,0]"}', '{"features":"[-0.3,0.4,-0.3,0.0,0.3,0.4,0.0,0.0,0.0,0.0,0.0,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","pedSize":1.021332,"bodySize":126,"modSkin":"[1631383957,401159544,2196852103,2539219498,642477207,null,319152566]"}', '{"coats": "0", "neckwear": "0x1750CBF5", "suspenders": "0", "pants": "0x225EEA60", "masks": "0", "beltbuckle": "0", "ponchos": "0", "access": "0x620114AF", "cloaks": "0", "gunbelts": "0x10CD7D44", "hat": "0x1E55488E", "gloves": "0", "boots": "0x23156B7D", "eyewear": "0x1A5EDE5B", "vests": "0x1737DA27", "chaps": "0", "coats2": "0x28AB5092", "shirts": "0x18015DB4"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(641, 348, 'Peter Tosh', 6, 27, 302, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "185000", "position": "[1350.337,-1306.013,76.743]", "stats": "[24,11.2,24,0]"}', '{"features":"[0.4,0.7,0.8,-0.7,0.0,0.0,0.0,0.0,0.0,0.4,0.3,-0.8,0.0,0.5,0.0,0.0,0.0,-0.3,0.0,0.0,0.0,0.0,0.0,0.3,0.0,0.0,0.0,0.0,0.0,0.5,0.0,0.4,0.8,0.0,0.2,0.4,0.0,0.0,0.0]","model":"mp_male","pedSize":1.026665,"bodySize":125,"modSkin":"[1422840308,2774284815,1773547611,1824319804,612262189,712446626,1971724686]"}', '{"gauntlets": "0", "belts": "0x3F49FF1B", "coats2": "0x7596B65E", "neckwear": "0x26BD2469", "suspenders": "0x14FB5BC0", "chaps": "0", "offhand": "0", "beltbuckle": "0x25409ADF", "ponchos": "0", "access": "0", "cloaks": "0", "gunbelts": "0x153557", "hat": "0x208B8617", "spurs": "0x390F2B71", "gloves": "0x16DEB1F", "boots": "0x29F57A99", "shirts": "0x5EB429B", "bracelets": "0", "coats": "0", "pants": "0x44C39E2C", "vests": "0", "neckties": "0", "eyewear": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(642, 347, 'El Japon', 2, 26, 126, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "72800", "position": "[2335.437,-736.035,41.867]", "stats": "[0,11.2,0,0]"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","pedSize":0.973335,"bodySize":128,"modSkin":"[1309745678,1192656540,543187419,2226823945,642477207,null,1037532367]"}', '{"belts": "0", "coats2": "0", "spurs": "0x6DF05052", "boots": "0x93095EA8", "eyewear": "0", "masks": "0", "beltbuckle": "0x63B38DEB", "neckties": "0", "hat": "0xAF686AEC", "pants": "0xB01C1D77", "shirts": "0", "vests": "0", "coats": "0xAD794606", "gauntlets": "0", "ponchos": "0", "gloves": "0", "access": "0", "offhand": "0", "neckwear": "0", "suspenders": "0", "gunbelts": "0x1F9ED1AA", "bracelets": "0", "cloaks": "0"}', 1);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(643, 350, 'Joyce Vandergeld', 13, 20, 1078, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "70000", "position": "[1403.809,-1302.507,77.751]", "stats": "[250,33.6,100,100]", "posse": "67"}', '{"model":"mp_female","pedSize":0.968002,"bodySize":127,"modSkin":"[2864896169,1046968383,1218117202,1218117202,2489772761,959712255]","features":"[0.0,0.2,0.6,0.2,0.0,0.5,0.0,0.0,-0.7,0.4,0.0,0.0,0.0,0.0,0.7,-0.4,0.2,0.4,0.4,-0.3,0.0,0.0,0.6,0.3,0.0,-0.3,0.0,0.2,-0.8,-0.7,0.3,0.4,0.6,0.0,0.0,0.0,0.0,0.6,0.0]"}', '{"chaps": "0", "pants": "0", "shirts": "0xA22BF122", "vests": "0", "coats2": "0", "boots": "0x16644E3C", "hat": "0", "coats": "0", "skirts": "0x573C64BB", "gunbelts": "0", "gloves": "0", "bracelets": "0", "beltbuckle": "0", "offhand": "0", "suspenders": "0x3BE8AEF6", "eyewear": "0", "access": "0", "spurs": "0", "belts": "0x7420395A", "ponchos": "0", "cloaks": "0", "neckwear": "0x183AA714", "gauntlets": "0", "masks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(644, 337, 'Celia Jacobsen', 1, 62, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2527.046,-1276.278,49.16]", "stats": "[250,33.6,100,100]"}', '{"model":"mp_female","pedSize":0.920005,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[4155271080,2637560292,3227133357,3227133357,2210319017]","bodySize":127}', '{"coats2": "0", "hat": "0", "pants": "0", "coats": "0", "shirts": "0x1AFE2824", "suspenders": "0", "gloves": "0", "bracelets": "0", "eyewear": "0x1890826", "gauntlets": "0", "boots": "0x6C480429", "ponchos": "0", "access": "0", "skirts": "0x3EE2A1EF"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(645, 351, 'João Caminhador', 1, 31, 17, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[1324.641,-1351.389,78.423]", "stats": "[242,27.82,100,74]"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[3620587182,332623772,543187419,2226823945,642477207,null,298392309]","pedSize":1.0,"bodySize":127,"model":"mp_male"}', '{"coats2": "0x1193B64F", "neckwear": "0x1750CBF5", "suspenders": "0", "chaps": "0", "masks": "0", "beltbuckle": "0", "ponchos": "0", "access": "0", "cloaks": "0", "hat": "0x11FBAE5", "spurs": "0x15076986", "gloves": "0x10BD09BD", "boots": "0x115D47FD", "eyewear": "0x24FAF393", "vests": "0x1B53FA5", "coats": "0", "pants": "0x106E3B84", "shirts": "0x215112"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(646, 353, 'Velha Dercy', 3, 70, 155, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "4300", "position": "[2240.116,-146.131,46.887]", "stats": "[250,33.6,100,100]"}', '{"features":"[0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_female","pedSize":0.94667,"bodySize":127,"modSkin":"[1352772082,1112305096,3251571649,3251571649,2273169671]"}', '{"coats2": "0", "eyewear": "0xE561C067", "gauntlets": "0", "cloaks": "0", "shirts": "0x21F6627D", "skirts": "0xECB07D8C", "neckwear": "0x11AB0D13", "vests": "0x5544CBCE", "spurs": "0", "access": "0", "gloves": "0x3F1D5D03", "gunbelts": "0x21DDD4C2", "coats": "0", "beltbuckle": "0", "bracelets": "0", "suspenders": "0", "offhand": "0x6E7E4E06", "ponchos": "0", "masks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(647, 354, 'Caramuru Kaluanã', 1, 25, 75, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "8400", "position": "[1286.979,-1288.861,76.0]", "stats": "[104,11.2,100,0]"}', '{"features":"[0.0,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":1.079995,"bodySize":126,"modSkin":"[1108478392,2062355027,3024641315,3550965899,612262189]","model":"mp_male"}', '{"cloaks": "0", "gloves": "0", "belts": "0x34A718CD", "coats2": "0", "gauntlets": "0", "pants": "0x7514F0C", "boots": "0", "chaps": "0", "spurs": "0", "masks": "0", "access": "0x5B5591A4", "ponchos": "0", "hat": "0", "eyewear": "0", "beltbuckle": "0", "shirts": "0", "coats": "0", "neckwear": "0", "gunbelts": "0x412B86A", "bracelets": "0x5D60E31", "offhand": "0", "vests": "0", "neckties": "0", "suspenders": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(648, 355, 'Nerson Macfly', 1, 37, 66, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "5668", "position": "[1298.868,-1298.62,77.112]", "stats": "[221,11.2,100,0]"}', '{"pedSize":1.079995,"bodySize":128,"modSkin":"[3396185070,889049917,1257168263,3623045497,642477207,712446626,549062696]","features":"[0.5,0.1,0.4,0.6,0.2,0.5,0.9,0.6,0.3,0.4,0.4,0.6,0.6,0.0,0.0,-0.6,0.9,0.0,-0.4,0.0,0.0,0.0,0.0,0.4,0.6,0.5,0.4,0.7,0.5,0.0,0.0,0.0,0.0,0.3,0.0,0.0,0.8,-0.4,0.7]","model":"mp_male"}', '{"shirts": "0x1BD7A3BD", "hat": "0x146C035C", "vests": "0x242A4C73", "boots": "0x151EAB71", "pants": "0x2C92A26A", "coats2": "0x1C38FAE4", "chaps": "0x25BF1052", "gunbelts": "0x15AF5CC4", "neckties": "0x22D12FEF", "coats": "0", "beltbuckle": "0x139FCC19", "spurs": "0x123BDDCB", "ponchos": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(649, 356, 'Terrence McGinnis', 3, 25, 181, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "10200", "position": "[2725.816,-1235.418,50.364]", "stats": "[250,33.6,100,100]"}', '{"pedSize":1.05333,"features":"[-0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[1422840308,604645064,1773547611,1824319804,3065185688,null,587465329]","bodySize":128,"model":"mp_male"}', '{"access": "0", "beltbuckle": "0xA0649C75", "hat": "0x2542A345", "ponchos": "0", "cloaks": "0", "offhand": "0x25FD15CA", "masks": "0", "eyewear": "0", "neckties": "0", "pants": "0x58E11937", "gloves": "0", "belts": "0x34A718CD", "chaps": "0", "gunbelts": "0x10CD7D44", "shirts": "0x7A4F9D2B", "coats": "0", "suspenders": "0", "gauntlets": "0", "coats2": "0x1193B64F", "vests": "0x2A80328B", "spurs": "0", "boots": "0x151EAB71"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(650, 357, 'Junior Leblanc', 1, 32, 40, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[1424.317,-1479.34,74.916]", "stats": "[250,33.6,100,100]", "posse": "67"}', '{"pedSize":1.031998,"features":"[-0.4,-0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[3311355577,623103571,942003495,1694074219,642477207,null,555155903]","bodySize":128,"model":"mp_male"}', '{"ponchos": "0", "pants": "0x1D8ADDD1", "beltbuckle": "0", "hat": "0x1053D06F", "gloves": "0x1A2D8F40", "spurs": "0x142D2BE8", "shirts": "0x1D615E9", "coats": "0", "cloaks": "0", "boots": "0x119D4929", "coats2": "0x1DE62579", "chaps": "0", "masks": "0", "eyewear": "0x14F06EA7", "vests": "0", "gunbelts": "0x15AF5CC4", "belts": "0x131D437B", "neckties": "0x365956FF"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(651, 326, 'Joe Stark', 11, 25, 703, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "65700", "position": "[1464.897,-1798.449,55.302]", "stats": "[249,26.17,100,67]", "posse": "67"}', '{"pedSize":1.0,"features":"[0.3,0.0,-0.1,0.0,-0.8,0.0,0.0,0.0,-0.9,0.0,-0.9,-0.7,0.9,0.9,-0.7,-0.8,0.9,0.8,0.9,0.0,0.1,-0.2,0.0,-0.7,0.0,0.5,0.0,0.0,-0.3,0.0,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[1309745678,719802851,543187419,2226823945,1552505114,712446626,382614413]","bodySize":128,"model":"mp_male"}', '{"access": "0", "beltbuckle": "0x17B4FFBC", "hat": "0x28654956", "neckwear": "0x451F37BF", "chaps": "0", "offhand": "0", "vests": "0", "eyewear": "0x47AF47AC", "neckties": "0", "masks": "0", "pants": "0x2FB3C6E1", "gauntlets": "0", "gloves": "0x1A2D8F40", "belts": "0xCC933469", "ponchos": "0", "shirts": "0x339C7959", "coats": "0", "cloaks": "0", "boots": "0x38772DE7", "coats2": "0x1FB51BD6", "spurs": "0x1A7F9150", "suspenders": "0", "gunbelts": "0x2DF2E811", "bracelets": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(652, 359, 'Phellip Sanches', 8, 22, 446, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "37840", "position": "[1446.52,-1294.122,77.656]", "stats": "[250,33.6,100,100]", "posse": "67"}', '{"pedSize":1.037331,"bodySize":128,"modSkin":"[3620587182,34917246,1180660122,2539219498,3508160042,null,481122513]","features":"[0.0,0.0,0.0,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male"}', '{"hat": "0x1632867A", "ponchos": "0", "cloaks": "0", "vests": "0", "eyewear": "0x24FAF393", "neckties": "0x188D7769", "pants": "0x12D463B0", "bracelets": "0", "belts": "0x131D437B", "shirts": "0x1D615E9", "coats": "0", "masks": "0", "gauntlets": "0", "coats2": "0xD2FA7128", "boots": "0x189227AA", "chaps": "0", "gloves": "0x16DEB1F", "spurs": "0x19E1EC40", "suspenders": "0", "gunbelts": "0x1C04C393", "access": "0", "beltbuckle": "0x17B4FFBC"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(653, 362, 'Edgar Water ', 15, 28, 2216, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "324600", "position": "[1350.034,-1371.45,84.343]", "stats": "[248,30.51,100,86]", "posse": "74"}', '{"pedSize":1.05333,"features":"[0.1,0.2,-0.5,0.9,0.5,0.0,0.0,0.0,0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.4,-0.3,0.0,-0.7,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[1180513553,1037287971,1807137864,3550965899,3508160042,null,481122513]","bodySize":126,"model":"mp_male"}', '{"access": "0x790DCD14", "beltbuckle": "0x139FCC19", "hat": "0x1D5FD02D", "spurs": "0", "cloaks": "0", "offhand": "0", "masks": "0", "eyewear": "0x14F06EA7", "neckties": "0x3E56C2FB", "gunbelts": "0x319BEEC1", "pants": "0x19CB5254", "bracelets": "0", "gloves": "0x3033DA22", "chaps": "0", "gauntlets": "0", "shirts": "0x2CD2CB71", "coats": "0", "belts": "0x3F49FF1B", "boots": "0x6DF3526B", "coats2": "0", "ponchos": "0", "suspenders": "0", "vests": "0x55C80238", "neckwear": "0xB7D70F9B"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(654, 364, 'Mauricio Bielski', 2, 50, 108, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "25000", "position": "[2773.307,-1218.303,48.203]", "stats": "[242,25.87,100,66]"}', '{"bodySize":126,"model":"mp_male","pedSize":0.973335,"modSkin":"[1380493861,1120192881,1773547611,1824319804,3065185688,712446626,3783314784]","features":"[0.3,0.6,0.4,0.8,0.5,0.3,0.4,0.2,0.9,0.8,0.9,0.6,0.3,0.3,0.1,0.1,0.1,0.0,0.9,0.0,0.1,0.6,-0.9,0.2,0.2,0.8,0.9,-0.9,0.0,0.1,0.9,0.0,0.0,0.0,0.9,0.3,0.9,-0.8,-0.4]"}', '{"offhand": "0", "access": "0xECC2276D", "eyewear": "0xF193AFD2", "spurs": "0", "shirts": "0x3D931E28", "hat": "0xB70C089B", "ponchos": "0", "coats2": "0", "neckties": "0", "cloaks": "0", "suspenders": "0", "neckwear": "0xEF67FEBC", "boots": "0xF6D71DD4", "vests": "0", "belts": "0", "gauntlets": "0", "coats": "0", "pants": "0x1B9F91CD", "chaps": "0", "gunbelts": "0", "gloves": "0xFB267B57", "masks": "0", "beltbuckle": "0", "bracelets": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(655, 361, 'Eduardo Trevisan', 14, 18, 1334, '{}', 16, '{"hunger": "0", "thirst": "0", "banco": "171200", "position": "[1215.634,-1288.376,77.032]", "stats": "[208,33.6,100,100]", "posse": "67"}', '{"pedSize":1.0,"bodySize":128,"modSkin":"[3322561239,470018738,2966572863,181068809,1552505114,null,502538388]","features":"[-0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male"}', '{"access": "0", "beltbuckle": "0x48467EC9", "hat": "0", "spurs": "0x3BB959DE", "cloaks": "0", "offhand": "0x83A1891D", "vests": "0x59786AE7", "gunbelts": "0x620C1BC5", "chaps": "0", "neckties": "0", "gloves": "0", "pants": "0x5F622EED", "bracelets": "0", "belts": "0x3F49FF1B", "masks": "0", "suspenders": "0", "shirts": "0x581A73B0", "coats": "0", "eyewear": "0", "boots": "0x119D4929", "coats2": "0", "gauntlets": "0", "neckwear": "0x24F81EAB", "ponchos": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(656, 363, 'Tom Oliveira', 1, 20, 20, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[1368.591,-1314.665,77.255]", "stats": "[242,33.6,100,100]"}', '{"bodySize":126,"model":"mp_male","pedSize":1.079995,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[3620587182,1417979506,942003495,1694074219,642477207,null,3750146482]"}', '{"boots": "0x119D4929", "vests": "0x1525E68A", "shirts": "0x339C7959", "coats": "0", "pants": "0xAB17B6", "ponchos": "0", "coats2": "0x20ED22EA", "hat": "0xA09665BA", "cloaks": "0", "chaps": "0x6223576E"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(657, 360, 'Dark Carson', 1, 36, 40, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "47700", "position": "[1471.155,-921.165,51.893]", "stats": "[0,5.66,0,0]", "posse": "74"}', '{"pedSize":1.047997,"features":"[0.0,0.0,0.0,0.3,0.0,0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[913546243,436828730,1180660122,2539219498,null,null,354937489]","bodySize":128,"model":"mp_male"}', '{"shirts": "0x1F5FA114", "coats": "0", "pants": "0x2800212A", "coats2": "0x7E124755", "hat": "0x17812F51", "vests": "0x4B3BCE6E", "boots": "0x16BDB756", "neckwear": "0x163F4C6E", "bracelets": "0x2FDF6243", "access": "0x620114AF", "belts": "0x7B529F6", "suspenders": "0x1FBEDA10", "offhand": "0", "neckties": "0x2A8048AB", "gunbelts": "0x15AF5CC4"}', 1);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(658, 358, 'Jane Calamidade', 1, 35, 2, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2511.963,-1308.813,48.874]", "stats": "[250,33.6,100,100]"}', '{"pedSize":0.920005,"features":"[-0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.2,-0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[3333943798,294577146,736263364,736263364,2451302243,959712255]","bodySize":127,"model":"mp_female"}', '{"skirts": "0x117BBF76", "shirts": "0x1178F4F4", "hat": "0x1168422C", "boots": "0x134D7E03"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(659, 352, 'Daniel Pearson', 2, 22, 141, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "239040", "position": "[2704.581,-1406.112,46.937]", "stats": "[240,33.6,100,100]", "posse": "72"}', '{"pedSize":0.936004,"bodySize":126,"modSkin":"[1309745678,593266682,2966572863,181068809,2195072443,712446626,1658715876]","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male"}', '{"access": "0", "beltbuckle": "0xDDFA0489", "hat": "0x1D55D130", "spurs": "0", "chaps": "0", "offhand": "0xFE584139", "vests": "0", "gunbelts": "0x1CE0C5ED", "pants": "0x5151D24C", "belts": "0xF68F8A60", "neckwear": "0", "ponchos": "0", "shirts": "0", "coats": "0x105F0147", "suspenders": "0", "boots": "0x11044269", "coats2": "0", "gloves": "0xAF4E5181", "masks": "0", "eyewear": "0", "neckties": "0", "cloaks": "0x27502A24", "gauntlets": "0", "bracelets": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(660, 365, 'Jeremiah Brown', 1, 26, 56, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "117517", "position": "[1336.166,-1323.39,77.075]", "stats": "[146,11.2,100,0]"}', '{"pedSize":1.0,"modSkin":"[2696825467,68409628,1272509601,3837101269,1552505114,null,1121209784]","model":"mp_male","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":126}', '{"coats2": "0x2D5907E6", "boots": "0x24CBC01D", "cloaks": "0", "chaps": "0", "coats": "0", "vests": "0x4B3BCE6E", "gloves": "0x2D851A19", "shirts": "0x41AD431A", "pants": "0x33FE4F72", "eyewear": "0", "bracelets": "0", "neckwear": "0x288E2953", "spurs": "0x1A7F9150", "access": "0", "belts": "0", "offhand": "0", "beltbuckle": "0x18DB3EB3", "gunbelts": "0x1371FF7F", "hat": "0x342B7753"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(661, 366, 'charles vaqueiro', 2, 29, 146, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "268000", "position": "[2709.132,-1409.745,46.778]", "stats": "[20,11.2,21,0]"}', '{"pedSize":1.026665,"modSkin":"[1998225129,470018738,1660566152,1694074219,642477207,712446626,502538388]","model":"mp_male","features":"[0.0,0.1,-0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":128}', '{"shirts": "0x339C7959", "coats": "0", "vests": "0", "masks": "0", "cloaks": "0", "suspenders": "0x129DD6FD", "hat": "0x17812F51", "eyewear": "0x14F06EA7", "gloves": "0", "ponchos": "0", "beltbuckle": "0", "bracelets": "0", "spurs": "0", "belts": "0x34A718CD", "boots": "0x119D4929", "chaps": "0", "pants": "0x7011504B", "gauntlets": "0", "coats2": "0", "gunbelts": "0x29875F42"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(662, 244, 'Taita Inti', 12, 73, 938, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "39300", "position": "[272.844,1386.766,174.258]", "stats": "[250,33.6,100,100]"}', '{"pedSize":1.079995,"modSkin":"[2344699549,2778936412,1660566152,1694074219,612262189,712446626]","model":"mp_male","features":"[0.0,0.0,0.5,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.5,0.4,0.0,0.2,0.0,0.0,0.0,0.0,0.0,0.2,0.2,0.0,0.0,0.0,0.0,0.1,0.0,0.0,0.0,0.0,0.1,0.0,0.0,0.1,0.0]","bodySize":126}', '{"shirts": "0", "coats": "0x80D7252E", "vests": "0", "ponchos": "0", "coats2": "0", "pants": "0xD09CEA7C", "belts": "0x277A5E96", "hat": "0", "boots": "0x3420118", "bracelets": "0x5D60E31", "offhand": "0", "chaps": "0", "beltbuckle": "0", "gunbelts": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(663, 367, 'Robert Wayne', 2, 48, 108, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "138600", "position": "[1769.806,-535.055,42.226]", "stats": "[109,11.2,100,0]"}', '{"pedSize":0.989334,"model":"mp_male","modSkin":"[1587165517,740714047,543187419,2226823945,2195072443,null,306678665]","features":"[0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":126}', '{"coats2": "0", "boots": "0xB68DDDAC", "cloaks": "0x208DA39A", "chaps": "0", "coats": "0xAAAA303C", "shirts": "0", "vests": "0", "hat": "0x65BCB477", "ponchos": "0", "pants": "0x2324081D", "gauntlets": "0", "masks": "0", "offhand": "0", "suspenders": "0", "neckties": "0", "eyewear": "0xF3F08F5F", "gloves": "0x7B60D9EA", "beltbuckle": "0x4B046666", "bracelets": "0", "spurs": "0x390F2B71", "neckwear": "0xAA94BFB1", "belts": "0", "gunbelts": "0x1CE0C5ED", "access": "0x790DCD14"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(664, 367, 'Billy the Kid', 1, 36, 10, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2589.7,-449.49,42.407]", "stats": "[250,33.6,100,100]"}', '{"pedSize":1.05333,"model":"mp_male","modSkin":"[908431499,373001057,942003495,1694074219,2195072443,712446626,934537342]","features":"[-0.9,0.0,0.0,0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.9,0.0,0.0,-0.8,0.0,-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":128}', '{}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(665, 368, 'Magno Killer', 1, 20, 44, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2304.353,-1097.997,40.931]", "stats": "[236,31.41,100,90]"}', '{"pedSize":0.973335,"model":"mp_male","modSkin":"[2597378528,3013807717,1807137864,3550965899,3508160042,null,282054283]","features":"[0.0,0.9,0.2,0.0,0.0,0.0,0.0,0.0,0.4,0.0,0.0,0.0,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":126}', '{"coats2": "0x1DE62579", "eyewear": "0", "bracelets": "0", "cloaks": "0", "shirts": "0x15298CA8", "neckwear": "0x163F4C6E", "ponchos": "0", "spurs": "0x19E1EC40", "access": "0", "belts": "0", "gloves": "0", "suspenders": "0", "chaps": "0", "masks": "0", "gunbelts": "0x1CE0C5ED", "vests": "0x1ED62F2B", "neckties": "0", "boots": "0x30539D9C", "coats": "0", "beltbuckle": "0xF52F775C", "offhand": "0", "gauntlets": "0", "hat": "0x3AACDC80", "pants": "0x2800212A"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(666, 358, 'Jane Calamidade', 7, 35, 351, '{}', 16, '{"hunger": "0", "thirst": "0", "banco": "169000", "position": "[1367.197,-1310.544,77.869]", "stats": "[250,33.6,100,100]"}', '{"pedSize":0.920005,"model":"mp_female","modSkin":"[1974431363,2403638681,736263364,736263364,2451302243]","features":"[-0.2,0.0,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":127}', '{"shirts": "0x917F36B2", "pants": "0", "boots": "0x1D2C6CF0", "hat": "0x1B0F520E", "gloves": "0x378243F0", "gauntlets": "0", "bracelets": "0", "spurs": "0x64F812CE", "offhand": "0", "belts": "0", "eyewear": "0x28FCD709", "gunbelts": "0", "neckwear": "0", "beltbuckle": "0", "chaps": "0", "ponchos": "0", "access": "0x33D36086", "coats2": "0", "coats": "0", "suspenders": "0x82C27B38", "cloaks": "0", "neckties": "0xB393E04A", "vests": "0", "skirts": "0xDFA0DBC1", "masks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(667, 349, 'Willian Henry', 1, 22, 90, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "85400", "position": "[2748.896,-1394.375,46.183]", "stats": "[7,22.71,8,51]"}', '{"pedSize":1.0,"model":"mp_male","features":"[-0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[2534355977,1569400794,2362013313,3623045497,642477207,null,605652010]","bodySize":126}', '{"ponchos": "0", "beltbuckle": "0", "coats": "0x75ECA86B", "chaps": "0xAB54E997", "cloaks": "0", "boots": "0x2C066D38", "gunbelts": "0x1BD4BEC7", "gloves": "0", "gauntlets": "0", "spurs": "0x304FF460", "hat": "0x342B7753", "offhand": "0", "coats2": "0", "shirts": "0x215112", "access": "0x3B7F8161", "suspenders": "0", "pants": "0x8B4A5FD8"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(668, 315, 'Buffalo Bill de Jesus', 1, 22, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2241.166,-1354.803,45.285]", "stats": "[250,33.6,100,100]"}', '{"modSkin":"[1744812031,361562633,1660566152,1694074219,3508160042,null,4252816540]","model":"mp_male","bodySize":128,"features":"[0.5,0.0,-0.9,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":0.930671}', '{"shirts": "0x167D36E9", "gauntlets": "0", "vests": "0", "masks": "0", "offhand": "0x1105E694", "neckties": "0x3AD5725E", "hat": "0x166462F8", "eyewear": "0x3766BB7B", "gloves": "0", "ponchos": "0", "beltbuckle": "0x18DB3EB3", "bracelets": "0", "spurs": "0x123BDDCB", "boots": "0x1002199A", "chaps": "0", "coats": "0", "pants": "0x1D8ADDD1", "gunbelts": "0x2DF2E811", "coats2": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(669, 370, 'Gaguinho de Jesus', 1, 24, 10, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2748.453,-1407.449,46.009]", "stats": "[227,30.24,100,85]"}', '{"modSkin":"[1631383957,3984769894,2582128739,2539219498,1552505114,null,382614413]","bodySize":126,"model":"mp_male","features":"[-0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":0.94667}', '{"shirts": "0xF5FAD1D6", "gauntlets": "0", "vests": "0x1E442267", "masks": "0", "cloaks": "0", "offhand": "0", "suspenders": "0", "neckties": "0", "hat": "0x1632867A", "eyewear": "0", "gloves": "0x1A2D8F40", "ponchos": "0", "beltbuckle": "0x16E62CC9", "bracelets": "0", "gunbelts": "0x1F9ED1AA", "access": "0x4355B247", "belts": "0", "boots": "0x1470CE34", "spurs": "0", "chaps": "0", "neckwear": "0x1A098C50", "pants": "0x165A9CDF", "coats": "0", "coats2": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(670, 1, 'Thomas Mcfield', 14, 30, 1449, '{}', 9, '{"hunger": "0", "thirst": "0", "banco": "453000", "position": "[1308.412,-1300.684,76.151]", "stats": "[250,24.77,100,61]"}', '{"modSkin":"[3396185070,436828730,543187419,2226823945,642477207,null,481122513]","pedSize":1.015999,"model":"mp_male","bodySize":128,"features":"[0.0,0.2,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"chaps": "0", "cloaks": "0", "boots": "0xC430AF11", "coats2": "0xCAB6E0A9", "hat": "0x943609EF", "ponchos": "0", "pants": "0xE1B0ABFF", "vests": "0x381EF1D3", "shirts": "0x12801254", "coats": "0", "beltbuckle": "0x24914BD1", "neckties": "0x67B0CC14", "offhand": "0", "gauntlets": "0", "eyewear": "0", "suspenders": "0", "belts": "0", "spurs": "0x6DF05052", "gunbelts": "0x2DF2E811", "gloves": "0x24B7D363", "access": "0", "bracelets": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(671, 255, 'Darkness', 2, 18, 111, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "225660", "position": "[2722.777,-1252.692,49.834]", "stats": "[250,21.28,100,45]"}', '{"modSkin":"[2696825467,3853929319,543187419,2226823945,2501331517,null,2587879296]","pedSize":0.920005,"model":"mp_male","bodySize":127,"features":"[-0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"pants": "0x7AA50F12", "neckwear": "0", "masks": "0xC1BF5F41", "gloves": "0", "shirts": "0", "coats2": "0", "coats": "0", "cloaks": "0xFD04D28F", "ponchos": "0xE5BD82FE"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(672, 332, 'Joseph Calloway', 3, 36, 152, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "88262", "position": "[1842.381,-1619.266,45.682]", "stats": "[250,32.06,100,93]"}', '{"model":"mp_male","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":124,"modSkin":"[1077303312,576291658,1519555092,4045206010,612262189,null,382614413]","pedSize":1.037331}', '{"hat": "0xBB959BC0", "chaps": "0", "gauntlets": "0", "gunbelts": "0x620C1BC5", "neckwear": "0", "pants": "0x389AB19E", "gloves": "0x46CAD525", "neckties": "0", "shirts": "0x2EC3810A", "belts": "0", "access": "0x17920A1E", "vests": "0x59786AE7", "eyewear": "0x58B7F65D", "boots": "0x119D4929", "masks": "0", "offhand": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(673, 301, 'Henry Newton ', 6, 50, 330, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "72800", "position": "[2265.848,-1208.371,42.272]", "stats": "[250,33.6,100,100]"}', '{"model":"mp_male","features":"[0.2,0.0,0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":125,"modSkin":"[3396185070,680521583,543187419,2226823945,null,null,1376969807]","pedSize":1.05333}', '{"coats2": "0xC3ABD28B", "vests": "0x5BB21D42", "shirts": "0", "coats": "0", "chaps": "0", "gauntlets": "0", "pants": "0x291B0190", "gloves": "0x3033DA22", "access": "0", "gunbelts": "0x319BEEC1", "beltbuckle": "0", "suspenders": "0", "bracelets": "0", "spurs": "0x19E1EC40", "offhand": "0", "belts": "0", "boots": "0x31B8DCFF", "hat": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(674, 309, 'Fabio Velloso', 1, 28, 30, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2562.379,-1330.901,48.031]", "stats": "[250,33.6,100,100]"}', '{"modSkin":"[1209218150,3798985182,543187419,2226823945,3096645940,null,382614413]","model":"mp_male","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":1.0,"bodySize":126}', '{"gauntlets": "0", "coats": "0", "gloves": "0", "neckwear": "0", "hat": "0x17812F51", "suspenders": "0", "gunbelts": "0x153557", "boots": "0x192C2A4B", "beltbuckle": "0x24914BD1", "shirts": "0x28BBFD59", "coats2": "0", "bracelets": "0", "spurs": "0x1CA207BD", "pants": "0xACDC2408", "vests": "0x4B3BCE6E"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(675, 95, 'John Cooper', 3, 30, 190, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "10000", "position": "[1435.205,-1366.457,83.851]", "stats": "[248,11.2,100,0]"}', '{"modSkin":"[908431499,864946818,2196852103,2539219498,2739887825,null,1063184222]","model":"mp_male","pedSize":0.973335,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":128}', '{"hat": "0x8F0DC2A9", "shirts": "0x65C1B5F6", "vests": "0x794A2FAD", "gauntlets": "0", "boots": "0xD27A4BA4", "gunbelts": "0x1C04C393", "coats2": "0", "belts": "0x52808E9D", "coats": "0", "pants": "0x689F80EF", "neckties": "0x5D6A803E", "beltbuckle": "0x25409ADF"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(676, 64, 'Elé Junior', 7, 78, 385, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "126800", "position": "[1421.189,-1300.2,77.527]", "stats": "[200,33.6,50,100]", "posse": "61"}', '{"modSkin":"[1303185113,74351192,885240113,202858862,612262189,null,983283548]","model":"mp_male","features":"[-0.5,0.9,0.0,0.0,0.0,0.0,0.0,0.0,-0.7,0.0,0.0,0.0,0.0,0.0,0.0,-0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":0.930671,"bodySize":127}', '{"spurs": "0x123BDDCB", "boots": "0x11044269", "hat": "0x8B655559", "suspenders": "0x129DD6FD", "shirts": "0x325B2832", "gunbelts": "0x620C1BC5", "pants": "0x106E3B84", "eyewear": "0x111AFF82", "beltbuckle": "0", "coats": "0", "coats2": "0", "ponchos": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(677, 227, 'Eduardo Quintero', 1, 32, 34, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "1400", "position": "[2528.965,-1265.479,49.098]", "stats": "[190,11.2,100,0]"}', '{"features":"[0.0,0.0,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":1.026665,"model":"mp_male","modSkin":"[null,719802851,null,null,642477207,null,2339538374]","bodySize":128}', '{"chaps": "0", "suspenders": "0x20CD640F", "hat": "0x1751D32F", "spurs": "0x3B330A2A", "bracelets": "0", "access": "0", "offhand": "0", "gloves": "0", "boots": "0x7D14A592", "belts": "0x9698406C", "pants": "0xE1B0ABFF", "shirts": "0x92071A86", "gauntlets": "0", "gunbelts": "0x5261D9F3", "neckties": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(678, 369, 'Hanzo the Kid', 1, 20, 50, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "800", "position": "[1335.079,-1289.933,76.537]", "stats": "[168,33.6,100,100]"}', '{"features":"[0.0,0.0,-0.7,0.1,-0.2,-0.5,0.0,0.0,0.7,0.0,0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.2,-0.5,-0.1,0.4,-0.9,-0.5,0.0,-0.6,0.0,0.0,-0.7,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":0.94667,"model":"mp_male","modSkin":"[1861339516,517266857,1660566152,1694074219,612262189,null,1037532367]","bodySize":127}', '{"chaps": "0", "hat": "0x152C2017", "bracelets": "0", "boots": "0x192C2A4B", "vests": "0", "gauntlets": "0", "eyewear": "0", "neckties": "0", "beltbuckle": "0x16E62CC9", "offhand": "0x1184AC1D", "cloaks": "0", "belts": "0x2AD73F47", "suspenders": "0", "coats2": "0", "coats": "0xAAAA303C", "shirts": "0", "ponchos": "0", "access": "0x7241EEE5", "gunbelts": "0x620C1BC5", "pants": "0x10051C7"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(679, 340, 'William Ross', 1, 32, 30, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2844.919,-1218.734,47.576]", "stats": "[250,33.6,100,100]"}', '{"modSkin":"[1587165517,482292860,543187419,2226823945,2432743988,null,390637164]","pedSize":0.920005,"model":"mp_male","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":127}', '{"chaps": "0", "coats2": "0", "belts": "0", "pants": "0x1700ADD7", "eyewear": "0x5C35FD31", "neckties": "0", "beltbuckle": "0x18DB3EB3", "offhand": "0", "spurs": "0x1A7F9150", "cloaks": "0", "gloves": "0x1A4A7FF5", "suspenders": "0", "coats": "0xF9917354", "shirts": "0x10DA80F1", "masks": "0", "access": "0x29A9AE4D", "gunbelts": "0x1CE0C5ED", "boots": "0x11B7CAB1"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(680, 373, 'Daniel Clyde', 1, 22, 22, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[1378.367,-934.962,55.088]", "stats": "[250,11.2,100,0]"}', '{"pedSize":1.042664,"modSkin":"[2534355977,68409628,942003495,1694074219,1552505114,1629650936,502538388]","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.8,0.0,0.0,0.6,0.5,0.0,0.0,-0.1,-0.9,0.6,0.3,0.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male","bodySize":126}', '{"ponchos": "0", "chaps": "0", "vests": "0xE37E0D13", "boots": "0xF1C2F8AE", "pants": "0xE3CFC09B", "shirts": "0", "coats2": "0xDDC82DEA", "coats": "0", "hat": "0x12BD5208", "gauntlets": "0", "eyewear": "0", "cloaks": "0", "beltbuckle": "0", "access": "0", "spurs": "0x1EDE4AC0", "neckties": "0", "gunbelts": "0x319BEEC1", "suspenders": "0", "gloves": "0x1A2D8F40", "bracelets": "0", "belts": "0x102F20E6", "offhand": "0x36BB8305", "masks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(681, 372, 'Jimmy London', 2, 37, 120, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "12000", "position": "[1341.576,-1244.068,78.791]", "stats": "[250,33.6,100,100]"}', '{"model":"mp_male","features":"[0.0,0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[2702657477,2425969086,543187419,2226823945,2452638665,null,1713580799]","bodySize":125,"pedSize":1.074662}', '{"coats2": "0", "coats": "0", "access": "0xBA33FEC8", "cloaks": "0", "bracelets": "0", "pants": "0x21FCD89B", "gloves": "0", "boots": "0x847234D2", "gauntlets": "0", "shirts": "0x6E4D22C1", "hat": "0", "ponchos": "0", "chaps": "0", "neckwear": "0", "masks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(682, 335, 'Athena Dubar', 1, 21, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2630.834,-1293.583,52.1]", "stats": "[249,33.6,100,100]"}', '{"model":"mp_female","features":"[-0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[2864896169,1771180828,1218117202,1218117202,3450854762]","bodySize":128,"pedSize":0.94667}', '{"coats2": "0x3DF55092", "coats": "0", "suspenders": "0x20C7CD2D", "gunbelts": "0x17B87F05", "ponchos": "0", "bracelets": "0", "hat": "0x32B80F05", "boots": "0xDDE974F3", "vests": "0xD7A1EF1D", "access": "0", "chaps": "0", "neckwear": "0xE09D458F", "offhand": "0", "cloaks": "0", "skirts": "0", "beltbuckle": "0", "pants": "0xDD77F38E", "neckties": "0x9DD9B4D6", "masks": "0", "belts": "0x1287221A", "gloves": "0xF15A70F5", "spurs": "0x1468A6E1", "shirts": "0x1C604777"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(683, 113, 'Vinicius Dorn Dubar', 1, 25, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2589.998,-458.961,42.462]", "stats": "[250,33.6,100,100]"}', '{"model":"mp_male","features":"[0.0,0.6,0.0,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[1998225129,576291658,543187419,2226823945,2452638665,712446626,3169600415]","bodySize":127,"pedSize":1.0}', '{}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(684, 374, 'Flor De Maria ', 5, 33, 283, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "24900", "position": "[1402.034,-1282.405,78.176]", "stats": "[5,16.89,2,25]"}', '{"model":"CS_TILLY","features":"[0.1,0.8,0.0,0.4,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.6,0.4,0.3,0.0,0.3,0.1,0.0,0.0,0.6,0.8,-0.2,0.6,-0.8,-0.3,0.1,-0.4,-0.6,0.3,0.0,0.1,0.1,0.0,0.6,0.0,0.0,0.0,0.0,0.0]","modSkin":"[1595484788,617200186,2475843490,2475843490,2451302243,1255518018]","bodySize":127,"pedSize":1.079995}', '{"coats2": "0", "coats": "0", "suspenders": "0", "offhand": "0", "ponchos": "0", "bracelets": "0", "hat": "0x28A8201F", "boots": "0x442C5B73", "gauntlets": "0", "neckwear": "0", "cloaks": "0", "skirts": "0xB66165F0", "masks": "0", "beltbuckle": "0xE0D49C43", "neckties": "0", "gunbelts": "0x100A188C", "eyewear": "0", "pants": "0", "shirts": "0x15A72A5", "gloves": "0", "access": "0", "chaps": "0", "belts": "0x103F75E6", "vests": "0", "spurs": "0x1096E1E4", "Outfit": "9"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(685, 375, 'Clay Jackoville', 4, 37, 210, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "151299", "position": "[-1807.33,-383.625,161.26]", "stats": "[250,24.74,100,89]"}', '{"model":"mp_male","features":"[0.1,0.9,0.9,0.0,0.0,0.3,0.2,0.0,0.9,0.9,0.0,0.0,0.9,0.9,0.9,0.9,0.0,0.9,0.9,0.0,0.0,0.0,-0.1,-0.1,0.2,0.0,0.7,0.0,-0.9,0.6,0.0,0.0,0.0,0.0,0.5,0.0,0.0,0.5,0.0]","modSkin":"[2640330835,686464008,942003495,1694074219,46507404,1629650936,502538388]","bodySize":126,"pedSize":0.94667}', '{"hat": "0x748886BE", "shirts": "0x339C7959", "coats2": "0xEF0E7141", "coats": "0", "access": "0xECC2276D", "chaps": "0x946FA489", "neckwear": "0x1C990028", "cloaks": "0", "suspenders": "0", "pants": "0x5F622EED", "bracelets": "0", "vests": "0xFA736FA9", "gloves": "0x46CAD525", "ponchos": "0x4B71D26B", "boots": "0x4D0FC31D", "gunbelts": "0x29875F42", "gauntlets": "0xB2303767", "beltbuckle": "0x17B4FFBC", "offhand": "0xEB0ADC25"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(686, 237, 'Cletus Kasady', 1, 45, 25, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "52300", "position": "[2642.169,-1296.016,52.252]", "stats": "[250,33.6,100,100]"}', '{"model":"mp_male","pedSize":1.005333,"bodySize":126,"modSkin":"[2230576261,3536417625,543187419,2226823945,642477207,null,2110468749]","features":"[0.0,0.0,0.0,0.0,0.9,0.0,0.9,0.9,-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"pants": "0x1D8ADDD1", "shirts": "0xF30B082", "coats2": "0", "vests": "0xDA8F269E", "coats": "0", "ponchos": "0", "suspenders": "0", "boots": "0x192C2A4B", "neckties": "0xEEF0AB1B", "belts": "0xCB1596B4", "cloaks": "0", "gunbelts": "0x15AF5CC4", "spurs": "0xF30441AF", "hat": "0x267E3453", "eyewear": "0xF3F08F5F", "bracelets": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(687, 376, 'Sarah Cooper', 1, 20, 10, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "11000", "position": "[1427.661,-1373.948,81.754]", "stats": "[177,29.8,100,83]"}', '{"model":"mp_female","pedSize":0.920005,"bodySize":127,"modSkin":"[2864896169,1320043540,1218117202,1218117202,1647937151,959712255]","features":"[0.0,0.0,-0.1,-0.9,-0.1,0.2,0.2,0.0,0.0,0.0,0.0,0.3,0.1,0.0,0.2,-0.5,0.0,0.3,0.2,0.0,-0.4,-0.2,0.0,0.0,0.6,0.9,0.5,0.0,0.0,0.9,0.8,0.0,0.0,0.0,0.5,0.0,0.3,0.5,0.0]"}', '{"chaps": "0", "gauntlets": "0", "boots": "0xB0CE90E", "neckties": "0", "cloaks": "0", "gloves": "0x3F1D5D03", "skirts": "0", "coats2": "0xF34D9B76", "access": "0xA0708B2B", "spurs": "0x4C118E0F", "suspenders": "0", "ponchos": "0", "eyewear": "0", "masks": "0", "offhand": "0", "hat": "0x1B0F520E", "neckwear": "0x268143A1", "pants": "0x303461A0", "vests": "0", "coats": "0", "shirts": "0x2CBEFF81", "bracelets": "0", "belts": "0x214BD73B", "beltbuckle": "0x124F10EC", "gunbelts": "0x100A188C"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(688, 377, 'Jin Morgan', 1, 57, 50, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[1357.359,-1307.706,77.652]", "stats": "[250,11.2,100,0]"}', '{"model":"mp_male","pedSize":0.920005,"bodySize":127,"modSkin":"[1209218150,429332843,543187419,2226823945,612262189,null,3101964980]","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"ponchos": "0", "hat": "0x6B62E5C5", "vests": "0x59786AE7", "boots": "0x192C2A4B", "pants": "0x12D463B0", "coats": "0", "coats2": "0x1DE62579", "cloaks": "0", "shirts": "0x2037C6AB", "chaps": "0", "suspenders": "0", "neckties": "0", "access": "0x965A7D5D", "spurs": "0", "gunbelts": "0x2FDA7221", "neckwear": "0x1B63F371", "gloves": "0x2B8130D7", "eyewear": "0", "beltbuckle": "0x1B301155", "masks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(689, 378, 'Raquel', 1, 18, 10, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[1320.259,-1319.074,76.852]", "stats": "[250,33.1,100,100]"}', '{"modSkin":"[1200388119,55480155,1218117202,1218117202,928002221]","pedSize":0.920005,"model":"mp_female","features":"[0.8,0.5,0.5,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":126}', '{"vests": "0", "shirts": "0x3EC8D9CF", "neckwear": "0", "boots": "0x46A41032", "masks": "0", "pants": "0", "coats2": "0", "gloves": "0", "eyewear": "0", "skirts": "0xC009D906", "ponchos": "0", "coats": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(690, 378, 'Rachel Cocaine', 5, 18, 272, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "26780", "position": "[1409.497,-1302.073,77.704]", "stats": "[2,33.6,2,100]"}', '{"model":"CS_KAREN","pedSize":0.930671,"features":"[0.0,0.4,0.3,-0.5,0.0,0.0,0.0,0.0,0.4,0.4,0.2,-0.9,0.8,0.0,-0.3,-0.4,0.0,0.0,0.7,0.0,0.0,-0.2,0.0,0.0,-0.9,0.0,0.0,0.0,0.0,-0.5,0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[1200388119,3632881362,3251571649,3251571649,928002221,959712255,0]","bodySize":126}', '{"eyewear": "0", "vests": "0", "belts": "0", "shirts": "0x8B68B568", "gauntlets": "0", "pants": "0x2FD8A5A9", "coats": "0", "coats2": "0", "neckwear": "0x1E462649", "ponchos": "0", "access": "0", "gunbelts": "0", "cloaks": "0", "skirts": "0", "boots": "0x16644E3C", "spurs": "0", "chaps": "0", "gloves": "0", "bracelets": "0", "masks": "0", "hat": "0x2F77CC70", "Outfit": "3"}', 1);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(691, 379, 'Lampião Vaquejada', 11, 5, 741, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0.000000000000007105427357601002", "position": "[652.772,-1243.963,43.295]", "stats": "[250,11.2,100,0]"}', '{"model":"CS_JACKMARSTON","pedSize":1.0,"modSkin":"[]","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"Outfit": "1"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(692, 379, 'Anne White', 1, 20, 90, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "849", "position": "[2331.517,-1138.074,45.492]", "stats": "[250,33.6,100,100]"}', '{"modSkin":"[196967420,91425386,1218117202,1218117202,1647937151]","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_female","bodySize":127,"pedSize":1.0}', '{"eyewear": "0", "coats": "0", "coats2": "0xEB109047", "boots": "0x16BF0A", "access": "0", "pants": "0x46390E3D", "shirts": "0x24643C10", "suspenders": "0", "neckwear": "0", "skirts": "0xFE90F64E"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(693, 380, 'Magnolia Cheeks', 1, 20, 67, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "32000", "position": "[2637.049,-1224.873,53.3]", "stats": "[221,33.6,100,100]"}', '{"modSkin":"[2864896169,1438066731,743432389,743432389,2489772761]","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":0.920005,"bodySize":127,"model":"mp_female"}', '{"coats": "0", "coats2": "0", "ponchos": "0", "cloaks": "0", "hat": "0", "shirts": "0x311EA4D9", "vests": "0", "beltbuckle": "0", "suspenders": "0x26780573", "gunbelts": "0", "eyewear": "0", "neckwear": "0x2EB3DF9D", "gloves": "0", "boots": "0x134D7E03", "masks": "0", "chaps": "0", "skirts": "0x5A4458B2", "access": "0", "pants": "0x1FBCC141", "bracelets": "0", "gauntlets": "0", "belts": "0x214BD73B", "neckties": "0x292EC858"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(694, 80, 'Jhony Carson', 1, 32, 70, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[1353.726,-1244.786,84.59]", "stats": "[1,10.58,1,0]"}', '{"modSkin":"[519165173,557173395,885240113,202858862,1552505114,712446626,39295965]","features":"[-0.7,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","pedSize":0.920005,"bodySize":127,"model":"mp_male"}', '{"hat": "0x9FD5D3CB", "coats2": "0xCAB6E0A9", "coats": "0", "boots": "0x20D85860", "pants": "0xED01EF60", "shirts": "0xFCA7C563", "vests": "0xED0D599", "beltbuckle": "0x24914BD1", "gunbelts": "0x5261D9F3", "eyewear": "0x3BA1A0E0", "neckties": "0", "gloves": "0x1D319438", "ponchos": "0", "cloaks": "0", "spurs": "0x3BB959DE", "belts": "0", "access": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(695, 382, 'Raimunda de Jesus', 6, 23, 340, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "66600", "position": "[2139.715,-641.608,42.645]", "stats": "[250,11.2,100,0]", "posse": "73"}', '{"features":"[0.9,0.9,0.6,0.1,-0.7,0.0,-0.9,-0.4,-0.9,-0.9,0.7,0.8,0.0,0.0,0.5,0.0,0.8,0.8,-0.4,0.2,-0.3,0.1,-0.2,-0.9,-0.3,0.8,0.0,-0.2,-0.8,0.8,0.9,0.0,0.0,0.9,0.8,0.3,0.9,0.9,0.7]","modSkin":"[1705365104,3632881362,186465082,186465082,2489772761,959712255]","model":"mp_female","pedSize":1.0,"bodySize":128}', '{"vests": "0", "gloves": "0", "neckwear": "0xE3266E3C", "gauntlets": "0", "offhand": "0", "pants": "0x2C620A03", "belts": "0", "eyewear": "0xC01A70AF", "shirts": "0x4CD925AB", "boots": "0x229E9FD4", "beltbuckle": "0", "masks": "0", "access": "0x6A4EF7FF", "coats": "0", "spurs": "0", "cloaks": "0", "hat": "0x1992EAFC", "neckties": "0", "coats2": "0x3DF55092", "ponchos": "0", "gunbelts": "0x21DDD4C2", "skirts": "0", "suspenders": "0x26780573", "bracelets": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(696, 381, 'Bozena Trambique', 6, 26, 325, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "79900", "position": "[2734.521,-1391.274,46.145]", "stats": "[250,33.6,100,100]", "posse": "73"}', '{"bodySize":126,"modSkin":"[1705365104,96809980,2458758467,2458758467,869083847,959712255]","pedSize":1.010666,"model":"mp_female","features":"[-0.5,-0.1,0.1,-0.8,-0.9,-0.9,-0.5,0.0,0.0,-0.6,-0.6,-0.9,0.0,-0.1,-0.8,0.1,-0.3,0.5,-0.7,-0.3,-0.4,0.2,-0.5,-0.5,-0.4,0.9,0.0,0.0,-0.8,-0.2,0.3,0.0,-0.6,0.8,0.0,0.0,-0.8,0.9,0.8]"}', '{"spurs": "0x5746DC8D", "chaps": "0", "gloves": "0x3F1D5D03", "neckwear": "0x956F06C4", "bracelets": "0", "gauntlets": "0", "offhand": "0", "skirts": "0", "belts": "0x4B5C2B53", "eyewear": "0", "shirts": "0", "boots": "0x416BDD3B", "beltbuckle": "0x2F5F76FE", "hat": "0x6A4A8F7F", "vests": "0", "coats2": "0", "neckties": "0x581EA961", "access": "0", "gunbelts": "0x293B4AEA", "pants": "0x5BE4B990", "cloaks": "0", "masks": "0", "ponchos": "0", "coats": "0x1454CD05", "suspenders": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(697, 384, 'Frank Roberts', 1, 29, 92, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "5000", "position": "[2208.021,-1346.473,45.311]", "stats": "[250,16.14,100,22]"}', '{"features":"[0.0,0.3,0.0,0.8,0.9,0.5,0.7,0.7,0.0,0.8,0.0,0.0,0.9,-0.9,0.2,0.7,0.3,0.0,0.8,0.0,0.0,0.1,-0.9,-0.4,0.4,-0.5,0.2,0.2,-0.9,0.1,0.0,0.2,0.6,-0.5,0.0,0.4,-0.7,0.0,0.0]","model":"mp_male","bodySize":128,"modSkin":"[2063814808,867224239,1257168263,3623045497,2432743988,1629650936,661022885]","pedSize":1.0}', '{"gunbelts": "0x29875F42", "spurs": "0x5DA17495", "coats2": "0x7E124755", "gloves": "0", "access": "0", "pants": "0x58584555", "coats": "0", "bracelets": "0", "masks": "0", "beltbuckle": "0x19E1847B", "neckties": "0x6B2CC0A9", "vests": "0", "ponchos": "0", "offhand": "0", "boots": "0x115D47FD", "chaps": "0", "hat": "0x1E55488E", "suspenders": "0", "gauntlets": "0", "belts": "0x34A718CD", "shirts": "0x8B648137", "eyewear": "0", "cloaks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(698, 383, 'Dolores Dormenny', 5, 45, 276, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "6800", "position": "[-245.861,794.497,120.214]", "stats": "[95,16.28,96,29]"}', '{"features":"[-0.9,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.6,-0.6,-0.9,0.0,0.0,0.7,0.8,0.0,0.1,0.0,0.0,0.0,0.0,-0.5,0.7,0.0,-0.2,0.0,0.2,0.0,0.9,0.0,0.0,0.8,0.0,0.0,0.0,0.0,0.0]","model":"mp_female","bodySize":126,"pedSize":1.010666,"modSkin":"[3333943798,3312528563,186465082,186465082,2489772761,959712255,0]"}', '{"vests": "0", "chaps": "0", "hat": "0x44EC6D5D", "skirts": "0", "boots": "0x19ADA9E", "coats": "0", "cloaks": "0", "shirts": "0xDBF627DD", "coats2": "0x11F694A8", "ponchos": "0", "gunbelts": "0x100A188C", "neckties": "0x5357F0B8", "gauntlets": "0", "gloves": "0x7AF0186A", "access": "0", "spurs": "0", "offhand": "0", "bracelets": "0", "neckwear": "0", "suspenders": "0", "masks": "0", "belts": "0x103F75E6", "beltbuckle": "0", "eyewear": "0x19C16BCF", "pants": "0x11FE25C4"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(699, 385, 'Daniella Wyatt', 10, 28, 609, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "26600", "position": "[1295.627,-1294.117,76.995]", "stats": "[250,33.6,100,100]"}', '{"features":"[0.0,0.0,0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_female","bodySize":126,"pedSize":0.962669,"modSkin":"[1705365104,2403638681,736263364,736263364,928002221]"}', '{"shirts": "0x2D63CE34", "pants": "0xDB35BE8C", "coats": "0", "hat": "0", "coats2": "0", "boots": "0x4B98F195", "vests": "0x97CFFF00", "gauntlets": "0", "belts": "0", "gloves": "0x7AF0186A", "beltbuckle": "0", "chaps": "0", "cloaks": "0", "spurs": "0", "offhand": "0", "gunbelts": "0x4D2686CA"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(700, 386, 'Jesse White', 1, 36, 75, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[1729.156,-1446.406,45.713]", "stats": "[250,33.6,100,100]"}', '{"model":"mp_male","modSkin":"[1209218150,465258498,1180660122,2539219498,3065185688,null,59227358]","pedSize":0.952003,"bodySize":127,"features":"[0.0,0.9,0.7,-0.2,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.5,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.5,0.0,0.0]"}', '{"boots": "0x11B7CAB1", "eyewear": "0x1A5EDE5B", "cloaks": "0", "hat": "0x12BD5208", "coats2": "0x1A84E2DB", "shirts": "0x1D615E9", "pants": "0x1D8ADDD1", "coats": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(701, 386, 'Jesse White', 1, 36, 30, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "7000", "position": "[2408.042,-1132.706,46.759]", "stats": "[152,29.56,100,82]"}', '{"features":"[0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[908431499,539445454,1519555092,4045206010,2432743988,null,306678665]","pedSize":0.952003,"bodySize":127,"model":"mp_male"}', '{"cloaks": "0", "coats2": "0", "ponchos": "0", "shirts": "0x3FFA5077", "coats": "0x75610E42", "hat": "0x2DDE7A0D", "vests": "0", "boots": "0x11B7CAB1", "pants": "0x291B0190", "chaps": "0", "eyewear": "0x3766BB7B", "spurs": "0x123BDDCB", "gloves": "0x17241F4", "gunbelts": "0", "access": "0", "neckwear": "0x163F4C6E", "masks": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(702, 197, 'Django Kimber', 1, 18, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2589.559,-452.215,42.374]", "stats": "[250,33.6,100,100]"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[1497781045,604645064,885240113,202858862,null,null,382614413]","pedSize":1.079995,"bodySize":128,"model":"mp_male"}', '{}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(703, 371, 'Josimar Braz', 3, 37, 154, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "3868", "position": "[1682.045,-710.557,41.511]", "stats": "[242,0.0,100,0]"}', '{"modSkin":"[853589349,604645064,2358675144,3096952736,3065185688,null,1244870786]","bodySize":126,"model":"mp_male","pedSize":1.063996,"features":"[0.5,0.4,0.3,0.0,0.1,0.0,0.0,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"cloaks": "0", "pants": "0x19CB5254", "gauntlets": "0", "coats2": "0", "offhand": "0", "coats": "0", "boots": "0x5D8BB19C", "spurs": "0x19E1EC40", "shirts": "0x2CD2CB71", "vests": "0x55C80238", "belts": "0x102F20E6", "ponchos": "0", "suspenders": "0", "beltbuckle": "0x16E62CC9", "hat": "0x1D5FD02D", "gunbelts": "0x620C1BC5", "eyewear": "0x9A1DFEE", "gloves": "0x3033DA22", "neckwear": "0xB7D70F9B"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(704, 387, 'Bob Alfred Woody', 1, 23, 20, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2634.026,-1299.68,51.787]", "stats": "[238,24.08,100,58]"}', '{"modSkin":"[1209218150,429332843,3126420045,2328978452,642477207,null,382614413]","bodySize":128,"model":"mp_male","pedSize":1.0,"features":"[-0.1,0.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,0.9,0.0,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"shirts": "0x1D615E9", "hat": "0x10106532", "vests": "0x7D275A2B", "pants": "0xBB2DF633", "coats2": "0", "coats": "0", "ponchos": "0", "masks": "0", "access": "0x847E935E", "gloves": "0x51B81B7B", "gauntlets": "0", "chaps": "0", "neckties": "0", "belts": "0", "eyewear": "0", "bracelets": "0", "suspenders": "0", "spurs": "0x453858E9", "boots": "0x5E79E5E1", "offhand": "0xA2C40A12", "neckwear": "0x14757301", "cloaks": "0", "gunbelts": "0x1CE0C5ED", "beltbuckle": "0x3A7A3B79"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(705, 389, 'Waya Akecheta', 1, 23, 89, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "4000", "position": "[2384.557,-1129.269,46.601]", "stats": "[250,33.6,100,100]"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.3,0.0,-0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.1,0.0,-0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[1106971106,464056288,62321923,3550965899,null,null,0]","pedSize":0.920005,"model":"mp_male","bodySize":126}', '{"shirts": "0x486BA2FB", "coats": "0", "cloaks": "0", "pants": "0x6DADEFD6", "boots": "0x10E40F4E", "hat": "0x28654956", "ponchos": "0x8E7E5481", "coats2": "0", "vests": "0", "belts": "0x3F49FF1B", "beltbuckle": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(706, 205, 'Irineu', 1, 29, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2518.0,-1314.802,48.925]", "stats": "[250,33.6,100,100]"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[1901130586,4199650471,1210379577,3723790941,642477207,null,282054283]","pedSize":0.989334,"model":"mp_male","bodySize":128}', '{"shirts": "0xEBFFEA3D", "hat": "0", "pants": "0x50F58641", "boots": "0x11044269", "gloves": "0x1A2D8F40", "eyewear": "0x1A5EDE5B", "vests": "0x1525E68A", "suspenders": "0x129DD6FD", "masks": "0", "gunbelts": "0x1371FF7F"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(707, 388, 'Greta Estrela Rica', 5, 26, 255, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "17600", "position": "[1410.446,-1301.781,77.784]", "stats": "[67,16.21,56,22]"}', '{"features":"[0.0,0.9,0.0,0.0,0.0,0.0,0.0,0.0,-0.6,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.4,0.2,0.0,0.0,0.0,0.0]","modSkin":"[2864896169,480662374,1218117202,1218117202,869083847,959712255]","pedSize":1.079995,"model":"mp_female","bodySize":128}', '{"shirts": "0x22A938BF", "coats": "0", "skirts": "0", "bracelets": "0", "spurs": "0x15E49D13", "belts": "0x8CD573EE", "pants": "0x2A69176A", "gauntlets": "0", "vests": "0", "eyewear": "0", "hat": "0x3AF49B35", "coats2": "0", "chaps": "0", "boots": "0x19E17B75", "gunbelts": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(708, 390, 'Joana Mitrigo', 2, 23, 125, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "31500", "position": "[1326.734,-1302.929,76.448]", "stats": "[250,20.93,100,43]"}', '{"features":"[0.0,0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.1,0.0,0.0,0.9,0.0,0.0,0.0,0.0,0.9,0.0,0.0,0.9,0.0]","modSkin":"[1139837702,473172620,3227133357,3227133357,3450854762,959712255]","pedSize":1.079995,"model":"mp_female","bodySize":127}', '{"coats2": "0x248DFE12", "coats": "0", "hat": "0x1168422C", "shirts": "0x135C16AC", "vests": "0", "ponchos": "0", "boots": "0x16BF0A", "pants": "0x1FBCC141", "gloves": "0x378243F0", "neckwear": "0xBE38BB72", "gunbelts": "0x46E3478E"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(709, 333, 'Bob Henry', 4, 45, 210, '{}', 8, '{"hunger": "0", "thirst": "0", "banco": "44400", "position": "[1375.9,-1320.049,77.381]", "stats": "[250,26.06,100,66]"}', '{"features":"[0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[2696825467,557173395,543187419,2226823945,1552505114,null,518502517]","pedSize":1.079995,"model":"mp_male","bodySize":126}', '{"coats2": "0xCAB6E0A9", "hat": "0x2490B32C", "beltbuckle": "0x24914BD1", "pants": "0xE1B0ABFF", "boots": "0xC430AF11", "coats": "0", "shirts": "0x12801254", "neckties": "0x67B0CC14", "vests": "0x381EF1D3"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(710, 85, 'Michael Bandit', 4, 32, 204, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "4300", "position": "[-1116.182,-543.504,83.928]", "stats": "[69,14.64,70,15]"}', '{"features":"[0.0,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[2702657477,1025183400,null,null,642477207,null,146025810]","pedSize":1.079995,"model":"mp_male","bodySize":128}', '{"coats2": "0", "hat": "0x9488C5B1", "beltbuckle": "0", "coats": "0", "access": "0x6599ED2", "belts": "0x3F49FF1B", "pants": "0xF294D831", "neckties": "0", "gloves": "0xE5F9A5C9", "vests": "0", "boots": "0x38772DE7", "gunbelts": "0x10CD7D44", "neckwear": "0x36DE44AB", "shirts": "0x89EC3C64", "offhand": "0x25FD15CA", "chaps": "0", "spurs": "0x8C76008", "suspenders": "0x3BDE2985", "bracelets": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(711, 391, 'Maria Trabuco', 4, 42, 205, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "29600", "position": "[1332.421,-1372.848,80.49]", "stats": "[250,24.19,100,58]"}', '{"pedSize":0.920005,"modSkin":"[2864001924,1237816835,1218117202,1218117202,869083847,null,0]","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","bodySize":126,"model":"mp_female"}', '{"offhand": "0", "vests": "0", "pants": "0x46390E3D", "ponchos": "0", "access": "0x383DDE91", "gloves": "0x3F1D5D03", "bracelets": "0", "coats": "0", "gunbelts": "0", "spurs": "0", "cloaks": "0", "coats2": "0xA199EA7A", "gauntlets": "0", "chaps": "0", "masks": "0", "boots": "0x4B516716", "beltbuckle": "0", "hat": "0", "skirts": "0", "eyewear": "0x40E33A12", "suspenders": "0", "shirts": "0xD588EF6E", "neckwear": "0x34F6F862", "neckties": "0", "belts": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(712, 392, 'Hannah Montanha', 5, 56, 290, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "20850", "position": "[2654.279,-930.419,42.771]", "stats": "[99,11.2,100,0]"}', '{"model":"CS_ABIGAILROBERTS","pedSize":1.0,"modSkin":"[]","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"Outfit": "95"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(713, 394, 'Sabrynna Bee Victoria ', 1, 35, 10, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2492.299,-1144.291,49.307]", "stats": "[95,5.31,96,0]"}', '{"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[888933139,494012117,900188667,900188667,869083847]","pedSize":0.920005,"model":"mp_female"}', '{"coats": "0", "coats2": "0", "chaps": "0", "boots": "0x139F347E", "masks": "0", "neckwear": "0x122A8031", "cloaks": "0", "hat": "0x1B0F520E", "shirts": "0x1A8CE361", "gloves": "0x3F1D5D03", "pants": "0xFE6E5D64", "skirts": "0x117BBF76"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(714, 395, 'Cece Drake', 1, 37, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2541.89,-364.201,41.613]", "stats": "[250,33.6,100,100]"}', '{"model":"mp_female","pedSize":1.0,"features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[379295174,null,923281039,923281039]"}', '{}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(715, 395, 'Cece Drake', 1, 37, 20, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2732.472,-1384.754,46.217]", "stats": "[250,28.39,100,77]"}', '{"pedSize":1.079995,"bodySize":126,"modSkin":"[2605439820,740194192,2475843490,2475843490,2451302243,959712255]","features":"[0.0,0.0,0.1,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.4,0.0,0.0,0.0,0.0,0.0,0.0,-0.1,0.0,0.0]","model":"mp_female"}', '{"boots": "0x448E7C18", "vests": "0", "ponchos": "0", "coats2": "0", "pants": "0x11FE25C4", "chaps": "0", "coats": "0x12F06E5", "skirts": "0", "cloaks": "0x1AD0CDE3", "hat": "0x280DB3A0", "shirts": "0x312FAE50"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(716, 323, 'Gregor Rabbit', 2, 34, 133, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "7200", "position": "[1422.435,-1302.155,77.656]", "stats": "[223,31.46,100,90]"}', '{"pedSize":1.031998,"bodySize":125,"modSkin":"[908431499,373664797,1519555092,4045206010,46507404,null,3388554110]","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_male"}', '{"access": "0x13F53A09", "coats2": "0x1DE62579", "gunbelts": "0x620C1BC5", "beltbuckle": "0x353C3AD6", "belts": "0", "chaps": "0", "shirts": "0x1D615E9", "boots": "0x195A47E0", "vests": "0x246900C9", "ponchos": "0", "spurs": "0x19E1EC40", "pants": "0x3C9ADC2", "gloves": "0x1A2D8F40", "neckwear": "0", "coats": "0", "cloaks": "0", "hat": "0x17812F51", "offhand": "0x1184AC1D"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(717, 350, 'Tina Vandergeld', 1, 25, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[1341.539,-1273.158,78.248]", "stats": "[65,17.79,66,29]"}', '{"pedSize":0.952003,"features":"[-0.8,-0.7,0.0,0.0,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.6,0.0,0.1]","modSkin":"[1200388119,494012117,1679300899,1679300899,1647937151]","bodySize":127,"model":"mp_female"}', '{"boots": "0x141281DC", "belts": "0x1287221A", "pants": "0x21CCB93E", "gunbelts": "0x293B4AEA", "hat": "0x3C0F3E38", "shirts": "0x6450F253", "cloaks": "0x17DDAAAE"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(718, 51, 'EDIGAR SALAZAR', 1, 22, 10, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[-581.606,-1288.026,40.145]", "stats": "[250,30.95,100,100]"}', '{"pedSize":1.0,"features":"[0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.8,-0.1,0.0,0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[1757924776,436828730,1660566152,1694074219,642477207,null,382614413]","bodySize":128,"model":"mp_male"}', '{"boots": "0x192C2A4B", "access": "0", "pants": "0x262B1D80", "coats2": "0x26A3702F", "spurs": "0x1EDE4AC0", "suspenders": "0x1FBEDA10", "gunbelts": "0x1371FF7F", "beltbuckle": "0x16BBC668", "belts": "0x295A6FF5", "eyewear": "0x14F06EA7", "neckwear": "0x164C04CF", "coats": "0", "cloaks": "0", "hat": "0x12BD5208", "shirts": "0x18015DB4"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(719, 93, 'Eustácio Zeppellin', 2, 58, 103, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "31414", "position": "[1353.881,-1379.784,84.361]", "stats": "[164,33.6,100,100]"}', '{"pedSize":1.026665,"bodySize":124,"modSkin":"[913546243,3319269342,543187419,2226823945,1552505114,712446626,2834932461]","features":"[0.5,0.4,0.4,0.6,0.0,0.0,0.3,0.2,0.1,0.2,0.1,-0.5,0.5,0.3,-0.6,0.3,0.6,0.3,0.4,0.0,0.0,0.0,0.0,0.1,0.2,-0.3,0.3,0.0,0.2,0.7,0.0,0.2,0.2,0.1,0.2,0.9,0.2,0.2,0.9]","model":"mp_male"}', '{"boots": "0x8FFD8459", "access": "0", "spurs": "0x3BB959DE", "pants": "0x1ED336A1", "gunbelts": "0x620C1BC5", "beltbuckle": "0", "belts": "0", "chaps": "0", "gloves": "0", "vests": "0", "eyewear": "0x25C51838", "hat": "0xBB959BC0", "shirts": "0x10DA80F1"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(720, 397, 'Julia Belmont', 4, 20, 234, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "20800", "position": "[1428.74,-1321.239,78.397]", "stats": "[241,12.09,100,4]"}', '{"model":"CS_ABIGAILROBERTS","pedSize":1.0,"modSkin":"[]","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]"}', '{"Outfit": "6"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(721, 398, 'Clay Wolf', 1, 35, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2526.949,-1307.46,49.181]", "stats": "[250,11.2,100,0]"}', '{"bodySize":128,"pedSize":1.026665,"model":"mp_male","features":"[0.5,0.0,0.1,0.0,0.7,0.3,0.3,0.2,0.4,0.5,0.3,0.5,0.2,0.1,0.3,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[2078925650,723076113,543187419,2226823945,642477207,null,1625991163]"}', '{}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(722, 396, 'Judith Bixotte', 6, 21, 318, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "11100", "position": "[660.855,-1256.746,43.759]", "stats": "[215,11.2,100,0]"}', '{"bodySize":125,"pedSize":1.079995,"features":"[0.9,0.0,0.0,-0.1,0.9,0.3,0.3,0.0,0.0,0.0,0.0,-0.1,-0.6,0.4,0.7,0.6,0.0,0.9,-0.1,0.3,0.0,0.9,-0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","model":"mp_female","modSkin":"[3557218953,1091490859,1218117202,1218117202,2489772761]"}', '{"coats2": "0", "masks": "0", "access": "0x2594C409", "chaps": "0", "suspenders": "0", "gauntlets": "0", "neckties": "0", "hat": "0x180A055D", "eyewear": "0", "gloves": "0x54323070", "shirts": "0x26379D95", "spurs": "0", "coats": "0", "boots": "0x139F347E", "beltbuckle": "0", "neckwear": "0x183AA714", "bracelets": "0", "gunbelts": "0", "skirts": "0x265AF0E0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(723, 393, 'Robson Tyler', 1, 23, 0, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2535.206,-1256.696,49.166]", "stats": "[250,33.6,100,100]"}', '{"bodySize":128,"pedSize":0.920005,"model":"mp_male","features":"[0.0,0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.9,-0.5,0.0,0.0,0.0,0.0,0.0,-0.9,0.0,-0.9,0.4,0.0,0.0,0.0,0.1,0.0,0.0,0.0,-0.7,0.0,0.0,-0.8,0.0,0.0]","modSkin":"[908431499,470018738,942003495,1694074219,1552505114,712446626,0]"}', '{"hat": "0x158C36FC", "pants": "0x10051C7", "coats2": "0x16D8F2FF", "shirts": "0x1281AB3F", "boots": "0x1F76387A", "vests": "0", "cloaks": "0", "coats": "0", "ponchos": "0", "access": "0", "gloves": "0", "belts": "0", "gauntlets": "0", "neckties": "0", "eyewear": "0", "offhand": "0", "suspenders": "0", "spurs": "0", "beltbuckle": "0x10443A0F", "gunbelts": "0x1371FF7F"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(724, 399, 'Peter Sanchez', 2, 30, 132, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[2942.84,583.969,44.463]", "stats": "[193,30.8,100,88]"}', '{"bodySize":126,"pedSize":1.005333,"model":"mp_male","features":"[0.0,0.9,0.0,0.9,-0.1,0.0,0.5,-0.2,0.0,-0.2,0.0,-0.5,0.9,0.3,-0.2,0.3,0.4,0.0,0.2,0.0,0.0,0.0,-0.2,0.0,0.0,0.0,0.0,0.0,0.0,0.4,0.9,0.0,0.0,0.0,0.0,0.0,0.0,0.5,0.0]","modSkin":"[2344699549,555297777,2362013313,3623045497,46507404,712446626,1389714514]"}', '{"hat": "0xB72204C6", "pants": "0x664430DA", "coats2": "0xAA997C94", "shirts": "0xF25E9B82", "boots": "0x35C87ED", "vests": "0", "cloaks": "0", "ponchos": "0", "coats": "0", "chaps": "0", "gauntlets": "0", "masks": "0", "belts": "0", "gloves": "0", "beltbuckle": "0"}', 0);
INSERT IGNORE INTO `characters` (`charid`, `user_id`, `characterName`, `level`, `age`, `xp`, `wanted`, `groups`, `charTable`, `SkinMdf`, `clothes`, `is_dead`) VALUES
	(725, 400, 'Joanne Jonsson', 1, 18, 10, '{}', 0, '{"hunger": "0", "thirst": "0", "banco": "0", "position": "[1400.704,-1318.218,77.557]", "stats": "[235,11.2,100,0]"}', '{"bodySize":127,"pedSize":0.936004,"model":"mp_female","features":"[0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.9,0.0,0.0,0.0,0.0,-0.8,0.0,0.0,0.0,0.0,0.0,0.0,0.0,-0.4,0.0,0.0,0.0,0.0,0.0,-0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0]","modSkin":"[2864896169,1141776368,736263364,736263364,928002221,959712255]"}', '{"coats": "0", "hat": "0x3AF49B35", "gloves": "0x378243F0", "pants": "0", "coats2": "0", "shirts": "0x118B1F87", "skirts": "0x86DB506", "chaps": "0", "eyewear": "0", "boots": "0x27C604C3", "vests": "0", "belts": "0x103F75E6", "bracelets": "0", "ponchos": "0", "cloaks": "0x244DC38E", "access": "0", "suspenders": "0"}', 0);
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
/*!40000 ALTER TABLE `chests` ENABLE KEYS */;

-- Copiando estrutura para tabela redm.farms
CREATE TABLE IF NOT EXISTS `farms` (
  `crop_id` varchar(100) DEFAULT NULL,
  `slot_id` smallint(6) DEFAULT NULL,
  `crop_percent_grown` tinyint(4) DEFAULT 0,
  `crop_min_time_water` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela redm.farms: ~162 rows (aproximadamente)
/*!40000 ALTER TABLE `farms` DISABLE KEYS */;
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('corn', 449, 33, 1587838184);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('corn', 403, 0, 1587840965);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('corn', 404, 0, 1587840970);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('corn', 402, 0, 1587840974);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('corn', 405, 0, 1587840977);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('corn', 401, 0, 1587840987);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('corn', 400, 0, 1587840994);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('corn', 406, 0, 1587841004);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 131, 0, 1592170201);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 129, 0, 1592170220);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 128, 0, 1592170235);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 127, 0, 1592170253);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 126, 0, 1592170279);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 125, 0, 1592170296);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 124, 0, 1592170317);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 123, 0, 1592170333);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 122, 0, 1592170351);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 121, 0, 1592170368);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 137, 0, 1592171022);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 73, 0, 1592171056);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 76, 0, 1592171078);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 28, 0, 1592171094);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 30, 0, 1592171115);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 71, 0, 1592317539);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 588, 0, 1592759124);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 587, 0, 1592759141);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 586, 0, 1592759152);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 585, 0, 1592759159);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 583, 0, 1592759166);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 582, 0, 1592759172);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 581, 0, 1592759178);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 580, 0, 1592759185);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 579, 0, 1592759191);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 578, 0, 1592759197);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 577, 0, 1592759203);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 576, 0, 1592759210);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 575, 0, 1592759217);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 574, 0, 1592759225);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 573, 0, 1592759231);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 572, 0, 1592759237);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 571, 0, 1592759246);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 569, 0, 1592759254);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 570, 0, 1592759259);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 568, 0, 1592759265);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 567, 0, 1592759274);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 566, 0, 1592759282);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 565, 0, 1592759291);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 564, 0, 1592759300);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 563, 0, 1592759308);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 562, 0, 1592759316);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 559, 0, 1592759323);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 558, 0, 1592759331);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 557, 0, 1592759338);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 556, 0, 1592759347);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 555, 0, 1592759355);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 554, 0, 1592759363);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 553, 0, 1592759370);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 552, 0, 1592759380);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 551, 0, 1592759387);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 550, 0, 1592759396);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 549, 0, 1592759404);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 548, 0, 1592759415);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 546, 0, 1592759423);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 545, 0, 1592759431);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 544, 0, 1592759439);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 543, 0, 1592759446);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 542, 0, 1592759454);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 541, 0, 1592759463);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 540, 0, 1592759471);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 539, 0, 1592759482);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 538, 0, 1592759490);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 537, 0, 1592759498);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 536, 0, 1592759506);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 535, 0, 1592759514);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 1, 0, 1593151613);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 2, 0, 1593151629);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 3, 0, 1593151673);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 42, 0, 1593151702);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 41, 0, 1593151743);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 40, 0, 1593151781);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 127, 0, 1593151791);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 128, 0, 1593151810);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 39, 0, 1593151821);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 129, 0, 1593151835);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 38, 33, 1593153420);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 37, 0, 1593151865);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 130, 0, 1593151878);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 4, 0, 1593151889);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 131, 0, 1593151900);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 5, 0, 1593151927);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 168, 0, 1593151962);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 84, 0, 1593151971);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 167, 0, 1593151986);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 83, 0, 1593151992);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 166, 0, 1593152007);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 82, 0, 1593152011);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 165, 0, 1593152025);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 81, 0, 1593152030);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 164, 0, 1593152045);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 80, 0, 1593152055);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 163, 0, 1593152071);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 79, 0, 1593152076);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 162, 0, 1593152090);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 85, 0, 1593152104);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 161, 0, 1593152110);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 86, 0, 1593152122);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 160, 0, 1593152130);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 87, 0, 1593152140);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 170, 33, 1593153698);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 88, 33, 1593153836);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 169, 0, 1593152221);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 89, 0, 1593152230);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 171, 0, 1593152245);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 90, 0, 1593152248);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 172, 0, 1593152265);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 210, 0, 1593152299);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 209, 0, 1593152318);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 273, 0, 1593152519);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 272, 0, 1593152555);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 274, 0, 1593152578);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 252, 0, 1593152628);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 251, 0, 1593152652);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 275, 0, 1593152672);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 271, 0, 1593152751);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 197, 0, 1593152848);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 198, 0, 1593152891);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 276, 0, 1593152902);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 250, 0, 1593152936);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 196, 0, 1593152952);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 249, 0, 1593152973);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 195, 0, 1593152991);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 270, 0, 1593153005);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 269, 0, 1593153136);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 248, 0, 1593153178);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 315, 0, 1593153216);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 314, 0, 1593153248);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 313, 0, 1593153285);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('corn', 20, 0, 1593153368);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('corn', 105, 0, 1593153377);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('corn', 21, 33, 1593154412);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('corn', 104, 0, 1593153400);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('corn', 103, 33, 1593154449);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('corn', 102, 33, 1593154511);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('corn', 101, 33, 1593154541);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 511, 33, 1593154726);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 247, 0, 1593153688);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 512, 0, 1593153701);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 268, 0, 1593153742);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 408, 0, 1593153793);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 246, 0, 1593153805);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('tobacco', 407, 0, 1593153828);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 267, 0, 1593153835);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 22, 0, 1593205521);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 23, 0, 1593205561);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 24, 0, 1593205591);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 25, 0, 1593205633);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 26, 0, 1593205663);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 27, 0, 1593205698);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 28, 0, 1593205736);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 29, 0, 1593205768);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 30, 0, 1593205798);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('sugarcane', 31, 0, 1593205830);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('corn', 610, 0, 1593205947);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('corn', 611, 0, 1593205966);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('corn', 612, 0, 1593206018);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('corn', 613, 0, 1593206048);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('corn', 614, 0, 1593206080);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('corn', 615, 0, 1593206107);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('corn', 616, 0, 1593206138);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('corn', 617, 0, 1593206170);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('corn', 618, 0, 1593206202);
INSERT IGNORE INTO `farms` (`crop_id`, `slot_id`, `crop_percent_grown`, `crop_min_time_water`) VALUES
	('corn', 619, 0, 1593206239);
/*!40000 ALTER TABLE `farms` ENABLE KEYS */;

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
	(1, 'Mercer', 0);
INSERT IGNORE INTO `fort` (`id`, `nome`, `bando`) VALUES
	(2, 'Wallace', 0);
/*!40000 ALTER TABLE `fort` ENABLE KEYS */;

-- Copiando estrutura para procedure redm.getData
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `getData`(
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
) ENGINE=InnoDB AUTO_INCREMENT=686 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.horses: ~228 rows (aproximadamente)
/*!40000 ALTER TABLE `horses` DISABLE KEYS */;
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(24, 265, 'A_C_Horse_Arabian_White', 'Booster', '["0x306806F","0x19C5E80C","0x75178DD2",null,"0x241D7FBD","0x30603BB5",0,"0x45FEA6D8"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(25, 283, 'A_C_Horse_Turkoman_Gold', 'tuco', '["0x306806F","0xDC87A9F","0xBDF19F85","0xF8FB69CA","0x3A7C2C86","0x33E7B1CB","0xE1B1B8F1","0x9FD99D7D"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(27, 336, 'A_C_Horse_Morgan_Palomino', 'Jon Salvador', '["0xF2F0045","0x19C5E80C","0xD8AE54FE","0xF8FB69CA",0,null,"0xF826E4EB","0xD258EF10"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(28, 247, 'A_C_Horse_Arabian_White', 'Mel', '["0x522CCED",0,"0x75178DD2","0xC05AA4AA","0x235DBF1","0x17EB79D3","0x333CDC06","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(29, 328, 'A_C_Horse_Arabian_White', 'Booster', '["0xE5B31D9F",0,"0xD8AE54FE","0xB4F40DD9","0x5ED14B9F",0,"0x107D9598","0x27543EBB"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(31, 279, 'A_C_Horse_Arabian_White', 'White Angel', '["0xE5510BB8","0x823A602A","0x587DD49F",0,"0x41EA9196","0x30603BB5","0x9AD2AA40","0x1B43F045"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(32, 244, 'A_C_Horse_Arabian_White', 'Florbela', '["0x7A23C686","0xA3D5298D","0x8D0BC7DA","0xE4108D59","0xAA3FAC1A","0xA62C9657","0xE1DC3856","0x69B21ADD"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(33, 256, 'A_C_Horse_Arabian_White', 'CavaloSemNome', '["0x5BBC54C3","0xFDF4250B","0xD8AE54FE","0x1D4EDB88","0x2E378E8A","0x1BB5EAA1","0x9AD2AA40","0x36BEDD90"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(34, 261, 'A_C_Horse_Arabian_White', 'Essência', '["0xE5510BB8","0x7951D487","0xD8AE54FE","0xE57042B4","0x41EA9196","0x1F7A99EA","0xE1DC3856","0x8C9F7709"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(35, 257, 'A_C_Horse_Arabian_White', 'Jurandir', '["0xC0C04297","0xFDF4250B",null,null,null,null,null,"0xD258EF10"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(36, 270, 'A_C_Horse_Arabian_White', 'Espirito Branco', '["0x189F7005","0x4BF1F80F","0x587DD49F",null,"0x14098229","0x12DBBBAF","0x333CDC06","0xBC664014"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(37, 260, 'A_C_Horse_Arabian_White', 'Toco', '["0x14168240","0x20D4A0BF",null,null,null,null,"0x2A28C8BE"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(38, 375, 'A_C_Horse_Arabian_White', 'Cavalo Skyline', '["0x7A23C686","0x5F0F9E4A","0xD8AE54FE","0xC05AA4AA","0xAA3FAC1A","0xA62C9657","0xED0BCEB5","0x9FD99D7D"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(40, 339, 'A_C_Horse_Arabian_White', 'Jack Daniels', '["0x15FB6791",0,"0xE73FF221","0xE4108D59",null,null,"0x107D9598","0x12F0DF9F"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(41, 193, 'A_C_Horse_Arabian_White', 'Gayzin', '["0x2F8C7941","0x5894FB24","0x9EE8E174","0xF8FB69CA",null,null,"0xF8CAE723"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(42, 311, 'A_C_Horse_Thoroughbred_DappleGrey', 'Lapantino', '["0x7092A211","0x5F0F9E4A","0xD8AE54FE","0xAE110017","0x130E341A",0,"0xE1B1B8F1","0x7B55D476"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(43, 301, 'A_C_Horse_Arabian_White', 'Romanov', '["0xD6BF27E1","0x6B2084E5","0x587DD49F","0x20AA8620","0x1FDC6D0F","0xB4AB3354","0xF09C56EE","0x84E5AFA"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(44, 303, 'A_C_Horse_Morgan_Palomino', 'Morgado', '["0xF2F0045","0xAD283105",null,"0xF8FB69CA","0x235DBF1","0x3D212D77","0xE1DC3856","0x1B43F045"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(45, 320, 'A_C_Horse_Shire_LightGrey', 'Thor', '["0x7092A211","0x3D34F3","0xBDF19F85","0xE2ADE94C","0x235DBF1","0x17EB79D3","0x3E40711D","0xD258EF10"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(47, 275, 'A_C_Horse_AmericanStandardbred_Buckskin', 'Frog', '["0x14168240","0x127E0412","0x8D0BC7DA","0x1D4EDB88","0x16923E26","0x17EB79D3","0x2A28C8BE","0x12F0DF9F"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(48, 355, 'A_C_HORSE_MORGAN_FLAXENCHESTNUT', 'Coyote\n', '["0x14168240","0x20D4A0BF","0x3B3AB08","0x20AA8620","0x14098229","0x1A3B721B","0x2A28C8BE","0x12F0DF9F"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(49, 252, 'A_C_Horse_Arabian_White', 'Nifertari', '["0x2F8C7941","0x5F0F9E4A","0x3B3AB08","0xC019F804",0,"0x1F7A99EA","0x3E40711D","0x1B43F045"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(50, 248, 'A_C_Horse_Appaloosa_Leopard', 'Raio', '["0xE5510BB8","0x41D52CD8","0xBDF19F85",null,null,null,0]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(51, 318, 'A_C_Horse_AmericanStandardbred_Buckskin', 'BillyJag', '["0x5D717C9","0xB19B4519","0xE73FF221","0x8BE10F93","0x354F6B7","0xB4AB3354","0x9AD2AA40","0x55A0E4FE"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(53, 394, 'A_C_Horse_AmericanStandardbred_Buckskin', 'TORRESMO', '["0x306806F",null,null,"0xC05AA4AA",null,"0x17EB79D3"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(54, 326, 'A_C_Horse_Thoroughbred_DappleGrey', 'Pangare', '["0xE039FC0F","0x127E0412",0,"0xE893DFD","0x14098229","0x1A3B721B","0x2A28C8BE","0x73D157B4"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(56, 280, 'A_C_Horse_Arabian_White', 'Franco', '["0x522CCED","0xEDCB3D78","0x75178DD2","0xF8FB69CA","0x2D47B5FD","0x49CD2991","0xED0BCEB5","0x84E5AFA"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(58, 359, 'A_C_Horse_Shire_LightGrey', 'Zacatraz', '["0x24F24446","0x41D52CD8","0xD8AE54FE","0xB4F40DD9","0x41EA9196","0xF867D611","0x9AD2AA40","0x7B55D476"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(59, 240, 'A_C_Horse_Thoroughbred_DappleGrey', 'Signorelli', '["0x8DD09A7C","0x5F0F9E4A","0xD8AE54FE",null,null,null,"0x34135CC3"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(62, 323, 'A_C_HORSE_MORGAN_FLAXENCHESTNUT', 'Qubeque', '["0xD11CBF82","0xFFB1DE72","0x75178DD2","0xC05AA4AA","0x1A5A45B6","0x1A3B721B","0x34135CC3","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(63, 321, 'A_C_Horse_KentuckySaddle_Grey', 'Braunhe BOY\n', '["0x335DC49F","0x4BF1F80F","0xE73FF221","0x1D4EDB88","0x130E341A","0xEAEAB164","0x2A28C8BE","0x27543EBB"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(64, 264, 'A_C_Horse_Turkoman_Gold', 'Golden Bar', '["0xBFD09512",0,0,0,"0x54A3CB0","0xF6B0AB06",null,0]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(65, 246, 'A_C_Horse_Andalusian_DarkBay', 'negão', '["0xC76C46D9","0x41D52CD8","0xE73FF221","0x1D4EDB88","0x388E4B32","0x1A3B721B","0x9AD2AA40","0x84E5AFA"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(66, 358, 'A_C_Horse_Andalusian_Perlino', 'Odin', '["0xD7FC86BF","0x4655E362",null,"0x20AA8620"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(67, 345, 'A_C_Horse_Arabian_White', 'Cavalo', '{}');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(68, 372, 'A_C_Horse_Nokota_ReverseDappleRoan', 'Barão', '["0xE36C8274",null,null,null,"0x3BFE2A17","0x2E753874",null,"0x72FCB059"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(70, 334, 'A_C_Horse_Andalusian_DarkBay', 'Quindão', '["0x5BBC54C3","0x342916F3","0x75178DD2","0xC05AA4AA","0x3F1FEE4C",0,"0xE1DC3856","0xAC1F34C"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(71, 204, 'A_C_Horse_Andalusian_DarkBay', 'asta', '["0x1D0BF8F2","0x20D4A0BF",null,"0x1D4EDB88","0x235DBF1","0x1A3B721B",0,"0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(72, 387, 'A_C_Horse_Andalusian_DarkBay', 'Pé pano', '["0x106961A8","0xA3D5298D",0,"0x1D4EDB88",null,null,0]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(74, 414, 'A_C_Horse_Andalusian_DarkBay', 'Dalila', '["0xF1BAA60D","0xFFB1DE72","0xD8AE54FE","0x293E17B3","0xFC74DF3B","0x17EB79D3","0xDBE6AC3B","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(75, 403, 'A_C_HORSE_MORGAN_FLAXENCHESTNUT', 'caraclho', '["0x150D0DAA","0x2286EE30","0x3B3AB08","0x20AA8620","0x14098229","0x1A3B721B","0x2A28C8BE","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(76, 439, 'A_C_Horse_Thoroughbred_DappleGrey', 'Branquinha', '["0x14168240","0x342916F3","0x587DD49F","0x577EF434","0x25627B98","0x1A3B721B","0x107D9598","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(77, 243, 'A_C_Horse_Arabian_White', 'Zeus', '["0x306806F","0x508B80B9","0xE73FF221",null,"0x54A3CB0",0,"0xED0BCEB5","0x12F0DF9F"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(78, 354, 'A_C_Horse_Andalusian_Perlino', 'Luffy', '["0x306806F",0,"0x8246282F","0xC05AA4AA","0x512377B","0x1A3B721B","0x9AD2AA40",0]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(80, 455, 'A_C_Horse_Andalusian_DarkBay', 'Spartano', '["0x106961A8","0xEBB4B70D","0x8246282F","0x293E17B3","0x130E341A","0xEFA67855",0,"0xD8258E14"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(81, 349, 'A_C_Horse_KentuckySaddle_Grey', 'Bala', '["0x2BEA8ED4","0x3BA0D76D","0x587DD49F","0x293E17B3","0x388E4B32","0x3D1F13D4","0xED0BCEB5","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(82, 445, 'A_C_Horse_KentuckySaddle_Grey', 'Zoro', '["0x2ECD9E70","0x41D52CD8"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(83, 386, 'A_C_Horse_Andalusian_DarkBay', 'chibata', '["0x106961A8","0x3BA0D76D","0xE73FF221","0x577EF434","0x25627B98",null,"0xE1B1B8F1","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(84, 471, 'A_C_Horse_Andalusian_DarkBay', 'thor', '["0x106961A8","0xFAE487F","0x75178DD2","0xC05AA4AA","0x130E341A","0x30603BB5","0xF09C56EE"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(85, 396, 'A_C_Horse_AmericanStandardbred_Buckskin', 'Enzo', '["0xCE8C2F22","0xFA1153C6","0x67AF7302",null,"0x130E341A",null,"0xED0BCEB5","0x84E5AFA"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(86, 245, 'A_C_Horse_Morgan_Palomino', 'Joe', '["0x1EE21489","0xC097E12C","0x9EE8E174","0xC05AA4AA","0x9836E71","0x383E86F3","0x333CDC06","0x9FD99D7D"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(88, 419, 'A_C_Horse_Arabian_White', 'Booster', '["0x219D85E2","0x41D52CD8",0,0,"0x1DF21752","0xE38F5D96",0,0]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(90, 442, 'A_C_Horse_KentuckySaddle_Grey', 'IronSide', '["0xBC52F5E6","0x67CAAF37","0x8D0BC7DA","0xF8FB69CA","0x235DBF1","0x2E753874","0x34135CC3","0x27543EBB"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(91, 440, 'A_C_HORSE_MORGAN_FLAXENCHESTNUT', 'Burns', '["0xD61B2996","0xD333865B","0x3B3AB08","0xB4F40DD9","0x14098229",null,0,"0xB4532FEE"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(92, 460, 'A_C_Horse_Andalusian_DarkBay', 'Shimmer', '["0x20359E53","0xFAE487F","0xD8AE54FE","0x1D4EDB88"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(93, 477, 'A_C_Horse_AmericanStandardbred_Buckskin', 'Bala', '["0xE5510BB8","0x2A6D33E8","0xE73FF221","0xC05AA4AA","0x5F0395A3","0x1F7A99EA","0x333CDC06","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(94, 494, 'A_C_HORSE_MORGAN_FLAXENCHESTNUT', 'Fungo', '["0x1D0BF8F2","0x41D52CD8","0xBDF19F85","0xD048C482","0x1FDC6D0F","0x1BB5EAA1","0xDBE6AC3B","0x55A0E4FE"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(96, 446, 'A_C_Horse_AmericanPaint_Tobiano', 'dreher', '["0x5D717C9","0x4A294AF1","0x67AF7302","0xF8FB69CA","0x1FDC6D0F","0x1A3B721B","0x9AD2AA40","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(98, 490, 'A_C_Horse_Thoroughbred_DappleGrey', 'bela', '["0x9533FA8E","0xD9E17DBB","0x8246282F","0x2AEFF6CA","0x16923E26",null,"0x3E40711D","0x1B43F045"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(99, 454, 'A_C_Horse_Shire_LightGrey', 'Bombado', '["0x219D85E2",null,"0x587DD49F","0x5277E9BA",null,null,"0x3E40711D"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(100, 462, 'A_C_Horse_AmericanPaint_Tobiano', 'Faisca', '["0xA1154105","0x823A602A","0x3B3AB08","0xC019F804","0x1DF21752",null,"0x2A28C8BE","0xD258EF10"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(102, 498, 'A_C_Horse_Belgian_MealyChestnut', 'MAFARRICO', '["0x306806F","0x20D4A0BF","0x75178DD2","0xF8FB69CA","0x1A5A45B6","0x12DBBBAF","0x9AD2AA40","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(103, 478, 'A_C_Horse_Andalusian_Perlino', 'Plotka', '["0xF1BAA60D","0x508B80B9","0x75178DD2","0xE57042B4","0x41EA9196","0x66C266F",0,"0x45FEA6D8"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(104, 249, 'A_C_Horse_Belgian_MealyChestnut', 'Sleipnir', '["0x189F7005","0x127E0412",null,"0x293E17B3","0x419D9470",0,0,"0x12F0DF9F"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(105, 507, 'A_C_Horse_Shire_LightGrey', 'Dakota', '["0xBFD09512","0xFDF4250B","0xCB9A3AD6","0xD048C482","0x1DF21752","0x1F7A99EA",0,"0x8DD7B735"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(106, 392, 'A_C_Horse_AmericanStandardbred_Buckskin', 'CóCó', '["0x14168240","0x41D52CD8","0x75178DD2","0x2AEFF6CA","0x14098229","0x1A3B721B","0x9AD2AA40","0x1B43F045"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(107, 504, 'A_C_Horse_Andalusian_DarkBay', 'Black', '["0x106961A8","0x5894FB24","0x587DD49F","0xC05AA4AA","0xB13D134B","0x4124CC49","0x3E40711D","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(108, 481, 'A_C_Horse_Andalusian_DarkBay', 'Polimante', '["0x2ECD9E70","0x2286EE30","0x75178DD2","0xD048C482","0x354F6B7",null,"0x333CDC06","0x1B43F045"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(109, 447, 'A_C_Horse_Shire_LightGrey', 'carpeado', '["0x6C622F8C",null,null,null,"0x419D9470"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(110, 505, 'A_C_Horse_Shire_LightGrey', 'Orelhas', '["0x93B7057","0x3278996D","0x8D0BC7DA","0xE4108D59","0xB881489D","0xC2FA4FF2","0x333CDC06","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(111, 512, 'A_C_Horse_Andalusian_DarkBay', 'Soberano', '["0xE5510BB8","0x127E0412",null,"0xE4108D59","0x130E341A","0x17EB79D3","0xDBE6AC3B","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(113, 452, 'A_C_Horse_Andalusian_Perlino', 'Belmiro', '["0x7092A211","0xC4C732B2","0xE73FF221","0x5277E9BA","0xF304C014","0x84D6B90","0xDBE6AC3B","0x9D868568"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(114, 508, 'A_C_Horse_Belgian_BlondChestnut', 'Feijao\n', '["0x306806F","0x2286EE30","0x75178DD2","0xC05AA4AA","0x41EA9196","0x1F7A99EA","0x333CDC06","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(115, 497, 'A_C_Horse_SuffolkPunch_RedChestnut', 'Taishu', '["0x64CEC6DF","0xEBB4B70D","0xD8AE54FE","0xC05AA4AA","0x5F0395A3",0,"0x34135CC3","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(116, 467, 'A_C_HORSE_MORGAN_FLAXENCHESTNUT', 'Alazão', '["0x150D0DAA","0xAD283105","0x9EE8E174","0x577EF434","0x1DF21752","0x3AE050B5",0,"0x27543EBB"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(117, 470, 'A_C_HORSE_MORGAN_FLAXENCHESTNUT', 'Jose', '["0x24F24446","0xBBF05395","0xBDF19F85","0xC019F804","0x1DF21752","0x25B51566","0x3E40711D","0x55A0E4FE"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(120, 484, 'A_C_Horse_Shire_LightGrey', 'Iron', '["0x8DD09A7C","0xCDD2FB96","0xE73FF221",null,null,"0x1F7A99EA","0x333CDC06"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(122, 515, 'A_C_Horse_AmericanStandardbred_Buckskin', 'Chapo\n', '["0x150D0DAA","0x2A6D33E8","0x67AF7302","0x1D4EDB88","0x1FDC6D0F","0x1BB5EAA1","0x2A28C8BE","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(123, 520, 'A_C_Horse_Shire_LightGrey', 'Zeca', '["0x1C14443F","0x3BA0D76D","0x67AF7302","0x5277E9BA","0x1A5A45B6","0x33E7B1CB","0x34135CC3","0x1B43F045"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(124, 409, 'A_C_Horse_Turkoman_Gold', 'Hércules', '["0xDE5A2905","0xC097E12C",0,"0xF8FB69CA","0xD4E65BE5","0xA62C9657","0xED0BCEB5","0x9FD99D7D"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(126, 530, 'A_C_Horse_Andalusian_DarkBay', 'Smoke', '["0xF2F0045",null,0]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(127, 535, 'A_C_Horse_Morgan_Palomino', 'Pangare', '["0x1D0BF8F2","0x3278996D",null,"0xB4F40DD9","0x241D7FBD","0x30603BB5",null,"0x55A0E4FE"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(129, 509, 'A_C_HORSE_MORGAN_FLAXENCHESTNUT', 'BIUTODEHORSE', '["0x1C14443F","0x20D4A0BF","0x8246282F","0xB4F40DD9","0x5445B9C0",0,0,0]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(130, 531, 'A_C_Horse_AmericanPaint_Tobiano', 'Sopro d\'estrelas', '["0x189F7005","0x2286EE30","0xBDF19F85","0xB4F40DD9","0x130E341A","0x12DBBBAF","0x333CDC06","0x1B43F045"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(132, 543, 'A_C_Horse_Shire_LightGrey', 'Boca de Lã', '["0xF1BAA60D","0xE409A807","0xBDF19F85","0xC05AA4AA",null,null,"0xED0BCEB5","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(133, 544, 'A_C_Horse_Andalusian_DarkBay', 'BlackSmith', '["0x7D795D72","0xF6484C84",0,"0x293E17B3","0xFC74DF3B",null,0,"0x9FD99D7D"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(135, 347, 'A_C_Horse_SuffolkPunch_RedChestnut', 'Chocolate', '["0xD7FC86BF","0x9AD633FC",null,"0xC019F804","0xDC62E996","0xEABBBAB9","0x9AD2AA40","0xAC1F34C"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(137, 536, 'A_C_Horse_Andalusian_DarkBay', 'Chanchito', '["0xE52BAC3F","0xEDCB3D78","0xBDF19F85","0x9D593283","0x130E341A","0x17EB79D3","0x9AD2AA40","0xA1FD8B43"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(139, 547, 'A_C_Horse_Thoroughbred_DappleGrey', 'Neve', '["0x306806F","0xFDF4250B","0xD8AE54FE","0xE893DFD","0x235DBF1","0x66C266F","0xED0BCEB5","0x9FD99D7D"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(140, 548, 'A_C_Horse_Andalusian_DarkBay', 'Heca\n', '["0xC76C46D9","0x20D4A0BF",0,"0xC019F804","0x9DF8175C","0xB4AB3354",0,"0x72FCB059"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(142, 551, 'A_C_Horse_AmericanStandardbred_Buckskin', 'Jubileu', '["0x21E8DDFA","0x2286EE30","0x75178DD2","0xC05AA4AA","0x5DE62AE8",0,0,"0xD020E789"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(143, 553, 'A_C_Horse_AmericanPaint_Tobiano', 'Euclides', '["0x1D0BF8F2","0x2286EE30","0x75178DD2","0x2AEFF6CA","0x419D9470","0x5D7FA043","0x333CDC06","0x841C784A"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(145, 556, 'A_C_Horse_Turkoman_Gold', 'Bala no alvo', '["0x1EC65C0","0x127E0412","0x3B3AB08","0x20AA8620","0x130E341A","0x12DBBBAF","0x107D9598","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(147, 559, 'A_C_Horse_Andalusian_DarkBay', 'cachimbo', '["0xD11CBF82","0xF506CA32",null,0,"0x446A6F01",null,"0xC6C381F5","0x69B21ADD"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(148, 503, 'A_C_Horse_Andalusian_DarkBay', 'BMW M4', '["0xD7FC86BF","0x9AD633FC","0x587DD49F","0x5277E9BA","0xFC74DF3B","0x1F7A99EA","0xC6C381F5","0x27543EBB"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(156, 474, 'A_C_Horse_Turkoman_Gold', 'Hamtaro', '["0x20359E53"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(158, 417, 'A_C_Horse_Turkoman_Gold', 'Tulipão', '["0xF1BAA60D","0x20D4A0BF","0x587DD49F","0x1D4EDB88","0x83563E39","0x894C290D","0xF8CAE723",0]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(159, 528, 'A_C_Horse_Turkoman_Gold', 'bolt', '["0x1EE21489","0x127E0412",null,null,null,0]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(160, 229, 'A_C_Horse_Andalusian_DarkBay', 'negão', '["0xE6488B58","0x127E0412",null,null,"0x130E341A","0x12DBBBAF",null,"0x12F0DF9F"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(161, 310, 'A_C_Horse_Andalusian_DarkBay', 'Nocoyoco', '["0x353FC03C","0xC4C732B2","0xCB9A3AD6","0xEEC77E72",null,null,0,"0xD8258E14"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(162, 558, 'A_C_Horse_AmericanPaint_Tobiano', 'Storm', '["0x106961A8","0x5F0F9E4A","0xCB9A3AD6","0xF8FB69CA","0x1FDC6D0F","0x33E7B1CB","0xDBE6AC3B","0x1B43F045"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(163, 242, 'A_C_HORSE_MORGAN_FLAXENCHESTNUT', 'Jarineu', '["0x106961A8","0x19C5E80C",0,"0x1D4EDB88",null,"0x12DBBBAF",0]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(165, 364, 'A_C_Horse_Thoroughbred_DappleGrey', 'DonVI', '["0xA7AC9F7B","0x5F0F9E4A","0x8246282F","0xC05AA4AA","0x354F6B7",null,"0xE1DC3856",0]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(166, 568, 'A_C_Horse_Shire_LightGrey', 'Hardin', '["0x7DBB3E1C","0xAD283105","0xE73FF221","0x9D593283","0x2E378E8A","0x4B51B039","0xDBE6AC3B","0x1B43F045"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(169, 574, 'A_C_Horse_Thoroughbred_DappleGrey', 'Moreira', '["0xA7AC9F7B","0xF506CA32",null,"0xC05AA4AA","0xE9FE04D0","0xF4294320","0xDBE6AC3B","0x9FD99D7D"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(172, 272, 'A_C_Horse_Appaloosa_Blanket', 'Cavalo', '["0x3F9F62CE","0x78FB209A","0xE73FF221","0xC019F804","0xF2E555D8","0xF4294320","0xE1DC3856","0x4B7E0712"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(175, 582, 'A_C_Horse_Andalusian_DarkBay', 'BMW M4', '["0xD7FC86BF","0xC073E2CA","0x587DD49F","0xC019F804","0x130E341A",0,0,"0xAC1F34C"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(177, 525, 'A_C_Horse_Andalusian_DarkBay', 'Panzer II', '["0xB5802A5F","0xFAE487F","0x587DD49F","0xF8FB69CA","0x6F4510C4","0xD7D68A7B","0x333CDC06","0x9FD99D7D"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(178, 592, 'A_C_Horse_SuffolkPunch_RedChestnut', 'Opala', '["0x1F7C4C5","0x2286EE30","0x8246282F","0xB4F40DD9","0xFF020F3A","0xED0397AC",0,"0xD258EF10"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(179, 591, 'A_C_Horse_Thoroughbred_DappleGrey', 'JankVII', '["0xD61B2996","0x5F0F9E4A","0x8246282F","0x9D593283",null,null,"0x34135CC3"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(185, 587, 'A_C_Horse_Andalusian_Perlino', 'Pé de Pano', '["0x1EC65C0","0x342916F3","0xBDF19F85","0x20AA8620","0x25627B98","0x1A3B721B","0x9AD2AA40","0x45FEA6D8"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(186, 573, 'A_C_Horse_Andalusian_Perlino', 'Ash', '["0x219D85E2",0,"0x3B3AB08",0,"0x16923E26","0x1BB5EAA1",0,"0x12F0DF9F"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(187, 555, 'A_C_Horse_Appaloosa_Blanket', 'cavalo do redy', '["0x3827D232","0x269583CA",null,"0x293E17B3","0xB881489D","0x30603BB5","0x3E40711D","0xA1FD8B43"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(188, 526, 'A_C_Horse_Andalusian_DarkBay', 'rabetao 2.0', '["0x1EC65C0","0x3973A986","0x9EE8E174","0x20AA8620","0x2D47B5FD","0x25B51566","0x34135CC3","0x36BEDD90"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(190, 486, 'A_C_Horse_Thoroughbred_DappleGrey', 'Flash', '["0x6384D886",0,"0xE73FF221","0x5277E9BA","0x14098229","0x1BB5EAA1","0x2A28C8BE","0x55A0E4FE"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(191, 588, 'A_C_Horse_Andalusian_DarkBay', 'Dravalo', '["0x9533FA8E","0xC097E12C","0x8D0BC7DA","0xC05AA4AA","0x3A7C2C86","0x383E86F3",null,"0xD8258E14"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(192, 550, 'A_C_Horse_Turkoman_Gold', 'Dourado', '["0xEC882931","0x508B80B9","0xD8AE54FE","0xE4108D59","0xDCF5321","0xD9288D47","0xDBE6AC3B","0x9FD99D7D"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(193, 493, 'A_C_Horse_Turkoman_Gold', 'Moha', '["0x93B7057","0x5F0F9E4A","0x75178DD2","0xF8FB69CA","0x632F2B7","0x5D7FA043","0x3E40711D","0x9FD99D7D"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(194, 511, 'A_C_Horse_Turkoman_Gold', 'MATILDA III', '["0xF1BAA60D","0xFFB1DE72","0x67AF7302","0xF8FB69CA","0xEAB72F85",null,"0x333CDC06","0x9FD99D7D"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(195, 397, 'A_C_Horse_SuffolkPunch_RedChestnut', 'Stella', '["0x21E8DDFA","0xFDF4250B","0x75178DD2","0xE57042B4","0x50AC7CC6","0x1A3B721B","0xED0BCEB5","0x69B29DC5"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(198, 564, 'A_C_Horse_Appaloosa_Blanket', 'Lajada', '["0x106961A8","0x127E0412","0x3B3AB08","0x1D4EDB88","0x130E341A","0x12DBBBAF","0x107D9598","0x841C784A"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(199, 567, 'A_C_Horse_Andalusian_DarkBay', 'Pomba', '["0x5B6390D9",0,"0x75178DD2","0xC05AA4AA","0x235DBF1","0x4F5268A4","0x9AD2AA40","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(200, 566, 'A_C_Horse_Andalusian_Perlino', 'Lucky', '["0x2F8C7941","0x19C5E80C","0xD8AE54FE","0xC019F804","0x41EA9196","0xA7438C29","0x107D9598","0x69B21ADD"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(201, 459, 'A_C_Horse_Nokota_ReverseDappleRoan', 'bisteca\n', '["0x93DA8768","0xFFB1DE72","0xCB9A3AD6",0,"0x9A640A3","0x33E7B1CB","0xDBE6AC3B",0]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(203, 593, 'A_C_Horse_Andalusian_Perlino', 'Pé De Pano', '["0xD6BF27E1","0xE32A1050","0x9EE8E174","0x8BE10F93","0x16923E26","0xF4A3443C","0xE1DC3856","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(204, 524, 'A_C_Horse_Turkoman_Gold', 'Capial II', '["0x106961A8","0x508B80B9","0x8D0BC7DA","0xE4108D59","0xB2FB934B","0xEAA5EEE7","0xED0BCEB5","0x55A0E4FE"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(205, 576, 'A_C_Horse_SuffolkPunch_RedChestnut', 'hulk', '["0x306806F","0x41D52CD8","0x3B3AB08","0x20AA8620","0x14098229","0x1BB5EAA1","0x9AD2AA40","0x69B21ADD"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(207, 241, 'A_C_Horse_Turkoman_Gold', 'Pe de pano', '["0x14168240","0x2286EE30","0x8D0BC7DA","0x5277E9BA","0x1FDC6D0F","0x1F7A99EA","0x2A28C8BE","0x1B43F045"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(209, 615, 'A_C_Horse_Appaloosa_Blanket', 'pé de pano', '["0x7DBB3E1C","0xFDF4250B","0xD8AE54FE","0xE57042B4","0xB881489D","0xEBC7218B","0xED0BCEB5","0xA1FD8B43"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(211, 604, 'A_C_Horse_Shire_LightGrey', 'SAMU', '["0x8FFCF06B","0xAD283105","0x8D0BC7DA","0xC019F804","0x235DBF1","0x30603BB5",0,"0x72FCB059"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(215, 609, 'A_C_Horse_Andalusian_DarkBay', 'Tiringa', '["0x306806F","0xEBB4B70D","0x75178DD2","0xC05AA4AA","0x130E341A","0x1E9A18C2","0x2A28C8BE","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(222, 606, 'A_C_Horse_Thoroughbred_DappleGrey', 'Pisafofo', '["0xF1BAA60D","0xC4C732B2","0x8D0BC7DA","0xF8FB69CA","0x2FCAF0CB","0x30603BB5","0x107D9598","0xA1FD8B43"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(226, 617, 'A_C_Horse_KentuckySaddle_Grey', 'ventania', '["0xF1BAA60D","0xC2EF5C93","0x75178DD2","0xE4108D59","0xACA2B4B1",0,"0x34135CC3","0xD8258E14"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(228, 586, 'A_C_Horse_Thoroughbred_DappleGrey', 'Pano', '[null,null,null,null,null,"0x1F7A99EA"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(229, 614, 'A_C_Horse_Andalusian_DarkBay', 'Chernobil', '["0xF1BAA60D","0x508B80B9","0xE73FF221","0xF8FB69CA","0x6F4510C4","0x33E7B1CB","0x333CDC06","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(234, 584, 'A_C_Horse_Turkoman_Gold', 'JUBILEU', '["0x306806F","0xFFB1DE72","0xCB9A3AD6","0xC05AA4AA","0x235DBF1","0x30603BB5","0xF826E4EB","0x45FEA6D8"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(236, 623, 'A_C_Horse_Andalusian_Perlino', 'Gasparzinho', '["0x6C622F8C","0xFDF4250B","0xE73FF221","0xC05AA4AA","0xB881489D","0x1F7A99EA","0xE1B1B8F1","0x45FEA6D8"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(237, 634, 'A_C_Horse_AmericanPaint_Overo', 'Sheique\n', '["0x694DE418","0xED0190A3",null,"0xE57042B4","0x86457C9A","0xD9EA1916","0x333CDC06","0x69B29DC5"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(239, 579, 'A_C_Horse_Belgian_MealyChestnut', 'Simon', '["0xBA6A921E","0xEDCB3D78","0x75178DD2","0x2AEFF6CA",null,null,"0x34135CC3",0]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(240, 571, 'A_C_Horse_SuffolkPunch_RedChestnut', 'Cardume', '["0x93B7057","0x19C5E80C","0x8D0BC7DA","0xF8FB69CA","0x632F2B7","0x4B51B039","0xF8CAE723","0x8C9F7709"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(247, 652, 'A_C_Horse_Nokota_ReverseDappleRoan', 'Asker', '["0x14168240","0x20D4A0BF","0x67AF7302",null,"0x130E341A","0xF867D611","0x107D9598","0xD258EF10"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(248, 649, 'A_C_Horse_KentuckySaddle_Grey', 'Ventania', '["0x70C65BED","0xEBB4B70D","0x75178DD2","0xC05AA4AA","0x235DBF1","0x30603BB5","0xE1DC3856","0x1B43F045"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(249, 254, 'A_C_Horse_Turkoman_Gold', 'Shimmer', '["0x20359E53","0x19C5E80C","0xD8AE54FE","0x1D4EDB88"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(250, 537, 'A_C_Horse_Turkoman_Gold', 'Fufusquinha 2.0', '["0x14168240","0xC097E12C","0x75178DD2","0x293E17B3","0x8679685F","0x4B51B039","0x34135CC3","0x8C9F7709"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(251, 635, 'A_C_Horse_Turkoman_Gold', 'Tornado', '["0x7D795D72","0xEC040C89","0x3B3AB08","0xD048C482","0x235DBF1","0x30603BB5",0,"0xA643680C"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(252, 640, 'A_C_Horse_Andalusian_DarkBay', 'FREDERICO', '["0x1EE21489","0x64BE7DF8","0x587DD49F","0x293E17B3","0x14098229","0x17EB79D3","0x2A28C8BE","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(256, 643, 'A_C_Horse_Turkoman_Gold', 'Sansa', '["0x1EC65C0","0x67CAAF37","0xE73FF221","0x5277E9BA","0x4F148D45",null,"0xDBE6AC3B","0x36BEDD90"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(257, 599, 'A_C_Horse_KentuckySaddle_Grey', 'CORINGA', '["0x15FB6791","0x508B80B9","0x75178DD2","0xC05AA4AA","0x235DBF1","0x33E7B1CB","0x333CDC06","0x1B43F045"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(263, 608, 'A_C_Horse_Andalusian_DarkBay', 'Safira', '["0xBFD09512","0x3D34F3","0xD8AE54FE","0x1D4EDB88","0xB881489D","0x574BC82D","0xE1DC3856","0x12F0DF9F"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(265, 654, 'A_C_HORSEMULE_01', 'Jamanta', '["0xE5B31D9F","0xFDF4250B","0x67AF7302","0xC019F804","0x3A7C2C86","0x84D6B90","0xDBE6AC3B","0x4B7E0712"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(266, 598, 'A_C_Horse_Andalusian_DarkBay', 'Mixirica', '["0x1D0BF8F2","0x3BA0D76D","0x67AF7302","0x577EF434","0x1FDC6D0F","0x17EB79D3","0x3E40711D","0x9FD99D7D"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(267, 637, 'A_C_Horse_Shire_LightGrey', 'Zezinho', '["0x40C53D24","0x20D4A0BF",0,"0x5277E9BA","0x130E341A","0x12DBBBAF",0,"0x36BEDD90"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(268, 660, 'A_C_Horse_KentuckySaddle_Grey', 'Adamastor', '["0x4C1A5ADB","0xB0F7BDA4","0x75178DD2","0x293E17B3","0x2FCAF0CB","0x1A3B721B","0x107D9598"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(270, 657, 'A_C_Horse_Thoroughbred_DappleGrey', 'Ghosth', '["0x189F7005","0x508B80B9","0x587DD49F","0xC05AA4AA","0x1DF21752","0x4951F22","0xF8CAE723","0x55A0E4FE"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(271, 315, 'A_C_Horse_Andalusian_Perlino', 'BRANCAO', '["0xE36C8274","0xEDCB3D78","0x67AF7302","0x577EF434","0x16923E26","0x1A3B721B",null,"0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(272, 600, 'A_C_Horse_Arabian_White', 'peninha', '["0x7C2C580C","0x41D52CD8","0x587DD49F","0x8BE10F93","0x241D7FBD","0x17EB79D3","0xF09C56EE","0x4B7E0712"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(274, 522, 'A_C_Horse_Turkoman_Gold', 'Lisdosmar', '["0xE52BAC3F","0xD333865B",null,"0xEEC77E72","0xFC74DF3B","0xF6B0AB06","0xED0BCEB5","0xBC664014"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(275, 618, 'A_C_Horse_KentuckySaddle_Grey', 'Mió', '["0x1EE21489","0x6B2084E5","0x67AF7302","0x293E17B3","0x2FCAF0CB","0x17EB79D3","0x333CDC06","0x1B43F045"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(276, 665, 'A_C_Horse_Andalusian_DarkBay', 'Meia noite', '["0xF1BAA60D","0x7951D487","0xE73FF221","0x577EF434","0xACA2B4B1","0xC74FCC45","0x3E40711D","0xD8258E14"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(277, 619, 'A_C_Horse_Andalusian_Perlino', 'BRANCO', '["0x2ECD9E70",0,"0x75178DD2","0xE4108D59",null,0,0]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(278, 661, 'A_C_Horse_Shire_LightGrey', 'panguare', '["0x24F24446","0x20D4A0BF","0x3B3AB08","0x20AA8620","0x130E341A","0x1F7A99EA","0x107D9598","0x12F0DF9F"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(280, 666, 'A_C_Horse_Andalusian_Perlino', 'SILVERADO', '["0x2ECD9E70","0x41D52CD8","0x75178DD2",null,"0x354F6B7","0xA62C9657","0xDBE6AC3B","0x69B21ADD"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(281, 572, 'A_C_Horse_Andalusian_Perlino', 'Montanha', '["0xC76C46D9","0x41D52CD8",0,"0xB4F40DD9","0xB881489D","0x66C266F","0x34135CC3","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(282, 620, 'A_C_Donkey_01', 'Nicolau', '[0,"0x19C5E80C",0,0,0,0,0,0]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(284, 322, 'A_C_Horse_Turkoman_Gold', 'Spirit', '["0x60DE5335","0x3D34F3","0xD8AE54FE",0,"0xF2E555D8","0xF867D611","0x34135CC3",0]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(285, 554, 'A_C_Horse_Andalusian_DarkBay', 'patolino', '["0xE5B31D9F","0xFFB1DE72",0,"0xE57042B4","0xE9FE04D0","0xD9EA1916","0xED0BCEB5","0xD258EF10"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(601, 662, 'A_C_Horse_AmericanPaint_Tobiano', 'Sopro de Vento', '["0xDA84CF33","0xFFB1DE72",0,"0xC05AA4AA","0x16923E26","0x1F7A99EA",null,"0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(602, 663, 'A_C_Horse_Turkoman_Gold', 'Ganja', '["0x306806F","0x9DE0EA65","0x75178DD2","0xEEC77E72","0x3BFE2A17","0x17EB79D3","0x3E40711D","0x27543EBB"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(603, 669, 'A_C_Horse_Andalusian_DarkBay', 'CABRITOZ PERIGOXO', '["0x7C2C580C","0x3973A986","0x587DD49F","0xE2ADE94C","0x14098229",0,0,"0x1B43F045"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(605, 472, 'A_C_Horse_SuffolkPunch_RedChestnut', 'Vinho', '["0x15FB6791","0x2A6D33E8","0x75178DD2",0,"0x130E341A",null,null,"0x12F0DF9F"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(606, 540, 'A_C_Horse_Turkoman_Gold', 'Alabama', '["0x1D0BF8F2",null,"0x587DD49F","0x293E17B3","0x130E341A","0x3AE050B5","0x333CDC06","0x1B43F045"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(607, 314, 'A_C_Horse_Turkoman_Gold', 'Carpeado', '["0x4C1A5ADB","0x41D52CD8","0xBDF19F85","0xC05AA4AA","0x235DBF1","0x17EB79D3","0x34135CC3","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(611, 625, 'A_C_Horse_Turkoman_Gold', 'Garanhão Rei Delas', '["0xF1BAA60D","0x3D34F3","0xE73FF221",null,"0x41EA9196","0x1A3B721B","0x2A28C8BE","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(614, 673, 'A_C_Horse_Nokota_ReverseDappleRoan', 'PÉ DE CANA', '["0xE5B31D9F","0xFDF4250B","0xCB9A3AD6","0x293E17B3","0xCF434F57","0xEABBBAB9","0xF826E4EB","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(615, 650, 'A_C_Horse_Andalusian_DarkBay', 'roberto', '["0x14168240","0x3973A986","0x75178DD2","0xB4F40DD9","0x235DBF1","0x17EB79D3","0x2A28C8BE","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(616, 676, 'A_C_Horse_Turkoman_Gold', 'Soram', '["0x20359E53","0x127E0412",null,"0x293E17B3",null,null,"0xE1B1B8F1","0x8C9F7709"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(617, 601, 'A_C_Horse_SuffolkPunch_RedChestnut', 'Pé de Pano', '["0x40C53D24","0x20D4A0BF","0xE73FF221","0x293E17B3","0x1FDC6D0F","0x1E9A18C2","0xE1DC3856","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(618, 642, 'A_C_Horse_Turkoman_Gold', 'fumaça', '["0xBFD09512","0xE409A807","0x75178DD2",0,"0xAA3FAC1A","0xED787168","0xED0BCEB5","0x9FD99D7D"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(619, 653, 'A_C_Horse_Turkoman_Gold', 'Mustangaum', '["0xE5510BB8","0x3278996D","0x8246282F","0xC05AA4AA","0x3A7C2C86",null,"0x333CDC06","0x45FEA6D8"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(620, 641, 'A_C_Horse_Nokota_ReverseDappleRoan', 'smoke', '["0xE52BAC3F","0xAB302059","0x75178DD2","0xC05AA4AA",0,"0x3D1F13D4","0x333CDC06","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(621, 621, 'A_C_Horse_Turkoman_Gold', 'Jamanta', '["0xE52BAC3F","0x78FB209A","0xD8AE54FE","0xF8FB69CA","0xC0085B74","0xA62C9657","0xE1DC3856","0x12F0DF9F"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(622, 672, 'A_C_Horse_AmericanStandardbred_Buckskin', 'Perigo', '["0x14168240","0x4BF1F80F","0xE73FF221","0xC05AA4AA","0x130E341A","0x12DBBBAF","0x3E40711D","0x1B43F045"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(623, 679, 'A_C_Horse_Shire_LightGrey', 'Abelardo', '["0x5B45F932","0xD333865B","0xBDF19F85","0x8BE10F93","0xFF17AB82","0x30603BB5","0xF826E4EB","0x45FEA6D8"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(625, 487, 'A_C_Horse_Turkoman_Gold', 'Mijão', '["0x219D85E2","0x20D4A0BF","0xBDF19F85","0x293E17B3",null,null,"0x333CDC06","0x12F0DF9F"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(626, 611, 'A_C_Horse_Shire_LightGrey', 'Trigão', '["0x15FB6791","0x2286EE30","0xBDF19F85","0x20AA8620","0x25627B98","0x1A3B721B","0x2A28C8BE","0x12F0DF9F"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(627, 675, 'A_C_Horse_Turkoman_Gold', 'Carpeado', '["0x522CCED","0x41D52CD8","0xBDF19F85","0xB4F40DD9","0x235DBF1","0x17EB79D3","0xE1B1B8F1","0x55A0E4FE"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(628, 667, 'A_C_Horse_SuffolkPunch_RedChestnut', 'Prestigio', '["0xC7FC601A","0x342916F3","0x587DD49F","0x293E17B3","0xE0BC27A6","0xC2FA4FF2","0x2A28C8BE","0xD258EF10"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(630, 400, 'A_C_Horse_Nokota_ReverseDappleRoan', 'Anne', '["0x306806F",0,"0xCB9A3AD6","0xC05AA4AA","0xB881489D","0x1F7A99EA","0x3E40711D","0x8C9F7709"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(631, 602, 'A_C_Horse_Turkoman_Gold', 'Pingo', '["0x88C363C5","0x5894FB24","0x8D0BC7DA",0,"0xB881489D","0x66C266F","0x3E40711D",0]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(632, 610, 'A_C_Horse_Turkoman_Gold', 'Chapolin', '["0x1EE21489","0x3278996D","0xE73FF221","0x293E17B3",null,0,"0x333CDC06","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(633, 651, 'A_C_Horse_Turkoman_Gold', 'CocoteDeBB', '["0xE52BAC3F","0xFDF4250B",null,"0xF8FB69CA","0x241D7FBD","0x1F7A99EA","0x9AD2AA40","0x12F0DF9F"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(634, 659, 'A_C_Horse_Shire_LightGrey', 'Didico', '["0xC0C04297","0xFDF4250B","0xD8AE54FE","0x20AA8620","0xFF17AB82",0,"0xED0BCEB5","0x84E5AFA"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(635, 646, 'A_C_Horse_Thoroughbred_DappleGrey', 'Sua Mae', '["0x7DBB3E1C","0x41D52CD8",null,"0xE4108D59","0x41EA9196","0xE38F5D96","0xC6C381F5","0x69B21ADD"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(636, 597, 'A_C_Horse_Turkoman_Gold', 'Foguinho II', '["0xC0C04297",0,0,"0xF8FB69CA","0x41EA9196","0x1F7A99EA","0xED0BCEB5","0xBC664014"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(637, 685, 'A_C_Horse_Andalusian_DarkBay', 'Máximus', '["0xE5510BB8","0x7D637917","0x3B3AB08","0xF8FB69CA","0xB5F379E6","0xC304EB4C","0xED0BCEB5","0x72FCB059"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(638, 680, 'A_C_Horse_Andalusian_Perlino', 'floquinho', '["0x15FB6791","0xFAE487F","0xE73FF221",null,"0x3A7C2C86","0x30603BB5","0xC6C381F5","0x1B43F045"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(641, 607, 'A_C_Horse_Turkoman_Gold', 'Aluado', '["0x7092A211",0,"0x67AF7302","0x577EF434","0x235DBF1","0x30603BB5","0x9AD2AA40","0x27543EBB"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(642, 692, 'A_C_Horse_Andalusian_Perlino', 'henry', '["0x306806F","0x19C5E80C","0x8246282F","0xC05AA4AA",null,0,"0xC6C381F5","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(643, 430, 'A_C_Horse_Andalusian_DarkBay', 'Molhado\n', '["0x14168240","0x71DFC3EA","0x75178DD2","0xE4108D59",null,null,null,"0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(644, 694, 'A_C_Horse_Andalusian_DarkBay', 'Cavalo', '["0x15FB6791","0x4BF1F80F",null,"0xC05AA4AA","0x235DBF1","0x1F7A99EA",0,"0x45FEA6D8"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(645, 684, 'A_C_Horse_Thoroughbred_DappleGrey', 'Pé sem pano', '["0x306806F","0xA3D5298D","0xE73FF221","0xE4108D59","0x632F2B7","0x17EB79D3","0x3E40711D","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(646, 343, 'A_C_Horse_Turkoman_Gold', 'Gold', '["0x2ECD9E70","0x5F0F9E4A","0xE73FF221","0x293E17B3","0xAA3FAC1A","0x574BC82D","0x34135CC3","0x45FEA6D8"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(648, 693, 'A_C_Horse_Thoroughbred_DappleGrey', 'Nuvem', '["0x5A9E4F6C","0x41D52CD8","0x67AF7302","0x293E17B3","0x817B10F6","0x1A3B721B","0xE1DC3856","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(649, 500, 'A_C_Horse_Andalusian_Perlino', 'Pe pano', '["0x2ECD9E70","0x3278996D","0xCB9A3AD6","0xC05AA4AA","0x130E341A","0x1F7A99EA","0x9AD2AA40","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(650, 696, 'A_C_Horse_Andalusian_Perlino', 'Bala no Alvo', '["0xF1BAA60D","0x7951D487","0xE73FF221","0xF8FB69CA","0x632F2B7","0xEAA5EEE7","0x107D9598","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(652, 691, 'A_C_HORSEMULE_01', 'Pé de pano', '["0x14168240","0x67CAAF37","0x67AF7302","0xC05AA4AA","0x130E341A",0,0,"0x1B43F045"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(653, 697, 'A_C_Horse_Andalusian_DarkBay', 'Nellya', '["0x20359E53","0x508B80B9","0x8D0BC7DA","0xB4F40DD9","0x5ED14B9F","0x30603BB5","0x34135CC3","0x69B21ADD"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(654, 698, 'A_C_Horse_Shire_LightGrey', 'Aaron', '["0x7DBB3E1C","0x5F0F9E4A","0x75178DD2","0xF8FB69CA","0xC9D16B31","0xF4294320","0xED0BCEB5","0x72FCB059"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(661, 701, 'A_C_Horse_Thoroughbred_DappleGrey', 'Xanaina', '["0x40C53D24","0xB19B4519","0xBDF19F85","0xB4F40DD9","0x388E4B32","0x1A3B721B","0xE1B1B8F1","0x7B55D476"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(662, 699, 'A_C_Horse_Andalusian_Perlino', 'Carpeado', '["0x5B6390D9","0xC097E12C","0xCB9A3AD6","0xF8FB69CA","0x16923E26","0x1F7A99EA","0x333CDC06","0x12F0DF9F"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(664, 690, 'A_C_Horse_Nokota_ReverseDappleRoan', 'Lady Gaga', '["0x150D0DAA","0x342916F3","0x587DD49F","0x2AEFF6CA",0,"0x17EB79D3",0,"0x36BEDD90"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(665, 695, 'A_C_Horse_Nokota_ReverseDappleRoan', 'Tico', '["0x8DD09A7C","0x41D52CD8","0xBDF19F85","0xC019F804","0x419D9470","0x810A5CE0","0xE1B1B8F1","0x45FEA6D8"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(666, 613, 'A_C_Horse_Nokota_ReverseDappleRoan', 'Carpeado', '["0x1D0BF8F2","0x41D52CD8","0x75178DD2","0x5277E9BA","0x235DBF1","0x1F7A99EA","0x333CDC06","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(667, 709, 'A_C_Horse_Andalusian_DarkBay', 'Pé´de pano\n', '["0x1EE21489",0,null,"0x1D4EDB88","0xE12C9C64","0xF4A3443C",null,"0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(668, 705, 'A_C_Horse_KentuckySaddle_Grey', 'Furia', '[0,"0x269583CA",null,"0x293E17B3","0x16923E26"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(669, 711, 'A_C_Horse_Andalusian_Perlino', 'pe de pano', '["0x306806F","0xAD283105","0xE73FF221","0xC05AA4AA","0x483AC803","0xF6B0AB06","0xC6C381F5","0x69B21ADD"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(671, 712, 'A_C_Horse_Andalusian_Perlino', 'gabiru', '["0x306806F","0x2A6D33E8","0xBDF19F85","0xB4F40DD9","0xD4E65BE5","0x33E7B1CB",0,"0x36BEDD90"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(673, 624, 'A_C_Horse_Turkoman_Gold', 'Duke', '["0x14168240","0x3278996D","0xE73FF221","0xD048C482","0x130E341A","0x12DBBBAF","0x333CDC06","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(674, 627, 'A_C_Horse_Shire_LightGrey', 'Insolente', '["0x78F07DFA",0,0,0,0,0,0,0]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(675, 707, 'A_C_Horse_Thoroughbred_DappleGrey', 'sebastchão', '["0x24F24446",null,null,"0x20AA8620",null,"0x30603BB5"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(676, 655, 'A_C_Horse_Turkoman_Gold', 'caramelo de ouro ', '["0xEC882931","0x19C5E80C","0x8246282F","0xC05AA4AA","0x5F0395A3","0x4B51B039","0xED0BCEB5","0x9FD99D7D"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(677, 720, 'A_C_Horse_Andalusian_Perlino', 'chupisco', '["0x20359E53",0,0,null,"0x419D9470","0x1A3B721B","0x107D9598","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(678, 719, 'A_C_HORSEMULE_01', 'Zoreia', '["0x14168240","0x19C5E80C","0x8246282F","0xC05AA4AA",null,null,"0x3E40711D",0]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(679, 722, 'A_C_Horse_Andalusian_Perlino', 'cú raso', '["0xF2F0045","0xFFB1DE72",null,null,"0xFF17AB82","0xF867D611",null,"0xD8258E14"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(680, 539, 'A_C_Horse_Andalusian_Perlino', 'Texas', '["0xC0C04297","0xF6484C84","0xE73FF221","0xF8FB69CA","0xF2E555D8","0x1F7A99EA","0xE1DC3856","0x8C9F7709"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(681, 700, 'A_C_Horse_AmericanStandardbred_Buckskin', 'SHANAINA', '["0x24F24446","0x823A602A","0x8D0BC7DA","0x577EF434","0x817B10F6","0x25B51566","0x3E40711D","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(682, 724, 'A_C_Horse_KentuckySaddle_Grey', 'Pe de Pano', '["0x522CCED","0x5F0F9E4A","0x587DD49F","0x293E17B3","0x235DBF1","0x1F7A99EA","0x107D9598","0x18BB6B30"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(683, 626, 'A_C_Horse_Turkoman_Gold', 'Lupo', '["0xBFD09512","0x41D52CD8","0x8246282F","0xF8FB69CA","0xAA3FAC1A","0xA62C9657",0,"0x12F0DF9F"]');
INSERT IGNORE INTO `horses` (`id`, `charid`, `model`, `name`, `components`) VALUES
	(685, 415, 'A_C_Horse_Andalusian_DarkBay', 'Carpiado', '{}');
/*!40000 ALTER TABLE `horses` ENABLE KEYS */;

-- Copiando estrutura para tabela redm.house_rent
CREATE TABLE IF NOT EXISTS `house_rent` (
  `house_id` varchar(11) NOT NULL,
  `house_next_payment` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Copiando dados para a tabela redm.house_rent: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `house_rent` DISABLE KEYS */;
/*!40000 ALTER TABLE `house_rent` ENABLE KEYS */;

-- Copiando estrutura para procedure redm.inventories
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `inventories`(
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
  `inv_capacity` tinyint(4) DEFAULT 40,
  `inv_slots` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL DEFAULT '{}',
  PRIMARY KEY (`id`),
  KEY `FK_inventoriers_characters` (`charid`),
  CONSTRAINT `FK_inventories_characters` FOREIGN KEY (`charid`) REFERENCES `characters` (`charid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.inventories: ~830 rows (aproximadamente)
/*!40000 ALTER TABLE `inventories` DISABLE KEYS */;
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:172', 172, 40, '{"65": "[\\"bow\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:189', 189, 40, '{"97": "[\\"money\\",17119]", "66": "[\\"repeater_carbine\\",1,0,0]", "67": "[\\"repeater_henry\\",1,0,0]", "73": "[\\"rifle_varmint\\",1,0,0]", "68": "[\\"rifle_varmint\\",1,0,0]", "49": "[\\"meat\\",1]", "130": "[\\"repeater_henry\\",1,3,0]", "129": "[\\"revolver_lemat\\",1,7,48]", "131": "[\\"revolver_cattleman\\",1,0,0]", "69": "[\\"ammo_revolver\\",40]", "71": "[\\"rifle_boltaction\\",1,2,71]", "74": "[\\"ammo_rifle\\",5]", "65": "[\\"ammo_rifle\\",45]", "75": "[\\"ammo_pistol\\",20]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:193', 193, 40, '{"130": "[\\"pistol_mauser\\",1,10,70]", "131": "[\\"lasso\\",1]", "132": "[\\"melee_lantern_electric\\",1,0,1]", "65": "[\\"rifle_springfield\\",1,0,80]", "97": "[\\"money\\",6104]", "35": "[\\"horse_stimulant_good\\",1]", "34": "[\\"horse_stimulant_good\\",1]", "40": "[\\"horse_stimulant_good\\",1]", "36": "[\\"horse_stimulant_good\\",1]", "33": "[\\"horse_stimulant_good\\",1]", "41": "[\\"horse_stimulant_good\\",1]", "39": "[\\"horse_stimulant_good\\",1]", "37": "[\\"horse_stimulant_good\\",1]", "129": "[\\"repeater_henry\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:196', 196, 40, '{"97": "[\\"money\\",20000]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:204', 204, 40, '{"65": "[\\"ammo_rifle\\",45]", "131": "[\\"melee_knife\\",1,0,1]", "49": "[\\"meat_perfect\\",1]", "51": "[\\"meat_perfect\\",2]", "50": "[\\"herb_burdock_root\\",1]", "68": "[\\"ammo_rifle\\",20]", "66": "[\\"ammo_rifle\\",45]", "73": "[\\"rifle_varmint\\",1,7,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:229', 229, 40, '{"97": "[\\"money\\",3490]", "129": "[\\"revolver_lemat\\",1,0,0]", "50": "[\\"raw_coal\\",4]", "65": "[\\"lasso\\",1]", "66": "[\\"melee_lantern_electric\\",1,0,1]", "130": "[\\"thrown_molotov\\",6,0,1]", "67": "[\\"pistol_volcanic\\",1,8,2]", "68": "[\\"revolver_cattleman\\",1,6,35]", "69": "[\\"thrown_molotov\\",6,0,1]", "70": "[\\"shotgun_sawedoff\\",1,2,17]", "73": "[\\"ammo_rifle\\",20]", "72": "[\\"rifle_varmint\\",1,0,0]", "131": "[\\"shotgun_double_pump\\",1,0,40]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:235', 235, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:240', 240, 40, '{"129": "[\\"rifle_springfield\\",1,1,76]", "130": "[\\"repeater_evans\\",1,3,24]", "131": "[\\"revolver_lemat\\",1,8,44]", "65": "[\\"melee_knife\\",1,0,1]", "67": "[\\"melee_lantern_electric\\",1,0,1]", "66": "[\\"revolver_cattleman\\",1,6,109]", "132": "[\\"melee_knife\\",1,0,1]", "97": "[\\"money\\",9013]", "68": "[\\"lasso\\",1]", "69": "[\\"revolver_cattleman\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:241', 241, 40, '{"50": "[\\"corn_seed\\",10]", "68": "[\\"melee_knife\\",1,0,1]", "132": "[\\"melee_lantern_electric\\",1,0,1]", "129": "[\\"pistol_mauser\\",1,7,92]", "131": "[\\"lasso\\",1]", "72": "[\\"melee_torch\\",1,0,1]", "66": "[\\"rifle_springfield\\",1,1,92]", "97": "[\\"money\\",7501]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:242', 242, 40, '{"97": "[\\"money\\",99]", "131": "[\\"lasso\\",1]", "132": "[\\"melee_knife\\",1,0,1]", "130": "[\\"revolver_cattleman\\",1,6,34]", "129": "[\\"repeater_carbine\\",1,7,15]", "65": "[\\"bow\\",1,0,12]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:243', 243, 40, '{"129": "[\\"revolver_doubleaction\\",1,3,137]", "131": "[\\"lasso\\",1]", "97": "[\\"money\\",66]", "49": "[\\"raw_copper\\",1]", "65": "[\\"rifle_springfield\\",1,1,74]", "130": "[\\"melee_knife\\",1,0,1]", "98": "[\\"gold\\",202]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:244', 244, 40, '{"50": "[\\"meat_poor\\",5]", "67": "[\\"revolver_cattleman\\",1,5,71]", "49": "[\\"meat_good\\",1]", "51": "[\\"meat_poor\\",2]", "71": "[\\"repeater_carbine\\",1,6,35]", "52": "[\\"herb_black_berry\\",0]", "53": "[\\"herb_common_bullrush\\",8]", "54": "[\\"herb_wild_mint\\",4]", "55": "[\\"herb_oregano\\",4]", "56": "[\\"herb_american_ginseng\\",3]", "57": "[\\"herb_parasol_mushroom\\",2]", "66": "[\\"melee_torch\\",1,0,1]", "130": "[\\"revolver_cattleman\\",1,4,78]", "100": "[\\"money\\",2186]", "58": "[\\"herb_burdock_root\\",1]", "65": "[\\"melee_lantern_electric\\",1,0,1]", "131": "[\\"melee_knife\\",1,0,1]", "81": "[\\"acamp_firesmal_pan\\",1]", "82": "[\\"acamp_bedroll\\",1]", "98": "[\\"money\\",3047]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:245', 245, 40, '{"130": "[\\"revolver_cattleman\\",1,6,34]", "131": "[\\"melee_knife\\",1,0,1]", "132": "[\\"lasso\\",1]", "65": "[\\"melee_lantern_electric\\",1,0,1]", "49": "[\\"meat_poor\\",1]", "66": "[\\"bow\\",1,0,7]", "67": "[\\"ammo_repeater\\",15]", "129": "[\\"repeater_carbine\\",1,7,38]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:246', 246, 40, '{"129": "[\\"rifle_springfield\\",1,1,65]", "97": "[\\"money\\",1175]", "130": "[\\"revolver_lemat\\",1,8,121]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:247', 247, 40, '{"81": "[\\"acamp_tents_med_closed\\",1]", "82": "[\\"acamp_tents_med_closed\\",1]", "83": "[\\"acamp_tents_med_closed\\",1]", "131": "[\\"lasso\\",1,0,0]", "130": "[\\"revolver_cattleman\\",1,6,72]", "129": "[\\"bow\\",1,0,0]", "132": "[\\"melee_lantern_electric\\",1,0,1]", "65": "[\\"melee_knife\\",1,0,1]", "49": "[\\"meat_poor\\",3]", "50": "[\\"meat_good\\",3]", "51": "[\\"herb_american_ginseng\\",1]", "52": "[\\"meat_good\\",2]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:248', 248, 40, '{"17": "[\\"meat_oregano_cooked\\",2]", "97": "[\\"money\\",57950]", "130": "[\\"melee_knife\\",1,0,1]", "49": "[\\"meat_poor\\",1]", "33": "[\\"eagleeye\\",1]", "132": "[\\"lasso\\",1]", "129": "[\\"pistol_mauser_drunk\\",1,10,46]", "131": "[\\"melee_lantern_electric\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:249', 249, 40, '{"81": "[\\"acamp_firesmal_pan\\",1]", "49": "[\\"herb_common_bullrush\\",2]", "53": "[\\"herb_american_ginseng\\",2]", "56": "[\\"herb_wild_carrot\\",2]", "66": "[\\"ammo_repeater\\",45]", "51": "[\\"herb_burdock_root\\",2]", "132": "[\\"melee_knife\\",1,0,1]", "79": "[\\"melee_torch\\",1,0,1]", "129": "[\\"revolver_cattleman\\",1,6,84]", "130": "[\\"lasso\\",1,0,0]", "52": "[\\"herb_wild_mint\\",3]", "54": "[\\"herb_alaskan_ginseng\\",1]", "55": "[\\"meat_perfect\\",3]", "50": "[\\"meat_perfect\\",2]", "97": "[\\"money\\",2]", "131": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:251', 251, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:252', 252, 40, '{"129": "[\\"melee_knife\\",1,0,1]", "131": "[\\"melee_lantern_electric\\",1,0,1]", "65": "[\\"lasso\\",1]", "67": "[\\"melee_knife\\",1,0,1]", "132": "[\\"lasso\\",1]", "130": "[\\"revolver_cattleman\\",1,3,170]", "49": "[\\"herb_common_bullrush\\",2]", "50": "[\\"meat_good\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:254', 254, 40, '{"81": "[\\"pigeonpost\\",1]", "131": "[\\"melee_knife\\",1,0,1]", "132": "[\\"lasso\\",1,0,0]", "129": "[\\"revolver_cattleman\\",1,6,100]", "65": "[\\"melee_torch\\",1,0,1]", "97": "[\\"money\\",93]", "130": "[\\"bow\\",1,0,15]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:256', 256, 40, '{"132": "[\\"bow\\",1,0,39]", "74": "[\\"melee_hatchet_hunter_rusted\\",0,0,1]", "73": "[\\"melee_knife\\",0,0,1]", "75": "[\\"melee_hatchet_hunter_rusted\\",0,0,1]", "130": "[\\"lasso\\",1]", "78": "[\\"melee_knife\\",0,0,1]", "71": "[\\"melee_knife\\",0,0,1]", "70": "[\\"shotgun_repeating\\",0,6,54]", "77": "[\\"melee_hatchet_hunter_rusted\\",0,0,1]", "69": "[\\"melee_knife\\",0,0,1]", "66": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "67": "[\\"shotgun_repeating\\",0,6,54]", "131": "[\\"melee_knife\\",1,0,1]", "68": "[\\"melee_knife\\",0,0,1]", "72": "[\\"ammo_arrow\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:257', 257, 40, '{"67": "[\\"ammo_repeater\\",45]", "68": "[\\"ammo_repeater\\",45]", "49": "[\\"herb_oregano\\",2]", "50": "[\\"herb_american_ginseng\\",1]", "79": "[\\"melee_torch\\",1,0,1]", "129": "[\\"bow\\",1,0,19]", "130": "[\\"melee_knife\\",1,0,1]", "131": "[\\"lasso\\",1]", "66": "[\\"ammo_repeater\\",5]", "51": "[\\"herb_common_bullrush\\",2]", "97": "[\\"money\\",12]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:260', 260, 40, '{"131": "[\\"melee_knife\\",1,0,1]", "129": "[\\"revolver_cattleman\\",1,6,139]", "51": "[\\"herb_wild_mint\\",5]", "50": "[\\"herb_wild_carrot\\",1]", "130": "[\\"lasso\\",1]", "49": "[\\"meat_poor\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:261', 261, 40, '{"49": "[\\"raw_copper\\",1]", "50": "[\\"meat_perfect\\",4]", "65": "[\\"thrown_molotov\\",1,0,1]", "51": "[\\"meat_poor\\",4]", "52": "[\\"meat_good\\",1]", "53": "[\\"meat_poor\\",1]", "97": "[\\"money\\",2072]", "36": "[\\"medicine_poor\\",1]", "66": "[\\"repeater_carbine\\",1,4,155]", "67": "[\\"melee_knife\\",1,0,1]", "68": "[\\"lasso\\",1,0,0]", "69": "[\\"revolver_cattleman\\",1,5,138]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:263', 263, 40, '{"49": "[\\"meat\\",2]", "53": "[\\"raw_coal\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:264', 264, 40, '{"97": "[\\"money\\",3092]", "130": "[\\"repeater_evans\\",1,5,49]", "129": "[\\"revolver_lemat\\",1,9,190]", "132": "[\\"lasso\\",1]", "65": "[\\"melee_knife\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:265', 265, 40, '{"129": "[\\"revolver_cattleman\\",1,6,25]", "67": "[\\"revolver_cattleman\\",1,0,0]", "51": "[\\"raw_coal\\",10]", "68": "[\\"melee_lantern_electric\\",1,0,1]", "66": "[\\"revolver_cattleman\\",1,0,0]", "130": "[\\"rifle_boltaction\\",1,5,33]", "70": "[\\"lasso\\",1]", "131": "[\\"melee_knife\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:266', 266, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:267', 267, 40, '{"131": "[\\"melee_lantern_electric\\",1,0,1]", "97": "[\\"money\\",9826]", "65": "[\\"melee_knife\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:270', 270, 40, '{"97": "[\\"money\\",3600]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:271', 271, 40, '{"129": "[\\"revolver_cattleman\\",1,4,43]", "97": "[\\"money\\",1945]", "66": "[\\"ammo_pistol\\",60]", "67": "[\\"ammo_pistol\\",20]", "68": "[\\"ammo_revolver\\",60]", "65": "[\\"ammo_22\\",60]", "130": "[\\"repeater_winchester\\",1,14,57]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:272', 272, 40, '{"129": "[\\"revolver_lemat\\",1,9,106]", "130": "[\\"lasso\\",1,0,0]", "97": "[\\"money\\",450]", "131": "[\\"melee_knife\\",1,0,1]", "17": "[\\"meat_cooked\\",3]", "18": "[\\"meat_cooked\\",3]", "132": "[\\"melee_lantern_electric\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:273', 273, 40, '{"97": "[\\"money\\",6010]", "49": "[\\"meat\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:274', 274, 40, '{"68": "[\\"lasso\\",1]", "129": "[\\"repeater_winchester\\",1,0,0]", "49": "[\\"raw_gold\\",2]", "50": "[\\"raw_coal\\",1]", "97": "[\\"money\\",4000]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:275', 275, 40, '{"71": "[\\"ammo_revolver\\",60]", "76": "[\\"ammo_rifle\\",45]", "78": "[\\"ammo_rifle\\",30]", "77": "[\\"ammo_rifle\\",45]", "129": "[\\"revolver_doubleaction\\",1,2,177]", "130": "[\\"rifle_springfield\\",1,1,92]", "131": "[\\"lasso\\",1]", "132": "[\\"melee_lantern_electric\\",1,0,1]", "97": "[\\"money\\",3000]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:279', 279, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:280', 280, 40, '{"129": "[\\"revolver_cattleman\\",1,6,95]", "97": "[\\"money\\",85]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:281', 281, 40, '{"49": "[\\"raw_copper\\",3]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:283', 283, 40, '{"49": "[\\"herb_burdock_root\\",1]", "50": "[\\"herb_alaskan_ginseng\\",2]", "51": "[\\"meat_perfect\\",1]", "52": "[\\"herb_wild_mint\\",1]", "131": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "53": "[\\"herb_wild_carrot\\",1]", "54": "[\\"meat_poor\\",2]", "55": "[\\"meat_good\\",1]", "132": "[\\"lasso\\",1]", "56": "[\\"herb_american_ginseng\\",1]", "68": "[\\"ammo_arrow\\",20]", "69": "[\\"bow\\",1,0,0]", "79": "[\\"repeater_evans\\",1,26,8]", "78": "[\\"rifle_boltaction\\",1,4,96]", "80": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "129": "[\\"revolver_lemat\\",1,9,188]", "77": "[\\"melee_lantern_electric\\",1,0,1]", "97": "[\\"money\\",99]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:284', 284, 40, '{"49": "[\\"meat\\",3]", "50": "[\\"meat_perfect\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:301', 301, 40, '{"129": "[\\"revolver_cattleman\\",1,6,73]", "97": "[\\"money\\",21]", "131": "[\\"melee_knife\\",1,0,1]", "132": "[\\"lasso\\",1]", "66": "[\\"ammo_rifle\\",45]", "130": "[\\"repeater_carbine\\",1,7,121]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:302', 302, 40, '{"97": "[\\"money\\",2]", "70": "[\\"melee_lantern_electric\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:303', 303, 40, '{"129": "[\\"pistol_volcanic\\",1,8,54]", "132": "[\\"melee_knife\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:304', 304, 40, '{"97": "[\\"money\\",156]", "129": "[\\"revolver_cattleman\\",1,6,34]", "66": "[\\"ammo_22\\",40]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:305', 305, 40, '{"97": "[\\"money\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:306', 306, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:310', 310, 40, '{"131": "[\\"lasso\\",1]", "132": "[\\"melee_knife\\",1,0,1]", "65": "[\\"melee_lantern_electric\\",1,0,1]", "129": "[\\"revolver_cattleman\\",1,5,194]", "77": "[\\"repeater_carbine\\",1,7,148]", "97": "[\\"money\\",1000]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:311', 311, 40, '{"68": "[\\"melee_lantern_electric\\",1,0,1]", "130": "[\\"repeater_evans\\",1,3,90]", "131": "[\\"melee_knife\\",1,0,1]", "132": "[\\"lasso\\",1]", "49": "[\\"meat\\",1]", "50": "[\\"meat_poor\\",3]", "97": "[\\"money\\",5948]", "66": "[\\"ammo_revolver\\",60]", "67": "[\\"ammo_revolver\\",20]", "74": "[\\"rifle_springfield\\",1,1,29]", "129": "[\\"revolver_doubleaction\\",1,6,54]", "65": "[\\"ammo_rifle\\",45]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:314', 314, 40, '{"131": "[\\"melee_knife\\",1,0,1]", "132": "[\\"lasso\\",1]", "97": "[\\"money\\",3999]", "129": "[\\"pistol_mauser\\",1,9,90]", "74": "[\\"repeater_evans\\",1,0,100]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:315', 315, 40, '{"49": "[\\"herb_parasol_mushroom\\",1]", "132": "[\\"melee_knife\\",1,0,1]", "97": "[\\"money\\",41]", "131": "[\\"lasso\\",1,0,0]", "130": "[\\"bow\\",1,0,38]", "65": "[\\"ammo_repeater\\",20]", "129": "[\\"revolver_lemat\\",1,9,179]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:316', 316, 40, '{"97": "[\\"money\\",4]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:318', 318, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:320', 320, 40, '{"132": "[\\"lasso\\",1]", "129": "[\\"revolver_lemat\\",1,9,111]", "68": "[\\"melee_knife\\",1,0,1]", "99": "[\\"money\\",1178]", "67": "[\\"repeater_carbine\\",1,7,68]", "66": "[\\"sniperrifle_rollingblock\\",1,1,78]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:321', 321, 40, '{"49": "[\\"herb_wild_mint\\",1]", "129": "[\\"revolver_cattleman\\",1,0,0]", "130": "[\\"melee_knife\\",1,0,1]", "50": "[\\"herb_oregano\\",1]", "97": "[\\"money\\",2690]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:322', 322, 40, '{"132": "[\\"lasso\\",1]", "49": "[\\"feather_1\\",1]", "52": "[\\"feather_5\\",1]", "97": "[\\"money\\",5081]", "66": "[\\"revolver_doubleaction\\",1,6,64]", "129": "[\\"revolver_lemat\\",1,9,111]", "53": "[\\"herb_wild_carrot\\",1]", "55": "[\\"herb_parasol_mushroom\\",1]", "69": "[\\"lasso\\",1,0,0]", "65": "[\\"melee_torch\\",1,0,1]", "33": "[\\"medicine_poor\\",1]", "67": "[\\"repeater_carbine\\",5,0,0]", "130": "[\\"melee_knife\\",1,0,1]", "50": "[\\"meat_perfect\\",2]", "51": "[\\"meat_poor\\",3]", "54": "[\\"meat_good\\",2]", "71": "[\\"melee_lantern_electric\\",1,0,1]", "131": "[\\"rifle_springfield\\",1,1,70]", "56": "[\\"meat_poor\\",2]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:323', 323, 40, '{"97": "[\\"money\\",4425]", "129": "[\\"melee_knife\\",1,0,1]", "130": "[\\"lasso\\",1]", "49": "[\\"raw_coal\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:324', 324, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:326', 326, 40, '{"97": "[\\"money\\",930]", "130": "[\\"revolver_cattleman\\",1,6,154]", "52": "[\\"feather_5\\",1]", "65": "[\\"ammo_arrow\\",7]", "132": "[\\"lasso\\",1]", "131": "[\\"melee_knife\\",1,0,1]", "129": "[\\"bow\\",1,0,7]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:327', 327, 40, '{"97": "[\\"money\\",457]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:328', 328, 40, '{"67": "[\\"money\\",0]", "80": "[\\"ammo_repeater\\",20]", "54": "[\\"feather_5\\",1]", "82": "[\\"acamp_firesmall\\",1]", "81": "[\\"acamp_bedroll\\",1]", "49": "[\\"meat_perfect\\",3]", "50": "[\\"herb_oregano\\",1]", "132": "[\\"lasso\\",1]", "131": "[\\"melee_knife\\",1,0,1]", "130": "[\\"bow\\",1,0,31]", "79": "[\\"lasso\\",1]", "129": "[\\"revolver_lemat\\",1,9,184]", "51": "[\\"meat_good\\",1]", "52": "[\\"meat_poor\\",1]", "53": "[\\"herb_wild_mint\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:331', 331, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:332', 332, 40, '{"50": "[\\"raw_iron\\",1]", "129": "[\\"revolver_cattleman\\",1,6,0]", "97": "[\\"money\\",45]", "49": "[\\"raw_coal\\",1]", "51": "[\\"raw_copper\\",1]", "66": "[\\"ammo_revolver\\",60]", "65": "[\\"ammo_revolver\\",40]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:333', 333, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:334', 334, 40, '{"17": "[\\"meat_cooked\\",3]", "18": "[\\"meat_cooked\\",1]", "19": "[\\"meat_oregano_cooked\\",1]", "97": "[\\"money\\",116]", "129": "[\\"revolver_cattleman\\",1,6,17]", "130": "[\\"melee_knife\\",1,0,1]", "131": "[\\"lasso\\",1]", "49": "[\\"meat_perfect\\",3]", "50": "[\\"meat_perfect\\",3]", "51": "[\\"meat_perfect\\",2]", "52": "[\\"meat_poor\\",1]", "65": "[\\"repeater_carbine\\",1,7,93]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:335', 335, 40, '{"49": "[\\"meat\\",1]", "97": "[\\"money\\",2]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:336', 336, 40, '{"131": "[\\"lasso\\",1]", "132": "[\\"melee_knife\\",1,0,1]", "129": "[\\"revolver_cattleman\\",1,6,60]", "130": "[\\"rifle_springfield\\",1,1,78]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:338', 338, 40, '{"56": "[\\"raw_coal\\",1]", "63": "[\\"raw_iron\\",1]", "64": "[\\"raw_copper\\",1]", "97": "[\\"money\\",700]", "98": "[\\"gold\\",400]", "129": "[\\"revolver_cattleman\\",1,6,94]", "130": "[\\"rifle_varmint\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:339', 339, 40, '{"130": "[\\"revolver_cattleman\\",1,4,10]", "131": "[\\"melee_knife\\",1,0,1]", "97": "[\\"money\\",12]", "49": "[\\"meat_poor\\",3]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:341', 341, 40, '{"98": "[\\"gold\\",160]", "129": "[\\"revolver_cattleman\\",1,3,38]", "66": "[\\"lasso\\",1]", "97": "[\\"money\\",675]", "49": "[\\"raw_iron\\",1]", "65": "[\\"ammo_arrow\\",10]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:343', 343, 40, '{"65": "[\\"repeater_evans\\",1,5,320]", "132": "[\\"lasso\\",1]", "129": "[\\"revolver_cattleman\\",1,5,86]", "66": "[\\"melee_lantern_electric\\",1,0,1]", "130": "[\\"rifle_springfield\\",1,1,93]", "72": "[\\"pistol_mauser\\",1,2,265]", "97": "[\\"money\\",6420]", "49": "[\\"meat_poor\\",2]", "50": "[\\"meat_perfect\\",3]", "51": "[\\"meat_perfect\\",3]", "52": "[\\"meat_perfect\\",3]", "53": "[\\"herb_wild_carrot\\",2]", "54": "[\\"meat_poor\\",3]", "55": "[\\"meat_perfect\\",1]", "56": "[\\"herb_alaskan_ginseng\\",1]", "131": "[\\"melee_knife\\",1,0,1]", "57": "[\\"herb_burdock_root\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:344', 344, 40, '{"97": "[\\"money\\",500]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:345', 345, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:346', 346, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:347', 347, 40, '{"49": "[\\"tobacco_seed\\",15]", "50": "[\\"corn_seed\\",15]", "51": "[\\"sugarcane_seed\\",15]", "52": "[\\"herb_oregano\\",2]", "53": "[\\"herb_common_bullrush\\",1]", "97": "[\\"money\\",559]", "130": "[\\"melee_knife\\",1,0,1]", "131": "[\\"revolver_cattleman\\",1,2,47]", "67": "[\\"ammo_rifle\\",45]", "68": "[\\"ammo_rifle\\",45]", "66": "[\\"ammo_rifle\\",10]", "129": "[\\"lasso\\",1,0,0]", "132": "[\\"melee_lantern_electric\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:349', 349, 40, '{"97": "[\\"money\\",50]", "129": "[\\"repeater_carbine\\",1,7,73]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:352', 352, 40, '{"97": "[\\"money\\",5153]", "49": "[\\"meat\\",1]", "129": "[\\"revolver_cattleman\\",1,4,14]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:353', 353, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:354', 354, 40, '{"70": "[\\"repeater_carbine\\",1,7,176]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:355', 355, 40, '{"129": "[\\"revolver_lemat\\",1,9,57]", "130": "[\\"bow\\",1,0,3]", "131": "[\\"melee_knife\\",1,0,1]", "132": "[\\"lasso\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:356', 356, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:358', 358, 40, '{"130": "[\\"rifle_springfield\\",1,1,52]", "129": "[\\"revolver_doubleaction\\",1,6,179]", "97": "[\\"money\\",28]", "131": "[\\"repeater_evans\\",1,4,43]", "67": "[\\"lasso\\",1]", "132": "[\\"melee_knife\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:359', 359, 40, '{"129": "[\\"revolver_doubleaction\\",1,3,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:360', 360, 40, '{"49": "[\\"meat\\",1]", "97": "[\\"money\\",350]", "50": "[\\"raw_coal\\",16]", "51": "[\\"raw_copper\\",2]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:362', 362, 40, '{"97": "[\\"money\\",1997]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:363', 363, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:364', 364, 40, '{"97": "[\\"money\\",1785]", "17": "[\\"meat_oregano_cooked\\",1]", "18": "[\\"meat_cooked\\",1]", "65": "[\\"melee_torch\\",1,0,1]", "129": "[\\"revolver_cattleman\\",1,2,154]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:365', 365, 40, '{"97": "[\\"money\\",25]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:367', 367, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:370', 370, 40, '{"98": "[\\"money\\",77]", "65": "[\\"melee_lantern_electric\\",1,0,1]", "130": "[\\"revolver_cattleman\\",1,6,17]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:371', 371, 40, '{"97": "[\\"money\\",75]", "131": "[\\"lasso\\",1]", "98": "[\\"gold\\",1]", "50": "[\\"raw_coal\\",18]", "51": "[\\"raw_copper\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:372', 372, 40, '{"97": "[\\"money\\",1]", "129": "[\\"revolver_cattleman\\",1,5,121]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:373', 373, 40, '{"49": "[\\"meat\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:375', 375, 40, '{"97": "[\\"money\\",4449]", "98": "[\\"gold\\",170]", "130": "[\\"revolver_lemat\\",1,4,176]", "66": "[\\"repeater_carbine\\",1,7,213]", "67": "[\\"rifle_boltaction\\",1,2,116]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:376', 376, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:377', 377, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:380', 380, 40, '{"97": "[\\"money\\",1]", "49": "[\\"raw_iron\\",7]", "50": "[\\"raw_iron\\",7]", "51": "[\\"raw_iron\\",7]", "52": "[\\"raw_copper\\",2]", "53": "[\\"raw_iron\\",7]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:381', 381, 40, '{"97": "[\\"money\\",474]", "129": "[\\"lasso\\",1]", "49": "[\\"meat\\",2]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:382', 382, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:385', 385, 40, '{"97": "[\\"money\\",1]", "129": "[\\"revolver_cattleman\\",1,6,25]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:386', 386, 40, '{"49": "[\\"herb_parasol_mushroom\\",1]", "51": "[\\"herb_wild_mint\\",1]", "52": "[\\"feather_5\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:387', 387, 40, '{"131": "[\\"lasso\\",1]", "67": "[\\"lasso\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:388', 388, 40, '{"97": "[\\"money\\",552]", "66": "[\\"rifle_varmint\\",1,0,0]", "67": "[\\"ammo_repeater\\",35]", "69": "[\\"ammo_repeater\\",45]", "129": "[\\"revolver_cattleman\\",1,0,20]", "65": "[\\"ammo_pistol\\",60]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:389', 389, 40, '{"97": "[\\"money\\",1089]", "65": "[\\"ammo_revolver\\",60]", "66": "[\\"ammo_revolver\\",40]", "129": "[\\"revolver_cattleman\\",1,5,28]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:390', 390, 40, '{"97": "[\\"money\\",125]", "131": "[\\"melee_knife\\",1,0,1]", "132": "[\\"lasso\\",1]", "49": "[\\"meat_poor\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:391', 391, 40, '{"97": "[\\"money\\",1]", "129": "[\\"bow\\",1,0,8]", "49": "[\\"raw_coal\\",15]", "50": "[\\"raw_copper\\",4]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:392', 392, 40, '{"129": "[\\"revolver_cattleman\\",1,6,83]", "97": "[\\"money\\",872]", "131": "[\\"melee_knife\\",1,0,1]", "130": "[\\"lasso\\",1]", "132": "[\\"bow\\",1,0,3]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:393', 393, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:394', 394, 40, '{"132": "[\\"lasso\\",1]", "97": "[\\"money\\",243]", "129": "[\\"rifle_springfield\\",1,1,48]", "130": "[\\"melee_knife\\",1,0,1]", "131": "[\\"bow\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:396', 396, 40, '{"97": "[\\"money\\",12595]", "129": "[\\"repeater_evans\\",1,1,49]", "132": "[\\"melee_lantern_electric\\",1,0,1]", "65": "[\\"lasso\\",1]", "66": "[\\"revolver_cattleman\\",1,3,1]", "131": "[\\"revolver_doubleaction\\",1,3,100]", "130": "[\\"rifle_springfield\\",1,1,64]", "67": "[\\"melee_knife\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:397', 397, 40, '{"131": "[\\"lasso\\",1]", "132": "[\\"melee_hatchet_hunter\\",1,0,1]", "129": "[\\"revolver_lemat\\",1,3,89]", "130": "[\\"repeater_carbine\\",3,7,82]", "81": "[\\"pigeonpost\\",1]", "17": "[\\"meat_cooked\\",3]", "33": "[\\"medicine_good\\",1]", "97": "[\\"money\\",6000]", "65": "[\\"repeater_winchester\\",1,0,0]", "68": "[\\"lasso\\",1]", "66": "[\\"lasso\\",1]", "67": "[\\"lasso\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:398', 398, 40, '{"97": "[\\"money\\",3400]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:399', 399, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:400', 400, 40, '{"129": "[\\"melee_knife\\",1,0,1]", "130": "[\\"revolver_cattleman\\",1,0,0]", "66": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "132": "[\\"lasso\\",1]", "97": "[\\"money\\",59]", "131": "[\\"bow\\",1,0,10]", "49": "[\\"meat_good\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:401', 401, 40, '{"131": "[\\"melee_knife\\",1,0,1]", "66": "[\\"bow\\",1,0,3]", "65": "[\\"repeater_carbine\\",1,4,70]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:402', 402, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:403', 403, 40, '{"49": "[\\"raw_iron\\",4]", "129": "[\\"melee_knife\\",1,0,1]", "50": "[\\"meat_poor\\",2]", "130": "[\\"lasso\\",1]", "131": "[\\"bow\\",1,0,0]", "97": "[\\"money\\",1]", "65": "[\\"ammo_arrow\\",10]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:404', 404, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:406', 406, 40, '{"49": "[\\"raw_coal\\",1]", "50": "[\\"meat_poor\\",1]", "97": "[\\"money\\",125]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:407', 407, 40, '{"49": "[\\"raw_coal\\",1]", "50": "[\\"meat_perfect\\",1]", "52": "[\\"raw_copper\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:409', 409, 40, '{"49": "[\\"meat_perfect\\",3]", "130": "[\\"bow\\",1,0,39]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:411', 411, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:414', 414, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:415', 415, 40, '{"49": "[\\"meat_poor\\",2]", "130": "[\\"bow\\",1,0,34]", "68": "[\\"lasso\\",1]", "67": "[\\"lasso\\",1]", "66": "[\\"lasso\\",1]", "97": "[\\"money\\",5000]", "129": "[\\"revolver_lemat\\",1,1,131]", "131": "[\\"repeater_winchester\\",1,11,109]", "132": "[\\"melee_knife\\",1,0,1]", "72": "[\\"lasso\\",1,0,0]", "33": "[\\"medicine_good\\",1]", "50": "[\\"meat_poor\\",1]", "17": "[\\"meat_cooked\\",2]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:417', 417, 40, '{"50": "[\\"herb_wild_mint\\",1]", "54": "[\\"herb_oregano\\",1]", "130": "[\\"revolver_lemat\\",1,9,129]", "34": "[\\"medicine_poor\\",1]", "131": "[\\"melee_knife\\",1,0,1]", "132": "[\\"lasso\\",1]", "49": "[\\"meat_poor\\",1]", "51": "[\\"meat_perfect\\",1]", "66": "[\\"rifle_springfield\\",1,1,80]", "33": "[\\"medicine_good\\",1]", "35": "[\\"medicine_good\\",1]", "67": "[\\"rifle_springfield\\",1,1,69]", "97": "[\\"money\\",5400]", "129": "[\\"rifle_springfield\\",1,1,91]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:437', 437, 40, '{"97": "[\\"money\\",2176]", "50": "[\\"raw_copper\\",1]", "66": "[\\"melee_lantern_electric\\",1,0,1]", "129": "[\\"melee_knife\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:438', 438, 40, '{"51": "[\\"raw_iron\\",1]", "129": "[\\"revolver_cattleman\\",1,6,46]", "49": "[\\"meat_poor\\",1]", "97": "[\\"money\\",3]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:439', 439, 40, '{"129": "[\\"revolver_cattleman\\",1,6,92]", "131": "[\\"melee_knife\\",1,0,1]", "130": "[\\"lasso\\",1]", "132": "[\\"bow\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:440', 440, 40, '{"97": "[\\"money\\",1321]", "129": "[\\"bow\\",1,0,0]", "131": "[\\"lasso\\",1]", "130": "[\\"melee_knife\\",1,0,1]", "50": "[\\"feather_5\\",1]", "53": "[\\"herb_oregano\\",1]", "52": "[\\"herb_alaskan_ginseng\\",2]", "132": "[\\"revolver_cattleman\\",1,2,43]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:441', 441, 20, '{"49": "[\\"meat_poor\\",1]", "97": "[\\"money\\",4399]", "50": "[\\"meat_good\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:442', 442, 20, '{"132": "[\\"lasso\\",1]", "131": "[\\"melee_knife\\",1,0,1]", "130": "[\\"repeater_carbine\\",1,5,0]", "97": "[\\"money\\",284]", "129": "[\\"revolver_cattleman\\",1,5,8]", "65": "[\\"melee_lantern_electric\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:443', 443, 20, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:445', 445, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:446', 446, 40, '{"132": "[\\"melee_knife\\",1,0,1]", "97": "[\\"money\\",1315]", "130": "[\\"bow\\",1,0,2]", "129": "[\\"revolver_cattleman\\",1,6,34]", "65": "[\\"melee_torch\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:447', 447, 40, '{"131": "[\\"melee_knife\\",1,0,1]", "132": "[\\"lasso\\",1]", "101": "[\\"money\\",262]", "50": "[\\"herb_american_ginseng\\",8]", "51": "[\\"herb_oregano\\",9]", "52": "[\\"herb_wild_mint\\",3]", "130": "[\\"revolver_cattleman\\",1,6,45]", "129": "[\\"repeater_carbine\\",1,7,96]", "53": "[\\"herb_burdock_root\\",5]", "55": "[\\"herb_parasol_mushroom\\",1]", "56": "[\\"herb_common_bullrush\\",8]", "57": "[\\"meat_perfect\\",1]", "58": "[\\"meat_good\\",2]", "60": "[\\"herb_oregano\\",4]", "49": "[\\"herb_alaskan_ginseng\\",10]", "54": "[\\"herb_wild_carrot\\",7]", "61": "[\\"herb_american_ginseng\\",4]", "62": "[\\"herb_common_bullrush\\",10]", "33": "[\\"medicine_good\\",1]", "59": "[\\"herb_common_bullrush\\",9]", "34": "[\\"medicine_good\\",1]", "17": "[\\"meat_oregano_cooked\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:449', 449, 40, '{"97": "[\\"money\\",1201]", "49": "[\\"raw_iron\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:451', 451, 40, '{"49": "[\\"meat_poor\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:452', 452, 40, '{"49": "[\\"feather_5\\",1]", "50": "[\\"meat_perfect\\",3]", "65": "[\\"bow\\",1,0,0]", "66": "[\\"melee_knife\\",1,0,1]", "67": "[\\"melee_torch\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:454', 454, 40, '{"97": "[\\"money\\",16]", "132": "[\\"melee_lantern_electric\\",1,0,1]", "131": "[\\"bow\\",1,0,0]", "130": "[\\"lasso\\",1,0,0]", "129": "[\\"melee_knife\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:455', 455, 40, '{"81": "[\\"pigeonpost\\",1]", "129": "[\\"revolver_doubleaction\\",1,6,49]", "130": "[\\"rifle_springfield\\",1,1,85]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:458', 458, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:459', 459, 40, '{"132": "[\\"lasso\\",1]", "129": "[\\"revolver_lemat\\",1,9,191]", "130": "[\\"melee_knife\\",1,0,1]", "65": "[\\"revolver_lemat\\",1,0,0]", "66": "[\\"revolver_doubleaction\\",1,6,181]", "67": "[\\"revolver_lemat\\",1,0,0]", "70": "[\\"rifle_boltaction\\",1,0,0]", "71": "[\\"rifle_boltaction\\",1,0,0]", "72": "[\\"repeater_evans\\",1,0,0]", "73": "[\\"repeater_evans\\",1,0,0]", "74": "[\\"rifle_boltaction\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:460', 460, 40, '{"131": "[\\"melee_knife\\",1,0,1]", "97": "[\\"money\\",425]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:461', 461, 40, '{"129": "[\\"revolver_cattleman\\",1,6,68]", "97": "[\\"money\\",11750]", "49": "[\\"raw_copper\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:462', 462, 40, '{"65": "[\\"revolver_lemat\\",1,1,99]", "132": "[\\"melee_knife\\",1,0,1]", "131": "[\\"lasso\\",1]", "130": "[\\"rifle_springfield\\",1,1,90]", "68": "[\\"ammo_22\\",60]", "49": "[\\"meat_perfect\\",2]", "50": "[\\"feather_1\\",1]", "51": "[\\"feather_1\\",1]", "52": "[\\"meat_good\\",1]", "69": "[\\"rifle_varmint\\",1,11,79]", "129": "[\\"shotgun_pump\\",1,5,49]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:463', 463, 40, '{"66": "[\\"ammo_rifle\\",20]", "129": "[\\"revolver_cattleman\\",1,6,37]", "130": "[\\"melee_knife\\",1,0,1]", "131": "[\\"bow\\",1,0,4]", "97": "[\\"money\\",150]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:465', 465, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:466', 466, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:467', 467, 40, '{"97": "[\\"money\\",300]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:468', 468, 40, '{"97": "[\\"money\\",50]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:469', 469, 40, '{"49": "[\\"meat_poor\\",1]", "97": "[\\"money\\",175]", "129": "[\\"melee_knife\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:470', 470, 40, '{"129": "[\\"bow\\",1,0,0]", "132": "[\\"melee_lantern_electric\\",1,0,1]", "97": "[\\"money\\",194]", "99": "[\\"money\\",144]", "131": "[\\"melee_knife\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:471', 471, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:472', 472, 40, '{"129": "[\\"revolver_cattleman\\",1,5,18]", "131": "[\\"lasso\\",1]", "130": "[\\"melee_knife\\",1,0,1]", "97": "[\\"money\\",1367]", "132": "[\\"melee_lantern_electric\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:474', 474, 40, '{"65": "[\\"lasso\\",1,0,0]", "67": "[\\"revolver_cattleman\\",1,6,81]", "131": "[\\"revolver_lemat\\",1,8,41]", "69": "[\\"ammo_revolver\\",60]", "70": "[\\"ammo_revolver\\",40]", "130": "[\\"melee_knife\\",1,0,1]", "49": "[\\"herb_oregano\\",4]", "52": "[\\"feather_2\\",1]", "71": "[\\"bow\\",1,0,30]", "101": "[\\"money\\",4449]", "50": "[\\"meat_good\\",1]", "73": "[\\"repeater_carbine\\",1,4,76]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:475', 475, 40, '{"97": "[\\"money\\",208]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:477', 477, 40, '{"49": "[\\"raw_copper\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:478', 478, 40, '{"132": "[\\"melee_knife\\",1,0,1]", "49": "[\\"herb_wild_carrot\\",1]", "50": "[\\"herb_wild_mint\\",1]", "97": "[\\"money\\",3001]", "51": "[\\"herb_rams_head\\",1]", "54": "[\\"meat_poor\\",2]", "77": "[\\"rifle_boltaction\\",1,5,53]", "78": "[\\"rifle_varmint\\",1,12,38]", "129": "[\\"revolver_lemat\\",1,9,69]", "53": "[\\"feather_2\\",1]", "55": "[\\"meat_poor\\",3]", "52": "[\\"herb_burdock_root\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:479', 479, 40, '{"97": "[\\"money\\",18]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:481', 481, 40, '{"131": "[\\"revolver_doubleaction\\",1,3,30]", "132": "[\\"melee_knife\\",1,0,1]", "130": "[\\"lasso\\",1]", "129": "[\\"bow\\",1,0,1]", "97": "[\\"money\\",1801]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:482', 482, 40, '{"97": "[\\"money\\",2401]", "50": "[\\"tobacco_seed\\",15]", "131": "[\\"melee_knife\\",1,0,1]", "129": "[\\"revolver_cattleman\\",1,4,79]", "52": "[\\"meat_poor\\",6]", "132": "[\\"lasso\\",1]", "130": "[\\"bow\\",1,0,3]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:483', 483, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:484', 484, 40, '{"129": "[\\"repeater_carbine\\",1,7,13]", "130": "[\\"bow\\",1,0,1]", "131": "[\\"melee_knife\\",1,0,1]", "97": "[\\"money\\",10530]", "49": "[\\"herb_oregano\\",4]", "51": "[\\"herb_burdock_root\\",4]", "52": "[\\"herb_wild_mint\\",2]", "54": "[\\"meat_poor\\",1]", "59": "[\\"meat_perfect\\",1]", "50": "[\\"herb_wild_carrot\\",7]", "53": "[\\"herb_common_bullrush\\",2]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:485', 485, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:486', 486, 40, '{"97": "[\\"money\\",957]", "131": "[\\"melee_knife\\",1,0,1]", "130": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "132": "[\\"bow\\",1,0,3]", "65": "[\\"ammo_arrow\\",8]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:487', 487, 40, '{"81": "[\\"pigeonpost\\",1]", "82": "[\\"pigeonpost\\",1]", "80": "[\\"melee_lantern_electric\\",1,0,1]", "132": "[\\"melee_knife\\",1,0,1]", "131": "[\\"lasso\\",1,0,0]", "97": "[\\"money\\",3263]", "129": "[\\"revolver_lemat\\",1,7,190]", "69": "[\\"ammo_rifle\\",45]", "65": "[\\"ammo_revolver\\",51]", "66": "[\\"rifle_boltaction\\",1,4,95]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:488', 488, 40, '{"49": "[\\"meat_poor\\",1]", "97": "[\\"money\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:489', 489, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:490', 490, 40, '{"131": "[\\"melee_knife\\",1,0,1]", "132": "[\\"lasso\\",1]", "130": "[\\"revolver_cattleman\\",1,6,127]", "97": "[\\"money\\",1279]", "129": "[\\"repeater_carbine\\",1,6,94]", "49": "[\\"herb_parasol_mushroom\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:492', 492, 40, '{"97": "[\\"money\\",816]", "132": "[\\"revolver_cattleman\\",1,6,12]", "129": "[\\"bow\\",1,0,8]", "130": "[\\"melee_knife\\",1,0,1]", "131": "[\\"lasso\\",1,0,0]", "69": "[\\"repeater_carbine\\",1,7,31]", "49": "[\\"meat_perfect\\",3]", "50": "[\\"meat_good\\",2]", "51": "[\\"meat_poor\\",1]", "52": "[\\"meat_perfect\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:493', 493, 40, '{"65": "[\\"melee_torch\\",1,0,1]", "129": "[\\"repeater_carbine\\",1,7,65]", "130": "[\\"lasso\\",1]", "131": "[\\"melee_knife\\",1,0,1]", "51": "[\\"feather_5\\",1]", "52": "[\\"feather_5\\",1]", "53": "[\\"feather_5\\",1]", "97": "[\\"money\\",430]", "132": "[\\"revolver_cattleman\\",1,5,35]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:494', 494, 40, '{"129": "[\\"bow\\",1,0,5]", "130": "[\\"revolver_cattleman\\",1,6,38]", "131": "[\\"repeater_winchester\\",1,6,17]", "97": "[\\"money\\",96]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:495', 495, 40, '{"129": "[\\"bow\\",1,0,8]", "97": "[\\"money\\",69]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:496', 496, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:497', 497, 40, '{"49": "[\\"raw_copper\\",1]", "129": "[\\"bow\\",1,0,1]", "131": "[\\"melee_knife\\",1,0,1]", "97": "[\\"money\\",1735]", "51": "[\\"herb_wild_carrot\\",1]", "130": "[\\"lasso\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:498', 498, 40, '{"65": "[\\"ammo_shotgun\\",35]", "73": "[\\"ammo_rifle\\",20]", "69": "[\\"ammo_shotgun\\",5]", "76": "[\\"rifle_varmint\\",1,6,147]", "80": "[\\"lasso\\",1]", "129": "[\\"revolver_cattleman\\",1,5,28]", "130": "[\\"melee_knife\\",1,0,1]", "132": "[\\"repeater_carbine\\",1,6,107]", "131": "[\\"bow\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:499', 499, 40, '{"97": "[\\"money\\",76]", "129": "[\\"revolver_cattleman\\",1,6,130]", "51": "[\\"raw_coal\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:500', 500, 40, '{"97": "[\\"money\\",65]", "68": "[\\"revolver_cattleman\\",1,0,0]", "131": "[\\"melee_knife\\",1,0,1]", "65": "[\\"ammo_rifle\\",20]", "66": "[\\"ammo_pistol\\",60]", "49": "[\\"meat_poor\\",1]", "130": "[\\"lasso\\",1,0,0]", "50": "[\\"herb_american_ginseng\\",1]", "76": "[\\"repeater_winchester\\",1,14,98]", "78": "[\\"pistol_mauser\\",1,10,60]", "129": "[\\"revolver_lemat\\",1,6,2]", "132": "[\\"rifle_springfield\\",1,1,87]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:501', 501, 40, '{"97": "[\\"money\\",1]", "131": "[\\"melee_knife\\",1,0,1]", "132": "[\\"lasso\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:502', 502, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:503', 503, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:504', 504, 40, '{"131": "[\\"revolver_doubleaction\\",1,6,107]", "132": "[\\"melee_knife\\",1,0,1]", "67": "[\\"melee_torch\\",1,0,1]", "75": "[\\"bow\\",1,0,0]", "80": "[\\"revolver_cattleman\\",1,0,0]", "79": "[\\"revolver_cattleman\\",1,0,0]", "130": "[\\"lasso\\",1]", "76": "[\\"bow\\",1,0,20]", "97": "[\\"money\\",3004]", "49": "[\\"meat_perfect\\",2]", "50": "[\\"meat_poor\\",1]", "98": "[\\"gold\\",100]", "33": "[\\"medicine_good\\",1]", "69": "[\\"repeater_henry\\",1,0,0]", "70": "[\\"repeater_henry\\",1,0,0]", "72": "[\\"repeater_evans\\",1,0,50]", "71": "[\\"rifle_springfield\\",1,1,87]", "129": "[\\"melee_lantern_electric\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:505', 505, 40, '{"97": "[\\"money\\",1946]", "65": "[\\"ammo_pistol\\",20]", "129": "[\\"revolver_cattleman\\",1,6,48]", "131": "[\\"melee_knife\\",1,0,1]", "130": "[\\"bow\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:506', 506, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:507', 507, 40, '{"132": "[\\"melee_knife\\",1,0,1]", "50": "[\\"raw_copper\\",1]", "97": "[\\"money\\",1497]", "130": "[\\"bow\\",1,0,3]", "129": "[\\"revolver_lemat\\",1,7,81]", "131": "[\\"repeater_carbine\\",1,6,53]", "65": "[\\"lasso\\",1]", "49": "[\\"meat_perfect\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:508', 508, 40, '{"130": "[\\"melee_knife\\",1,0,1]", "129": "[\\"bow\\",1,0,8]", "131": "[\\"repeater_carbine\\",1,6,104]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:509', 509, 40, '{"129": "[\\"revolver_cattleman\\",1,6,140]", "131": "[\\"melee_knife\\",1,0,1]", "130": "[\\"repeater_carbine\\",1,7,25]", "49": "[\\"meat_good\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:510', 510, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:511', 511, 40, '{"81": "[\\"pigeonpost\\",1]", "82": "[\\"pigeonpost\\",1]", "52": "[\\"feather_5\\",1]", "53": "[\\"herb_wild_mint\\",3]", "57": "[\\"feather_1\\",1]", "58": "[\\"feather_1\\",1]", "60": "[\\"herb_wild_carrot\\",5]", "54": "[\\"herb_parasol_mushroom\\",1]", "55": "[\\"herb_oregano\\",2]", "65": "[\\"rifle_springfield\\",1,1,180]", "97": "[\\"money\\",10582]", "132": "[\\"melee_knife\\",1,0,1]", "130": "[\\"revolver_lemat\\",1,8,137]", "69": "[\\"lasso\\",1,0,0]", "70": "[\\"repeater_evans\\",1,26,89]", "71": "[\\"repeater_carbine\\",1,1,196]", "72": "[\\"melee_torch\\",1,0,1]", "51": "[\\"herb_burdock_root\\",2]", "61": "[\\"herb_common_bullrush\\",1]", "49": "[\\"meat_perfect\\",3]", "50": "[\\"meat_good\\",1]", "56": "[\\"meat_poor\\",3]", "59": "[\\"meat_perfect\\",3]", "62": "[\\"meat_perfect\\",3]", "63": "[\\"meat_perfect\\",2]", "64": "[\\"meat_poor\\",1]", "73": "[\\"rifle_boltaction\\",1,4,72]", "66": "[\\"rifle_varmint\\",1,13,45]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:512', 512, 40, '{"97": "[\\"money\\",3884]", "129": "[\\"revolver_cattleman\\",1,5,48]", "49": "[\\"meat_poor\\",2]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:513', 513, 40, '{"129": "[\\"lasso\\",1]", "130": "[\\"melee_knife\\",1,0,1]", "97": "[\\"money\\",2803]", "132": "[\\"melee_lantern_electric\\",1,0,1]", "51": "[\\"herb_oregano\\",2]", "131": "[\\"bow\\",1,0,3]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:515', 515, 40, '{"129": "[\\"revolver_cattleman\\",1,6,11]", "130": "[\\"melee_knife\\",1,0,1]", "97": "[\\"money\\",5]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:516', 516, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:517', 517, 40, '{"129": "[\\"bow\\",1,0,6]", "130": "[\\"melee_knife\\",1,0,1]", "97": "[\\"money\\",52]", "131": "[\\"revolver_cattleman\\",1,6,34]", "65": "[\\"ammo_pistol\\",40]", "49": "[\\"meat_perfect\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:519', 519, 40, '{"97": "[\\"money\\",165]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:520', 520, 40, '{"131": "[\\"melee_knife\\",1,0,1]", "97": "[\\"money\\",8858]", "49": "[\\"meat_poor\\",4]", "129": "[\\"rifle_springfield\\",1,1,97]", "130": "[\\"repeater_evans\\",1,5,53]", "65": "[\\"revolver_doubleaction\\",1,6,193]", "66": "[\\"melee_lantern_electric\\",1,0,1]", "132": "[\\"lasso\\",1,0,0]", "67": "[\\"ammo_repeater\\",40]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:522', 522, 40, '{"49": "[\\"herb_burdock_root\\",6]", "50": "[\\"herb_wild_mint\\",2]", "51": "[\\"herb_wild_carrot\\",3]", "52": "[\\"herb_common_bullrush\\",10]", "81": "[\\"pigeonpost\\",1]", "82": "[\\"pigeonpost\\",1]", "69": "[\\"melee_lantern_electric\\",1,0,1]", "18": "[\\"meat_cooked\\",2]", "19": "[\\"meat_cooked\\",2]", "97": "[\\"money\\",443]", "53": "[\\"feather_1\\",1]", "65": "[\\"bow\\",1,0,6]", "57": "[\\"feather_1\\",1]", "54": "[\\"meat_perfect\\",3]", "55": "[\\"feather_2\\",1]", "56": "[\\"meat_poor\\",3]", "58": "[\\"feather_1\\",1]", "59": "[\\"meat_perfect\\",3]", "60": "[\\"feather_5\\",1]", "61": "[\\"herb_common_bullrush\\",2]", "66": "[\\"rifle_springfield\\",1,1,85]", "129": "[\\"revolver_lemat\\",1,9,184]", "130": "[\\"lasso\\",1]", "131": "[\\"melee_knife\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:523', 523, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:524', 524, 40, '{"50": "[\\"feather_5\\",1]", "53": "[\\"feather_5\\",1]", "54": "[\\"feather_5\\",1]", "55": "[\\"feather_2\\",1]", "51": "[\\"feather_2\\",1]", "49": "[\\"feather_5\\",1]", "52": "[\\"feather_2\\",1]", "56": "[\\"feather_2\\",1]", "57": "[\\"feather_5\\",1]", "59": "[\\"feather_5\\",1]", "60": "[\\"feather_5\\",1]", "78": "[\\"rifle_springfield\\",1,1,99]", "79": "[\\"repeater_evans\\",1,24,181]", "129": "[\\"pistol_mauser\\",1,10,90]", "130": "[\\"melee_knife\\",1,0,1]", "131": "[\\"lasso\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:525', 525, 40, '{"97": "[\\"money\\",164]", "129": "[\\"revolver_cattleman\\",1,5,23]", "132": "[\\"lasso\\",1]", "131": "[\\"melee_knife\\",1,0,1]", "49": "[\\"meat_poor\\",2]", "65": "[\\"bow\\",1,0,8]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:526', 526, 40, '{"131": "[\\"lasso\\",1,0,0]", "99": "[\\"money\\",632]", "107": "[\\"money\\",1]", "129": "[\\"revolver_doubleaction\\",1,6,22]", "130": "[\\"melee_knife\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:527', 527, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:528', 528, 40, '{"51": "[\\"feather_5\\",1]", "49": "[\\"meat_good\\",2]", "33": "[\\"eagleeye\\",1]", "65": "[\\"pistol_mauser\\",1,10,90]", "66": "[\\"melee_knife\\",1,0,1]", "67": "[\\"lasso\\",1]", "97": "[\\"money\\",5700]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:530', 530, 40, '{"131": "[\\"melee_knife\\",1,0,1]", "132": "[\\"lasso\\",1,0,0]", "97": "[\\"money\\",63]", "49": "[\\"feather_2\\",1]", "129": "[\\"revolver_cattleman\\",1,5,63]", "50": "[\\"herb_oregano\\",1]", "65": "[\\"bow\\",1,0,14]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:531', 531, 40, '{"52": "[\\"herb_american_ginseng\\",10]", "49": "[\\"herb_american_ginseng\\",4]", "108": "[\\"money\\",22306]", "55": "[\\"meat_perfect\\",1]", "56": "[\\"herb_wild_carrot\\",1]", "78": "[\\"melee_torch\\",1,0,1]", "50": "[\\"herb_burdock_root\\",2]", "51": "[\\"herb_wild_mint\\",1]", "66": "[\\"revolver_cattleman_john\\",1,5,91]", "71": "[\\"melee_knife\\",1,0,1]", "33": "[\\"medicine_good\\",1]", "34": "[\\"medicine_good\\",1]", "35": "[\\"medicine_good\\",1]", "53": "[\\"meat_good\\",2]", "36": "[\\"stimulant_good\\",1]", "37": "[\\"medicine_good\\",1]", "73": "[\\"bow\\",1,0,17]", "74": "[\\"lasso\\",1]", "130": "[\\"revolver_cattleman\\",1,0,34]", "77": "[\\"repeater_henry\\",1,13,126]", "129": "[\\"pistol_mauser\\",1,5,22]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:532', 532, 40, '{"97": "[\\"money\\",73]", "65": "[\\"melee_knife\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:533', 533, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:534', 534, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:535', 535, 40, '{"97": "[\\"money\\",12048]", "50": "[\\"raw_copper\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:536', 536, 40, '{"129": "[\\"revolver_lemat\\",1,9,129]", "130": "[\\"melee_knife\\",1,0,1]", "66": "[\\"lasso\\",1,0,0]", "49": "[\\"meat_perfect\\",1]", "65": "[\\"repeater_evans\\",1,5,54]", "67": "[\\"rifle_springfield\\",1,1,92]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:537', 537, 40, '{"49": "[\\"herb_wild_carrot\\",8]", "129": "[\\"revolver_cattleman\\",1,4,46]", "50": "[\\"herb_common_bullrush\\",4]", "51": "[\\"herb_wild_mint\\",1]", "52": "[\\"herb_wild_carrot\\",0]", "53": "[\\"herb_parasol_mushroom\\",1]", "54": "[\\"herb_oregano\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:539', 539, 40, '{"131": "[\\"melee_knife\\",1,0,1]", "132": "[\\"lasso\\",1,0,0]", "51": "[\\"herb_wild_carrot\\",1]", "17": "[\\"meat_cooked\\",2]", "49": "[\\"meat_poor\\",3]", "50": "[\\"meat_poor\\",2]", "69": "[\\"revolver_cattleman\\",1,3,148]", "129": "[\\"revolver_cattleman\\",1,6,188]", "130": "[\\"repeater_carbine\\",1,7,116]", "97": "[\\"money\\",750]", "65": "[\\"ammo_arrow\\",20]", "66": "[\\"bow\\",1,0,0]", "67": "[\\"revolver_cattleman\\",1,0,0]", "68": "[\\"bow\\",1,0,0]", "70": "[\\"revolver_cattleman\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:540', 540, 40, '{"82": "[\\"pigeonpost\\",1]", "131": "[\\"melee_knife\\",1,0,1]", "132": "[\\"lasso\\",1,0,0]", "130": "[\\"revolver_lemat\\",1,9,200]", "66": "[\\"melee_torch\\",1,0,1]", "81": "[\\"pigeonpost\\",1]", "77": "[\\"rifle_springfield\\",1,1,98]", "65": "[\\"melee_lantern_electric\\",1,0,1]", "33": "[\\"eagleeye\\",1]", "34": "[\\"eagleeye\\",1]", "35": "[\\"eagleeye\\",1]", "80": "[\\"bow\\",1,0,2]", "67": "[\\"ammo_revolver\\",60]", "69": "[\\"ammo_rifle\\",45]", "70": "[\\"ammo_rifle\\",45]", "79": "[\\"repeater_evans\\",1,24,216]", "68": "[\\"ammo_revolver\\",60]", "78": "[\\"rifle_boltaction\\",1,5,140]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:541', 541, 40, '{"132": "[\\"melee_knife\\",1,0,1]", "131": "[\\"bow\\",1,0,3]", "129": "[\\"revolver_cattleman\\",1,6,114]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:543', 543, 40, '{"132": "[\\"revolver_cattleman\\",1,6,67]", "130": "[\\"lasso\\",1]", "129": "[\\"repeater_carbine\\",1,0,0]", "131": "[\\"melee_knife\\",1,0,1]", "97": "[\\"money\\",600]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:544', 544, 40, '{"132": "[\\"lasso\\",1,0,0]", "65": "[\\"melee_knife\\",1,0,1]", "66": "[\\"bow\\",1,0,0]", "49": "[\\"meat_perfect\\",6]", "67": "[\\"melee_knife\\",1,0,1]", "68": "[\\"melee_lantern_electric\\",1,0,1]", "69": "[\\"rifle_varmint\\",1,12,78]", "50": "[\\"meat_poor\\",2]", "51": "[\\"meat_perfect\\",4]", "129": "[\\"revolver_doubleaction\\",1,6,134]", "130": "[\\"rifle_springfield\\",1,1,84]", "131": "[\\"shotgun_pump\\",1,4,54]", "97": "[\\"money\\",2]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:545', 545, 40, '{"97": "[\\"money\\",541]", "130": "[\\"melee_knife\\",1,0,1]", "49": "[\\"meat_poor\\",3]", "50": "[\\"meat_poor\\",1]", "67": "[\\"repeater_carbine\\",1,0,20]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:546', 546, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:547', 547, 40, '{"97": "[\\"money\\",57]", "131": "[\\"lasso\\",1,0,0]", "77": "[\\"revolver_cattleman\\",1,6,122]", "130": "[\\"revolver_doubleaction\\",1,6,193]", "129": "[\\"melee_knife\\",1,0,1]", "51": "[\\"herb_alaskan_ginseng\\",3]", "78": "[\\"bow\\",1,0,12]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:548', 548, 40, '{"130": "[\\"lasso\\",1]", "51": "[\\"herb_oregano\\",2]", "131": "[\\"melee_knife\\",1,0,1]", "65": "[\\"melee_torch\\",1,0,1]", "129": "[\\"bow\\",1,0,22]", "49": "[\\"raw_copper\\",2]", "50": "[\\"herb_alaskan_ginseng\\",1]", "97": "[\\"money\\",2041]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:549', 549, 40, '{"97": "[\\"money\\",251]", "49": "[\\"herb_alaskan_ginseng\\",1]", "50": "[\\"herb_oregano\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:550', 550, 40, '{"65": "[\\"repeater_carbine\\",0,0,0]", "131": "[\\"melee_knife\\",1,0,1]", "129": "[\\"revolver_lemat\\",1,9,189]", "130": "[\\"lasso\\",1]", "78": "[\\"rifle_boltaction\\",1,5,92]", "132": "[\\"melee_torch\\",1,0,1]", "33": "[\\"medicine_good\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:551', 551, 40, '{"132": "[\\"lasso\\",1,0,0]", "131": "[\\"bow\\",1,0,1]", "97": "[\\"money\\",505]", "130": "[\\"melee_knife\\",1,0,1]", "65": "[\\"revolver_cattleman\\",1,2,36]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:552', 552, 40, '{"129": "[\\"melee_knife\\",1,0,1]", "130": "[\\"bow\\",1,0,23]", "97": "[\\"money\\",46]", "49": "[\\"meat_perfect\\",2]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:553', 553, 40, '{"97": "[\\"money\\",64]", "129": "[\\"bow\\",1,0,5]", "130": "[\\"revolver_cattleman\\",1,6,20]", "131": "[\\"melee_knife\\",1,0,1]", "50": "[\\"herb_oregano\\",1]", "52": "[\\"feather_2\\",1]", "65": "[\\"lasso\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:554', 554, 40, '{"97": "[\\"money\\",6299]", "129": "[\\"melee_knife\\",1,0,1]", "66": "[\\"ammo_shotgun\\",35]", "132": "[\\"revolver_cattleman\\",1,6,20]", "67": "[\\"bow\\",1,0,6]", "68": "[\\"ammo_repeater\\",45]", "69": "[\\"ammo_revolver\\",60]", "130": "[\\"lasso\\",1]", "49": "[\\"meat_good\\",3]", "50": "[\\"meat_perfect\\",3]", "51": "[\\"meat_perfect\\",1]", "52": "[\\"meat_poor\\",2]", "53": "[\\"feather_5\\",1]", "54": "[\\"herb_common_bullrush\\",1]", "65": "[\\"repeater_carbine\\",1,7,43]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:555', 555, 40, '{"129": "[\\"melee_knife\\",1,0,1]", "130": "[\\"bow\\",1,0,21]", "131": "[\\"lasso\\",1,0,0]", "50": "[\\"feather_2\\",1]", "51": "[\\"feather_2\\",1]", "97": "[\\"money\\",3133]", "49": "[\\"meat_poor\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:556', 556, 40, '{"132": "[\\"lasso\\",1]", "129": "[\\"pistol_mauser\\",1,10,90]", "131": "[\\"melee_knife\\",1,0,1]", "33": "[\\"medicine_good\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:557', 557, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:558', 558, 40, '{"97": "[\\"money\\",30]", "66": "[\\"melee_torch\\",1,0,1]", "129": "[\\"revolver_cattleman\\",1,6,94]", "130": "[\\"melee_lantern_electric\\",1,0,1]", "131": "[\\"lasso\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:559', 559, 40, '{"50": "[\\"herb_common_bullrush\\",4]", "97": "[\\"money\\",1034]", "129": "[\\"revolver_doubleaction\\",1,6,31]", "130": "[\\"melee_knife\\",1,0,1]", "131": "[\\"lasso\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:560', 560, 40, '{"130": "[\\"bow\\",1,0,26]", "129": "[\\"melee_knife\\",1,0,1]", "97": "[\\"money\\",972]", "65": "[\\"lasso\\",1]", "49": "[\\"meat_perfect\\",3]", "50": "[\\"meat_good\\",1]", "51": "[\\"feather_2\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:561', 561, 40, '{"49": "[\\"raw_copper\\",10]", "50": "[\\"raw_iron\\",6]", "51": "[\\"raw_coal\\",4]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:562', 562, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:563', 563, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:564', 564, 40, '{"132": "[\\"lasso\\",1]", "74": "[\\"bow\\",1,0,6]", "129": "[\\"melee_lantern_electric\\",1,0,1]", "50": "[\\"herb_oregano\\",1]", "49": "[\\"raw_copper\\",14]", "51": "[\\"meat_perfect\\",2]", "97": "[\\"money\\",1560]", "130": "[\\"melee_knife\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:565', 565, 40, '{"97": "[\\"money\\",1400]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:566', 566, 40, '{"130": "[\\"melee_knife\\",1,0,1]", "131": "[\\"lasso\\",1,0,0]", "97": "[\\"money\\",268]", "58": "[\\"raw_iron\\",0]", "129": "[\\"revolver_cattleman\\",1,5,154]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:567', 567, 40, '{"130": "[\\"lasso\\",1,0,0]", "132": "[\\"melee_knife\\",1,0,1]", "97": "[\\"money\\",85]", "49": "[\\"herb_american_ginseng\\",1]", "50": "[\\"meat_poor\\",2]", "51": "[\\"herb_wild_carrot\\",1]", "52": "[\\"meat_good\\",1]", "65": "[\\"repeater_evans\\",1,26,171]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:568', 568, 40, '{"129": "[\\"melee_knife\\",1,0,1]", "130": "[\\"lasso\\",1,0,0]", "131": "[\\"bow\\",1,0,9]", "51": "[\\"herb_oregano\\",1]", "49": "[\\"feather_5\\",1]", "97": "[\\"money\\",4497]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:569', 569, 40, '{"49": "[\\"herb_wild_mint\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:570', 570, 40, '{"97": "[\\"money\\",207]", "65": "[\\"repeater_carbine\\",1,7,53]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:571', 571, 40, '{"129": "[\\"lasso\\",1]", "130": "[\\"melee_knife\\",1,0,1]", "131": "[\\"bow\\",1,0,8]", "132": "[\\"melee_lantern_electric\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:572', 572, 40, '{"50": "[\\"meat_perfect\\",3]", "37": "[\\"medicine_good\\",1]", "38": "[\\"medicine_good\\",1]", "39": "[\\"medicine_good\\",1]", "51": "[\\"herb_american_ginseng\\",4]", "52": "[\\"herb_oregano\\",5]", "40": "[\\"medicine_good\\",1]", "41": "[\\"medicine_good\\",1]", "42": "[\\"medicine_good\\",1]", "43": "[\\"medicine_good\\",1]", "44": "[\\"medicine_good\\",1]", "49": "[\\"meat_poor\\",3]", "53": "[\\"meat_perfect\\",3]", "54": "[\\"meat_perfect\\",3]", "97": "[\\"money\\",6]", "132": "[\\"melee_knife\\",1,0,1]", "55": "[\\"herb_parasol_mushroom\\",1]", "56": "[\\"meat_poor\\",3]", "78": "[\\"melee_torch\\",1,0,1]", "130": "[\\"lasso\\",1,0,0]", "131": "[\\"revolver_cattleman\\",1,6,180]", "77": "[\\"repeater_winchester\\",1,13,186]", "129": "[\\"bow\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:573', 573, 40, '{"97": "[\\"money\\",4737]", "130": "[\\"melee_knife\\",1,0,1]", "65": "[\\"bow\\",1,0,16]", "75": "[\\"lasso\\",1]", "131": "[\\"melee_lantern_electric\\",1,0,1]", "49": "[\\"herb_alaskan_ginseng\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:574', 574, 40, '{"132": "[\\"lasso\\",1,0,0]", "131": "[\\"melee_knife\\",1,0,1]", "129": "[\\"bow\\",1,0,20]", "50": "[\\"meat_good\\",1]", "97": "[\\"money\\",93]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:575', 575, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:576', 576, 40, '{"130": "[\\"melee_knife\\",1,0,1]", "131": "[\\"bow\\",1,0,9]", "97": "[\\"money\\",4]", "66": "[\\"melee_lantern_electric\\",1,0,1]", "132": "[\\"repeater_carbine\\",1,7,53]", "70": "[\\"revolver_cattleman\\",1,6,77]", "129": "[\\"lasso\\",1]", "49": "[\\"raw_coal\\",1]", "50": "[\\"raw_copper\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:577', 577, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:578', 578, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:579', 579, 40, '{"129": "[\\"melee_knife\\",1,0,1]", "130": "[\\"melee_lantern_electric\\",1,0,1]", "49": "[\\"herb_oregano\\",1]", "97": "[\\"money\\",5462]", "65": "[\\"melee_torch\\",1,0,1]", "81": "[\\"pigeonpost\\",1]", "82": "[\\"pigeonpost\\",1]", "83": "[\\"pigeonpost\\",1]", "50": "[\\"herb_american_ginseng\\",3]", "51": "[\\"herb_common_bullrush\\",2]", "52": "[\\"herb_wild_mint\\",4]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:580', 580, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:581', 581, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:582', 582, 40, '{"52": "[\\"herb_oregano\\",3]", "34": "[\\"stimulant_good\\",1]", "97": "[\\"money\\",394]", "65": "[\\"ammo_arrow\\",20]", "132": "[\\"melee_knife\\",1,0,1]", "131": "[\\"lasso\\",1]", "129": "[\\"revolver_cattleman\\",1,6,166]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:584', 584, 40, '{"49": "[\\"herb_american_ginseng\\",4]", "131": "[\\"lasso\\",1]", "130": "[\\"melee_knife\\",1,0,1]", "50": "[\\"herb_wild_mint\\",2]", "51": "[\\"meat_perfect\\",3]", "132": "[\\"bow\\",1,0,14]", "97": "[\\"money\\",190]", "129": "[\\"revolver_cattleman\\",1,6,108]", "52": "[\\"meat_poor\\",2]", "53": "[\\"herb_common_bullrush\\",2]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:585', 585, 40, '{"97": "[\\"money\\",8714]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:586', 586, 40, '{"49": "[\\"herb_oregano\\",1]", "66": "[\\"melee_lantern_electric\\",1,0,1]", "129": "[\\"melee_lantern_electric\\",1,0,1]", "130": "[\\"bow\\",1,0,2]", "131": "[\\"melee_knife\\",1,0,1]", "97": "[\\"money\\",117]", "132": "[\\"revolver_cattleman\\",1,6,10]", "50": "[\\"herb_common_bullrush\\",1]", "51": "[\\"meat_perfect\\",2]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:587', 587, 40, '{"131": "[\\"melee_lantern_electric\\",1,0,1]", "132": "[\\"lasso\\",1]", "49": "[\\"meat_poor\\",2]", "97": "[\\"money\\",125]", "129": "[\\"revolver_lemat\\",1,8,94]", "130": "[\\"melee_knife\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:588', 588, 40, '{"50": "[\\"feather_5\\",1]", "97": "[\\"money\\",578]", "49": "[\\"meat_poor\\",2]", "67": "[\\"ammo_revolver\\",60]", "132": "[\\"melee_knife\\",1,0,1]", "66": "[\\"rifle_varmint\\",1,0,0]", "68": "[\\"ammo_22\\",60]", "69": "[\\"ammo_revolver\\",60]", "129": "[\\"revolver_lemat\\",1,0,0]", "130": "[\\"bow\\",1,0,0]", "131": "[\\"lasso\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:589', 589, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:590', 590, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:591', 591, 40, '{"132": "[\\"lasso\\",1,0,0]", "97": "[\\"money\\",14449]", "81": "[\\"pigeonpost\\",1]", "49": "[\\"herb_black_berry\\",1]", "51": "[\\"herb_prairie_poppy\\",1]", "52": "[\\"herb_black_current\\",3]", "53": "[\\"herb_wild_feverfew\\",2]", "65": "[\\"melee_torch\\",1,0,1]", "50": "[\\"herb_common_bullrush\\",1]", "66": "[\\"repeater_carbine\\",1,7,108]", "54": "[\\"herb_parasol_mushroom\\",1]", "82": "[\\"acamp_tents_med_closed\\",1]", "83": "[\\"acamp_bedroll\\",1]", "55": "[\\"herb_oregano\\",1]", "56": "[\\"feather_5\\",1]", "33": "[\\"eagleeye\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:592', 592, 40, '{"49": "[\\"meat_perfect\\",2]", "51": "[\\"herb_oregano\\",1]", "50": "[\\"meat_poor\\",1]", "97": "[\\"money\\",652]", "69": "[\\"fishingrod\\",1,0,1]", "66": "[\\"thrown_throwing_knives\\",1,0,1]", "70": "[\\"melee_torch\\",1,0,1]", "74": "[\\"lasso\\",1]", "75": "[\\"melee_knife\\",1,0,1]", "73": "[\\"revolver_lemat\\",1,5,27]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:593', 593, 40, '{"132": "[\\"melee_knife\\",1,0,1]", "130": "[\\"lasso\\",1,0,0]", "129": "[\\"revolver_cattleman\\",1,4,69]", "74": "[\\"bow\\",1,0,5]", "97": "[\\"money\\",4538]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:594', 594, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:595', 595, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:596', 596, 40, '{"97": "[\\"money\\",722]", "132": "[\\"lasso\\",1]", "131": "[\\"melee_knife\\",1,0,1]", "130": "[\\"revolver_cattleman\\",1,6,8]", "65": "[\\"ammo_pistol\\",40]", "49": "[\\"meat_perfect\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:597', 597, 40, '{"132": "[\\"melee_lantern_electric\\",1,0,1]", "66": "[\\"melee_lantern_electric\\",1,0,1]", "70": "[\\"rifle_springfield\\",1,1,131]", "97": "[\\"money\\",3000]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:598', 598, 40, '{"130": "[\\"melee_knife\\",1,0,1]", "129": "[\\"bow\\",1,0,2]", "97": "[\\"money\\",17]", "49": "[\\"feather_5\\",1]", "131": "[\\"melee_lantern_electric\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:599', 599, 40, '{"132": "[\\"melee_knife\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:600', 600, 40, '{"50": "[\\"feather_2\\",1]", "52": "[\\"feather_2\\",1]", "51": "[\\"feather_2\\",1]", "54": "[\\"herb_common_bullrush\\",1]", "55": "[\\"herb_wild_carrot\\",2]", "131": "[\\"lasso\\",1,0,0]", "130": "[\\"bow\\",1,0,19]", "129": "[\\"melee_knife\\",1,0,1]", "56": "[\\"feather_1\\",1]", "57": "[\\"feather_1\\",1]", "58": "[\\"feather_1\\",1]", "97": "[\\"money\\",3]", "65": "[\\"rifle_varmint\\",1,11,26]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:601', 601, 40, '{"65": "[\\"melee_lantern_electric\\",1,0,1]", "130": "[\\"melee_knife\\",1,0,1]", "131": "[\\"lasso\\",1,0,0]", "66": "[\\"bow\\",1,0,8]", "129": "[\\"revolver_lemat\\",1,8,26]", "70": "[\\"revolver_cattleman\\",1,4,29]", "97": "[\\"money\\",6001]", "68": "[\\"rifle_springfield\\",1,1,19]", "71": "[\\"ammo_rifle\\",35]", "132": "[\\"rifle_boltaction\\",1,4,40]", "49": "[\\"meat_poor\\",3]", "50": "[\\"herb_common_bullrush\\",1]", "51": "[\\"herb_wild_carrot\\",1]", "52": "[\\"meat_poor\\",1]", "53": "[\\"meat_perfect\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:602', 602, 40, '{"65": "[\\"repeater_evans\\",1,20,20]", "131": "[\\"melee_knife\\",1,0,1]", "68": "[\\"pistol_mauser\\",1,9,51]", "129": "[\\"revolver_lemat\\",1,2,175]", "97": "[\\"money\\",6073]", "50": "[\\"herb_alaskan_ginseng\\",2]", "52": "[\\"herb_wild_carrot\\",1]", "69": "[\\"melee_torch\\",1,0,1]", "132": "[\\"rifle_boltaction\\",1,3,87]", "49": "[\\"meat_perfect\\",1]", "70": "[\\"lasso\\",1]", "130": "[\\"rifle_springfield\\",1,1,78]", "51": "[\\"herb_oregano\\",1]", "53": "[\\"meat_poor\\",3]", "54": "[\\"herb_burdock_root\\",1]", "55": "[\\"herb_american_ginseng\\",3]", "56": "[\\"meat_poor\\",3]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:603', 603, 40, '{"49": "[\\"herb_wild_carrot\\",1]", "97": "[\\"money\\",5800]", "130": "[\\"melee_knife\\",1,0,1]", "132": "[\\"lasso\\",1]", "77": "[\\"bow\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:604', 604, 40, '{"131": "[\\"lasso\\",1]", "49": "[\\"herb_wild_carrot\\",5]", "129": "[\\"revolver_cattleman\\",1,1,98]", "50": "[\\"herb_american_ginseng\\",7]", "51": "[\\"herb_wild_mint\\",4]", "97": "[\\"money\\",361]", "52": "[\\"herb_oregano\\",1]", "56": "[\\"herb_parasol_mushroom\\",2]", "53": "[\\"herb_common_bullrush\\",5]", "65": "[\\"bow\\",1,0,13]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:605', 605, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:606', 606, 40, '{"49": "[\\"herb_parasol_mushroom\\",1]", "129": "[\\"bow\\",1,0,2]", "130": "[\\"melee_knife\\",1,0,1]", "97": "[\\"money\\",1061]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:607', 607, 40, '{"65": "[\\"lasso\\",1]", "131": "[\\"melee_lantern_electric\\",1,0,1]", "132": "[\\"melee_knife\\",1,0,1]", "50": "[\\"herb_american_ginseng\\",2]", "51": "[\\"herb_common_bullrush\\",3]", "97": "[\\"money\\",9021]", "17": "[\\"meat_cooked\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:608', 608, 40, '{"132": "[\\"lasso\\",1]", "53": "[\\"herb_wild_carrot\\",6]", "81": "[\\"acamp_firesmall\\",1]", "82": "[\\"acamp_tents_med_closed\\",1]", "49": "[\\"herb_wild_mint\\",1]", "50": "[\\"meat_poor\\",2]", "51": "[\\"herb_alaskan_ginseng\\",1]", "97": "[\\"money\\",516]", "54": "[\\"herb_burdock_root\\",1]", "130": "[\\"melee_knife\\",1,0,1]", "55": "[\\"meat_poor\\",2]", "66": "[\\"bow\\",1,0,33]", "129": "[\\"revolver_lemat\\",1,9,142]", "65": "[\\"melee_lantern_electric\\",1,0,1]", "67": "[\\"repeater_carbine\\",1,7,193]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:609', 609, 40, '{"52": "[\\"herb_parasol_mushroom\\",1]", "51": "[\\"herb_common_bullrush\\",2]", "53": "[\\"herb_american_ginseng\\",4]", "55": "[\\"herb_wild_carrot\\",3]", "65": "[\\"melee_torch\\",1,0,1]", "97": "[\\"money\\",302]", "66": "[\\"melee_lantern_electric\\",1,0,1]", "130": "[\\"lasso\\",1]", "131": "[\\"melee_knife\\",1,0,1]", "129": "[\\"bow\\",1,0,6]", "132": "[\\"revolver_cattleman\\",1,6,114]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:610', 610, 40, '{"34": "[\\"medicine_good\\",1]", "33": "[\\"medicine_good\\",1]", "37": "[\\"medicine_good\\",1]", "38": "[\\"medicine_good\\",1]", "41": "[\\"medicine_good\\",1]", "42": "[\\"medicine_good\\",1]", "45": "[\\"stimulant_good\\",1]", "46": "[\\"stimulant_good\\",1]", "35": "[\\"medicine_good\\",1]", "49": "[\\"meat_perfect\\",3]", "50": "[\\"meat_perfect\\",3]", "51": "[\\"meat_perfect\\",3]", "52": "[\\"meat_perfect\\",3]", "53": "[\\"meat_perfect\\",2]", "97": "[\\"money\\",8500]", "129": "[\\"lasso\\",1,0,0]", "130": "[\\"melee_knife\\",1,0,1]", "131": "[\\"revolver_cattleman\\",1,6,185]", "65": "[\\"rifle_springfield\\",1,1,77]", "132": "[\\"melee_torch\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:611', 611, 40, '{"129": "[\\"melee_knife\\",1,0,1]", "49": "[\\"herb_common_bullrush\\",2]", "51": "[\\"herb_wild_mint\\",1]", "52": "[\\"herb_oregano\\",1]", "54": "[\\"herb_wild_carrot\\",4]", "55": "[\\"herb_parasol_mushroom\\",1]", "101": "[\\"money\\",3504]", "56": "[\\"feather_5\\",1]", "65": "[\\"ammo_arrow\\",0]", "50": "[\\"meat_perfect\\",1]", "130": "[\\"bow\\",1,0,3]", "53": "[\\"meat_poor\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:612', 612, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:613', 613, 40, '{"81": "[\\"pigeonpost\\",1]", "129": "[\\"revolver_cattleman\\",1,4,142]", "132": "[\\"melee_knife\\",1,0,1]", "65": "[\\"bow\\",1,0,0]", "66": "[\\"ammo_arrow\\",15]", "130": "[\\"repeater_carbine\\",1,7,162]", "68": "[\\"lasso\\",1,0,0]", "17": "[\\"meat_cooked\\",3]", "18": "[\\"meat_cooked\\",3]", "19": "[\\"meat_cooked\\",3]", "20": "[\\"meat_cooked\\",1]", "131": "[\\"melee_lantern_electric\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:614', 614, 40, '{"132": "[\\"melee_knife\\",1,0,1]", "131": "[\\"bow\\",1,0,14]", "129": "[\\"revolver_cattleman\\",1,3,115]", "130": "[\\"lasso\\",1,0,0]", "50": "[\\"feather_1\\",1]", "54": "[\\"herb_oregano\\",3]", "49": "[\\"meat_poor\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:615', 615, 40, '{"53": "[\\"herb_common_bullrush\\",2]", "55": "[\\"herb_american_ginseng\\",1]", "81": "[\\"pigeonpost\\",1]", "129": "[\\"revolver_lemat\\",1,9,205]", "130": "[\\"lasso\\",1,0,0]", "131": "[\\"melee_knife\\",1,0,1]", "50": "[\\"meat_poor\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:616', 616, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:617', 617, 40, '{"51": "[\\"herb_oregano\\",1]", "50": "[\\"herb_burdock_root\\",1]", "52": "[\\"herb_parasol_mushroom\\",2]", "57": "[\\"feather_1\\",1]", "58": "[\\"feather_2\\",1]", "49": "[\\"meat_perfect\\",3]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:618', 618, 40, '{"49": "[\\"herb_american_ginseng\\",7]", "130": "[\\"revolver_cattleman\\",1,3,51]", "131": "[\\"melee_knife\\",1,0,1]", "66": "[\\"ammo_pistol\\",20]", "52": "[\\"herb_common_bullrush\\",5]", "50": "[\\"herb_oregano\\",1]", "53": "[\\"herb_wild_mint\\",3]", "57": "[\\"herb_alaskan_ginseng\\",1]", "129": "[\\"bow\\",1,0,5]", "97": "[\\"money\\",35]", "51": "[\\"herb_wild_carrot\\",1]", "54": "[\\"herb_burdock_root\\",1]", "67": "[\\"melee_lantern_electric\\",1,0,1]", "68": "[\\"repeater_carbine\\",1,0,40]", "132": "[\\"lasso\\",1,0,0]", "65": "[\\"revolver_lemat\\",1,4,124]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:619', 619, 40, '{"81": "[\\"acamp_firesmal_pan\\",1]", "18": "[\\"meat_oregano_cooked\\",1]", "49": "[\\"feather_2\\",1]", "50": "[\\"feather_1\\",1]", "51": "[\\"feather_2\\",1]", "52": "[\\"feather_5\\",1]", "53": "[\\"feather_5\\",1]", "129": "[\\"lasso\\",1,0,0]", "130": "[\\"melee_knife\\",1,0,1]", "54": "[\\"herb_common_bullrush\\",1]", "55": "[\\"meat_poor\\",1]", "33": "[\\"medicine_poor\\",1]", "34": "[\\"medicine_poor\\",1]", "66": "[\\"melee_lantern_electric\\",1,0,1]", "131": "[\\"revolver_cattleman\\",1,3,147]", "132": "[\\"bow\\",1,0,22]", "56": "[\\"meat_good\\",2]", "57": "[\\"meat_good\\",1]", "97": "[\\"money\\",137]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:620', 620, 40, '{"129": "[\\"lasso\\",1,0,0]", "59": "[\\"raw_copper\\",0]", "58": "[\\"raw_copper\\",0]", "49": "[\\"herb_burdock_root\\",2]", "53": "[\\"feather_5\\",1]", "56": "[\\"feather_1\\",1]", "81": "[\\"pigeonpost\\",1]", "66": "[\\"bow\\",1,0,37]", "50": "[\\"feather_1\\",1]", "51": "[\\"feather_1\\",1]", "54": "[\\"meat_poor\\",2]", "131": "[\\"melee_knife_vampire\\",1,0,0]", "82": "[\\"pigeonpost\\",1]", "55": "[\\"herb_oregano\\",1]", "52": "[\\"raw_gold\\",5]", "71": "[\\"melee_knife\\",1,0,1]", "132": "[\\"melee_lantern_electric\\",1,0,1]", "57": "[\\"herb_wild_mint\\",1]", "78": "[\\"repeater_carbine\\",1,4,183]", "130": "[\\"revolver_cattleman\\",1,6,177]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:621', 621, 40, '{"97": "[\\"money\\",8172]", "67": "[\\"melee_lantern_electric\\",1,0,1]", "66": "[\\"repeater_evans\\",1,24,143]", "65": "[\\"rifle_springfield\\",1,1,32]", "129": "[\\"revolver_lemat\\",1,9,201]", "132": "[\\"lasso\\",1]", "131": "[\\"melee_knife\\",1,0,1]", "68": "[\\"ammo_revolver\\",60]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:622', 622, 40, '{"97": "[\\"money\\",6690]", "50": "[\\"meat_poor\\",1]", "51": "[\\"raw_coal\\",1]", "65": "[\\"repeater_carbine\\",1,5,77]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:623', 623, 40, '{"49": "[\\"herb_alaskan_ginseng\\",1]", "65": "[\\"melee_knife\\",1,0,1]", "73": "[\\"repeater_carbine\\",0,7,133]", "66": "[\\"repeater_carbine\\",0,7,133]", "69": "[\\"ammo_arrow\\",4]", "51": "[\\"herb_american_ginseng\\",1]", "70": "[\\"ammo_rifle\\",45]", "132": "[\\"melee_knife\\",1,0,1]", "50": "[\\"repeater_carbine\\",0,7,133]", "54": "[\\"meat_perfect\\",2]", "55": "[\\"meat_good\\",1]", "56": "[\\"meat_poor\\",1]", "57": "[\\"meat_poor\\",3]", "58": "[\\"repeater_carbine\\",0,7,133]", "67": "[\\"repeater_carbine\\",0,7,133]", "97": "[\\"repeater_carbine\\",0,7,133]", "130": "[\\"revolver_lemat\\",1,8,151]", "17": "[\\"meat_cooked\\",3]", "68": "[\\"lasso\\",1,0,0]", "71": "[\\"ammo_rifle\\",20]", "74": "[\\"ammo_repeater\\",45]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:624', 624, 40, '{"82": "[\\"acamp_firesmall\\",1]", "81": "[\\"acamp_bedroll\\",1]", "132": "[\\"melee_knife\\",1,0,1]", "49": "[\\"herb_parasol_mushroom\\",1]", "50": "[\\"herb_alaskan_ginseng\\",1]", "51": "[\\"meat_perfect\\",3]", "52": "[\\"meat_perfect\\",2]", "129": "[\\"revolver_lemat\\",1,9,200]", "33": "[\\"eagleeye\\",1]", "131": "[\\"lasso\\",1]", "53": "[\\"herb_black_berry\\",1]", "65": "[\\"rifle_boltaction\\",1,5,95]", "66": "[\\"melee_lantern_electric\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:625', 625, 40, '{"49": "[\\"meat_perfect\\",2]", "50": "[\\"meat_perfect\\",2]", "132": "[\\"lasso\\",1]", "131": "[\\"melee_knife\\",1,0,1]", "129": "[\\"revolver_lemat\\",1,9,188]", "97": "[\\"money\\",58]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:626', 626, 40, '{"33": "[\\"medicine_good\\",1]", "130": "[\\"repeater_carbine\\",1,7,86]", "132": "[\\"melee_knife\\",1,0,1]", "129": "[\\"lasso\\",1,0,0]", "65": "[\\"bow\\",1,0,33]", "131": "[\\"revolver_lemat\\",1,9,103]", "49": "[\\"meat_poor\\",3]", "50": "[\\"meat_poor\\",2]", "51": "[\\"herb_alaskan_ginseng\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:627', 627, 40, '{"129": "[\\"pistol_mauser\\",1,10,90]", "33": "[\\"medicine_poor\\",1]", "34": "[\\"medicine_poor\\",1]", "35": "[\\"stimulant_poor\\",1]", "36": "[\\"medicine_poor\\",1]", "97": "[\\"money\\",4001]", "37": "[\\"eagleeye\\",1]", "131": "[\\"melee_knife\\",1,0,1]", "130": "[\\"rifle_springfield\\",1,1,98]", "132": "[\\"repeater_evans\\",1,26,55]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:628', 628, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:629', 629, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:630', 630, 40, '{"97": "[\\"money\\",3123]", "49": "[\\"herb_burdock_root\\",1]", "50": "[\\"herb_burdock_root\\",1]", "51": "[\\"herb_burdock_root\\",1]", "17": "[\\"meat_cooked\\",1]", "130": "[\\"melee_knife\\",1,0,1]", "52": "[\\"herb_parasol_mushroom\\",1]", "53": "[\\"meat_perfect\\",1]", "54": "[\\"meat_poor\\",1]", "55": "[\\"herb_common_bullrush\\",1]", "67": "[\\"melee_knife\\",1,0,1]", "129": "[\\"pistol_mauser\\",1,10,90]", "75": "[\\"rifle_springfield\\",1,1,159]", "131": "[\\"lasso\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:631', 631, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:632', 632, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:633', 633, 40, '{"129": "[\\"revolver_cattleman\\",1,6,171]", "97": "[\\"money\\",70]", "65": "[\\"rifle_springfield\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:634', 634, 40, '{"49": "[\\"herb_oregano\\",1]", "130": "[\\"bow\\",1,0,10]", "129": "[\\"melee_knife\\",1,0,1]", "132": "[\\"lasso\\",1]", "51": "[\\"herb_burdock_root\\",1]", "106": "[\\"money\\",550]", "131": "[\\"revolver_cattleman\\",1,6,74]", "65": "[\\"melee_lantern_electric\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:635', 635, 40, '{"131": "[\\"melee_knife\\",1,0,1]", "130": "[\\"lasso\\",1,0,0]", "65": "[\\"bow\\",1,0,21]", "98": "[\\"money\\",304]", "132": "[\\"melee_lantern_electric\\",1,0,1]", "49": "[\\"meat_perfect\\",1]", "129": "[\\"revolver_cattleman\\",1,6,119]", "50": "[\\"meat_poor\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:636', 636, 40, '{"129": "[\\"melee_lantern_electric\\",1,0,1]", "130": "[\\"lasso\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:637', 637, 40, '{"51": "[\\"herb_wild_carrot\\",10]", "129": "[\\"bow\\",1,0,1]", "130": "[\\"melee_knife\\",1,0,1]", "56": "[\\"herb_oregano\\",1]", "97": "[\\"money\\",6399]", "49": "[\\"herb_wild_carrot\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:638', 638, 40, '{"97": "[\\"money\\",2478]", "132": "[\\"melee_knife\\",1,0,1]", "49": "[\\"tobacco_seed\\",5]", "50": "[\\"herb_parasol_mushroom\\",1]", "51": "[\\"herb_wild_carrot\\",1]", "65": "[\\"melee_torch\\",1,0,1]", "52": "[\\"herb_common_bullrush\\",1]", "53": "[\\"herb_american_ginseng\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:639', 639, 40, '{"129": "[\\"revolver_cattleman\\",1,6,24]", "97": "[\\"money\\",1]", "132": "[\\"melee_knife\\",1,0,1]", "131": "[\\"lasso\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:640', 640, 40, '{"97": "[\\"money\\",10711]", "68": "[\\"melee_torch\\",1,0,1]", "130": "[\\"lasso\\",1]", "131": "[\\"melee_knife\\",1,0,1]", "132": "[\\"melee_lantern_electric\\",1,0,1]", "81": "[\\"acamp_tents_med_closed\\",1]", "129": "[\\"bow\\",1,0,3]", "55": "[\\"herb_burdock_root\\",2]", "58": "[\\"herb_prairie_poppy\\",1]", "50": "[\\"meat_perfect\\",3]", "65": "[\\"ammo_arrow\\",11]", "51": "[\\"meat_perfect\\",3]", "61": "[\\"herb_wild_carrot\\",1]", "49": "[\\"herb_common_bullrush\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:641', 641, 40, '{"129": "[\\"bow\\",1,0,7]", "131": "[\\"revolver_cattleman\\",1,2,11]", "130": "[\\"melee_knife\\",1,0,1]", "50": "[\\"herb_common_bullrush\\",1]", "97": "[\\"money\\",619]", "57": "[\\"herb_oregano\\",2]", "58": "[\\"herb_wild_carrot\\",1]", "65": "[\\"melee_torch\\",1,0,1]", "68": "[\\"melee_torch\\",1,0,1]", "67": "[\\"repeater_carbine\\",1,7,181]", "132": "[\\"lasso\\",1]", "52": "[\\"meat_good\\",1]", "53": "[\\"meat_perfect\\",1]", "49": "[\\"feather_5\\",1]", "51": "[\\"feather_5\\",1]", "54": "[\\"meat_poor\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:642', 642, 40, '{"49": "[\\"meat_poor\\",3]", "50": "[\\"meat_good\\",2]", "51": "[\\"meat_poor\\",3]", "52": "[\\"meat_poor\\",3]", "53": "[\\"meat_perfect\\",3]", "54": "[\\"meat_poor\\",3]", "102": "[\\"money\\",482]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:643', 643, 40, '{"50": "[\\"feather_2\\",1]", "53": "[\\"herb_alaskan_ginseng\\",1]", "81": "[\\"pigeonpost\\",1]", "54": "[\\"herb_wild_carrot\\",7]", "56": "[\\"herb_wild_mint\\",4]", "49": "[\\"herb_black_berry\\",1]", "57": "[\\"herb_burdock_root\\",5]", "58": "[\\"meat_perfect\\",3]", "17": "[\\"meat_oregano_cooked\\",2]", "52": "[\\"herb_american_ginseng\\",1]", "97": "[\\"money\\",102]", "100": "[\\"money\\",1650]", "55": "[\\"meat_poor\\",2]", "59": "[\\"meat_perfect\\",2]", "65": "[\\"bow\\",1,0,0]", "98": "[\\"money\\",650]", "60": "[\\"herb_parasol_mushroom\\",1]", "61": "[\\"meat_poor\\",1]", "69": "[\\"melee_knife\\",1,0,1]", "66": "[\\"rifle_springfield\\",1,1,97]", "129": "[\\"revolver_doubleaction\\",1,4,19]", "130": "[\\"lasso\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:644', 644, 40, '{"97": "[\\"money\\",1892]", "130": "[\\"melee_lantern_electric\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:645', 645, 40, '{"129": "[\\"revolver_cattleman\\",1,5,88]", "130": "[\\"melee_knife\\",1,0,1]", "49": "[\\"herb_oregano\\",1]", "50": "[\\"meat_poor\\",3]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:646', 646, 40, '{"97": "[\\"money\\",77]", "65": "[\\"melee_torch\\",1,0,1]", "129": "[\\"revolver_cattleman\\",1,5,26]", "130": "[\\"melee_knife\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:647', 647, 40, '{"129": "[\\"bow\\",1,0,1]", "97": "[\\"money\\",975]", "130": "[\\"melee_knife\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:648', 648, 40, '{"130": "[\\"bow\\",1,0,0]", "131": "[\\"melee_knife\\",1,0,1]", "132": "[\\"melee_lantern_electric\\",1,0,1]", "50": "[\\"meat_perfect\\",3]", "51": "[\\"herb_american_ginseng\\",2]", "49": "[\\"herb_wild_carrot\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:649', 649, 40, '{"49": "[\\"herb_common_bullrush\\",1]", "50": "[\\"herb_wild_mint\\",1]", "129": "[\\"melee_knife\\",1,0,1]", "130": "[\\"bow\\",1,0,3]", "131": "[\\"lasso\\",1]", "51": "[\\"meat_poor\\",1]", "17": "[\\"meat_oregano_cooked\\",2]", "18": "[\\"meat_cooked\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:650', 650, 40, '{"68": "[\\"melee_torch\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:651', 651, 40, '{"130": "[\\"melee_knife\\",1,0,1]", "49": "[\\"herb_common_bullrush\\",2]", "82": "[\\"acamp_firesmal_pan\\",1]", "52": "[\\"herb_alaskan_ginseng\\",1]", "129": "[\\"revolver_lemat\\",1,3,137]", "62": "[\\"herb_alaskan_ginseng\\",0]", "50": "[\\"feather_1\\",1]", "51": "[\\"feather_1\\",1]", "53": "[\\"herb_burdock_root\\",1]", "57": "[\\"herb_wild_carrot\\",4]", "60": "[\\"herb_oregano\\",5]", "97": "[\\"money\\",581]", "131": "[\\"repeater_winchester\\",1,4,0]", "66": "[\\"lasso\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:652', 652, 40, '{"49": "[\\"herb_wild_mint\\",1]", "130": "[\\"lasso\\",1]", "131": "[\\"melee_knife\\",1,0,1]", "132": "[\\"bow\\",1,0,0]", "129": "[\\"revolver_cattleman\\",1,6,156]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:653', 653, 40, '{"132": "[\\"lasso\\",1]", "97": "[\\"money\\",96]", "131": "[\\"melee_lantern_electric\\",1,0,1]", "129": "[\\"revolver_cattleman\\",1,6,154]", "65": "[\\"repeater_carbine\\",1,7,33]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:654', 654, 40, '{"65": "[\\"ammo_pistol\\",20]", "69": "[\\"melee_torch\\",1,0,1]", "129": "[\\"melee_knife\\",1,0,1]", "131": "[\\"revolver_cattleman\\",1,6,144]", "73": "[\\"bow\\",1,0,10]", "132": "[\\"melee_lantern_electric\\",1,0,1]", "130": "[\\"lasso\\",1]", "97": "[\\"money\\",5326]", "49": "[\\"meat_poor\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:655', 655, 40, '{"33": "[\\"medicine_good\\",1]", "34": "[\\"medicine_good\\",1]", "65": "[\\"repeater_henry\\",1,16,144]", "130": "[\\"lasso\\",1]", "129": "[\\"revolver_cattleman_john\\",1,5,189]", "131": "[\\"melee_knife\\",1,0,1]", "132": "[\\"bow\\",1,0,39]", "66": "[\\"melee_lantern_electric\\",1,0,1]", "97": "[\\"money\\",2500]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:656', 656, 40, '{"97": "[\\"money\\",158]", "129": "[\\"bow\\",1,0,5]", "130": "[\\"melee_knife\\",1,0,1]", "131": "[\\"melee_torch\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:657', 657, 40, '{"49": "[\\"herb_wild_mint\\",1]", "50": "[\\"meat_perfect\\",3]", "129": "[\\"revolver_cattleman\\",1,5,88]", "130": "[\\"lasso\\",1,0,0]", "131": "[\\"melee_knife\\",1,0,1]", "132": "[\\"bow\\",1,0,2]", "97": "[\\"money\\",5600]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:658', 658, 40, '{"49": "[\\"herb_common_bullrush\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:659', 659, 40, '{"129": "[\\"bow\\",1,0,10]", "130": "[\\"revolver_cattleman\\",1,6,54]", "131": "[\\"melee_lantern_electric\\",1,0,1]", "33": "[\\"medicine_good\\",1]", "97": "[\\"money\\",3510]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:660', 660, 40, '{"97": "[\\"money\\",1600]", "129": "[\\"revolver_cattleman\\",1,6,30]", "130": "[\\"melee_knife\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:661', 661, 40, '{"129": "[\\"revolver_cattleman\\",1,4,54]", "131": "[\\"melee_knife\\",1,0,1]", "49": "[\\"raw_iron\\",1]", "130": "[\\"bow\\",1,0,0]", "97": "[\\"money\\",55]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:662', 662, 40, '{"101": "[\\"money\\",714]", "67": "[\\"lasso\\",1,0,0]", "81": "[\\"pigeonpost\\",1]", "129": "[\\"revolver_cattleman\\",1,3,93]", "65": "[\\"melee_torch\\",1,0,1]", "49": "[\\"herb_prairie_poppy\\",1]", "102": "[\\"money\\",357]", "103": "[\\"money\\",89]", "50": "[\\"herb_oregano\\",10]", "51": "[\\"herb_american_ginseng\\",10]", "52": "[\\"herb_parasol_mushroom\\",10]", "131": "[\\"bow\\",1,0,32]", "71": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "130": "[\\"melee_knife\\",1,0,1]", "54": "[\\"meat_perfect\\",2]", "53": "[\\"herb_oregano\\",9]", "55": "[\\"herb_american_ginseng\\",4]", "56": "[\\"herb_common_bullrush\\",4]", "132": "[\\"repeater_carbine\\",1,3,56]", "57": "[\\"herb_parasol_mushroom\\",5]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:663', 663, 40, '{"52": "[\\"feather_5\\",1]", "97": "[\\"money\\",16204]", "129": "[\\"revolver_cattleman\\",1,6,106]", "67": "[\\"melee_lantern_electric\\",1,0,1]", "130": "[\\"lasso\\",1]", "131": "[\\"melee_knife\\",1,0,1]", "132": "[\\"repeater_carbine\\",1,7,189]", "49": "[\\"meat_good\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:664', 664, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:665', 665, 40, '{"97": "[\\"money\\",6448]", "129": "[\\"revolver_cattleman\\",1,6,29]", "131": "[\\"bow\\",1,0,0]", "130": "[\\"lasso\\",1]", "132": "[\\"melee_knife\\",1,0,1]", "50": "[\\"herb_wild_carrot\\",2]", "54": "[\\"meat_poor\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:666', 666, 40, '{"97": "[\\"money\\",12330]", "129": "[\\"revolver_cattleman\\",1,5,12]", "131": "[\\"lasso\\",1]", "50": "[\\"herb_burdock_root\\",10]", "49": "[\\"herb_common_bullrush\\",8]", "51": "[\\"herb_burdock_root\\",6]", "52": "[\\"herb_american_ginseng\\",7]", "53": "[\\"herb_oregano\\",2]", "54": "[\\"herb_wild_mint\\",1]", "132": "[\\"melee_lantern_electric\\",1,0,1]", "66": "[\\"melee_knife\\",1,0,1]", "67": "[\\"melee_knife\\",1,0,1]", "68": "[\\"melee_knife\\",1,0,1]", "130": "[\\"melee_knife\\",1,0,1]", "55": "[\\"herb_parasol_mushroom\\",4]", "33": "[\\"medicine_good\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:667', 667, 40, '{"49": "[\\"meat_perfect\\",1]", "69": "[\\"ammo_repeater\\",45]", "70": "[\\"ammo_repeater\\",45]", "71": "[\\"ammo_repeater\\",30]", "50": "[\\"feather_5\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:668', 668, 40, '{"97": "[\\"money\\",446]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:669', 669, 40, '{"97": "[\\"money\\",15121]", "130": "[\\"bow\\",1,0,2]", "129": "[\\"repeater_carbine\\",1,7,13]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:670', 670, 40, '{"67": "[\\"melee_lantern_electric\\",1,0,1]", "68": "[\\"ammo_arrow\\",3]", "97": "[\\"money\\",5703]", "49": "[\\"meat_poor\\",3]", "50": "[\\"meat_perfect\\",2]", "51": "[\\"meat_good\\",3]", "52": "[\\"meat_good\\",1]", "131": "[\\"melee_knife\\",1,0,1]", "66": "[\\"melee_torch\\",1,0,1]", "65": "[\\"revolver_doubleaction\\",1,5,166]", "132": "[\\"lasso\\",1,0,0]", "129": "[\\"revolver_lemat\\",1,2,181]", "69": "[\\"ammo_revolver\\",20]", "70": "[\\"ammo_pistol\\",20]", "71": "[\\"rifle_springfield\\",1,0,0]", "72": "[\\"pistol_volcanic\\",1,0,0]", "73": "[\\"revolver_cattleman\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:671', 671, 40, '{"51": "[\\"meat_perfect\\",2]", "130": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "53": "[\\"meat_poor\\",3]", "49": "[\\"meat_poor\\",2]", "50": "[\\"herb_wild_mint\\",1]", "52": "[\\"herb_common_bullrush\\",1]", "54": "[\\"herb_wild_carrot\\",1]", "132": "[\\"lasso\\",1]", "129": "[\\"bow\\",1,0,6]", "131": "[\\"melee_knife\\",1,0,1]", "97": "[\\"money\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:672', 672, 40, '{"82": "[\\"acamp_firesmal_pan\\",1]", "131": "[\\"lasso\\",1]", "132": "[\\"melee_knife\\",1,0,1]", "79": "[\\"repeater_winchester\\",0,0,0]", "49": "[\\"corn_seed\\",5]", "71": "[\\"lasso\\",0]", "81": "[\\"acamp_bedroll\\",1]", "50": "[\\"herb_wild_mint\\",1]", "129": "[\\"revolver_lemat\\",1,9,190]", "65": "[\\"melee_torch\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:673', 673, 40, '{"130": "[\\"melee_knife\\",1,0,1]", "50": "[\\"feather_2\\",1]", "51": "[\\"herb_wild_mint\\",1]", "131": "[\\"lasso\\",1]", "129": "[\\"revolver_lemat\\",1,4,21]", "65": "[\\"bow\\",1,0,0]", "66": "[\\"rifle_varmint\\",1,0,0]", "67": "[\\"ammo_repeater\\",10]", "81": "[\\"acamp_bedroll\\",1]", "49": "[\\"herb_burdock_root\\",1]", "52": "[\\"herb_wild_carrot\\",4]", "53": "[\\"meat_poor\\",1]", "97": "[\\"money\\",1050]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:674', 674, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:675', 675, 40, '{"97": "[\\"money\\",9]", "131": "[\\"melee_knife\\",1,0,1]", "130": "[\\"revolver_cattleman\\",1,4,52]", "51": "[\\"herb_american_ginseng\\",1]", "52": "[\\"herb_wild_carrot\\",1]", "129": "[\\"bow\\",1,0,0]", "50": "[\\"herb_common_bullrush\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:676', 676, 40, '{"131": "[\\"lasso\\",1,0,0]", "132": "[\\"melee_knife\\",1,0,1]", "130": "[\\"revolver_lemat\\",1,9,166]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:677', 677, 40, '{"106": "[\\"money\\",52]", "49": "[\\"herb_oregano\\",2]", "130": "[\\"melee_knife\\",1,0,1]", "129": "[\\"bow\\",1,0,18]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:678', 678, 40, '{"129": "[\\"melee_knife\\",1,0,1]", "130": "[\\"bow\\",1,0,4]", "49": "[\\"feather_5\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:679', 679, 40, '{"97": "[\\"money\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:680', 680, 40, '{"97": "[\\"money\\",1080]", "129": "[\\"bow\\",1,0,7]", "130": "[\\"melee_knife\\",1,0,1]", "49": "[\\"meat_good\\",1]", "50": "[\\"meat_perfect\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:681', 681, 40, '{"49": "[\\"herb_american_ginseng\\",2]", "50": "[\\"herb_common_bullrush\\",1]", "97": "[\\"money\\",2540]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:682', 682, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:683', 683, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:684', 684, 40, '{"51": "[\\"herb_wild_mint\\",1]", "54": "[\\"feather_1\\",1]", "52": "[\\"herb_rams_head\\",1]", "65": "[\\"bow\\",1,0,7]", "67": "[\\"revolver_cattleman\\",1,0,0]", "131": "[\\"lasso\\",1,0,0]", "132": "[\\"melee_lantern_electric\\",1,0,1]", "66": "[\\"melee_knife\\",1,0,1]", "97": "[\\"money\\",2]", "68": "[\\"revolver_cattleman\\",1,5,172]", "129": "[\\"melee_knife\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:685', 685, 40, '{"129": "[\\"melee_knife\\",1,0,1]", "130": "[\\"revolver_cattleman\\",1,6,193]", "131": "[\\"repeater_carbine\\",1,7,179]", "132": "[\\"melee_lantern_electric\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:686', 686, 40, '{"65": "[\\"melee_torch\\",1,0,1]", "97": "[\\"money\\",5]", "49": "[\\"meat_poor\\",2]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:687', 687, 40, '{"97": "[\\"money\\",1200]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:688', 688, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:689', 689, 40, '{"97": "[\\"money\\",145]", "129": "[\\"lasso\\",1]", "130": "[\\"melee_knife\\",1,0,1]", "131": "[\\"melee_lantern_electric\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:690', 690, 40, '{"130": "[\\"lasso\\",1]", "65": "[\\"melee_lantern_electric\\",1,0,1]", "66": "[\\"melee_knife\\",1,0,1]", "49": "[\\"meat_poor\\",1]", "67": "[\\"bow\\",1,0,0]", "68": "[\\"lasso\\",1]", "69": "[\\"lasso\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:691', 691, 40, '{"51": "[\\"herb_wild_mint\\",5]", "65": "[\\"melee_knife\\",1,0,1]", "97": "[\\"money\\",3]", "50": "[\\"herb_american_ginseng\\",2]", "52": "[\\"herb_common_bullrush\\",1]", "53": "[\\"herb_wild_carrot\\",1]", "132": "[\\"melee_lantern_electric\\",1,0,1]", "131": "[\\"melee_knife\\",1,0,1]", "130": "[\\"melee_hatchet_viking\\",1,0,1]", "66": "[\\"repeater_carbine\\",1,7,144]", "74": "[\\"bow\\",1,0,38]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:692', 692, 40, '{"129": "[\\"bow\\",1,0,7]", "130": "[\\"melee_knife\\",1,0,1]", "98": "[\\"money\\",52]", "131": "[\\"lasso\\",1,0,0]", "49": "[\\"meat_perfect\\",2]", "50": "[\\"meat_good\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:693', 693, 40, '{"97": "[\\"money\\",6573]", "50": "[\\"herb_oregano\\",1]", "130": "[\\"melee_knife\\",1,0,1]", "131": "[\\"lasso\\",1]", "132": "[\\"melee_lantern_electric\\",1,0,1]", "65": "[\\"bow\\",1,0,36]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:694', 694, 40, '{"129": "[\\"pistol_mauser\\",1,10,83]", "130": "[\\"melee_knife\\",1,0,1]", "131": "[\\"lasso\\",1]", "65": "[\\"rifle_springfield\\",1,1,95]", "67": "[\\"ammo_pistol\\",60]", "97": "[\\"money\\",3500]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:695', 695, 40, '{"130": "[\\"melee_knife\\",1,0,1]", "132": "[\\"lasso\\",1]", "131": "[\\"bow\\",1,0,15]", "129": "[\\"revolver_cattleman\\",1,4,59]", "65": "[\\"melee_lantern_electric\\",1,0,1]", "49": "[\\"meat_good\\",2]", "81": "[\\"acamp_bedroll\\",1]", "50": "[\\"meat_poor\\",3]", "66": "[\\"melee_torch\\",1,0,1]", "51": "[\\"meat_perfect\\",1]", "52": "[\\"herb_alaskan_ginseng\\",3]", "53": "[\\"herb_burdock_root\\",1]", "54": "[\\"herb_wild_carrot\\",1]", "97": "[\\"money\\",5645]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:696', 696, 40, '{"132": "[\\"lasso\\",1]", "17": "[\\"meat_cooked\\",1]", "81": "[\\"acamp_bedroll\\",1]", "130": "[\\"revolver_cattleman\\",1,6,140]", "49": "[\\"meat_poor\\",3]", "98": "[\\"money\\",1264]", "50": "[\\"meat_poor\\",3]", "131": "[\\"bow\\",1,0,34]", "51": "[\\"meat_poor\\",3]", "52": "[\\"meat_good\\",2]", "53": "[\\"herb_common_bullrush\\",1]", "54": "[\\"meat_poor\\",3]", "55": "[\\"meat_perfect\\",3]", "56": "[\\"meat_poor\\",1]", "70": "[\\"melee_torch\\",1,0,1]", "129": "[\\"melee_knife\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:697', 697, 40, '{"97": "[\\"money\\",783]", "49": "[\\"herb_wild_carrot\\",1]", "51": "[\\"herb_common_bullrush\\",1]", "130": "[\\"bow\\",1,0,16]", "129": "[\\"melee_knife\\",1,0,1]", "132": "[\\"melee_lantern_electric\\",1,0,1]", "131": "[\\"lasso\\",1]", "50": "[\\"meat_poor\\",2]", "52": "[\\"meat_perfect\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:698', 698, 40, '{"129": "[\\"revolver_cattleman\\",1,2,145]", "132": "[\\"melee_lantern_electric\\",1,0,1]", "130": "[\\"melee_knife\\",1,0,1]", "70": "[\\"bow\\",1,0,12]", "131": "[\\"lasso\\",1]", "51": "[\\"herb_alaskan_ginseng\\",1]", "53": "[\\"herb_burdock_root\\",1]", "49": "[\\"meat_poor\\",2]", "52": "[\\"herb_oregano\\",3]", "54": "[\\"herb_wild_carrot\\",5]", "55": "[\\"raw_copper\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:699', 699, 40, '{"129": "[\\"bow\\",1,0,32]", "131": "[\\"melee_knife\\",1,0,1]", "132": "[\\"lasso\\",1,0,0]", "101": "[\\"money\\",2121]", "65": "[\\"repeater_carbine\\",1,6,158]", "130": "[\\"revolver_lemat\\",1,9,201]", "17": "[\\"meat_oregano_cooked\\",2]", "18": "[\\"meat_cooked\\",3]", "49": "[\\"herb_common_bullrush\\",2]", "50": "[\\"herb_black_berry\\",1]", "51": "[\\"herb_burdock_root\\",1]", "19": "[\\"meat_cooked\\",2]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:700', 700, 40, '{"49": "[\\"herb_wild_carrot\\",3]", "65": "[\\"revolver_cattleman\\",1,0,0]", "50": "[\\"herb_oregano\\",1]", "129": "[\\"bow\\",1,0,0]", "130": "[\\"lasso\\",1]", "131": "[\\"melee_knife\\",1,0,1]", "97": "[\\"money\\",835]", "66": "[\\"melee_lantern_electric\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:701', 701, 40, '{"97": "[\\"money\\",1770]", "67": "[\\"ammo_revolver\\",20]", "129": "[\\"revolver_cattleman\\",1,6,54]", "68": "[\\"melee_lantern_electric\\",1,0,1]", "130": "[\\"melee_knife\\",1,0,1]", "131": "[\\"melee_lantern_electric\\",1,0,1]", "132": "[\\"melee_torch\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:702', 702, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:703', 703, 40, '{"129": "[\\"revolver_cattleman\\",1,6,109]", "130": "[\\"melee_knife\\",1,0,1]", "131": "[\\"lasso\\",1]", "49": "[\\"herb_common_bullrush\\",10]", "50": "[\\"herb_wild_mint\\",3]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:704', 704, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:705', 705, 40, '{"97": "[\\"money\\",804]", "68": "[\\"melee_knife\\",1,0,1]", "65": "[\\"melee_knife\\",1,0,1]", "129": "[\\"melee_knife\\",1,0,1]", "130": "[\\"lasso\\",1]", "131": "[\\"bow\\",1,0,5]", "49": "[\\"herb_wild_mint\\",1]", "50": "[\\"herb_oregano\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:706', 706, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:707', 707, 40, '{"129": "[\\"melee_lantern_electric\\",1,0,1]", "50": "[\\"herb_wild_mint\\",4]", "130": "[\\"melee_knife\\",1,0,1]", "51": "[\\"herb_wild_carrot\\",8]", "131": "[\\"lasso\\",1,0,0]", "54": "[\\"herb_burdock_root\\",1]", "53": "[\\"herb_parasol_mushroom\\",2]", "55": "[\\"herb_common_bullrush\\",1]", "97": "[\\"money\\",35]", "65": "[\\"repeater_carbine\\",1,6,33]", "132": "[\\"bow\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:708', 708, 40, '{"67": "[\\"ammo_pistol\\",20]", "53": "[\\"herb_wild_carrot\\",4]", "97": "[\\"money\\",1015]", "56": "[\\"herb_oregano\\",1]", "65": "[\\"bow\\",1,0,12]", "66": "[\\"revolver_cattleman\\",1,4,6]", "68": "[\\"melee_knife\\",1,0,1]", "69": "[\\"lasso\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:709', 709, 40, '{"49": "[\\"meat_poor\\",3]", "50": "[\\"meat_poor\\",2]", "67": "[\\"ammo_rifle\\",15]", "45": "[\\"eagleeye\\",1]", "97": "[\\"money\\",9601]", "68": "[\\"lasso\\",1]", "71": "[\\"ammo_revolver\\",60]", "72": "[\\"ammo_revolver\\",60]", "73": "[\\"ammo_revolver\\",40]", "129": "[\\"revolver_lemat\\",1,9,230]", "130": "[\\"lasso\\",1]", "131": "[\\"melee_knife\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:710', 710, 40, '{"49": "[\\"herb_common_bullrush\\",6]", "50": "[\\"meat_poor\\",3]", "51": "[\\"herb_burdock_root\\",1]", "52": "[\\"meat_poor\\",2]", "129": "[\\"revolver_cattleman\\",1,0,0]", "65": "[\\"ammo_22\\",40]", "97": "[\\"money\\",373]", "66": "[\\"melee_knife\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:711', 711, 40, '{"97": "[\\"money\\",495]", "65": "[\\"repeater_carbine\\",1,6,181]", "131": "[\\"melee_knife\\",1,0,1]", "68": "[\\"melee_lantern_electric\\",1,0,1]", "17": "[\\"meat_cooked\\",2]", "18": "[\\"meat_cooked\\",1]", "50": "[\\"herb_oregano\\",1]", "49": "[\\"meat_perfect\\",1]", "132": "[\\"lasso\\",1,0,0]", "66": "[\\"revolver_cattleman\\",1,5,154]", "67": "[\\"bow\\",1,0,32]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:712', 712, 40, '{"49": "[\\"herb_wild_mint\\",2]", "54": "[\\"herb_wild_carrot\\",6]", "129": "[\\"melee_knife\\",1,0,1]", "131": "[\\"revolver_cattleman\\",1,0,0]", "130": "[\\"bow\\",1,0,21]", "50": "[\\"meat_perfect\\",3]", "51": "[\\"meat_good\\",3]", "52": "[\\"herb_oregano\\",2]", "53": "[\\"meat_poor\\",3]", "55": "[\\"meat_poor\\",3]", "56": "[\\"meat_poor\\",3]", "57": "[\\"meat_perfect\\",1]", "58": "[\\"herb_black_berry\\",1]", "65": "[\\"lasso\\",1,0,0]", "59": "[\\"meat_poor\\",2]", "60": "[\\"meat_good\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:713', 713, 40, '{"97": "[\\"money\\",5177]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:714', 714, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:715', 715, 40, '{"65": "[\\"bow\\",1,0,0]", "97": "[\\"money\\",4]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:716', 716, 40, '{"130": "[\\"melee_knife\\",1,0,1]", "97": "[\\"money\\",15408]", "66": "[\\"bow\\",1,0,0]", "67": "[\\"bow\\",1,0,7]", "69": "[\\"revolver_cattleman\\",1,6,1]", "129": "[\\"revolver_cattleman\\",1,6,143]", "131": "[\\"lasso\\",1,0,0]", "33": "[\\"medicine_good\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:717', 717, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:718', 718, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:719', 719, 40, '{"132": "[\\"melee_knife\\",1,0,1]", "129": "[\\"revolver_cattleman\\",1,5,27]", "130": "[\\"lasso\\",1]", "131": "[\\"melee_torch\\",1,0,1]", "97": "[\\"money\\",643]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:720', 720, 40, '{"132": "[\\"melee_lantern_electric\\",1,0,1]", "130": "[\\"lasso\\",1,0,0]", "50": "[\\"herb_american_ginseng\\",1]", "97": "[\\"money\\",16]", "49": "[\\"herb_wild_carrot\\",1]", "51": "[\\"meat_poor\\",2]", "65": "[\\"melee_knife\\",1,0,1]", "67": "[\\"bow\\",1,0,26]", "66": "[\\"repeater_henry\\",1,14,66]", "129": "[\\"revolver_cattleman\\",1,6,171]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:721', 721, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:722', 722, 40, '{"49": "[\\"raw_iron\\",1]", "130": "[\\"melee_knife\\",1,0,1]", "131": "[\\"lasso\\",1,0,0]", "52": "[\\"herb_burdock_root\\",6]", "53": "[\\"herb_black_berry\\",2]", "54": "[\\"herb_wild_carrot\\",1]", "66": "[\\"melee_torch\\",1,0,1]", "132": "[\\"melee_lantern_electric\\",1,0,1]", "65": "[\\"revolver_cattleman\\",1,4,14]", "55": "[\\"feather_5\\",1]", "57": "[\\"feather_2\\",1]", "59": "[\\"herb_wild_mint\\",1]", "70": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "69": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "71": "[\\"bow\\",1,0,0]", "35": "[\\"medicine_good\\",1]", "34": "[\\"medicine_good\\",1]", "33": "[\\"medicine_good\\",1]", "72": "[\\"repeater_carbine\\",1,6,193]", "129": "[\\"bow\\",1,0,19]", "97": "[\\"money\\",112]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:723', 723, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:724', 724, 40, '{"97": "[\\"money\\",4899]", "129": "[\\"bow\\",1,0,20]", "131": "[\\"revolver_cattleman\\",1,2,38]", "132": "[\\"repeater_henry\\",1,2,38]", "98": "[\\"gold\\",100]", "130": "[\\"melee_knife\\",1,0,1]", "49": "[\\"raw_copper\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('char:725', 725, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('chest:static:house:2', 0, 60, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('chest:static:house:4', 0, 60, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('chest:static:public:1', 0, 60, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('chest:static:public:2', 0, 60, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('chest:static:public:3', 0, 60, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('chest:static:public:4', 0, 60, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('chest:static:trooper:1', 0, 100, '{"49": "[\\"herb_oregano\\",1]", "97": "[\\"gold\\",2003]", "98": "[\\"money\\",317831]", "70": "[\\"repeater_carbine\\",3,0,0]", "71": "[\\"bow\\",1,0,0]", "73": "[\\"bow\\",1,0,0]", "74": "[\\"rifle_varmint\\",1,0,0]", "75": "[\\"revolver_cattleman\\",1,0,0]", "50": "[\\"herb_american_ginseng\\",2]", "51": "[\\"herb_common_bullrush\\",6]", "52": "[\\"feather_5\\",1]", "72": "[\\"pistol_mauser\\",1,0,0]", "67": "[\\"revolver_lemat\\",1,0,0]", "68": "[\\"revolver_lemat\\",1,0,0]", "77": "[\\"revolver_doubleaction\\",1,0,0]", "78": "[\\"revolver_doubleaction\\",1,0,0]", "79": "[\\"revolver_doubleaction\\",1,0,0]", "66": "[\\"pistol_mauser\\",1,0,0]", "76": "[\\"repeater_winchester\\",1,0,0]", "69": "[\\"revolver_doubleaction\\",1,0,0]", "65": "[\\"rifle_springfield\\",1,0,0]", "80": "[\\"rifle_springfield\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('chest:static:trooper:2', 0, 100, '{"49": "[\\"raw_gold\\",1]", "97": "[\\"money\\",6704]", "65": "[\\"thrown_molotov\\",2,0,1]", "81": "[\\"pigeonpost\\",1]", "50": "[\\"herb_american_ginseng\\",1]", "73": "[\\"revolver_lemat\\",1,0,0]", "67": "[\\"repeater_carbine\\",5,0,0]", "77": "[\\"repeater_evans\\",1,0,0]", "78": "[\\"repeater_evans\\",1,0,0]", "68": "[\\"shotgun_repeating\\",1,0,0]", "66": "[\\"repeater_carbine\\",4,0,0]", "71": "[\\"revolver_cattleman\\",1,0,0]", "70": "[\\"revolver_cattleman\\",1,0,0]", "74": "[\\"revolver_doubleaction\\",1,0,0]", "75": "[\\"revolver_doubleaction\\",1,0,0]", "76": "[\\"rifle_springfield\\",1,0,0]", "69": "[\\"rifle_springfield\\",1,0,0]", "72": "[\\"bow\\",1,0,0]", "79": "[\\"pistol_mauser\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('chest:static:trooper:3', 0, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:100', 462, 40, '{"66": "[\\"revolver_cattleman\\",1,0,0]", "69": "[\\"ammo_shotgun\\",20]", "49": "[\\"feather_5\\",1]", "50": "[\\"feather_5\\",1]", "51": "[\\"feather_5\\",1]", "65": "[\\"ammo_pistol\\",20]", "67": "[\\"ammo_rifle\\",40]", "68": "[\\"bow\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:101', 486, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:102', 498, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:103', 478, 40, '{"49": "[\\"feather_5\\",1]", "70": "[\\"pistol_mauser\\",1,0,0]", "71": "[\\"revolver_cattleman\\",1,0,0]", "66": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "65": "[\\"ammo_arrow\\",20]", "69": "[\\"bow\\",1,0,0]", "34": "[\\"medicine_good\\",1]", "35": "[\\"medicine_good\\",1]", "36": "[\\"medicine_good\\",1]", "97": "[\\"money\\",10431]", "67": "[\\"repeater_evans\\",1,0,0]", "68": "[\\"rifle_springfield\\",1,0,0]", "72": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:104', 249, 40, '{"49": "[\\"raw_copper\\",1]", "66": "[\\"melee_lantern_electric\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:105', 507, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:106', 392, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:107', 504, 40, '{"65": "[\\"ammo_pistol\\",20]", "69": "[\\"ammo_repeater\\",20]", "49": "[\\"feather_5\\",1]", "50": "[\\"feather_5\\",1]", "51": "[\\"feather_5\\",1]", "52": "[\\"feather_1\\",1]", "53": "[\\"feather_1\\",1]", "97": "[\\"money\\",364703]", "80": "[\\"rifle_varmint\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:108', 481, 40, '{"66": "[\\"repeater_carbine\\",1,0,0]", "49": "[\\"tobacco_seed\\",15]", "50": "[\\"tobacco_seed\\",15]", "51": "[\\"tobacco_seed\\",15]", "52": "[\\"tobacco_seed\\",15]", "53": "[\\"tobacco_seed\\",15]", "54": "[\\"tobacco_seed\\",15]", "55": "[\\"tobacco_seed\\",15]", "56": "[\\"tobacco_seed\\",15]", "57": "[\\"tobacco_seed\\",5]", "67": "[\\"ammo_rifle\\",20]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:109', 447, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:110', 505, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:111', 512, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:113', 452, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:114', 508, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:115', 497, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:116', 467, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:117', 470, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:118', 511, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:119', 525, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:120', 484, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:121', 528, 40, '{"65": "[\\"ammo_rifle\\",45]", "66": "[\\"ammo_rifle\\",45]", "67": "[\\"ammo_rifle\\",10]", "69": "[\\"melee_lantern_electric\\",1,0,1]", "70": "[\\"lasso\\",1]", "71": "[\\"revolver_cattleman\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:122', 515, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:123', 520, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:124', 409, 40, '{"65": "[\\"melee_lantern_electric\\",1,0,1]", "66": "[\\"melee_torch\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:125', 400, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:126', 530, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:127', 535, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:128', 537, 40, '{"65": "[\\"bow\\",1,0,0]", "67": "[\\"melee_knife\\",1,0,1]", "70": "[\\"melee_knife\\",1,0,1]", "71": "[\\"bow\\",1,0,0]", "66": "[\\"repeater_carbine\\",1,0,0]", "69": "[\\"rifle_varmint\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:129', 509, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:130', 531, 40, '{"81": "[\\"acamp_bedroll\\",1]", "65": "[\\"melee_knife\\",1,0,1]", "49": "[\\"herb_burdock_root\\",10]", "50": "[\\"herb_burdock_root\\",10]", "53": "[\\"herb_alaskan_ginseng\\",2]", "54": "[\\"herb_alaskan_ginseng\\",10]", "51": "[\\"herb_burdock_root\\",10]", "37": "[\\"medicine_good\\",1]", "38": "[\\"medicine_good\\",1]", "39": "[\\"medicine_good\\",1]", "40": "[\\"medicine_good\\",1]", "41": "[\\"medicine_good\\",1]", "42": "[\\"medicine_good\\",1]", "43": "[\\"medicine_good\\",1]", "44": "[\\"medicine_good\\",1]", "45": "[\\"medicine_good\\",1]", "46": "[\\"medicine_good\\",1]", "47": "[\\"medicine_good\\",1]", "48": "[\\"medicine_good\\",1]", "67": "[\\"ammo_rifle\\",45]", "52": "[\\"herb_burdock_root\\",3]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:131', 540, 40, '{"51": "[\\"feather_5\\",1]", "52": "[\\"feather_5\\",1]", "53": "[\\"feather_5\\",1]", "54": "[\\"feather_5\\",1]", "50": "[\\"feather_2\\",1]", "49": "[\\"herb_oregano\\",1]", "55": "[\\"feather_5\\",1]", "56": "[\\"feather_5\\",1]", "57": "[\\"feather_1\\",1]", "58": "[\\"feather_1\\",1]", "59": "[\\"feather_1\\",1]", "60": "[\\"feather_1\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:132', 543, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:133', 544, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:135', 347, 40, '{"66": "[\\"rifle_varmint\\",1,0,0]", "65": "[\\"repeater_carbine\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:136', 524, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:137', 536, 40, '{"65": "[\\"revolver_doubleaction\\",1,0,0]", "66": "[\\"melee_knife\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:138', 343, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:139', 547, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:140', 548, 40, '{"69": "[\\"ammo_rifle\\",40]", "70": "[\\"ammo_shotgun\\",35]", "66": "[\\"ammo_shotgun\\",20]", "71": "[\\"ammo_pistol\\",40]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:141', 550, 40, '{"66": "[\\"ammo_repeater\\",45]", "68": "[\\"ammo_repeater\\",45]", "65": "[\\"rifle_varmint\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:142', 551, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:143', 553, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:145', 556, 40, '{"72": "[\\"bow\\",1,0,0]", "39": "[\\"medicine_good\\",1]", "40": "[\\"medicine_good\\",1]", "75": "[\\"lasso\\",1]", "66": "[\\"revolver_doubleaction\\",1,0,0]", "68": "[\\"repeater_carbine\\",1,0,0]", "71": "[\\"repeater_evans\\",1,0,0]", "65": "[\\"revolver_doubleaction\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:146', 564, 40, '{"65": "[\\"lasso\\",1]", "67": "[\\"lasso\\",1]", "68": "[\\"lasso\\",1]", "70": "[\\"rifle_springfield\\",1,0,0]", "72": "[\\"repeater_winchester\\",1,0,0]", "50": "[\\"raw_coal\\",28]", "66": "[\\"repeater_winchester\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:147', 559, 40, '{"68": "[\\"ammo_22\\",20]", "74": "[\\"melee_torch\\",1,0,1]", "71": "[\\"melee_lantern_electric\\",1,0,1]", "72": "[\\"ammo_revolver\\",20]", "65": "[\\"repeater_carbine\\",2,0,0]", "67": "[\\"lasso\\",1]", "66": "[\\"rifle_springfield\\",1,0,0]", "69": "[\\"melee_knife\\",1,0,1]", "70": "[\\"revolver_lemat\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:148', 503, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:149', 511, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:150', 550, 40, '{"67": "[\\"bow\\",1,0,0]", "69": "[\\"rifle_varmint\\",1,0,0]", "66": "[\\"repeater_carbine\\",1,0,0]", "65": "[\\"revolver_doubleaction\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:152', 322, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:153', 343, 40, '{"65": "[\\"bow\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:154', 566, 40, '{"72": "[\\"melee_torch\\",1,0,1]", "76": "[\\"melee_knife\\",1,0,1]", "69": "[\\"melee_lantern_electric\\",1,0,1]", "77": "[\\"ammo_repeater\\",40]", "67": "[\\"rifle_springfield\\",1,0,0]", "74": "[\\"lasso\\",1]", "71": "[\\"melee_knife\\",1,0,1]", "73": "[\\"lasso\\",1]", "65": "[\\"rifle_varmint\\",1,0,0]", "79": "[\\"revolver_lemat\\",1,0,0]", "78": "[\\"revolver_doubleaction\\",1,0,0]", "80": "[\\"revolver_doubleaction\\",1,0,0]", "68": "[\\"rifle_springfield\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:155', 417, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:156', 474, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:157', 487, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:158', 417, 40, '{"66": "[\\"repeater_henry\\",1,0,0]", "67": "[\\"repeater_winchester\\",1,0,0]", "69": "[\\"bow\\",1,0,0]", "49": "[\\"herb_black_berry\\",3]", "50": "[\\"herb_common_bullrush\\",1]", "51": "[\\"herb_burdock_root\\",1]", "52": "[\\"herb_wild_carrot\\",4]", "53": "[\\"herb_oregano\\",1]", "54": "[\\"herb_american_ginseng\\",3]", "35": "[\\"medicine_poor\\",1]", "36": "[\\"medicine_poor\\",1]", "37": "[\\"medicine_good\\",1]", "97": "[\\"money\\",24719]", "65": "[\\"pistol_mauser_drunk\\",1,0,0]", "68": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "70": "[\\"pistol_mauser\\",1,0,0]", "71": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:159', 528, 40, '{"65": "[\\"rifle_springfield\\",1,0,0]", "66": "[\\"pistol_mauser\\",1,0,0]", "67": "[\\"rifle_springfield\\",1,0,0]", "68": "[\\"repeater_evans\\",1,0,0]", "69": "[\\"repeater_evans\\",1,0,0]", "70": "[\\"ammo_pistol\\",20]", "71": "[\\"ammo_repeater\\",20]", "72": "[\\"ammo_rifle\\",20]", "73": "[\\"lasso\\",1]", "74": "[\\"melee_torch\\",1,0,1]", "75": "[\\"melee_knife\\",1,0,1]", "76": "[\\"melee_torch\\",1,0,1]", "77": "[\\"revolver_doubleaction\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:160', 229, 40, '{"97": "[\\"money\\",40]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:161', 310, 40, '{"97": "[\\"gold\\",100]", "49": "[\\"meat_perfect\\",1]", "50": "[\\"meat_poor\\",2]", "17": "[\\"meat_oregano_cooked\\",3]", "18": "[\\"meat_cooked\\",1]", "70": "[\\"repeater_evans\\",1,0,0]", "69": "[\\"repeater_winchester\\",1,0,0]", "33": "[\\"medicine_good\\",1]", "51": "[\\"meat_good\\",1]", "74": "[\\"rifle_springfield\\",1,0,0]", "73": "[\\"repeater_carbine\\",1,0,0]", "75": "[\\"bow\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:162', 558, 40, '{"33": "[\\"medicine_good\\",1]", "97": "[\\"gold\\",100]", "66": "[\\"melee_knife\\",1,0,1]", "68": "[\\"lasso\\",1]", "69": "[\\"ammo_pistol\\",60]", "70": "[\\"ammo_pistol\\",60]", "65": "[\\"revolver_cattleman\\",1,0,0]", "79": "[\\"melee_lantern_electric\\",1,0,1]", "76": "[\\"ammo_repeater\\",5]", "67": "[\\"bow\\",1,0,0]", "73": "[\\"shotgun_semiauto\\",1,0,0]", "74": "[\\"rifle_boltaction\\",1,0,0]", "75": "[\\"revolver_cattleman\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:163', 242, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:165', 364, 40, '{"65": "[\\"repeater_evans\\",1,0,0]", "33": "[\\"medicine_good\\",1]", "66": "[\\"revolver_lemat\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:166', 568, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:168', 572, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:169', 574, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:172', 272, 40, '{"71": "[\\"bow\\",1,0,0]", "66": "[\\"revolver_lemat\\",1,0,0]", "65": "[\\"revolver_lemat\\",1,0,0]", "68": "[\\"pistol_mauser\\",1,0,0]", "67": "[\\"pistol_mauser\\",1,0,0]", "70": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "72": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "69": "[\\"sniperrifle_rollingblock\\",1,0,0]", "73": "[\\"repeater_evans\\",1,0,0]", "74": "[\\"rifle_springfield\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:173', 560, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:174', 576, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:175', 582, 40, '{"77": "[\\"revolver_lemat\\",1,0,0]", "65": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "73": "[\\"melee_knife\\",1,0,1]", "70": "[\\"bow\\",1,0,0]", "75": "[\\"revolver_cattleman_john\\",1,0,0]", "71": "[\\"pistol_mauser\\",1,0,0]", "68": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "74": "[\\"repeater_carbine\\",0,0,0]", "66": "[\\"melee_knife\\",1,0,1]", "69": "[\\"melee_knife\\",1,0,1]", "36": "[\\"medicine_good\\",1]", "49": "[\\"herb_oregano\\",10]", "50": "[\\"herb_oregano\\",10]", "33": "[\\"stimulant_good\\",1]", "67": "[\\"lasso\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:176', 587, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:177', 525, 40, '{"50": "[\\"raw_iron\\",6]", "65": "[\\"revolver_cattleman\\",1,0,0]", "66": "[\\"melee_knife\\",1,0,1]", "67": "[\\"bow\\",1,0,0]", "97": "[\\"gold\\",100]", "68": "[\\"repeater_henry\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:178', 592, 40, '{"65": "[\\"melee_knife_vampire\\",1,0,0]", "97": "[\\"gold\\",10012]", "67": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "66": "[\\"melee_knife_vampire\\",1,0,0]", "80": "[\\"revolver_cattleman_john\\",1,0,0]", "77": "[\\"rifle_springfield\\",1,0,0]", "79": "[\\"pistol_volcanic\\",1,0,0]", "75": "[\\"pistol_mauser\\",1,0,0]", "73": "[\\"sniperrifle_rollingblock\\",1,0,0]", "76": "[\\"revolver_doubleaction\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:179', 591, 40, '{"65": "[\\"melee_knife_vampire\\",1,0,0]", "49": "[\\"raw_gold\\",5]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:180', 315, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:181', 315, 40, '{"65": "[\\"rifle_springfield\\",1,0,0]", "77": "[\\"revolver_cattleman\\",1,0,0]", "73": "[\\"revolver_cattleman\\",1,0,0]", "80": "[\\"bow\\",1,0,0]", "78": "[\\"revolver_cattleman\\",1,0,0]", "67": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "69": "[\\"rifle_springfield\\",1,0,0]", "66": "[\\"repeater_winchester\\",1,0,0]", "68": "[\\"repeater_winchester\\",1,0,0]", "97": "[\\"money\\",16138]", "70": "[\\"ammo_rifle\\",15]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:182', 593, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:183', 587, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:184', 584, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:185', 587, 40, '{"67": "[\\"ammo_arrow\\",13]", "68": "[\\"ammo_repeater\\",45]", "70": "[\\"melee_knife\\",1,0,1]", "71": "[\\"melee_knife\\",1,0,1]", "74": "[\\"melee_torch\\",1,0,1]", "76": "[\\"bow\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:186', 573, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:187', 555, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:188', 526, 40, '{"65": "[\\"fishingrod\\",1,0,1]", "67": "[\\"shotgun_pump\\",1,0,0]", "68": "[\\"rifle_springfield\\",1,0,0]", "69": "[\\"revolver_cattleman\\",1,0,0]", "70": "[\\"melee_knife\\",1,0,1]", "49": "[\\"meat_poor\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:189', 487, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:190', 486, 40, '{"65": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "34": "[\\"medicine_good\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:191', 588, 40, '{"65": "[\\"revolver_cattleman\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:192', 550, 40, '{"72": "[\\"revolver_cattleman_john\\",1,0,0]", "97": "[\\"money\\",39895]", "65": "[\\"rifle_springfield\\",1,0,0]", "66": "[\\"repeater_evans\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:193', 493, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:194', 511, 40, '{"65": "[\\"melee_knife\\",1,0,1]", "66": "[\\"lasso\\",1]", "67": "[\\"melee_lantern_electric\\",1,0,1]", "69": "[\\"melee_torch\\",1,0,1]", "71": "[\\"revolver_lemat\\",1,0,0]", "72": "[\\"pistol_mauser\\",1,0,0]", "73": "[\\"melee_lantern_electric\\",1,0,1]", "74": "[\\"revolver_lemat\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:195', 397, 40, '{"66": "[\\"revolver_cattleman\\",1,0,0]", "67": "[\\"melee_knife\\",1,0,1]", "69": "[\\"melee_hatchet_viking\\",1,0,1]", "65": "[\\"revolver_cattleman\\",1,0,0]", "70": "[\\"lasso\\",1]", "56": "[\\"meat_poor\\",3]", "57": "[\\"meat_poor\\",2]", "68": "[\\"melee_knife\\",1,0,1]", "49": "[\\"herb_common_bullrush\\",1]", "71": "[\\"repeater_winchester\\",1,0,0]", "72": "[\\"rifle_springfield\\",1,0,0]", "33": "[\\"medicine_good\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:196', 597, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:197', 586, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:198', 564, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:199', 567, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:200', 566, 40, '{"66": "[\\"revolver_lemat\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:201', 459, 40, '{"65": "[\\"revolver_lemat\\",1,0,0]", "66": "[\\"revolver_lemat\\",1,0,40]", "67": "[\\"revolver_lemat\\",1,0,0]", "68": "[\\"repeater_evans\\",1,0,0]", "69": "[\\"rifle_boltaction\\",1,0,20]", "72": "[\\"repeater_evans\\",1,0,0]", "73": "[\\"rifle_springfield\\",1,0,0]", "74": "[\\"melee_lantern_electric\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:202', 593, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:203', 593, 40, '{"66": "[\\"bow\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:204', 524, 40, '{"77": "[\\"repeater_evans\\",1,0,0]", "67": "[\\"melee_torch\\",1,0,1]", "72": "[\\"ammo_repeater\\",45]", "71": "[\\"ammo_repeater\\",5]", "65": "[\\"bow\\",1,0,0]", "69": "[\\"revolver_doubleaction\\",1,0,0]", "66": "[\\"revolver_lemat\\",1,0,0]", "70": "[\\"melee_torch\\",1,0,1]", "68": "[\\"rifle_springfield\\",1,0,0]", "33": "[\\"medicine_good\\",1]", "34": "[\\"medicine_poor\\",1]", "35": "[\\"medicine_good\\",1]", "97": "[\\"money\\",3000]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:205', 576, 40, '{"49": "[\\"feather_5\\",1]", "51": "[\\"feather_5\\",1]", "52": "[\\"feather_2\\",1]", "53": "[\\"feather_2\\",1]", "54": "[\\"feather_5\\",1]", "56": "[\\"feather_5\\",1]", "57": "[\\"herb_wild_mint\\",2]", "58": "[\\"feather_5\\",1]", "59": "[\\"feather_5\\",1]", "60": "[\\"feather_5\\",1]", "61": "[\\"herb_wild_carrot\\",1]", "62": "[\\"herb_common_bullrush\\",2]", "63": "[\\"herb_oregano\\",1]", "64": "[\\"feather_5\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:206', 560, 40, '{"67": "[\\"melee_torch\\",1,0,1]", "68": "[\\"melee_lantern_electric\\",1,0,1]", "97": "[\\"money\\",103607]", "66": "[\\"melee_hatchet\\",1,0,1]", "69": "[\\"revolver_cattleman\\",1,0,0]", "49": "[\\"meat_poor\\",3]", "65": "[\\"repeater_carbine\\",1,0,0]", "50": "[\\"herb_oregano\\",2]", "51": "[\\"meat_poor\\",3]", "52": "[\\"feather_2\\",1]", "53": "[\\"feather_5\\",1]", "54": "[\\"feather_2\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:207', 241, 40, '{"67": "[\\"revolver_doubleaction\\",1,0,0]", "68": "[\\"melee_lantern_electric\\",1,0,1]", "65": "[\\"rifle_springfield\\",1,0,0]", "66": "[\\"revolver_cattleman\\",1,0,0]", "33": "[\\"medicine_good\\",1]", "34": "[\\"medicine_good\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:208', 608, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:209', 615, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:21', 229, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:210', 610, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:211', 604, 40, '{"81": "[\\"pigeonpost\\",1]", "49": "[\\"herb_wild_mint\\",3]", "50": "[\\"herb_wild_carrot\\",3]", "51": "[\\"herb_american_ginseng\\",2]", "33": "[\\"medicine_good\\",1]", "37": "[\\"medicine_good\\",1]", "82": "[\\"acamp_bedroll\\",1]", "66": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "67": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "65": "[\\"melee_lantern_electric\\",1,0,1]", "68": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:212', 624, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:213', 602, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:214', 597, 40, '{"50": "[\\"feather_5\\",1]", "51": "[\\"feather_5\\",1]", "52": "[\\"feather_5\\",1]", "54": "[\\"feather_5\\",1]", "55": "[\\"feather_5\\",1]", "56": "[\\"feather_5\\",1]", "57": "[\\"feather_5\\",1]", "58": "[\\"feather_2\\",1]", "59": "[\\"feather_5\\",1]", "60": "[\\"feather_5\\",1]", "61": "[\\"herb_wild_mint\\",2]", "62": "[\\"meat_poor\\",2]", "63": "[\\"herb_american_ginseng\\",6]", "64": "[\\"herb_burdock_root\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:215', 609, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:216', 621, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:217', 602, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:218', 624, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:219', 602, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:220', 626, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:221', 614, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:222', 606, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:223', 601, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:224', 400, 40, '{"49": "[\\"herb_oregano\\",1]", "50": "[\\"herb_wild_carrot\\",4]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:225', 617, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:226', 617, 40, '{"68": "[\\"rifle_springfield\\",1,0,0]", "34": "[\\"medicine_good\\",1]", "65": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "66": "[\\"repeater_winchester\\",1,0,0]", "35": "[\\"medicine_good\\",1]", "67": "[\\"repeater_winchester\\",1,0,0]", "69": "[\\"repeater_winchester\\",1,0,0]", "70": "[\\"rifle_springfield\\",1,0,0]", "71": "[\\"rifle_springfield\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:227', 579, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:228', 586, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:229', 614, 40, '{"65": "[\\"bow\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:23', 272, 40, '{"97": "[\\"money\\",3283]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:230', 602, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:231', 625, 40, '{"68": "[\\"melee_torch\\",1,0,1]", "67": "[\\"ammo_repeater\\",20]", "65": "[\\"ammo_rifle\\",45]", "66": "[\\"ammo_shotgun\\",20]", "69": "[\\"ammo_pistol\\",40]", "70": "[\\"ammo_rifle\\",15]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:232', 626, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:233', 623, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:234', 584, 40, '{"65": "[\\"melee_lantern_electric\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:235', 635, 40, '{"65": "[\\"ammo_revolver\\",40]", "68": "[\\"revolver_cattleman\\",1,0,0]", "66": "[\\"melee_torch\\",1,0,1]", "67": "[\\"ammo_arrow\\",12]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:236', 623, 40, '{"61": "[\\"meat_poor\\",1]", "56": "[\\"herb_prairie_poppy\\",1]", "71": "[\\"bow\\",1,0,0]", "67": "[\\"melee_lantern_electric\\",1,0,1]", "76": "[\\"lasso\\",1]", "68": "[\\"lasso\\",1]", "72": "[\\"lasso\\",1]", "80": "[\\"lasso\\",1]", "79": "[\\"melee_knife\\",1,0,1]", "66": "[\\"melee_torch\\",1,0,1]", "49": "[\\"herb_common_bullrush\\",1]", "97": "[\\"money\\",37575]", "65": "[\\"repeater_evans\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:237', 634, 40, '{"49": "[\\"raw_copper\\",10]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:238', 537, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:239', 579, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:24', 265, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:240', 571, 40, '{"97": "[\\"money\\",704]", "49": "[\\"feather_5\\",1]", "50": "[\\"herb_oregano\\",2]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:241', 522, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:242', 613, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:243', 641, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:244', 642, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:245', 643, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:246', 641, 40, '{"49": "[\\"herb_burdock_root\\",2]", "50": "[\\"herb_american_ginseng\\",1]", "51": "[\\"herb_wild_carrot\\",2]", "65": "[\\"ammo_pistol\\",60]", "66": "[\\"ammo_pistol\\",60]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:247', 652, 40, '{"49": "[\\"herb_wild_carrot\\",5]", "50": "[\\"herb_american_ginseng\\",1]", "51": "[\\"herb_rams_head\\",1]", "52": "[\\"herb_common_bullrush\\",3]", "53": "[\\"tobacco_seed\\",5]", "65": "[\\"lasso\\",1]", "66": "[\\"melee_knife\\",1,0,1]", "67": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "68": "[\\"rifle_springfield\\",1,0,0]", "69": "[\\"lasso\\",1]", "70": "[\\"lasso\\",1]", "73": "[\\"pistol_mauser\\",1,0,0]", "74": "[\\"pistol_mauser\\",1,0,0]", "75": "[\\"melee_knife\\",1,0,1]", "76": "[\\"melee_lantern_electric\\",1,0,1]", "77": "[\\"ammo_revolver\\",20]", "71": "[\\"rifle_springfield\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:248', 649, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:249', 254, 40, '{"65": "[\\"repeater_carbine\\",1,0,0]", "66": "[\\"lasso\\",1]", "33": "[\\"medicine_poor\\",1]", "34": "[\\"medicine_poor\\",1]", "35": "[\\"medicine_poor\\",1]", "36": "[\\"medicine_poor\\",1]", "37": "[\\"medicine_poor\\",1]", "38": "[\\"medicine_poor\\",1]", "39": "[\\"medicine_poor\\",1]", "40": "[\\"medicine_poor\\",1]", "41": "[\\"medicine_poor\\",1]", "42": "[\\"medicine_poor\\",1]", "43": "[\\"medicine_poor\\",1]", "44": "[\\"medicine_poor\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:25', 283, 40, '{"68": "[\\"sniperrifle_rollingblock\\",1,0,0]", "67": "[\\"sniperrifle_rollingblock\\",1,0,0]", "74": "[\\"repeater_carbine\\",1,0,0]", "72": "[\\"revolver_cattleman_john\\",1,0,0]", "65": "[\\"repeater_evans\\",1,0,0]", "66": "[\\"revolver_doubleaction\\",1,0,0]", "33": "[\\"medicine_good\\",1]", "34": "[\\"medicine_good\\",1]", "35": "[\\"medicine_good\\",1]", "36": "[\\"medicine_good\\",1]", "37": "[\\"medicine_good\\",1]", "38": "[\\"medicine_good\\",1]", "39": "[\\"medicine_good\\",1]", "40": "[\\"medicine_good\\",1]", "41": "[\\"medicine_good\\",1]", "42": "[\\"medicine_good\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:250', 537, 40, '{"65": "[\\"repeater_carbine\\",1,0,0]", "77": "[\\"melee_knife\\",1,0,1]", "78": "[\\"melee_knife\\",1,0,1]", "80": "[\\"lasso\\",1]", "68": "[\\"revolver_doubleaction\\",1,0,0]", "34": "[\\"medicine_good\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:251', 635, 40, '{"49": "[\\"raw_copper\\",10]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:252', 640, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:253', 651, 40, '{"65": "[\\"revolver_cattleman\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:254', 602, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:255', 602, 40, '{"61": "[\\"herb_parasol_mushroom\\",3]", "62": "[\\"herb_wild_carrot\\",3]", "64": "[\\"herb_american_ginseng\\",3]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:256', 643, 40, '{"33": "[\\"medicine_good\\",1]", "34": "[\\"medicine_good\\",1]", "35": "[\\"medicine_good\\",1]", "97": "[\\"gold\\",100]", "66": "[\\"repeater_henry\\",1,0,0]", "65": "[\\"repeater_henry\\",1,0,0]", "67": "[\\"ammo_rifle\\",45]", "68": "[\\"ammo_rifle\\",15]", "69": "[\\"ammo_shotgun\\",35]", "70": "[\\"ammo_shotgun\\",5]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:257', 599, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:258', 618, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:259', 608, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:260', 625, 40, '{"66": "[\\"ammo_rifle\\",20]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:261', 653, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:262', 608, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:263', 608, 40, '{"65": "[\\"revolver_cattleman\\",1,0,0]", "66": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:264', 655, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:265', 654, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:266', 598, 40, '{"65": "[\\"melee_knife\\",1,0,1]", "49": "[\\"raw_copper\\",2]", "53": "[\\"herb_black_berry\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:267', 637, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:268', 660, 40, '{"51": "[\\"herb_common_bullrush\\",2]", "52": "[\\"herb_wild_mint\\",1]", "67": "[\\"ammo_repeater\\",35]", "68": "[\\"ammo_rifle\\",20]", "65": "[\\"repeater_carbine\\",1,0,0]", "70": "[\\"ammo_revolver\\",60]", "71": "[\\"melee_torch\\",1,0,1]", "33": "[\\"medicine_poor\\",1]", "49": "[\\"tobacco_seed\\",5]", "53": "[\\"meat_perfect\\",3]", "57": "[\\"raw_coal\\",1]", "81": "[\\"acamp_firesmal_pan\\",1]", "82": "[\\"acamp_tents_med_closed\\",1]", "83": "[\\"acamp_bedroll\\",1]", "50": "[\\"feather_2\\",1]", "54": "[\\"meat_good\\",1]", "55": "[\\"meat_poor\\",3]", "56": "[\\"meat_perfect\\",1]", "58": "[\\"feather_2\\",1]", "97": "[\\"money\\",1086]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:269', 554, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:27', 336, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:270', 657, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:271', 315, 40, '{"97": "[\\"gold\\",200]", "68": "[\\"bow\\",1,0,0]", "35": "[\\"medicine_good\\",1]", "36": "[\\"medicine_good\\",1]", "33": "[\\"medicine_good\\",1]", "34": "[\\"medicine_good\\",1]", "38": "[\\"medicine_good\\",1]", "66": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "72": "[\\"bow\\",1,0,0]", "65": "[\\"repeater_henry\\",1,0,0]", "69": "[\\"repeater_henry\\",1,0,0]", "80": "[\\"revolver_cattleman\\",1,0,0]", "79": "[\\"revolver_cattleman\\",1,0,0]", "70": "[\\"revolver_cattleman\\",1,0,0]", "98": "[\\"money\\",27774]", "67": "[\\"bow\\",1,0,0]", "77": "[\\"repeater_winchester\\",1,0,0]", "75": "[\\"ammo_rifle\\",20]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:272', 600, 40, '{"49": "[\\"herb_oregano\\",3]", "50": "[\\"herb_american_ginseng\\",2]", "51": "[\\"herb_wild_carrot\\",5]", "52": "[\\"herb_common_bullrush\\",10]", "53": "[\\"herb_common_bullrush\\",1]", "65": "[\\"ammo_rifle\\",45]", "66": "[\\"ammo_rifle\\",10]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:273', 620, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:274', 522, 40, '{"65": "[\\"melee_lantern_electric\\",1,0,1]", "66": "[\\"ammo_pistol\\",40]", "67": "[\\"revolver_cattleman\\",1,0,0]", "68": "[\\"ammo_shotgun\\",35]", "69": "[\\"ammo_shotgun\\",35]", "70": "[\\"ammo_shotgun\\",15]", "71": "[\\"revolver_cattleman\\",1,0,0]", "73": "[\\"ammo_rifle\\",12]", "77": "[\\"ammo_rifle\\",11]", "78": "[\\"ammo_rifle\\",11]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:275', 618, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:276', 665, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:277', 619, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:278', 661, 40, '{"65": "[\\"revolver_cattleman\\",1,0,0]", "68": "[\\"ammo_revolver\\",60]", "51": "[\\"feather_5\\",1]", "66": "[\\"ammo_arrow\\",4]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:279', 620, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:28', 247, 40, '{"66": "[\\"lasso\\",1]", "67": "[\\"revolver_cattleman\\",1,0,0]", "49": "[\\"herb_american_ginseng\\",1]", "50": "[\\"herb_parasol_mushroom\\",2]", "97": "[\\"money\\",3048]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:280', 666, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:281', 572, 40, '{"58": "[\\"herb_burdock_root\\",10]", "59": "[\\"herb_burdock_root\\",10]", "60": "[\\"herb_burdock_root\\",10]", "56": "[\\"herb_burdock_root\\",2]", "69": "[\\"melee_knife_vampire\\",1,0,0]", "66": "[\\"revolver_cattleman_john\\",1,0,0]", "65": "[\\"repeater_winchester\\",1,0,0]", "70": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "67": "[\\"rifle_springfield\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:282', 620, 40, '{"66": "[\\"melee_lantern_electric\\",1,0,1]", "49": "[\\"tobacco_seed\\",5]", "50": "[\\"sugarcane_seed\\",5]", "53": "[\\"corn_seed\\",5]", "81": "[\\"acamp_firesmall\\",1]", "82": "[\\"acamp_firesmal_pan\\",1]", "83": "[\\"acamp_firesmall\\",1]", "84": "[\\"acamp_bedroll\\",1]", "67": "[\\"melee_torch\\",1,0,1]", "68": "[\\"melee_lantern_electric\\",1,0,1]", "54": "[\\"herb_common_bullrush\\",3]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:283', 663, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:284', 322, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:285', 554, 40, '{"49": "[\\"herb_wild_mint\\",1]", "50": "[\\"herb_burdock_root\\",2]", "51": "[\\"feather_2\\",1]", "52": "[\\"feather_5\\",1]", "53": "[\\"herb_common_bullrush\\",4]", "54": "[\\"herb_oregano\\",1]", "55": "[\\"herb_american_ginseng\\",1]", "56": "[\\"feather_2\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:287', 663, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:288', 624, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:29', 328, 40, '{"97": "[\\"gold\\",6200]", "73": "[\\"lasso\\",1]", "75": "[\\"bow\\",1,0,0]", "78": "[\\"pistol_mauser\\",1,0,0]", "79": "[\\"revolver_cattleman\\",1,0,0]", "70": "[\\"repeater_winchester\\",1,0,0]", "34": "[\\"medicine_good\\",1]", "65": "[\\"ammo_rifle\\",20]", "66": "[\\"revolver_cattleman_john\\",1,0,0]", "35": "[\\"stimulant_good\\",1]", "98": "[\\"money\\",13367]", "68": "[\\"repeater_carbine\\",1,0,0]", "67": "[\\"melee_knife_vampire\\",1,0,0]", "69": "[\\"repeater_winchester\\",1,0,0]", "71": "[\\"revolver_cattleman\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:31', 279, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:32', 244, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:33', 256, 40, '{"65": "[\\"ammo_shotgun\\",35]", "69": "[\\"ammo_shotgun\\",35]", "97": "[\\"gold\\",1100]", "33": "[\\"medicine_good\\",1]", "76": "[\\"repeater_henry\\",1,0,0]", "77": "[\\"repeater_winchester\\",1,0,0]", "78": "[\\"rifle_springfield\\",1,0,0]", "79": "[\\"rifle_varmint\\",1,0,0]", "80": "[\\"repeater_henry\\",1,0,0]", "75": "[\\"revolver_cattleman\\",1,0,0]", "66": "[\\"ammo_shotgun\\",20]", "67": "[\\"ammo_shotgun\\",35]", "74": "[\\"revolver_cattleman\\",1,0,0]", "68": "[\\"ammo_shotgun\\",35]", "73": "[\\"bow\\",1,0,0]", "70": "[\\"ammo_rifle\\",40]", "98": "[\\"money\\",3225]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:34', 261, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:35', 257, 40, '{"65": "[\\"ammo_rifle\\",45]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:36', 270, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:37', 260, 40, '{"66": "[\\"melee_torch\\",1,0,1]", "65": "[\\"revolver_lemat\\",1,0,0]", "67": "[\\"rifle_boltaction\\",1,0,0]", "68": "[\\"bow\\",1,0,0]", "33": "[\\"medicine_good\\",1]", "34": "[\\"medicine_good\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:38', 375, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:40', 339, 40, '{"49": "[\\"raw_copper\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:41', 193, 40, '{"49": "[\\"raw_coal\\",3]", "50": "[\\"meat_perfect\\",1]", "101": "[\\"money\\",2078]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:42', 311, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:43', 301, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:44', 303, 40, '{"97": "[\\"money\\",600]", "65": "[\\"bow\\",1,0,0]", "57": "[\\"raw_copper\\",10]", "49": "[\\"raw_copper\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:45', 320, 40, '{"65": "[\\"ammo_repeater\\",20]", "69": "[\\"ammo_rifle\\",45]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:46', 364, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:47', 275, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:48', 355, 40, '{"49": "[\\"meat\\",1]", "50": "[\\"raw_iron\\",1]", "51": "[\\"raw_copper\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:49', 252, 40, '{"97": "[\\"gold\\",2]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:50', 248, 40, '{"65": "[\\"revolver_cattleman\\",1,0,0]", "67": "[\\"bow\\",1,0,0]", "69": "[\\"revolver_cattleman\\",1,0,0]", "71": "[\\"ammo_arrow\\",20]", "72": "[\\"repeater_henry\\",1,0,0]", "73": "[\\"repeater_winchester\\",1,0,0]", "70": "[\\"bow\\",1,0,0]", "66": "[\\"revolver_cattleman\\",1,0,0]", "68": "[\\"ammo_revolver\\",60]", "74": "[\\"sniperrifle_rollingblock\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:51', 318, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:52', 314, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:53', 394, 40, '{"65": "[\\"repeater_winchester\\",1,0,0]", "66": "[\\"rifle_springfield\\",1,0,0]", "67": "[\\"rifle_springfield\\",1,0,0]", "68": "[\\"rifle_springfield\\",1,0,0]", "69": "[\\"rifle_springfield\\",1,0,0]", "81": "[\\"pigeonpost\\",1]", "49": "[\\"raw_gold\\",2]", "50": "[\\"raw_copper\\",2]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:54', 326, 40, '{"67": "[\\"ammo_shotgun\\",20]", "68": "[\\"repeater_henry\\",1,0,0]", "65": "[\\"ammo_rifle\\",45]", "49": "[\\"raw_coal\\",1]", "50": "[\\"raw_iron\\",1]", "66": "[\\"ammo_rifle\\",45]", "69": "[\\"repeater_henry\\",1,0,0]", "70": "[\\"ammo_rifle\\",20]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:55', 322, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:56', 280, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:57', 254, 40, '{"49": "[\\"herb_wild_carrot\\",1]", "65": "[\\"ammo_repeater\\",45]", "66": "[\\"melee_lantern_electric\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:58', 359, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:59', 240, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:60', 315, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:600', 670, 40, '{"65": "[\\"rifle_springfield\\",1,0,0]", "69": "[\\"repeater_carbine\\",1,0,0]", "66": "[\\"rifle_springfield\\",1,0,0]", "72": "[\\"bow\\",1,0,0]", "68": "[\\"bow\\",1,0,0]", "73": "[\\"repeater_evans\\",1,0,0]", "74": "[\\"repeater_evans\\",1,0,0]", "78": "[\\"revolver_lemat\\",1,0,0]", "79": "[\\"revolver_lemat\\",1,0,0]", "80": "[\\"revolver_lemat\\",1,0,0]", "77": "[\\"shotgun_repeating\\",1,0,0]", "71": "[\\"repeater_carbine\\",1,0,0]", "70": "[\\"repeater_carbine\\",1,0,0]", "67": "[\\"rifle_springfield\\",1,0,0]", "51": "[\\"feather_5\\",1]", "52": "[\\"feather_5\\",1]", "53": "[\\"feather_5\\",1]", "54": "[\\"feather_5\\",1]", "50": "[\\"feather_2\\",1]", "49": "[\\"herb_oregano\\",1]", "55": "[\\"feather_5\\",1]", "56": "[\\"feather_5\\",1]", "57": "[\\"feather_1\\",1]", "58": "[\\"feather_1\\",1]", "59": "[\\"feather_1\\",1]", "75": "[\\"repeater_evans\\",1,0,0]", "60": "[\\"feather_1\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:601', 662, 40, '{"49": "[\\"herb_prairie_poppy\\",10]", "51": "[\\"herb_prairie_poppy\\",10]", "52": "[\\"herb_prairie_poppy\\",10]", "53": "[\\"herb_prairie_poppy\\",10]", "55": "[\\"herb_rams_head\\",3]", "50": "[\\"herb_black_current\\",10]", "54": "[\\"herb_wild_feverfew\\",6]", "56": "[\\"herb_american_ginseng\\",10]", "57": "[\\"herb_oregano\\",10]", "58": "[\\"herb_american_ginseng\\",10]", "59": "[\\"herb_american_ginseng\\",10]", "60": "[\\"meat_good\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:602', 663, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:603', 669, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:604', 540, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:605', 472, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:606', 540, 40, '{"65": "[\\"revolver_lemat\\",1,0,0]", "66": "[\\"revolver_lemat\\",1,0,0]", "67": "[\\"revolver_lemat\\",1,0,0]", "77": "[\\"bow\\",1,0,0]", "78": "[\\"bow\\",1,0,0]", "33": "[\\"medicine_poor\\",1]", "34": "[\\"medicine_poor\\",1]", "69": "[\\"pistol_mauser\\",1,0,0]", "70": "[\\"pistol_mauser\\",1,0,0]", "36": "[\\"eagleeye\\",1]", "37": "[\\"medicine_poor\\",1]", "40": "[\\"eagleeye\\",1]", "41": "[\\"medicine_poor\\",1]", "68": "[\\"revolver_lemat\\",1,0,0]", "80": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "73": "[\\"revolver_cattleman\\",1,0,0]", "44": "[\\"eagleeye\\",1]", "38": "[\\"medicine_poor\\",1]", "48": "[\\"eagleeye\\",1]", "42": "[\\"medicine_poor\\",1]", "45": "[\\"medicine_poor\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:607', 314, 40, '{"49": "[\\"raw_gold\\",5]", "33": "[\\"medicine_good\\",1]", "34": "[\\"medicine_good\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:608', 626, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:609', 626, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:610', 624, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:611', 625, 40, '{"67": "[\\"bow\\",1,0,0]", "68": "[\\"lasso\\",1]", "72": "[\\"bow\\",1,0,0]", "76": "[\\"bow\\",1,0,0]", "65": "[\\"repeater_carbine\\",1,0,0]", "69": "[\\"repeater_winchester\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:612', 601, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:613', 672, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:614', 673, 40, '{"71": "[\\"ammo_rifle\\",45]", "72": "[\\"ammo_repeater\\",45]", "65": "[\\"revolver_cattleman\\",1,0,0]", "66": "[\\"repeater_carbine\\",1,0,0]", "67": "[\\"ammo_rifle\\",15]", "69": "[\\"ammo_repeater\\",45]", "73": "[\\"ammo_revolver\\",60]", "68": "[\\"repeater_winchester\\",1,0,0]", "70": "[\\"rifle_springfield\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:615', 650, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:616', 676, 40, '{"67": "[\\"repeater_evans\\",1,0,0]", "97": "[\\"gold\\",3297]", "68": "[\\"repeater_evans\\",1,0,0]", "65": "[\\"repeater_evans\\",1,0,0]", "71": "[\\"pistol_mauser\\",1,0,0]", "69": "[\\"repeater_evans\\",1,0,0]", "70": "[\\"rifle_boltaction\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:617', 601, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:618', 642, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:619', 653, 40, '{"49": "[\\"herb_desert_sage\\",10]", "50": "[\\"herb_desert_sage\\",10]", "51": "[\\"herb_desert_sage\\",10]", "66": "[\\"lasso\\",1]", "65": "[\\"ammo_rifle\\",40]", "52": "[\\"herb_american_ginseng\\",10]", "53": "[\\"herb_american_ginseng\\",10]", "54": "[\\"herb_american_ginseng\\",10]", "55": "[\\"herb_american_ginseng\\",10]", "56": "[\\"herb_american_ginseng\\",2]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:62', 323, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:620', 641, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:621', 621, 40, '{"67": "[\\"ammo_rifle\\",45]", "68": "[\\"ammo_rifle\\",45]", "72": "[\\"ammo_rifle\\",45]", "65": "[\\"ammo_repeater\\",45]", "66": "[\\"repeater_winchester\\",1,0,0]", "69": "[\\"ammo_repeater\\",45]", "70": "[\\"ammo_rifle\\",45]", "71": "[\\"ammo_rifle\\",45]", "73": "[\\"ammo_rifle\\",30]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:622', 672, 40, '{"65": "[\\"revolver_cattleman\\",1,0,0]", "69": "[\\"revolver_cattleman\\",1,0,0]", "66": "[\\"repeater_carbine\\",1,0,45]", "70": "[\\"revolver_cattleman\\",1,0,0]", "97": "[\\"gold\\",100]", "67": "[\\"repeater_henry\\",1,0,0]", "68": "[\\"repeater_winchester\\",1,0,0]", "71": "[\\"ammo_repeater\\",45]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:623', 679, 40, '{"65": "[\\"repeater_henry\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:624', 597, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:625', 487, 40, '{"66": "[\\"revolver_doubleaction\\",1,0,0]", "67": "[\\"repeater_evans\\",1,0,0]", "65": "[\\"revolver_lemat\\",1,0,0]", "68": "[\\"rifle_springfield\\",1,0,0]", "69": "[\\"pistol_mauser\\",1,0,0]", "70": "[\\"melee_knife\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:626', 611, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:627', 675, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:628', 667, 40, '{"65": "[\\"rifle_varmint\\",1,0,80]", "66": "[\\"ammo_rifle\\",45]", "67": "[\\"ammo_rifle\\",35]", "68": "[\\"revolver_cattleman\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:629', 684, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:63', 321, 40, '{"97": "[\\"money\\",3000]", "49": "[\\"raw_copper\\",2]", "65": "[\\"repeater_carbine\\",1,0,0]", "68": "[\\"lasso\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:630', 400, 40, '{"65": "[\\"ammo_pistol\\",60]", "71": "[\\"ammo_pistol\\",60]", "67": "[\\"bow\\",1,0,0]", "68": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "69": "[\\"ammo_arrow\\",20]", "66": "[\\"repeater_henry\\",1,0,0]", "70": "[\\"repeater_henry\\",1,0,0]", "49": "[\\"meat_poor\\",1]", "51": "[\\"meat_good\\",1]", "52": "[\\"herb_wild_mint\\",3]", "54": "[\\"meat_perfect\\",2]", "57": "[\\"herb_black_berry\\",3]", "97": "[\\"gold\\",100]", "50": "[\\"herb_wild_carrot\\",1]", "53": "[\\"herb_burdock_root\\",2]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:631', 602, 40, '{"69": "[\\"repeater_carbine\\",2,0,0]", "65": "[\\"revolver_cattleman\\",1,0,0]", "66": "[\\"bow\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:632', 610, 40, '{"36": "[\\"medicine_good\\",1]", "38": "[\\"medicine_good\\",1]", "39": "[\\"medicine_good\\",1]", "40": "[\\"medicine_good\\",1]", "41": "[\\"medicine_good\\",1]", "42": "[\\"medicine_good\\",1]", "43": "[\\"medicine_good\\",1]", "44": "[\\"medicine_good\\",1]", "37": "[\\"medicine_good\\",1]", "45": "[\\"medicine_good\\",1]", "46": "[\\"medicine_good\\",1]", "47": "[\\"medicine_good\\",1]", "48": "[\\"medicine_good\\",1]", "51": "[\\"herb_common_bullrush\\",10]", "52": "[\\"herb_american_ginseng\\",10]", "50": "[\\"herb_common_bullrush\\",10]", "66": "[\\"pistol_mauser\\",1,0,0]", "65": "[\\"bow\\",1,0,0]", "33": "[\\"medicine_good\\",1]", "34": "[\\"medicine_good\\",1]", "35": "[\\"medicine_good\\",1]", "67": "[\\"repeater_winchester\\",1,0,0]", "49": "[\\"herb_common_bullrush\\",10]", "53": "[\\"herb_american_ginseng\\",3]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:633', 651, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:634', 659, 40, '{"65": "[\\"melee_knife\\",1,0,1]", "66": "[\\"lasso\\",1]", "67": "[\\"rifle_varmint\\",1,0,0]", "69": "[\\"repeater_carbine\\",1,0,0]", "49": "[\\"raw_iron\\",1]", "71": "[\\"ammo_pistol\\",60]", "70": "[\\"ammo_repeater\\",20]", "68": "[\\"ammo_rifle\\",20]", "72": "[\\"ammo_shotgun\\",20]", "33": "[\\"medicine_good\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:635', 646, 40, '{"65": "[\\"revolver_cattleman\\",1,0,0]", "66": "[\\"bow\\",1,0,0]", "67": "[\\"ammo_pistol\\",40]", "68": "[\\"bow\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:636', 597, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:637', 685, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:638', 680, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:639', 655, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:64', 264, 40, '{"65": "[\\"repeater_winchester\\",1,0,0]", "66": "[\\"repeater_henry\\",1,0,0]", "97": "[\\"gold\\",140]", "98": "[\\"money\\",101]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:640', 613, 40, '{"65": "[\\"ammo_repeater\\",35]", "66": "[\\"repeater_carbine\\",1,0,0]", "33": "[\\"medicine_good\\",1]", "34": "[\\"medicine_good\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:641', 607, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:642', 692, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:643', 430, 40, '{"65": "[\\"rifle_springfield\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:644', 694, 40, '{"65": "[\\"repeater_evans\\",1,0,0]", "66": "[\\"ammo_repeater\\",45]", "67": "[\\"ammo_repeater\\",45]", "68": "[\\"ammo_repeater\\",10]", "97": "[\\"money\\",1001]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:645', 684, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:646', 343, 40, '{"49": "[\\"herb_common_bullrush\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:647', 690, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:648', 693, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:649', 500, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:65', 246, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:650', 696, 40, '{"65": "[\\"repeater_carbine\\",1,0,140]", "67": "[\\"melee_lantern_electric\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:651', 695, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:652', 691, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:653', 697, 40, '{"66": "[\\"ammo_rifle\\",45]", "67": "[\\"ammo_rifle\\",45]", "68": "[\\"ammo_rifle\\",45]", "65": "[\\"ammo_rifle\\",45]", "70": "[\\"ammo_rifle\\",45]", "78": "[\\"bow\\",1,0,0]", "72": "[\\"ammo_shotgun\\",20]", "71": "[\\"ammo_repeater\\",20]", "69": "[\\"ammo_rifle\\",15]", "73": "[\\"rifle_varmint\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:654', 698, 40, '{"65": "[\\"ammo_22\\",20]", "66": "[\\"ammo_pistol\\",20]", "51": "[\\"feather_1\\",1]", "97": "[\\"money\\",10331]", "50": "[\\"herb_wild_carrot\\",4]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:655', 613, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:656', 613, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:657', 613, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:658', 613, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:659', 613, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:66', 358, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:660', 613, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:661', 701, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:662', 699, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:663', 622, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:664', 690, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:665', 695, 40, '{"65": "[\\"repeater_carbine\\",1,0,0]", "98": "[\\"money\\",27065]", "33": "[\\"medicine_poor\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:666', 613, 40, '{"66": "[\\"ammo_arrow\\",25]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:667', 709, 40, '{"66": "[\\"revolver_cattleman\\",1,0,0]", "67": "[\\"revolver_cattleman\\",1,0,0]", "69": "[\\"bow\\",1,0,0]", "70": "[\\"lasso\\",1]", "71": "[\\"melee_knife\\",1,0,1]", "72": "[\\"ammo_repeater\\",45]", "73": "[\\"melee_knife\\",1,0,1]", "74": "[\\"melee_knife\\",1,0,1]", "75": "[\\"melee_lantern_electric\\",1,0,1]", "76": "[\\"ammo_repeater\\",10]", "77": "[\\"lasso\\",1]", "65": "[\\"revolver_cattleman\\",1,0,0]", "78": "[\\"repeater_carbine\\",2,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:668', 705, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:669', 711, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:67', 345, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:670', 712, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:671', 712, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:672', 707, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:673', 624, 40, '{"65": "[\\"rifle_varmint\\",1,0,0]", "66": "[\\"bow\\",1,0,0]", "67": "[\\"pistol_mauser\\",1,0,0]", "68": "[\\"rifle_springfield\\",1,0,0]", "69": "[\\"repeater_evans\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:674', 627, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:675', 707, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:676', 655, 40, '{"33": "[\\"stimulant_good\\",1]", "34": "[\\"stimulant_good\\",1]", "35": "[\\"medicine_good\\",1]", "36": "[\\"medicine_good\\",1]", "37": "[\\"medicine_good\\",1]", "38": "[\\"medicine_good\\",1]", "39": "[\\"medicine_good\\",1]", "40": "[\\"medicine_good\\",1]", "41": "[\\"medicine_good\\",1]", "42": "[\\"medicine_good\\",1]", "43": "[\\"medicine_good\\",1]", "51": "[\\"herb_american_ginseng\\",10]", "53": "[\\"herb_american_ginseng\\",10]", "49": "[\\"herb_common_bullrush\\",10]", "50": "[\\"herb_common_bullrush\\",10]", "44": "[\\"medicine_good\\",1]", "45": "[\\"medicine_good\\",1]", "46": "[\\"medicine_good\\",1]", "47": "[\\"medicine_good\\",1]", "48": "[\\"medicine_good\\",1]", "52": "[\\"herb_american_ginseng\\",9]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:677', 720, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:678', 719, 40, '{"33": "[\\"medicine_good\\",1]", "34": "[\\"medicine_good\\",1]", "35": "[\\"medicine_good\\",1]", "36": "[\\"medicine_good\\",1]", "65": "[\\"melee_knife\\",1,0,1]", "66": "[\\"bow\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:679', 722, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:68', 372, 40, '{"49": "[\\"raw_copper\\",1]", "50": "[\\"raw_coal\\",1]", "67": "[\\"ammo_rifle\\",45]", "68": "[\\"ammo_rifle\\",35]", "70": "[\\"revolver_cattleman\\",1,0,0]", "71": "[\\"revolver_cattleman\\",1,0,0]", "72": "[\\"ammo_arrow\\",20]", "73": "[\\"bow\\",1,0,0]", "74": "[\\"bow\\",1,0,0]", "65": "[\\"repeater_carbine\\",1,0,0]", "97": "[\\"money\\",24486]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:680', 539, 40, '{"65": "[\\"bow\\",1,0,0]", "66": "[\\"melee_knife\\",1,0,1]", "67": "[\\"ammo_rifle\\",45]", "33": "[\\"medicine_good\\",1]", "68": "[\\"bow\\",1,0,0]", "69": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "70": "[\\"ammo_arrow\\",20]", "71": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "72": "[\\"melee_knife\\",1,0,1]", "81": "[\\"pigeonpost\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:681', 700, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:682', 724, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:683', 626, 40, '{"65": "[\\"revolver_cattleman\\",1,0,0]", "66": "[\\"revolver_cattleman\\",1,0,0]", "67": "[\\"melee_lantern_electric\\",1,0,1]", "68": "[\\"melee_lantern_electric\\",1,0,1]", "97": "[\\"gold\\",100]", "33": "[\\"medicine_good\\",1]", "34": "[\\"medicine_good\\",1]", "35": "[\\"stimulant_good\\",1]", "36": "[\\"stimulant_good\\",1]", "49": "[\\"herb_wild_mint\\",10]", "50": "[\\"herb_american_ginseng\\",2]", "51": "[\\"herb_parasol_mushroom\\",1]", "69": "[\\"lasso\\",1]", "70": "[\\"lasso\\",1]", "71": "[\\"lasso\\",1]", "72": "[\\"lasso\\",1]", "73": "[\\"lasso\\",1]", "74": "[\\"lasso\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:684', 415, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:685', 415, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:70', 334, 40, '{"70": "[\\"melee_knife\\",1,0,1]", "71": "[\\"revolver_cattleman\\",1,0,0]", "65": "[\\"bow\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:71', 204, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:72', 387, 40, '{"66": "[\\"revolver_cattleman\\",1,0,0]", "71": "[\\"revolver_cattleman\\",1,0,0]", "72": "[\\"lasso\\",1]", "77": "[\\"repeater_carbine\\",3,0,0]", "79": "[\\"revolver_cattleman\\",1,0,0]", "80": "[\\"revolver_cattleman\\",1,0,0]", "70": "[\\"lasso\\",1]", "67": "[\\"revolver_doubleaction\\",1,0,0]", "68": "[\\"revolver_doubleaction\\",1,0,0]", "73": "[\\"revolver_cattleman\\",1,0,0]", "65": "[\\"revolver_cattleman\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:73', 417, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:74', 414, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:75', 403, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:76', 439, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:77', 243, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:78', 354, 40, '{"65": "[\\"rifle_springfield\\",1,0,0]", "66": "[\\"rifle_springfield\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:79', 241, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:80', 455, 40, '{"65": "[\\"repeater_evans\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:81', 349, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:82', 445, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:83', 386, 40, '{"97": "[\\"gold\\",100]", "98": "[\\"money\\",3853]", "65": "[\\"rifle_springfield\\",1,0,0]", "71": "[\\"repeater_carbine\\",1,0,0]", "72": "[\\"rifle_springfield\\",1,0,0]", "73": "[\\"lasso\\",1]", "70": "[\\"shotgun_repeating\\",1,0,0]", "74": "[\\"melee_lantern_electric\\",1,0,1]", "69": "[\\"revolver_cattleman\\",1,0,0]", "68": "[\\"revolver_cattleman\\",1,0,0]", "66": "[\\"revolver_cattleman\\",1,0,0]", "67": "[\\"revolver_cattleman\\",1,0,0]", "75": "[\\"lasso\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:84', 471, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:85', 396, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:86', 245, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:87', 474, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:88', 419, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:89', 459, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:90', 442, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:91', 440, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:92', 460, 40, '{"65": "[\\"revolver_cattleman\\",1,0,0]", "66": "[\\"repeater_carbine\\",1,0,0]", "67": "[\\"melee_lantern_electric\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:93', 477, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:94', 494, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:95', 486, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:96', 446, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:97', 493, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:98', 490, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('horse:99', 454, 40, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:1:229', 229, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:1:260', 260, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:1:283', 283, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:1:310', 310, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:1:315', 315, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:1:320', 320, 100, '{"97": "[\\"money\\",979]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:1:328', 328, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:1:386', 386, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:1:558', 558, 100, '{"97": "[\\"money\\",79]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:1:559', 559, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:1:564', 564, 100, '{"49": "[\\"meat_poor\\",2]", "97": "[\\"money\\",911]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:1:582', 582, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:1:592', 592, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:1:593', 593, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:2:257', 257, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:2:272', 272, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:2:283', 283, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:2:321', 321, 100, '{"66": "[\\"melee_knife\\",1,0,1]", "67": "[\\"lasso\\",1]", "65": "[\\"bow\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:2:328', 328, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:2:582', 582, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:2:592', 592, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:3:257', 257, 100, '{"97": "[\\"money\\",29]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:3:272', 272, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:3:328', 328, 100, '{"68": "[\\"lasso\\",1]", "77": "[\\"rifle_springfield\\",1,0,0]", "78": "[\\"rifle_springfield\\",1,0,0]", "73": "[\\"repeater_winchester\\",1,0,0]", "74": "[\\"repeater_winchester\\",1,0,0]", "72": "[\\"lasso\\",1]", "76": "[\\"lasso\\",1]", "80": "[\\"lasso\\",1]", "65": "[\\"rifle_varmint\\",1,0,0]", "66": "[\\"rifle_boltaction\\",1,0,0]", "67": "[\\"melee_knife\\",1,0,1]", "70": "[\\"revolver_cattleman\\",1,0,0]", "71": "[\\"melee_lantern_electric\\",1,0,1]", "75": "[\\"melee_torch\\",1,0,1]", "69": "[\\"ammo_pistol\\",60]", "79": "[\\"lasso\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:3:554', 554, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:3:559', 559, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:248', 248, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:254', 254, 100, '{"65": "[\\"rifle_springfield\\",1,0,0]", "66": "[\\"rifle_springfield\\",1,0,0]", "67": "[\\"rifle_springfield\\",1,0,0]", "68": "[\\"rifle_springfield\\",1,0,0]", "73": "[\\"ammo_rifle\\",30]", "74": "[\\"ammo_repeater\\",45]", "72": "[\\"ammo_rifle\\",45]", "75": "[\\"ammo_repeater\\",45]", "49": "[\\"herb_parasol_mushroom\\",2]", "50": "[\\"herb_burdock_root\\",1]", "52": "[\\"herb_common_bullrush\\",8]", "53": "[\\"herb_wild_carrot\\",6]", "33": "[\\"medicine_poor\\",1]", "34": "[\\"medicine_poor\\",1]", "35": "[\\"medicine_poor\\",1]", "36": "[\\"medicine_poor\\",1]", "51": "[\\"herb_oregano\\",5]", "69": "[\\"repeater_henry\\",1,0,0]", "70": "[\\"bow\\",1,0,0]", "71": "[\\"ammo_rifle\\",45]", "76": "[\\"ammo_repeater\\",45]", "54": "[\\"herb_american_ginseng\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:257', 257, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:260', 260, 100, '{"49": "[\\"raw_gold\\",5]", "35": "[\\"stimulant_good\\",1]", "75": "[\\"bow\\",1,0,0]", "70": "[\\"revolver_lemat\\",1,0,0]", "81": "[\\"acamp_firesmal_pan\\",1]", "82": "[\\"acamp_tents_med_closed\\",1]", "33": "[\\"stimulant_good\\",1]", "66": "[\\"repeater_evans\\",1,0,0]", "67": "[\\"repeater_evans\\",1,0,0]", "71": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "72": "[\\"revolver_lemat\\",1,0,0]", "65": "[\\"repeater_henry\\",1,0,0]", "68": "[\\"sniperrifle_rollingblock\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:272', 272, 100, '{"73": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "72": "[\\"melee_knife\\",1,0,1]", "75": "[\\"revolver_cattleman_john\\",1,0,0]", "78": "[\\"repeater_henry\\",1,0,0]", "77": "[\\"repeater_winchester\\",1,0,0]", "76": "[\\"repeater_winchester\\",1,0,0]", "65": "[\\"revolver_cattleman\\",1,0,0]", "67": "[\\"revolver_doubleaction\\",1,0,0]", "80": "[\\"rifle_springfield\\",1,0,0]", "66": "[\\"revolver_cattleman\\",1,0,0]", "68": "[\\"rifle_varmint\\",1,0,0]", "69": "[\\"revolver_cattleman\\",1,0,0]", "70": "[\\"bow\\",1,0,0]", "71": "[\\"bow\\",1,0,0]", "74": "[\\"melee_knife\\",1,0,1]", "79": "[\\"lasso\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:283', 283, 100, '{"65": "[\\"revolver_lemat\\",1,0,0]", "66": "[\\"revolver_lemat\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:310', 310, 100, '{"76": "[\\"revolver_lemat\\",1,0,0]", "49": "[\\"herb_oregano\\",3]", "50": "[\\"herb_wild_mint\\",8]", "51": "[\\"herb_parasol_mushroom\\",3]", "52": "[\\"herb_american_ginseng\\",6]", "81": "[\\"pigeonpost\\",1]", "75": "[\\"revolver_lemat\\",1,0,0]", "74": "[\\"revolver_lemat\\",1,0,0]", "73": "[\\"revolver_cattleman\\",1,0,0]", "65": "[\\"melee_knife\\",1,0,1]", "69": "[\\"lasso\\",1]", "77": "[\\"repeater_carbine\\",1,0,0]", "78": "[\\"repeater_carbine\\",1,0,0]", "79": "[\\"repeater_carbine\\",1,0,0]", "70": "[\\"lasso\\",1]", "66": "[\\"melee_knife\\",1,0,1]", "68": "[\\"bow\\",1,0,0]", "97": "[\\"money\\",1643]", "71": "[\\"rifle_springfield\\",1,0,0]", "72": "[\\"pistol_mauser\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:314', 314, 100, '{"65": "[\\"revolver_cattleman_john\\",1,0,0]", "67": "[\\"rifle_boltaction\\",1,0,0]", "68": "[\\"ammo_rifle\\",45]", "69": "[\\"ammo_rifle\\",45]", "49": "[\\"herb_wild_mint\\",4]", "50": "[\\"herb_wild_carrot\\",4]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:315', 315, 100, '{"49": "[\\"herb_prairie_poppy\\",4]", "53": "[\\"herb_burdock_root\\",2]", "54": "[\\"feather_5\\",1]", "76": "[\\"revolver_cattleman\\",1,0,0]", "50": "[\\"feather_2\\",1]", "33": "[\\"medicine_good\\",1]", "57": "[\\"herb_wild_mint\\",2]", "58": "[\\"feather_2\\",1]", "51": "[\\"herb_wild_carrot\\",10]", "52": "[\\"herb_oregano\\",5]", "56": "[\\"herb_parasol_mushroom\\",1]", "55": "[\\"herb_alaskan_ginseng\\",1]", "59": "[\\"herb_wild_carrot\\",3]", "60": "[\\"raw_gold\\",1]", "61": "[\\"herb_common_bullrush\\",2]", "77": "[\\"repeater_winchester\\",1,0,0]", "65": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "66": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "67": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "72": "[\\"revolver_cattleman\\",1,0,0]", "80": "[\\"bow\\",1,0,0]", "79": "[\\"bow\\",1,0,0]", "75": "[\\"revolver_cattleman\\",1,0,0]", "68": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "74": "[\\"revolver_cattleman\\",1,0,0]", "97": "[\\"gold\\",100]", "70": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "69": "[\\"bow\\",1,0,0]", "71": "[\\"bow\\",1,0,0]", "73": "[\\"bow\\",1,0,0]", "78": "[\\"repeater_winchester\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:328', 328, 100, '{"18": "[\\"meat_oregano_cooked\\",3]", "19": "[\\"meat_oregano_cooked\\",3]", "71": "[\\"melee_lantern_electric\\",1,0,1]", "68": "[\\"ammo_repeater\\",15]", "73": "[\\"bow\\",1,0,0]", "66": "[\\"shotgun_semiauto\\",1,0,0]", "74": "[\\"bow\\",1,0,0]", "33": "[\\"medicine_good\\",1]", "77": "[\\"revolver_cattleman\\",1,0,0]", "78": "[\\"revolver_cattleman\\",1,0,0]", "79": "[\\"revolver_cattleman\\",1,0,0]", "80": "[\\"revolver_cattleman\\",1,0,0]", "72": "[\\"lasso\\",1]", "75": "[\\"bow\\",1,0,0]", "49": "[\\"herb_oregano\\",7]", "50": "[\\"herb_burdock_root\\",1]", "51": "[\\"herb_prairie_poppy\\",7]", "52": "[\\"herb_alaskan_ginseng\\",6]", "56": "[\\"herb_black_berry\\",6]", "55": "[\\"herb_wild_mint\\",3]", "65": "[\\"rifle_varmint\\",1,0,0]", "67": "[\\"repeater_henry\\",1,0,0]", "97": "[\\"money\\",40000]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:387', 387, 100, '{"65": "[\\"revolver_cattleman\\",1,0,0]", "66": "[\\"bow\\",1,0,0]", "67": "[\\"revolver_cattleman\\",1,0,0]", "68": "[\\"revolver_cattleman\\",1,0,0]", "69": "[\\"revolver_cattleman\\",1,0,0]", "70": "[\\"bow\\",1,0,0]", "71": "[\\"bow\\",1,0,0]", "72": "[\\"bow\\",1,0,0]", "75": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "73": "[\\"rifle_springfield\\",1,0,0]", "76": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "77": "[\\"revolver_cattleman\\",1,0,0]", "79": "[\\"revolver_lemat\\",1,0,0]", "80": "[\\"lasso\\",1]", "74": "[\\"rifle_springfield\\",1,0,0]", "78": "[\\"revolver_cattleman\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:397', 397, 100, '{"65": "[\\"rifle_springfield\\",1,0,0]", "66": "[\\"repeater_carbine\\",1,0,0]", "67": "[\\"bow\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:400', 400, 100, '{"81": "[\\"acamp_bedroll\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:415', 415, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:417', 417, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:486', 486, 100, '{"49": "[\\"raw_gold\\",3]", "50": "[\\"herb_oregano\\",1]", "51": "[\\"herb_alaskan_ginseng\\",1]", "65": "[\\"bow\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:487', 487, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:522', 522, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:531', 531, 100, '{"65": "[\\"revolver_cattleman\\",1,0,0]", "66": "[\\"rifle_varmint\\",1,0,0]", "69": "[\\"ammo_rifle\\",45]", "67": "[\\"ammo_shotgun\\",20]", "68": "[\\"ammo_pistol\\",20]", "71": "[\\"ammo_rifle\\",15]", "34": "[\\"medicine_good\\",1]", "35": "[\\"medicine_good\\",1]", "37": "[\\"stimulant_good\\",1]", "38": "[\\"stimulant_good\\",1]", "36": "[\\"medicine_good\\",1]", "39": "[\\"stimulant_good\\",1]", "40": "[\\"stimulant_good\\",1]", "41": "[\\"medicine_good\\",1]", "42": "[\\"medicine_good\\",1]", "43": "[\\"medicine_good\\",1]", "44": "[\\"medicine_good\\",1]", "45": "[\\"medicine_good\\",1]", "46": "[\\"medicine_good\\",1]", "47": "[\\"medicine_good\\",1]", "33": "[\\"medicine_good\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:537', 537, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:540', 540, 100, '{"65": "[\\"rifle_springfield\\",1,0,0]", "69": "[\\"repeater_evans\\",1,0,0]", "70": "[\\"repeater_evans\\",1,0,0]", "71": "[\\"repeater_evans\\",1,0,0]", "66": "[\\"rifle_springfield\\",1,0,0]", "67": "[\\"rifle_springfield\\",1,0,0]", "72": "[\\"repeater_evans\\",1,0,0]", "68": "[\\"rifle_springfield\\",1,0,0]", "74": "[\\"repeater_carbine\\",3,0,0]", "73": "[\\"rifle_varmint\\",1,0,0]", "77": "[\\"rifle_springfield\\",1,0,0]", "80": "[\\"repeater_evans\\",1,0,0]", "76": "[\\"shotgun_repeating\\",1,0,0]", "75": "[\\"revolver_lemat\\",1,0,0]", "79": "[\\"repeater_evans\\",1,0,0]", "78": "[\\"rifle_springfield\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:548', 548, 100, '{"65": "[\\"repeater_henry\\",1,0,0]", "66": "[\\"rifle_varmint\\",1,0,0]", "67": "[\\"revolver_cattleman\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:550', 550, 100, '{"65": "[\\"pistol_mauser\\",1,0,0]", "66": "[\\"pistol_mauser\\",1,0,0]", "49": "[\\"raw_gold\\",3]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:556', 556, 100, '{"71": "[\\"rifle_springfield\\",1,0,0]", "69": "[\\"repeater_henry\\",1,0,0]", "65": "[\\"repeater_carbine\\",4,0,0]", "66": "[\\"repeater_henry\\",1,0,0]", "67": "[\\"repeater_henry\\",1,0,0]", "73": "[\\"melee_knife_vampire\\",1,0,0]", "77": "[\\"rifle_boltaction\\",1,0,0]", "68": "[\\"rifle_springfield\\",1,0,0]", "49": "[\\"herb_oregano\\",10]", "50": "[\\"herb_oregano\\",10]", "74": "[\\"rifle_varmint\\",1,0,0]", "70": "[\\"rifle_springfield\\",1,0,0]", "72": "[\\"rifle_springfield\\",1,0,0]", "79": "[\\"repeater_evans\\",1,0,0]", "75": "[\\"repeater_winchester\\",1,0,0]", "76": "[\\"repeater_winchester\\",1,0,0]", "78": "[\\"revolver_cattleman_mexican\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:572', 572, 100, '{"65": "[\\"lasso\\",1]", "66": "[\\"lasso\\",1]", "67": "[\\"bow\\",1,0,0]", "71": "[\\"melee_lantern_electric\\",1,0,1]", "54": "[\\"herb_black_berry\\",3]", "50": "[\\"herb_alaskan_ginseng\\",1]", "55": "[\\"herb_prairie_poppy\\",2]", "56": "[\\"herb_wild_feverfew\\",2]", "51": "[\\"herb_wild_carrot\\",10]", "52": "[\\"herb_black_current\\",3]", "70": "[\\"bow\\",1,0,0]", "36": "[\\"medicine_good\\",1]", "53": "[\\"herb_rams_head\\",5]", "57": "[\\"herb_wild_carrot\\",4]", "49": "[\\"herb_oregano\\",10]", "58": "[\\"herb_desert_sage\\",1]", "59": "[\\"herb_burdock_root\\",4]", "60": "[\\"herb_oregano\\",3]", "33": "[\\"medicine_good\\",1]", "34": "[\\"medicine_good\\",1]", "35": "[\\"medicine_good\\",1]", "37": "[\\"medicine_good\\",1]", "40": "[\\"medicine_good\\",1]", "45": "[\\"stimulant_good\\",1]", "46": "[\\"stimulant_good\\",1]", "47": "[\\"stimulant_good\\",1]", "48": "[\\"stimulant_good\\",1]", "41": "[\\"stimulant_good\\",1]", "42": "[\\"stimulant_good\\",1]", "69": "[\\"rifle_varmint\\",1,0,0]", "38": "[\\"medicine_good\\",1]", "39": "[\\"medicine_good\\",1]", "43": "[\\"medicine_good\\",1]", "44": "[\\"medicine_good\\",1]", "73": "[\\"repeater_henry\\",1,0,0]", "74": "[\\"melee_knife_vampire\\",1,0,0]", "75": "[\\"lasso\\",1]", "72": "[\\"revolver_cattleman_john\\",1,0,0]", "76": "[\\"repeater_henry\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:576', 576, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:582', 582, 100, '{"81": "[\\"acamp_tents_small\\",1]", "70": "[\\"repeater_carbine\\",2,0,0]", "72": "[\\"lasso\\",1]", "66": "[\\"melee_knife_vampire\\",1,0,0]", "76": "[\\"rifle_springfield\\",1,0,0]", "36": "[\\"medicine_good\\",1]", "65": "[\\"melee_knife\\",1,0,1]", "78": "[\\"lasso\\",1]", "79": "[\\"lasso\\",1]", "82": "[\\"pigeonpost\\",1]", "74": "[\\"pistol_mauser\\",1,0,0]", "77": "[\\"rifle_springfield\\",1,0,0]", "80": "[\\"repeater_evans\\",1,0,0]", "67": "[\\"ammo_rifle\\",40]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:588', 588, 100, '{"65": "[\\"revolver_cattleman\\",1,0,0]", "66": "[\\"ammo_rifle\\",20]", "67": "[\\"ammo_shotgun\\",20]", "68": "[\\"ammo_repeater\\",20]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:591', 591, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:592', 592, 100, '{"68": "[\\"bow\\",1,0,0]", "76": "[\\"revolver_cattleman_pig\\",1,0,0]", "75": "[\\"revolver_cattleman\\",1,0,0]", "80": "[\\"revolver_cattleman\\",1,0,0]", "73": "[\\"repeater_evans\\",1,0,0]", "77": "[\\"bow\\",1,0,0]", "74": "[\\"repeater_carbine\\",1,0,0]", "67": "[\\"melee_cleaver\\",1,0,1]", "66": "[\\"melee_knife_bear\\",1,0,1]", "78": "[\\"repeater_winchester\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:597', 597, 100, '{"65": "[\\"lasso\\",1]", "66": "[\\"lasso\\",1]", "67": "[\\"lasso\\",1]", "68": "[\\"melee_knife\\",1,0,1]", "33": "[\\"medicine_good\\",1]", "34": "[\\"medicine_good\\",1]", "35": "[\\"medicine_good\\",1]", "36": "[\\"medicine_good\\",1]", "37": "[\\"medicine_good\\",1]", "38": "[\\"medicine_good\\",1]", "69": "[\\"revolver_cattleman\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:600', 600, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:608', 608, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:609', 609, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:610', 610, 100, '{"51": "[\\"herb_prairie_poppy\\",2]", "52": "[\\"herb_wild_mint\\",3]", "33": "[\\"stimulant_good\\",1]", "34": "[\\"stimulant_good\\",1]", "35": "[\\"stimulant_good\\",1]", "36": "[\\"stimulant_good\\",1]", "37": "[\\"stimulant_good\\",1]", "38": "[\\"stimulant_good\\",1]", "39": "[\\"stimulant_good\\",1]", "40": "[\\"stimulant_good\\",1]", "41": "[\\"stimulant_good\\",1]", "42": "[\\"stimulant_good\\",1]", "43": "[\\"stimulant_good\\",1]", "44": "[\\"stimulant_good\\",1]", "45": "[\\"stimulant_good\\",1]", "46": "[\\"stimulant_good\\",1]", "49": "[\\"herb_oregano\\",9]", "53": "[\\"herb_alaskan_ginseng\\",3]", "47": "[\\"medicine_good\\",1]", "48": "[\\"medicine_good\\",1]", "54": "[\\"meat_perfect\\",1]", "65": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "55": "[\\"herb_parasol_mushroom\\",10]", "56": "[\\"herb_parasol_mushroom\\",10]", "57": "[\\"herb_parasol_mushroom\\",2]", "50": "[\\"herb_wild_carrot\\",2]", "67": "[\\"rifle_varmint\\",1,0,0]", "68": "[\\"revolver_cattleman\\",1,0,0]", "70": "[\\"melee_knife_vampire\\",1,0,0]", "97": "[\\"gold\\",100]", "66": "[\\"repeater_winchester\\",1,0,0]", "69": "[\\"ammo_arrow\\",8]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:614', 614, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:615', 615, 100, '{"67": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "68": "[\\"ammo_rifle\\",40]", "65": "[\\"melee_lantern_electric\\",1,0,1]", "33": "[\\"stimulant_good\\",1]", "34": "[\\"medicine_good\\",1]", "66": "[\\"revolver_cattleman\\",1,0,0]", "69": "[\\"ammo_revolver\\",40]", "35": "[\\"medicine_poor\\",1]", "36": "[\\"stimulant_poor\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:617', 617, 100, '{"33": "[\\"stimulant_good\\",1]", "49": "[\\"herb_wild_mint\\",10]", "50": "[\\"herb_prairie_poppy\\",2]", "51": "[\\"herb_wild_mint\\",3]", "52": "[\\"herb_wild_carrot\\",4]", "53": "[\\"herb_rams_head\\",3]", "54": "[\\"herb_alaskan_ginseng\\",3]", "55": "[\\"herb_black_berry\\",3]", "56": "[\\"herb_oregano\\",3]", "57": "[\\"herb_american_ginseng\\",10]", "58": "[\\"herb_american_ginseng\\",9]", "59": "[\\"herb_burdock_root\\",10]", "60": "[\\"herb_burdock_root\\",6]", "61": "[\\"herb_parasol_mushroom\\",4]", "34": "[\\"medicine_good\\",1]", "97": "[\\"gold\\",300]", "65": "[\\"bow\\",1,0,0]", "66": "[\\"bow\\",1,0,0]", "73": "[\\"repeater_winchester\\",1,0,0]", "74": "[\\"repeater_winchester\\",1,0,0]", "68": "[\\"revolver_cattleman\\",1,0,0]", "35": "[\\"medicine_good\\",1]", "36": "[\\"medicine_good\\",1]", "37": "[\\"medicine_good\\",1]", "38": "[\\"medicine_good\\",1]", "39": "[\\"medicine_good\\",1]", "75": "[\\"repeater_winchester\\",1,0,0]", "67": "[\\"revolver_cattleman\\",1,0,0]", "70": "[\\"repeater_henry\\",1,0,0]", "71": "[\\"repeater_henry\\",1,0,0]", "69": "[\\"repeater_henry\\",1,0,0]", "72": "[\\"repeater_carbine\\",1,0,0]", "80": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "79": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "77": "[\\"rifle_springfield\\",1,0,0]", "78": "[\\"rifle_springfield\\",1,0,0]", "76": "[\\"repeater_winchester\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:620', 620, 100, '{"65": "[\\"rifle_springfield\\",1,0,0]", "17": "[\\"meat_cooked\\",3]", "18": "[\\"meat_cooked\\",3]", "19": "[\\"meat_cooked\\",3]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:623', 623, 100, '{"65": "[\\"lasso\\",1]", "67": "[\\"melee_knife\\",1,0,1]", "69": "[\\"ammo_revolver\\",60]", "71": "[\\"lasso\\",1]", "72": "[\\"lasso\\",1]", "73": "[\\"melee_knife\\",1,0,1]", "74": "[\\"melee_knife\\",1,0,1]", "76": "[\\"lasso\\",1]", "80": "[\\"lasso\\",1]", "66": "[\\"revolver_lemat\\",1,0,0]", "68": "[\\"revolver_cattleman\\",1,0,0]", "70": "[\\"revolver_cattleman\\",1,0,0]", "75": "[\\"revolver_cattleman\\",1,0,0]", "77": "[\\"rifle_springfield\\",1,0,0]", "78": "[\\"melee_knife\\",1,0,1]", "79": "[\\"melee_lantern_electric\\",1,0,1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:625', 625, 100, '{"73": "[\\"lasso\\",1]", "69": "[\\"lasso\\",1]", "68": "[\\"melee_lantern_electric\\",1,0,1]", "74": "[\\"revolver_cattleman\\",1,0,0]", "66": "[\\"revolver_cattleman\\",1,0,0]", "72": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "76": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "78": "[\\"revolver_cattleman\\",1,0,0]", "71": "[\\"bow\\",1,0,0]", "33": "[\\"medicine_good\\",1]", "34": "[\\"medicine_good\\",1]", "53": "[\\"herb_desert_sage\\",10]", "54": "[\\"herb_desert_sage\\",10]", "55": "[\\"herb_desert_sage\\",10]", "56": "[\\"herb_desert_sage\\",10]", "52": "[\\"herb_desert_sage\\",2]", "60": "[\\"herb_burdock_root\\",10]", "75": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "70": "[\\"revolver_cattleman\\",1,0,0]", "65": "[\\"lasso\\",1]", "77": "[\\"revolver_doubleaction\\",1,0,0]", "67": "[\\"bow\\",1,0,0]", "79": "[\\"melee_knife_vampire\\",1,0,0]", "49": "[\\"herb_burdock_root\\",1]", "80": "[\\"lasso\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:626', 626, 100, '{"68": "[\\"melee_knife\\",1,0,1]", "50": "[\\"herb_wild_mint\\",1]", "51": "[\\"meat_perfect\\",3]", "52": "[\\"meat_perfect\\",3]", "53": "[\\"meat_good\\",1]", "54": "[\\"meat_perfect\\",1]", "65": "[\\"repeater_henry\\",1,0,0]", "67": "[\\"rifle_springfield\\",1,0,0]", "69": "[\\"repeater_winchester\\",1,0,0]", "70": "[\\"revolver_cattleman\\",1,0,0]", "71": "[\\"repeater_henry\\",1,0,0]", "72": "[\\"revolver_cattleman_john\\",1,0,0]", "73": "[\\"melee_knife_vampire\\",1,0,0]", "66": "[\\"revolver_cattleman\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:629', 629, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:630', 630, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:634', 634, 100, '{"65": "[\\"revolver_cattleman\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:635', 635, 100, '{"65": "[\\"repeater_carbine\\",1,0,0]", "66": "[\\"ammo_repeater\\",45]", "67": "[\\"ammo_repeater\\",35]", "68": "[\\"melee_torch\\",1,0,1]", "69": "[\\"ammo_shotgun\\",20]", "70": "[\\"revolver_cattleman\\",1,0,0]", "71": "[\\"revolver_cattleman\\",1,0,0]", "73": "[\\"ammo_pistol\\",60]", "74": "[\\"ammo_pistol\\",20]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:645', 645, 100, '{"65": "[\\"bow\\",1,0,0]", "66": "[\\"ammo_arrow\\",9]", "67": "[\\"ammo_revolver\\",40]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:650', 650, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:651', 651, 100, '{"65": "[\\"lasso\\",1]", "66": "[\\"bow\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:652', 652, 100, '{"65": "[\\"bow\\",1,0,0]", "66": "[\\"melee_knife\\",1,0,1]", "67": "[\\"melee_knife\\",1,0,1]", "68": "[\\"pistol_mauser\\",1,0,0]", "73": "[\\"melee_torch\\",1,0,1]", "97": "[\\"money\\",52]", "49": "[\\"meat_poor\\",1]", "76": "[\\"melee_lantern_electric\\",1,0,1]", "77": "[\\"melee_torch\\",1,0,1]", "78": "[\\"repeater_henry\\",1,0,0]", "69": "[\\"ammo_pistol\\",60]", "70": "[\\"ammo_pistol\\",40]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:653', 653, 100, '{"49": "[\\"herb_desert_sage\\",10]", "50": "[\\"herb_oregano\\",10]", "51": "[\\"herb_desert_sage\\",10]", "52": "[\\"herb_desert_sage\\",10]", "53": "[\\"herb_desert_sage\\",10]", "65": "[\\"rifle_springfield\\",1,0,0]", "66": "[\\"ammo_rifle\\",40]", "54": "[\\"herb_desert_sage\\",10]", "61": "[\\"herb_desert_sage\\",10]", "62": "[\\"herb_desert_sage\\",10]", "63": "[\\"herb_desert_sage\\",10]", "64": "[\\"herb_desert_sage\\",4]", "55": "[\\"herb_oregano\\",10]", "56": "[\\"herb_oregano\\",10]", "57": "[\\"herb_oregano\\",10]", "58": "[\\"herb_oregano\\",10]", "59": "[\\"herb_oregano\\",10]", "60": "[\\"herb_oregano\\",8]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:655', 655, 100, '{"17": "[\\"meat_cooked\\",3]", "18": "[\\"meat_cooked\\",1]", "64": "[\\"herb_common_bullrush\\",10]", "45": "[\\"medicine_good\\",1]", "46": "[\\"medicine_good\\",1]", "98": "[\\"gold\\",200]", "77": "[\\"repeater_henry\\",1,0,0]", "78": "[\\"repeater_henry\\",1,0,0]", "79": "[\\"repeater_henry\\",1,0,0]", "80": "[\\"melee_knife_vampire\\",1,0,0]", "57": "[\\"herb_oregano\\",5]", "59": "[\\"herb_american_ginseng\\",10]", "63": "[\\"herb_common_bullrush\\",10]", "61": "[\\"herb_common_bullrush\\",10]", "62": "[\\"herb_common_bullrush\\",10]", "58": "[\\"herb_oregano\\",10]", "60": "[\\"herb_american_ginseng\\",10]", "56": "[\\"herb_american_ginseng\\",10]", "55": "[\\"herb_american_ginseng\\",10]", "75": "[\\"bow\\",1,0,0]", "73": "[\\"repeater_winchester\\",1,0,0]", "72": "[\\"lasso\\",1]", "71": "[\\"lasso\\",1]", "50": "[\\"herb_common_bullrush\\",10]", "51": "[\\"herb_common_bullrush\\",10]", "49": "[\\"herb_common_bullrush\\",1]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:662', 662, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:670', 670, 100, '{"65": "[\\"rifle_springfield\\",1,0,0]", "66": "[\\"rifle_springfield\\",1,0,0]", "69": "[\\"repeater_evans\\",1,0,0]", "70": "[\\"repeater_evans\\",1,0,0]", "73": "[\\"rifle_varmint\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:676', 676, 100, '{"74": "[\\"pistol_mauser\\",1,0,0]", "78": "[\\"melee_hatchet_hunter_rusted\\",1,0,1]", "73": "[\\"pistol_mauser\\",1,0,0]", "77": "[\\"revolver_cattleman_john\\",1,0,0]", "68": "[\\"repeater_evans\\",1,0,0]", "67": "[\\"repeater_evans\\",1,0,0]", "65": "[\\"rifle_springfield\\",1,0,0]", "70": "[\\"revolver_doubleaction\\",1,0,0]", "71": "[\\"revolver_doubleaction\\",1,0,0]", "72": "[\\"revolver_lemat\\",1,0,0]", "76": "[\\"revolver_cattleman_john\\",1,0,0]", "80": "[\\"sniperrifle_rollingblock\\",1,0,0]", "66": "[\\"repeater_carbine\\",1,0,0]", "75": "[\\"pistol_mauser\\",1,0,0]", "69": "[\\"sniperrifle_rollingblock_exotic\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:680', 680, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:685', 685, 100, '{"67": "[\\"revolver_lemat\\",1,0,0]", "68": "[\\"revolver_cattleman\\",1,0,0]", "65": "[\\"ammo_rifle\\",45]", "66": "[\\"ammo_rifle\\",45]", "69": "[\\"ammo_rifle\\",30]", "70": "[\\"bow\\",1,0,0]", "71": "[\\"lasso\\",1]", "72": "[\\"rifle_varmint\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:697', 697, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:699', 699, 100, '{"65": "[\\"revolver_cattleman\\",1,0,0]", "49": "[\\"herb_parasol_mushroom\\",3]", "50": "[\\"herb_american_ginseng\\",6]", "51": "[\\"herb_common_bullrush\\",2]", "66": "[\\"repeater_henry\\",1,0,0]", "97": "[\\"gold\\",100]", "67": "[\\"repeater_henry\\",1,0,0]", "68": "[\\"melee_knife\\",1,0,1]", "52": "[\\"feather_2\\",1]", "53": "[\\"feather_5\\",1]", "54": "[\\"raw_gold\\",2]", "55": "[\\"herb_burdock_root\\",10]", "56": "[\\"herb_wild_mint\\",2]", "57": "[\\"herb_black_berry\\",1]", "58": "[\\"herb_alaskan_ginseng\\",3]", "69": "[\\"pistol_mauser\\",1,0,0]", "70": "[\\"bow\\",1,0,0]", "71": "[\\"melee_knife\\",1,0,1]", "72": "[\\"revolver_cattleman\\",1,0,0]", "73": "[\\"rifle_varmint\\",1,0,0]", "74": "[\\"revolver_cattleman\\",1,0,0]", "75": "[\\"lasso\\",1]", "76": "[\\"revolver_cattleman\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:703', 703, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:710', 710, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:711', 711, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:716', 716, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:719', 719, 100, '{}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:720', 720, 100, '{"65": "[\\"bow\\",1,0,0]", "67": "[\\"revolver_cattleman\\",1,0,0]", "68": "[\\"revolver_cattleman\\",1,0,0]"}');
INSERT IGNORE INTO `inventories` (`id`, `charid`, `inv_capacity`, `inv_slots`) VALUES
	('static:public:4:724', 724, 100, '{}');
/*!40000 ALTER TABLE `inventories` ENABLE KEYS */;

-- Copiando estrutura para procedure redm.inv_remove_slot
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `inv_remove_slot`(
	IN `inv_id` VARCHAR(100),
	IN `slot_id` INT
)
BEGIN
    UPDATE inventories SET inv_slots = JSON_REMOVE(inv_slots, CONCAT("$.", slot_id)) WHERE id = inv_id;
END//
DELIMITER ;

-- Copiando estrutura para procedure redm.inv_update_slot
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `inv_update_slot`(
	IN `inv_id` VARCHAR(100),
	IN `slot_id` INT,
	IN `slot_value` VARCHAR(255)
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

-- Copiando estrutura para tabela redm.membres
CREATE TABLE IF NOT EXISTS `membres` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pseudo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mail` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `motdepasse` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Copiando dados para a tabela redm.membres: 3 rows
/*!40000 ALTER TABLE `membres` DISABLE KEYS */;
INSERT IGNORE INTO `membres` (`id`, `pseudo`, `mail`, `motdepasse`) VALUES
	(5, 'KlandesTino', 'klandestino6@hotmail.com', '6fcf00a5c74c20f55bc4ccbe4ba0048f07430b0d');
INSERT IGNORE INTO `membres` (`id`, `pseudo`, `mail`, `motdepasse`) VALUES
	(6, 'Belamusa', 'thebelamusa@outlook.com', '6a4e06ee67db381fd3ef01bab96a8c3f34536dc7');
INSERT IGNORE INTO `membres` (`id`, `pseudo`, `mail`, `motdepasse`) VALUES
	(7, 'soram', 'soramgamer@hotmail.com', '3fd8dd9d9f1cd3260ce53500af472c61a01ad5d8');
/*!40000 ALTER TABLE `membres` ENABLE KEYS */;

-- Copiando estrutura para tabela redm.posses
CREATE TABLE IF NOT EXISTS `posses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `charid` int(11) NOT NULL,
  `members` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `charid` (`charid`),
  CONSTRAINT `FK_posses_characters` FOREIGN KEY (`charid`) REFERENCES `characters` (`charid`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=75 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.posses: ~13 rows (aproximadamente)
/*!40000 ALTER TABLE `posses` DISABLE KEYS */;
INSERT IGNORE INTO `posses` (`id`, `charid`, `members`, `name`) VALUES
	(60, 189, '{"189":1}', 'Babalu\n');
INSERT IGNORE INTO `posses` (`id`, `charid`, `members`, `name`) VALUES
	(61, 248, '{"248":1}', 'Downtown Babys');
INSERT IGNORE INTO `posses` (`id`, `charid`, `members`, `name`) VALUES
	(63, 543, '{"543":1}', 'Peaky Blinders');
INSERT IGNORE INTO `posses` (`id`, `charid`, `members`, `name`) VALUES
	(64, 486, '{"486":1}', 'Santo Capra');
INSERT IGNORE INTO `posses` (`id`, `charid`, `members`, `name`) VALUES
	(65, 493, '{"493":1}', 'Los Mexicanos');
INSERT IGNORE INTO `posses` (`id`, `charid`, `members`, `name`) VALUES
	(66, 560, '{"560":1}', 'Urso Negro');
INSERT IGNORE INTO `posses` (`id`, `charid`, `members`, `name`) VALUES
	(67, 556, '{"556":1}', 'Irmandade do Norte');
INSERT IGNORE INTO `posses` (`id`, `charid`, `members`, `name`) VALUES
	(69, 559, '{"559":1}', 'CABRAS DA PESTE');
INSERT IGNORE INTO `posses` (`id`, `charid`, `members`, `name`) VALUES
	(70, 592, '{"592":1}', 'DownTown Babys');
INSERT IGNORE INTO `posses` (`id`, `charid`, `members`, `name`) VALUES
	(71, 315, '{"315":1}', 'Clã Aesir');
INSERT IGNORE INTO `posses` (`id`, `charid`, `members`, `name`) VALUES
	(72, 602, '{"602":1}', 'MANDRAKE');
INSERT IGNORE INTO `posses` (`id`, `charid`, `members`, `name`) VALUES
	(73, 315, '{"315":1}', 'Clã Aesir');
INSERT IGNORE INTO `posses` (`id`, `charid`, `members`, `name`) VALUES
	(74, 625, '{"625":1}', 'Bounty Hunter');
/*!40000 ALTER TABLE `posses` ENABLE KEYS */;

-- Copiando estrutura para procedure redm.procInventory
DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `procInventory`(
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `remData`(
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `setData`(
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
) ENGINE=InnoDB AUTO_INCREMENT=401 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.users: ~310 rows (aproximadamente)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(0, 'system', 'system', 1);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(1, 'steam:11000010596ee06', 'KlandesTino', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(4, 'steam:110000106321dbf', 'Twitch/sorambr', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(6, 'steam:110000109766c18', 'key_value', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(7, 'steam:110000115598f8c', 'gashex', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(51, 'steam:110000134b230b1', 'VelmaDricky', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(52, 'steam:1100001067bddc2', 'SiG', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(53, 'steam:110000106ff1cbd', 'SuplaGames', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(54, 'steam:110000107caf442', 'Diego', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(55, 'steam:1100001031f4669', 'Zen0n', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(56, 'steam:11000011559ed3f', 'chuplinga', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(57, 'steam:11000010dc424d9', 'marcosfnjf', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(58, 'steam:1100001178ea858', 'ferhb.g2', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(59, 'steam:1100001085ff572', 'VOVO', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(60, 'steam:11000010e89a137', 'Lu', 1);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(61, 'steam:110000133d4876b', 'ŁѲƦĐ', 1);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(62, 'steam:1100001045461b8', 'Dinho', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(63, 'steam:11000013c62e106', '❟❛❟ Farlindu ❟❛❟', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(64, 'steam:110000114c155cc', '✪ ZT', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(65, 'steam:1100001055da0a1', 'SweeT', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(66, 'steam:1100001160aed12', 'dartab 麻', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(67, 'steam:110000107156247', 'miojo', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(68, 'steam:110000106dbc281', 'Kangee', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(69, 'steam:11000013cd34f6a', 'FMS |アンドレアルメイダ', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(70, 'steam:110000105f862f7', 'Paloma Soares', 1);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(71, 'steam:1100001062dd384', 'nery', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(72, 'steam:11000011195af13', 'McLovin', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(73, 'steam:11000011204cc57', 'Carlitinhos', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(74, 'steam:110000111b14f4c', 'CoyotePlaysom', 1);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(75, 'steam:110000137b46b49', 'Diego Rubens', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(76, 'steam:110000133422c48', 'tremere_kjb', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(77, 'steam:110000114706515', 'El Nacho Libre', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(78, 'steam:11000010d34c06e', 'twitch.tv/QuinnyRP', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(79, 'steam:1100001406a9c5b', 'gamershouse.com.br', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(80, 'steam:11000011b6dcf70', 'Clonado', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(81, 'steam:110000105fcf676', 'Pirog', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(82, 'steam:11000010a9886d6', 'Lampião do RP', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(83, 'steam:110000107d19865', 'FroG', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(84, 'steam:110000119a068ba', 'juníσr', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(85, 'steam:11000013ebb6ad3', 'Men0r_', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(86, 'steam:1100001121b084e', 'F1xoh', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(87, 'steam:110000114734901', 'dasilvaaa', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(88, 'steam:110000113393044', '⭕⃤ G4', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(89, 'steam:1100001063df198', 'Nhish', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(90, 'steam:11000011604bf25', 'Zick', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(91, 'steam:110000106f9d71a', 'kNNNw', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(92, 'steam:110000135a6f8e4', 'Jo', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(93, 'steam:110000116fd4d07', 'Patifico', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(94, 'steam:11000010e96aca9', 'Pino', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(95, 'steam:110000102a2e760', 'JuNiOR', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(96, 'steam:110000111c6338d', 'Binoísca', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(97, 'steam:11000013aa356ed', 'Joice mara', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(98, 'steam:1100001128e0a15', 'Ｒｅｖｏｌｖｉ３８　ナしレ', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(101, 'steam:11000010c8dedc3', 'Rata Mansa', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(102, 'steam:110000118359d2d', 'Saint', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(103, 'steam:11000010a0bdcdc', 'twitch.tv/CRODTV', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(104, 'steam:11000010896140c', 'Bifão', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(105, 'steam:110000109340e43', 'igorregalla', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(106, 'steam:1100001033e7f2d', 'Marob', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(107, 'steam:1100001126a10fe', 'SELLmeCHICKENS', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(108, 'steam:1100001366fa2c4', 'Albert Austein', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(109, 'steam:110000105f0fc1e', 'XinZ', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(110, 'steam:110000119d7ea37', 'Nascimento', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(111, 'steam:11000010f3bdb19', '[THL] LapantinoPT', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(112, 'steam:11000010a1a4ee0', 'CUBApt', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(113, 'steam:11000013c40ac50', 'Vini_GOD', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(114, 'steam:11000010c523e98', 'caue', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(115, 'steam:110000108f20ad4', 'PapaPrimas', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(116, 'steam:110000109a40103', 'VexOnTwo', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(117, 'steam:11000010c26fe90', 'Padilha', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(118, 'steam:1100001120d91ad', 'Policial Disfarçado', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(119, 'steam:11000013b8c6f45', 'Caveirao Doido', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(120, 'steam:110000112b60af5', 'Souza Lima', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(121, 'steam:110000102ce5766', 'Nikako', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(122, 'steam:1100001369d2831', 'ESQUERDISTA POR AMOR', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(123, 'steam:110000117db3fc9', 'Pedro Henrique', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(124, 'steam:110000103dc4c5f', 'Gaiato', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(125, 'steam:110000108b1f611', 'zThunder', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(126, 'steam:11000010c71b7e4', 'Lynit', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(127, 'steam:110000109e0b775', 'pMALDITO', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(128, 'steam:110000115cef76c', 'xMaFioSox', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(129, 'steam:11000013bd62156', 'xthosad', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(130, 'steam:11000010bcac214', 'Gabrieell', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(131, 'steam:11000010963187a', 'Nitromash', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(132, 'steam:110000110f385c2', 'Psycho', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(133, 'steam:110000135fcae2c', 'Fla', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(134, 'steam:110000106d521c7', 'BOT Miltão', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(135, 'steam:110000134de800c', 'Fl4m3', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(136, 'steam:110000106480a94', 'DaemonBSD', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(137, 'steam:110000101cdf164', 'Jake Zarakki', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(138, 'steam:11000010a46fbad', 'Ark Zeus', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(139, 'steam:11000010b43cb86', 'Alex', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(140, 'steam:110000107615cdd', 'BlazeExpert', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(141, 'steam:11000011a7426e2', 'Charlie Brown', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(142, 'steam:110000113a6bd7f', 'Minato', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(143, 'steam:11000013c95154b', 'Kekel', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(144, 'steam:110000131e90ec7', 'Chuparosa', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(145, 'steam:1100001016199c4', 'Numenusty', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(146, 'steam:1100001124763f6', 'D3MONBLK', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(147, 'steam:1100001051164c5', 'Thales Gameplay', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(148, 'steam:1100001113d76e6', 'JohnMuniz', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(149, 'steam:110000119ba9b61', 'Peralta', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(150, 'steam:110000103bcfe75', 'Castela Mask', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(151, 'steam:11000010a43d3a7', '[GaijiN]^VassoritO^', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(152, 'steam:11000011b8849e2', 'Bom Pai BR', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(153, 'steam:110000106d02f67', 'Juquinha', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(154, 'steam:11000010be31993', 'gad2lherme', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(155, 'steam:11000011638dc7c', 'Teddy', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(156, 'steam:110000107871567', 'Twitch.tv/Kanaa4RR', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(157, 'steam:11000010a41d0e9', 'RX_Rysborg', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(158, 'steam:11000010117a124', 'Aprendiz', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(159, 'steam:110000114176859', 'Chavão_GOD', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(160, 'steam:11000013be503d6', 'Malooka', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(161, 'steam:110000117637750', 'Maya', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(162, 'steam:11000010ba787ab', 'chucky', 1);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(163, 'steam:11000010cc93911', 'GUAXININ.RJ', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(164, 'steam:110000109713766', 'Castelinho Branco', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(165, 'steam:110000108353598', 'morera', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(166, 'steam:110000105a713f4', 'Ninaratah', 1);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(167, 'steam:11000010536a552', 'Effecto', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(168, 'steam:11000010a6a94cb', 'Luni', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(169, 'steam:110000103a95d02', 't.tv/thotoharris', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(170, 'steam:1100001053cb788', 'marcobc', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(171, 'steam:11000010c21729b', 'ஜ۩P4NDAO TV۩ஜ CSGO.NET', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(172, 'steam:11000010ea78f44', 'Don', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(173, 'steam:1100001090b6bd2', 'Mara', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(174, 'steam:1100001377b02dc', 'Vieira', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(175, 'steam:110000139b5deed', 'Pererecuda', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(177, 'steam:11000013299f406', 'JADER FPS', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(178, 'steam:110000105c85b66', 'Dvsn', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(179, 'steam:1100001151b0c61', 'Twist Marchezy', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(180, 'steam:11000010e623d8b', 'Rosi', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(181, 'steam:11000013a264707', 'rapazz', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(182, 'steam:1100001198a4b25', 'Tjgamer', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(183, 'steam:11000011d3467a4', 'kalleo', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(184, 'steam:110000113467f15', 'MarcusTWD', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(185, 'steam:11000011100cff2', 'Fusca', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(186, 'steam:11000010755e6c0', 'Cidrini', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(187, 'steam:110000133e9e965', 'ReiDoGadoGame', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(188, 'steam:110000132c890b3', 'JamesSh', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(189, 'steam:1100001170a2257', 'Thiago^', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(190, 'steam:1100001070014c2', 'Grayzito', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(191, 'steam:110000105f812d1', 'KaLu', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(192, 'steam:11000010f9f45e0', 'Leo', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(193, 'steam:110000109578458', 'krzy', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(194, 'steam:110000113932cb0', 'Dud1', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(195, 'steam:11000010ce58236', 'Oficial_Fever', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(196, 'steam:11000010214df5b', 'Mhysah', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(197, 'steam:11000013eb664af', 'Django', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(198, 'steam:11000011589b9f9', 'BuoMorallez', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(199, 'steam:110000107dd32e5', 'uno', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(200, 'steam:11000010b80fe30', 'TheHunter', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(201, 'steam:1100001063b50fa', 'Lifer', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(202, 'steam:110000116f3f45d', 'McLOVIN', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(203, 'steam:11000013dcf4094', 'renatabrito1510', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(204, 'steam:110000104c9105b', 'Castro', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(205, 'steam:1100001337c728d', 'Ravenaldo', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(206, 'steam:11000010864b67e', 'Migass Musclado', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(207, 'steam:1100001110b6ef6', 'layla', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(208, 'steam:1100001079b5182', 'Havocky', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(209, 'steam:1100001034dc831', 'BiG', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(210, 'steam:1100001058d67f0', 'Hyan', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(211, 'steam:110000103969832', 'Devilfire', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(212, 'steam:110000102e95203', 'RZD', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(213, 'steam:1100001068738c1', 'Mad God', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(214, 'steam:11000011922a921', 'Twitch.com/ratoexplosivo13', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(215, 'steam:110000111cb17eb', 'victor.alves', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(216, 'steam:11000010bf59372', 'Notchens', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(217, 'steam:11000013cd9f1ac', 'manzas', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(218, 'steam:11000011793b211', 'socrets', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(219, 'steam:110000103d00c34', 'Mino', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(220, 'steam:11000010593d219', 'ALPHAIAT', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(221, 'steam:1100001020e0291', '142 | Scott Morrison', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(222, 'steam:110000136292986', 'Nub-Supremo', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(223, 'steam:110000118474f60', 'D0nuts', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(224, 'steam:110000116232d76', 'Rafao', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(225, 'steam:1100001363731b5', 'Machadin', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(226, 'steam:11000010377a996', 'BHdhix', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(227, 'steam:11000013fea6f63', 'RDR2 \'SAHD Games', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(228, 'steam:11000011c77eabf', 'Guerra', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(229, 'steam:1100001035e6c1e', 'Pirrao', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(230, 'steam:110000104d15388', 'H4V3N', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(231, 'steam:1100001147c8ee9', 'GooMly', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(232, 'steam:110000114652c27', 'NoName', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(233, 'steam:11000011aa5e54b', '✩M1ster✩', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(234, 'steam:1100001131d2ed3', 'Foxhound', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(235, 'steam:110000136568842', '<CF>Leandro23', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(236, 'steam:110000118071ed0', 'SΛBINO ”)', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(237, 'steam:11000010760ea7e', 'Rent', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(238, 'steam:11000010bdd0145', 'Softe', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(239, 'steam:11000011094c516', 'Hassfarben', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(240, 'steam:110000101b89514', 'gabepeixe', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(241, 'steam:1100001197bfbb8', 'ySenna__', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(242, 'steam:11000010d690f82', 'Escadas', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(243, 'steam:11000010692c842', 'Sasquatch', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(244, 'steam:11000011cdcba80', 'BrutalºFatal', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(245, 'steam:1100001182e8b67', 'Sush1.', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(246, 'steam:11000010916cab8', 'Dr. Syller', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(247, 'steam:11000010928bd50', 'BarretoCarlos', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(248, 'steam:11000014217983c', 'ucasproman', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(249, 'steam:110000110ea3734', 'Thomas', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(250, 'steam:1100001026c8a81', 'BarakaGG', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(251, 'steam:11000013e640e4d', 'lucasschulzer', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(252, 'steam:110000105f46d83', 'xDrouT', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(253, 'steam:1100001184d9315', 'FractaLiizeN', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(254, 'steam:1100001153f8a8a', 'GSouza', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(255, 'steam:11000010b9c3ff5', 'prreus', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(256, 'steam:110000106bad802', 'z-manguita ★', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(257, 'steam:11000010307a2b8', 'Snider', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(258, 'steam:110000132fd8e3d', 'dtr', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(267, 'steam:110000102e5c618', 'awdswdadd', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(274, 'steam:11000010f5729cb', 'ReDy GameSS', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(279, 'steam:1100001043d2cbe', 'Jok3rzz', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(280, 'steam:11000013478a5ab', 'CAPITAN - TORTUM', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(281, 'steam:11000011d4d641b', 'pypergm', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(282, 'steam:110000133012bdf', 'Patrick Lima', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(283, 'steam:11000010c295ae8', 'Bibi', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(284, 'steam:1100001075415e3', 'fb.gg/vilelon', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(285, 'steam:110000118d3ec60', 'gabriel_killdawn', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(286, 'steam:1100001118294be', 'mikelele', 1);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(289, 'steam:11000010a383527', 'NovaK', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(290, 'steam:110000116fb396d', 'Rodrigosoaresz', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(291, 'steam:110000107b27be0', 'madruga', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(292, 'steam:110000107275cee', 'Bunny Style', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(293, 'steam:110000105f6f769', 'Lcsmarsom', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(294, 'steam:11000010c327872', 'NesZao', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(295, 'steam:110000107dfe627', 'nobody', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(296, 'steam:11000010537d260', 'Ks', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(297, 'steam:11000010084739e', 'deadp00l05pt', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(298, 'steam:11000013290b9a9', 'brwp', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(299, 'steam:11000010a2494b3', 'Shaca', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(300, 'steam:11000010a016ec6', 'pat', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(301, 'steam:110000114a33514', 'Condello', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(302, 'steam:11000010bcf1ae2', 'EduardoBigZ', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(303, 'steam:110000102190921', '!ChoCkyTV', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(304, 'steam:1100001062f6ead', 'Sapphire', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(305, 'steam:1100001014c2ccf', 'Biggie', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(306, 'steam:110000116ddc901', 'jn180597', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(307, 'steam:110000114c116f3', 'Is Sana', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(308, 'steam:11000010878f1b7', 'Snow', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(309, 'steam:110000106db9cac', 'Velloso', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(310, 'steam:1100001095998ba', '▸ᴀᴍᴇɴ ʜᴏᴛᴛᴇᴘ', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(311, 'steam:1100001345ad63b', 'rodrigoorocha', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(312, 'steam:110000112643e37', 'Asqui7', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(313, 'steam:1100001342bf011', 'iTz ViKiinG Xz', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(314, 'steam:110000108287464', 'muriloericooliveira', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(315, 'steam:1100001060abe7e', 'godyZ', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(316, 'steam:11000011a4e3858', 'LilowCroft', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(317, 'steam:11000010d86c702', '</ kikofranchin >', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(318, 'steam:11000011d6462fb', 'SaudadeDela', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(319, 'steam:11000013256c5c9', 'Lucão', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(320, 'steam:11000010a988bfb', 'Benny, The Bull', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(321, 'steam:1100001095164bb', 'Felps', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(322, 'steam:11000013cf482c9', 'vagner14k', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(323, 'steam:110000103feb8f9', 'Alkapaha', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(324, 'steam:11000010dccfedb', 'pontesvinicius18', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(325, 'steam:110000114ea2d7b', 'BMF', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(326, 'steam:11000011a1935da', 'twitch.tv/pedepato', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(327, 'steam:110000106677b22', 'Avalon', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(328, 'steam:110000111c8a9dd', 'Rah', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(329, 'steam:1100001321f881e', 'DiGreia', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(330, 'steam:11000010f8dac6c', 'Dahlem', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(331, 'steam:110000106feb025', 'Gnomo', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(332, 'steam:110000111d57f88', 'Fields', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(333, 'steam:110000107787a62', 'BicalhoRJ', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(334, 'steam:1100001065d1758', '❄️ Arthas', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(335, 'steam:11000011705e056', '† Suspiria †', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(336, 'steam:11000011204f886', '123', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(337, 'steam:11000011d02d80f', 'easterx', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(338, 'steam:11000010c5db1ab', 'Nala', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(339, 'steam:11000010b3a531c', 'twitch.tv/CapNascimentoTv', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(340, 'steam:1100001065d0ca7', 'Kuran', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(341, 'steam:11000010192ace7', 'BIFF', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(342, 'steam:1100001064fe3a0', 'Wilfer', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(343, 'steam:11000010977d8cd', 'Blankinha Gameplay', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(344, 'steam:11000013c99ff4d', 'BusttDown', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(345, 'steam:110000118021750', 'Ramalho', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(346, 'steam:110000116470cdb', 'danplayss', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(347, 'steam:1100001152c6fa9', 'JaperaBrabo', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(348, 'steam:110000115640009', 'Tosh', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(349, 'steam:110000117b33444', 'LH GAMER', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(350, 'steam:11000010326195e', 'JJ', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(351, 'steam:11000011175da16', 'Carmo', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(352, 'steam:11000013460f727', 'Tio D4NNY', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(353, 'steam:1100001062f06fd', 'Twitch/NoobeiEGraveiPlus', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(354, 'steam:11000010dc3cbbf', 'Cotoco_God', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(355, 'steam:110000102670a37', 'FaraGameplays', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(356, 'steam:110000105f4f979', 'AsaK', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(357, 'steam:11000010f1b60db', 'fz', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(358, 'steam:11000010b70ef2e', 'Scarlet Smith', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(359, 'steam:11000010a123425', 'PHELLIP', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(360, 'steam:11000013a521153', 'Razieldark', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(361, 'steam:110000109f6e7c3', 'Eduardost3', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(362, 'steam:11000011bd112a7', 'BurBunoT', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(363, 'steam:11000011a248d2c', 'biGOD', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(364, 'steam:110000118c48c81', 'Maunizim', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(365, 'steam:11000011af224f0', 'Tropa', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(366, 'steam:11000013be1fac8', 'Mario', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(367, 'steam:11000010d36eae7', 'Doooug', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(368, 'steam:1100001425a30b8', 'antonioivanprado', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(369, 'steam:1100001183d1f72', 'Ally', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(370, 'steam:1100001058e74f9', 'Gaguinho', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(371, 'steam:11000010b0dc456', 'Kayke', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(372, 'steam:1100001096c8877', 'GaaZ', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(373, 'steam:110000106b4258f', 'dNN__', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(374, 'steam:11000013301bd08', 'Rebeca', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(375, 'steam:1100001356ce9dc', 'Matpson', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(376, 'steam:11000010f7857eb', 'MadGirl', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(377, 'steam:110000108cb0d08', 'Kakashi Sniper', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(378, 'steam:11000013b3cbafd', 'Indaiass', 1);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(379, 'steam:11000011aa612ba', 'Ann', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(380, 'steam:110000103fb577b', 'Lore', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(381, 'steam:110000131ea8f10', 'Demetria Sixx', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(382, 'steam:110000106f0df29', 'Thamy', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(383, 'steam:11000010988b215', 'Kendra', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(384, 'steam:110000116b7ef1f', 'KUMApt', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(385, 'steam:1100001020a0ace', 'Alinespp', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(386, 'steam:110000106da66f1', 'headshana', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(387, 'steam:1100001148cad8b', 'LDavid', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(388, 'steam:110000108d03cfb', 'VANESSAO', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(389, 'steam:110000111d84b4d', 'twitchtv/leofreitas', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(390, 'steam:1100001157cbdd3', 'Nicky Mitrava', 1);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(391, 'steam:110000111eb5ccb', 'Lolita', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(392, 'steam:11000010a614688', 'Ranoroxa', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(393, 'steam:11000010ce310fa', 'FeZu', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(394, 'steam:1100001323b85d6', 'Sabrynna Victoria', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(395, 'steam:110000132cf38d1', 'Bellatrix Royali', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(396, 'steam:11000011deb1114', 'davefranca', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(397, 'steam:1100001190d765c', 'Lcorder22', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(398, 'steam:11000013640008a', 'Rustic', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(399, 'steam:1100001094ab7c3', 'PeterSkywalker', 0);
INSERT IGNORE INTO `users` (`user_id`, `identifier`, `name`, `banned`) VALUES
	(400, 'steam:11000010a218129', 'HaneyBe', 0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Copiando estrutura para tabela redm.whitelist
CREATE TABLE IF NOT EXISTS `whitelist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(21) NOT NULL,
  `nome` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=474 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela redm.whitelist: ~383 rows (aproximadamente)
/*!40000 ALTER TABLE `whitelist` DISABLE KEYS */;
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(0, 'system', 'system');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(2, 'steam:1100001349014c1', NULL);
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(3, 'steam:110000106321dbf', NULL);
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(4, 'steam:110000109766c18', NULL);
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(5, 'steam:110000115598f8c', NULL);
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(66, 'steam:11000010596ee06', 'Klan');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(67, 'steam:1100001067bddc2', 'Franco');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(69, 'steam:110000106ff1cbd', 'Supla');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(70, 'steam:110000134b230b1', 'Velma');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(71, 'steam:1100001178ea858', 'Tayfe');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(72, 'steam:110000107caf442', 'Diego');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(74, 'steam:1100001031f4669', 'Zeeenon!');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(75, 'steam:11000011559ed3f', 'Tonico');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(76, 'steam:11000010dc424d9', 'Mark');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(77, 'steam:1100001085ff572', 'Cabra');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(78, 'steam:11000010e89a137', 'Lucroft');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(79, 'steam:110000133d4876b', 'gabriel');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(80, 'steam:11000010e96aca9', 'Pino');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(81, 'steam:110000133d4876b', 'Gabriel Caraspo');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(82, 'steam:11000010a9886d6', 'Will de Bill');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(83, 'steam:1100001045461b8', 'Dinho');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(84, 'steam:110000108038411', 'Liam');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(85, 'steam:1100001063df198', 'Miguel Alejandro');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(86, 'steam:110000136568842', 'J. Wayne');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(87, 'steam:110000111b14f4c', 'Billy Kimber');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(88, 'steam:110000139b5deed', 'Capitolina');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(89, 'steam:11000013c62e106', 'Vartan');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(90, 'steam:1100001055da0a1', 'Amber');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(91, 'steam:110000114c155cc', 'Elé');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(92, 'steam:110000107d19865', 'J. Graham');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(93, 'steam:110000135a6f8e4', 'Araceia Theira');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(94, 'steam:110000106f9d71a', 'Harry Crawford');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(95, 'steam:11000011204cc57', 'Carlos Alejandro');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(96, 'steam:11000013cd34f6a', 'Jack Middleton');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(97, 'steam:1100001160aed12', 'Tom Deperto');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(98, 'steam:1100001067bddc2', 'John Miller');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(99, 'steam:110000107156247', 'Emeritus');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(100, 'steam:1100001070014c2', 'Richard');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(101, 'steam:110000107871567', 'Kannaa');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(102, 'steam:11000010d34c06e', 'Tatanka');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(103, 'steam:110000106dbc281', 'Charles Winter');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(104, 'steam:110000105f862f7', 'Paloma Soares');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(105, 'steam:11000010385de32', 'Pírog');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(106, 'steam:110000137b46b49', 'Revolts');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(107, 'steam:11000011195af13', 'Henrique Bennet');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(108, 'steam:1100001062dd384', 'Gerremmy');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(109, 'steam:110000110f385c2', 'Butch');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(110, 'steam:1100001121b084e', 'Jackson Davis');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(111, 'steam:110000133422c48', 'Jack Foster');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(112, 'steam:110000114706515', 'Johnathan Smith');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(113, 'steam:1100001406a9c5b', 'Charlie Shelby');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(114, 'steam:11000011b6dcf70', 'Jhon Carson');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(115, 'steam:1100001406a9c5b', '...');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(116, 'steam:110000105fcf676', 'Pirog');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(117, 'steam:1100001128e0a15', 'Pablito Cornnito');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(118, 'steam:110000111c6338d', 'Cap. Nascimento');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(119, 'steam:110000135fcae2c', 'Carlin');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(120, 'steam:110000119a068ba', 'Jacob Walker');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(121, 'steam:11000013ebb6ad3', 'Michael Kimber');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(122, 'steam:110000113393044', 'Tarik Shelby');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(123, 'steam:110000114734901', 'André Almeida');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(124, 'steam:110000107d19865', '...w');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(125, 'steam:11000011604bf25', 'Zick');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(127, 'steam:110000135a6f8e4', 'Araceia Theira');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(128, 'steam:11000011638dc7c', 'Heron Miles');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(129, 'steam:110000116fd4d07', 'Jack McBill');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(130, 'steam:11000010ab5147a', 'Jessie James');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(131, 'steam:110000115bc67cb', 'Luke Bennet');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(132, 'steam:1100001068ca3ef', 'Alphonse');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(133, 'steam:110000108353598', 'Colton Riggs');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(134, 'steam:1100001198a4b25', 'Django Miles');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(135, 'steam:11000010c26fe90', 'Sebastian Bury');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(136, 'steam:110000109a40103', 'Victor Galloway');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(137, 'steam:110000118359d2d', 'Luke Hunter');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(138, 'steam:1100001060aa3a2', 'Minowa');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(139, 'steam:110000102a2e760', 'Torbjorn');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(140, 'steam:1100001016199c4', 'Dante Brewer');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(141, 'steam:110000119d7ea37', 'Tommy Shelby');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(142, 'steam:110000104c9105b', 'Cleef');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(143, 'steam:110000106b2b5cd', 'John Eberhart');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(144, 'steam:1100001051164c5', 'James West');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(145, 'steam:110000112643e37', 'Cleyto');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(146, 'steam:110000137b46b49', 'Henry Brow');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(147, 'steam:11000010a43d3a7', 'Fred');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(148, 'steam:11000013aa356ed', 'Barbara Kimber');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(149, 'steam:11000010d51e5bf', 'Jack Pearce');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(150, 'steam:110000115cef76c', 'Bill');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(151, 'steam:1100001120d91ad', 'Shallow');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(152, 'steam:110000108b1f611', 'Johnny Pokaballa');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(153, 'steam:110000106d521c7', 'Milton Magnum');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(154, 'steam:110000107615cdd', 'Alex');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(155, 'steam:110000104952e1a', 'Laura Silver');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(156, 'steam:110000103a95d02', 'Ingo');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(157, 'steam:110000101cdf164', 'Jake Zaraki');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(158, 'steam:11000010117a124', 'Alexandre Bill');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(159, 'steam:11000010c21729b', 'Jonah Hex');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(160, 'steam:11000010bcac214', 'Clay');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(161, 'steam:1100001113d76e6', 'Jhon ');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(162, 'steam:11000013c40ac50', 'Vinicius Rego');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(164, 'steam:110000106d02f67', 'Juba');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(165, 'steam:110000108a90146', 'Willard');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(166, 'steam:1100001153f8a8a', 'James Bill');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(167, 'steam:11000010963187a', 'David Marston');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(168, 'steam:11000011a7426e2', 'Tom Coy');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(169, 'steam:11000010c8dedc3', 'Reginah ');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(170, 'steam:11000010a016ec6', 'Patricia');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(171, 'steam:110000114176859', 'Licarco ');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(172, 'steam:110000112b60af5', 'Billy Jhow');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(173, 'steam:110000119a068ba', 'Jacob Walker');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(174, 'steam:11000013ea4baca', 'Kelvin');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(175, 'steam:110000103dc4c5f', 'Thomy Kludge');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(176, 'steam:110000108284819', 'Charles Belson');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(177, 'steam:110000110f385c2', 'Butch Maverick');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(178, 'steam:110000109713766', ' Leroy J. Gibbs');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(179, 'steam:110000117db3fc9', 'Henrique Morgan');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(180, 'steam:110000113fd02f2', ' Jimmy Winchester ');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(181, 'steam:11000010a0bdcdc', 'Jon Jones');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(182, 'steam:11000010a1a4ee0', 'Cash');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(183, 'steam:110000109340e43', 'Igor Regalla');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(184, 'steam:1100001067a40c1', 'Pablo');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(185, 'steam:11000010ea78f44', 'Don');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(186, 'steam:11000010f7857eb', 'Sara');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(187, 'steam:11000013dcf4094', 'Yanka');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(188, 'steam:110000105c85b66', 'Caladett');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(189, 'steam:110000108f20ad4', 'Chico');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(190, 'steam:11000013be503d6', 'Will Lopes');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(191, 'steam:1100001366fa2c4', 'Willian');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(192, 'steam:11000010a46fbad', 'Corleone');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(193, 'steam:11000010896140c', 'Miranda');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(194, 'steam:110000109bc0414', '.');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(195, 'steam:110000134de800c', 'Giuseppe');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(196, 'steam:110000106480a94', 'Jesse Daemon James');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(197, 'steam:110000119ba9b61', 'Peralta');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(198, 'steam:11000010a41d0e9', 'Winchester');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(199, 'steam:11000010c99c072', 'Emily');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(200, 'steam:110000114706515', 'Alto Trovão');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(201, 'steam:1100001369d2831', 'Alisa');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(202, 'steam:11000010f33464c', 'Jesse Allison');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(203, 'steam:11000013ebb6ad3', 'Michael Kimber');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(204, 'steam:110000118071ed0', 'Mark Maverick');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(205, 'steam:11000011aa5e54b', 'Manel António ');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(206, 'steam:11000013b8c6f45', ' John Dorn Dubar');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(207, 'steam:1100001133ce9d4', 'Demerson');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(208, 'steam:11000010a6a94cb', 'Kate');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(209, 'steam:11000010f3bdb19', 'Leopoldo Sousa');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(210, 'steam:1100001126a10fe', 'WW');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(211, 'steam:110000136568842', 'John Wayne');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(212, 'steam:1100001033e7f2d', 'Leyo');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(213, 'steam:110000114fba70d', 'Noah Snow');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(214, 'steam:1100001121b084e', 'Davis');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(215, 'steam:11000010c71b7e4', 'Butch Taylor');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(216, 'steam:110000105F0FC1E', 'Pedro Davis');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(217, 'steam:11000010b03fc75', 'Johnn Reid');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(218, 'steam:1100001020e0291', 'Austin Cliff');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(219, 'steam:1100001066b492c', 'Mourrice');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(220, 'steam:11000011d3467a4', 'Adam');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(221, 'steam:11000011d3467a4', 'Adam Miles');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(222, 'steam:11000013c95154b', 'Kekel');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(223, 'steam:110000102CE5766', 'George');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(224, 'steam:1100001124763f6', 'Fernando Diaz');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(225, 'steam:11000010c523e98', 'Ceasar');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(226, 'steam:11000013bd62156', 'Lurdes');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(227, 'steam:110000113a6bd7f', 'Corleone');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(228, 'steam:110000109e0b775', 'awe');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(229, 'steam:11000010963187a', 'wer');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(230, 'steam:11000010b43cb86', 'alucard');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(231, 'steam:110000131e90ec7', 'Alex');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(232, 'steam:110000139b5deed', 'Cap');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(233, 'steam:110000103bcfe75', 'Castela');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(234, 'steam:11000010ba787ab', 'Skies');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(235, 'steam:11000013716c979', 'Jesse Woodson James');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(236, 'steam:11000011b8849e2', 'Rolo Dorn Dubar');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(237, 'steam:11000010be31993', 'gado');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(238, 'steam:11000010a9886d6', 'Lampiao');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(239, 'steam:110000117637750', 'my');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(240, 'steam:11000010322f528', 'ATT');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(241, 'steam:11000010cc93911', 'GuaxininRJ');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(242, 'steam:110000108353598', 'Colton Riggs');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(243, 'John Wayne', 'steam:11000010536a552');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(244, 'steam:110000105a713f4', 'Nina');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(245, 'steam:11000010536a552', 'rera');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(246, 'steam:1100001053cb788', 'marcobc');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(247, 'steam:11000013424b4a3', 'Geremias');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(248, '11000011c77eabf', 'Guerra');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(249, '110000114c9e01f', 'Fer');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(250, '11000010183e0d8', 'Bob');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(251, 'steam:1100001377b02dc', 'Vieira Gameplay');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(252, 'steam:11000011589b9f9', 'Kalemba Djambe');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(253, 'steam:1100001090b6bd2', 'a menina que choras abatida por ser lesbica');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(254, 'steam:110000101736cc1', 'Andarilho');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(255, 'steam:1100001151b0c61', 'Belle Starr');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(256, 'steam:11000010214df5b', 'Sónia Erikson');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(258, 'steam:11000013299f406', 'Jader');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(259, 'steam:11000013a264707', 'Amadeu');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(260, 'steam:11000013a264707', 'Amadeu');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(261, 'steam:1100001063b50fa', 'Nickolas');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(262, 'steam:11000010e623d8b', 'Rosi Marry');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(263, 'steam:11000010755e6c0', 'Benjamim');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(264, 'steam:11000010f9f45e0', 'Elideus');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(265, 'steam:110000133e9e965', 'reidogadi');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(266, 'steam:110000105f812d1', 'rta');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(267, 'steam:110000113932cb0', 'Lizander');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(268, 'steam:110000113467f15', 'Marcus');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(269, 'steam:11000010b80fe30', 'Lucius');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(270, 'steam:11000011100cff2', 'James');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(271, 'steam:110000132c890b3', 'Wayne');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(272, 'steam:110000107dd32e5', 'Jailson Maul');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(273, 'steam:1100001170a2257', 'Toni Bala');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(274, 'steam:110000109fbfa9f', 'fatalb');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(275, 'steam:110000109578458', 'Forrest Cassidy');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(276, 'steam:11000010ce58236', 'Oficial_Fever');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(277, 'steam:11000013eb664af', 'Django Kimber');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(278, 'steam:1100001034dc831', 'B!G');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(279, 'steam:1100001079b5182', 'Jax Teller');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(280, 'steam:1100001058d67f0', 'Hyan');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(281, 'steam:110000116f3f45d', 'souza');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(282, 'steam:1100001337c728d', 'Ravenaldo');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(283, 'steam:11000010377a996', 'Agostinho Tavares');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(284, 'steam:110000103969832', 'Eduardo Murilo');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(285, 'steam:11000010864b67e', 'John Greenwood');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(286, 'steam:110000136292986', 'Marks Bil');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(287, 'steam:1100001110b6ef6', 'Mohamed');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(288, 'steam:11000013375db22', 'Layla');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(289, 'steam:110000112edc525', 'Joseph Hill');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(290, 'steam:1100001068738c1', 'Horácio Pires Peres');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(291, 'steam:110000102e95203', 'RZD');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(292, 'steam:1100001035e6c1e', 'Augusto Meirelles');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(293, 'steam:11000011793b211', 'Bennys');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(294, 'steam:11000011922a921', 'Ruizinho');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(295, 'steam:110000111cb17eb', 'Jonas Jameson');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(296, 'steam:11000013cd9f1ac', 'Filipe Vaz Pinto');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(297, 'steam:11000010bf59372', 'Clepe ShinZon');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(298, 'steam:1100001173e72e0', 'Joey Williams');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(299, 'steam:1100001083eedfe', 'pescoco');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(300, 'steam:110000103d00c34', 'Mino');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(301, 'steam:11000010593d219', 'Bud Alphaiat');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(302, 'steam:1100001131D2ED3', 'Foxhound Mcway');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(303, 'steam:110000118474f60', 'Scott ');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(304, 'steam:110000116232d76', 'Rafão');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(305, 'steam:1100001363731b5', 'Machado98');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(306, 'steam:1100001147c8ee9', 'Marco');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(307, 'steam:11000013fea6f63', 'Guadalupe');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(308, 'steam:11000011c77eabf', 'guerra');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(309, 'steam:110000104d15388', 'Richard Lincon');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(310, 'steam:110000114652c27', 'Rafael Rango');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(311, 'steam:1100001182e8b67', 'Kirk');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(312, 'steam:1100001023e6195', 'Scarlett Stanwyck');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(313, 'steam:11000010d690f82', 'Theodore Willow');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(314, 'steam:11000010760ea7e', 'hanck donato');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(315, 'steam:11000010bdd0145', 'softe');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(316, 'steam:11000011094c516', 'Howard Hassfarben');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(317, 'steam:110000101b89514', 'gabepeixe');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(318, 'steam:11000011094c516', 'Howard Hassfarben');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(319, 'steam:11000011cdcba80', 'Ze das Noites');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(320, 'steam:11000010692c842', 'Harvey Mccoy');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(321, 'steam:1100001197bfbb8', ' James Senna');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(322, 'steam:110000104d15388', 'Richard Lincoln');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(323, 'steam:11000010d690f82', 'Theodore Willow');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(324, 'steam:11000011094c516', 'Howard Hassfarben');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(325, 'steam:11000011cdcba80', 'Ze das Noites');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(326, 'steam:11000010692c842', 'Harvey Mccoy');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(327, 'steam:1100001197bfbb8', 'James Senna');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(328, 'steam:11000010928bd50', 'Scott Marshall');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(329, 'steam:11000010916cab8', 'Syller Bennett');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(330, 'steam:11000014217983c', 'Lucas rhoman');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(331, 'steam:110000110ea3734', ' Thomas ');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(332, 'steam:110000110ea3734', 'Thomas Mcfield');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(333, 'steam:100001026c8a81', 'Cleiton BlackGold');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(334, 'steam:1100001026c8a81', 'Baraka');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(335, 'steam:11000013e640e4d', 'Buffalo Bill');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(336, 'steam:110000105f46d83', 'Matulele BlackGold');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(337, 'steam:1100001184d9315', 'Pedro Vieira');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(338, 'steam:11000010b9c3ff5', 'Caipira Rock');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(339, 'steam:11000010307a2b8', 'DennisSnider');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(340, 'steam:110000106bad802', 'Rafaela Vieira');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(341, 'steam:110000132fd8e3d', 'John Holliday');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(342, 'steam:110000102e5c618', 'noia');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(343, 'steam:11000010f5729cb', 'Algum stremar');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(344, 'steam:1100001043d2cbe', 'Joker');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(345, 'steam:110000118d3ec60', 'Billy Brown');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(346, 'steam:11000010537d260', 'Krivoz Sernef');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(347, 'steam:110000114c116f3', 'Sora Onawa');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(348, 'steam:11000013478a5ab', 'Fernando Pessoa');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(349, 'steam:11000010c295ae8', 'Beatrice Silver');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(350, 'steam:1100001062f6ead', 'Desiree');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(351, 'steam:11000010878f1b7', 'Javier Macfield');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(352, 'steam:11000011d4d641b', 'Kenai silver');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(353, 'steam:110000114a33514', 'Reuben Montoya');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(354, 'steam:11000013472f262', 'Carla Machado');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(355, 'steam:110000133012bdf', 'Ze Pilintra');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(356, 'steam:110000116ddc901', 'Billy The Kid');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(357, 'steam:110000105f6f769', 'Eustácio Vankover');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(358, 'steam:11000010c327872', 'NesZao Kastro');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(359, 'steam:11000013a521153', 'Raziell Dark');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(360, 'steam:110000107275cee', 'Clarice Rousseau ');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(361, 'steam:110000107dfe627', 'Walker MacGregor');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(362, 'steam:11000010b0dc456', 'Josimar Braz');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(363, 'steam:11000010bcf1ae2', 'Akin');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(364, 'steam:11000011bd112a7', 'Edgar Water');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(365, 'steam:110000110c1847c', 'Pedro Pereira');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(366, 'steam:11000013290b9a9', 'Cauã Iberê');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(367, 'steam:110000116fb396d', 'Jhon radin');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(368, 'steam:110000107b27be0', 'Madruga Nascimento');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(369, 'steam:1100001075415e3', 'Pablo Chan');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(370, 'steam:1100001118294be', 'Jacinto Tonto');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(371, 'steam:11000010a383527', 'Marquis');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(372, 'steam:11000010084739e', 'dead');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(373, 'steam:11000010a2494b3', 'chaco');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(375, 'steam:110000102190921', 'chocky');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(376, 'steam:1100001014c2ccf', NULL);
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(377, 'steam:110000106db9cac', 'Fabio Velloso');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(378, 'steam:1100001054418a9', 'Jesse "Big Mouse" Dalton');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(379, 'steam:1100001345ad63b', 'Tiringa Del Fuego');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(380, 'steam:1100001095998ba', 'Jhon McGarry');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(381, 'steam:11000013460f727', 'Daniel Pearson');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(382, 'steam:110000108287464', 'Bill Oliveira');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(383, 'steam:1100001342bf011', 'John Oliveira');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(384, 'steam:11000010d86c702', 'kiko');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(385, 'steam:1100001060abe7e', 'Buffalo Bill');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(386, 'steam:11000011a4e3858', 'Anastácia Berrycloth');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(387, 'steam:110000111c8a9dd', 'Sol');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(388, 'steam:11000010c5db1ab', 'Nala Carter');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(389, 'steam:1100001321f881e', 'Wafer Vitarela');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(390, 'steam:110000107787a62', 'Billy Costa');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(391, 'steam:11000011d6462fb', 'Annie LeLouise ');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(392, 'steam:11000011705e056', 'Lilith Vanhord Vaquejada');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(393, 'steam:110000116470cdb', 'Dom Leôncio');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(394, 'steam:1100001136e5de6', 'Marshall Torne');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(395, 'steam:11000010a988bfb', 'Yoki "Pássaro azul"');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(396, 'steam:110000111d57f88', 'Frank Gray');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(397, 'steam:11000010dccfedb', 'Vini Pampa');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(398, 'steam:11000010977d8cd', 'Blanka D\'Lavier');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(399, 'steam:11000010f8dac6c', ' James Maverick ');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(400, 'steam:11000013256c5c9', 'Tony Oliveira');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(401, 'steam:1100001065d0ca7', 'Wyatt Maverick');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(402, 'steam:110000106feb025', 'Berham Brandbarlett');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(403, 'steam:110000114ea2d7b', 'Billy Creed');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(404, 'steam:11000013cf482c9', 'Owen Shaw');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(405, 'steam:110000106677b22', ' Jhony Walker');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(406, 'steam:11000011204f886', 'Daren Shappa');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(407, 'steam:1100001095164bb', 'Zeca Pimenta');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(408, 'steam:1100001065d1758', 'Paul Carson');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(409, 'steam:110000103feb8f9', 'Peter Rabbit');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(410, 'steam:11000011d02d80f', 'Jake Carter');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(411, 'steam:11000010b3a531c', ' Jose Nascimento');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(412, 'steam:11000011a1935da', 'ped epato');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(413, 'steam:110000118021750', 'Belle Dalton');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(414, 'steam:11000010192ace7', 'Kange Pena vermelha');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(415, 'steam:1100001064fe3a0', 'Joaquin Murrieta');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(416, 'steam:110000115640009', 'Peter Tosh');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(417, 'steam:1100001152c6fa9', 'El Japa');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(418, 'steam:11000013c99ff4d', 'Aurora Santi');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(419, 'steam:110000117b33444', ' William Henry');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(420, 'steam:1100001062f06fd', 'MandioK');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(421, 'steam:11000010326195e', 'Joyce Vandergeld');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(422, 'steam:11000011175da16', 'João Caminhador');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(423, 'steam:11000010dc3cbbf', 'Caramuru Kaluanã');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(424, 'steam:110000105f4f979', 'Terrence McGinnis');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(425, 'steam:110000118c48c81', 'Mauricio Bielski');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(426, 'steam:110000102670a37', 'Nerson Mcfly');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(427, 'steam:11000011a248d2c', 'Tom Oliveira');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(428, 'steam:110000109f6e7c3', 'Eduardo Trevisan');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(429, 'steam:11000010f1b60db', 'Junior Leblanc');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(430, 'steam:11000010a123425', 'Phellip Sanches');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(431, 'steam:110000106da66f1', 'Jesse White');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(432, 'steam:11000010b70ef2e', 'Jane Calamidade');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(433, 'steam:1100001362355f9', 'James Maravilha');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(434, 'steam:11000011AF224F0', 'Jeremiah Brown');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(435, 'steam:11000013be1fac8', 'Charles Vaqueiro');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(437, 'steam:1100001425a30b8', 'AlexMagno');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(438, 'steam:11000010d36eae7', NULL);
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(439, 'steam:1100001183d1f72', NULL);
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(440, 'steam:110000105632ad5', NULL);
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(442, 'steam:1100001058e74f9', 'Gaguinho');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(443, 'steam:110000106b4258f', NULL);
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(444, 'steam:1100001096c8877', NULL);
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(445, 'steam:110000108cb0d08', NULL);
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(446, 'steam:1100001356ce9dc', NULL);
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(447, 'steam:11000013301bd08', 'Flor de Maria');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(448, 'steam:11000013b3cbafd', 'Indais');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(449, 'steam:11000011aa612ba', NULL);
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(450, 'steam:110000103fb577b', 'Magnolia Cheeks ');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(451, 'steam:1100001148cad8b', NULL);
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(452, 'steam:110000131ea8f10', NULL);
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(453, 'steam:110000106f0df29', NULL);
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(454, 'steam:11000010988b215', NULL);
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(455, 'steam:110000111d84b4d', NULL);
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(456, 'steam:110000116b7ef1f', NULL);
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(457, 'steam:110000108d03cfb', NULL);
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(458, 'steam:110000108d03cfb', 'Greta Gorski');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(459, 'steam:1100001020a0ace', 'Daniella Wyatt');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(460, 'steam:1100001157cbdd3', 'NIkcy');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(461, 'steam:11000010ce310fa', 'fezu');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(462, 'steam:110000111eb5ccb', NULL);
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(463, 'steam:11000010a614688', 'Hannah Montanha');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(464, 'steam:110000132cf38d1', 'Cece Drake');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(465, 'steam:1100001323b85d6', 'Sabrynna Bee Victoria');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(466, 'steam:11000011deb1114', 'Judith Bixotte');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(467, 'steam:1100001048bba96', 'Jaci Rizzi');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(468, 'steam:1100001190d765c', 'Julia Belmont');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(469, 'steam:11000013640008a', 'Clay Wolf');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(470, 'steam:11000010b63d5f1', 'Bellamy Blake');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(471, 'steam:110000101e726c4', 'Arkan');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(472, 'steam:1100001094ab7c3', 'Peter Sanchez');
INSERT IGNORE INTO `whitelist` (`id`, `identifier`, `nome`) VALUES
	(473, 'steam:11000010a218129', 'Joanne Jonsson');
/*!40000 ALTER TABLE `whitelist` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
