Config = {}

Config.ShopDatas = {
	-- level, dollar, gold
	{
		name = "Armeiro",
		{
			{"revolver_lemat", 0, 317, 13},
			{"revolver_cattleman", 0, 50, 2},
			{"revolver_navy", 0, 257, 11},
			{"pistol_volcanic", 0, 300, 14},
			{"shotgun_sawedoff", 0, 65, 15},
			{"repeater_carbine", 0, 90, 4},
			{"repeater_henry", 0, 234, 10},
			{"sniperrifle_rollingblock", 0, 500, 20},
			{"rifle_varmint", 0, 72, 3},
		}
	},
	{
		name = "Policia",
		{
			{"revolver_doubleaction", 0, 0, 0},
			{"rifle_springfield", 0, 0, 0},
			{"shotgun_pump", 0, 0, 0},
			{"ammo_revolver", 0, 0, 0},
			{"ammo_rifle", 0, 0, 0},
			{"ammo_shotgun", 0, 0, 0}
		}
	},
	{
		name = "Geral",
		{
			{"tobacco_seed", 0, 1, 1},
			{"corn_seed", 0, 1, 1},
			{"sugarcane_seed", 0, 1, 1}
		}
	}
}

Config.ShopLocations = {
	-- x, y, z, heading(optional)
	["Armeiro"] = {
		{-281.99, 780.92, 119.52}, -- VALENTINE
		-- {1322.87, -1321.48, 76.89},
		{2715.91, -1285.65, 48.63},
		{2946.53, 1319.66, 44.82},
		{-5508.16, -2964.47, -0.63}
	},
	["Policia"] = {
		{-764.768, -1272.072, 44.041},
		{-1813.974, -354.651, 164.649},
		{-278.365, 805.207, 119.380},
		{2494.206, -1304.434, 48.954},
		{2494.392, -1312.568, 48.954}
	},
	-- ["Mercadinho"] = {
	-- 	{373.875, 325.896, 103.566},
	-- 	{2557.458, 382.282, 107.622},
	-- 	{-3038.939, 585.954, 6.908},
	-- 	{-3241.927, 1001.462, 11.830},
	-- 	{547.431, 2671.710, 41.156},
	-- 	{1961.464, 3740.672, 31.343},
	-- 	{2678.916, 3280.671, 54.241},
	-- 	{-2540.81, 2313.85, 33.41},
	-- 	{161.41, 6640.7, 31.71},
	-- 	{1729.216, 6414.131, 35.037}
	-- },
	-- ["PlanetaSemente"] = {
	-- 	{1296.121, -1279.396, 75.834}
	-- },
	["Geral"] = {
		{1327.907, -1292.865, 77.023}
	}
}
