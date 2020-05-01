Config = {}

Config.ShopDatas = {
	-- {
	-- 	name = "Ammunation",
	-- 	{
	-- 		{"bow", 1, 50, 10},
	-- 		{"weapon_assaultrifle", 6, 10, 15},
	-- 		{"ammo_arrow", 2, 25, 10},
	-- 		{"weapon_knife", 7, 65, 15}
	-- 	}
	-- },
	{
		name = "Policia",
		{
			{"revolver_doubleaction", 0, 0, 0},
			{"rifle_springfield", 0, 0, 0},
			{"shotgun_pump", 0, 0, 0},
			{"ammo_revolver", 0, 0, 0},
			{"ammo_rifle", 0, 0, 0},
			{"ammo_shotgun", 0, 0, 0},
		}
	},
	-- {
	-- 	name = "Mercadinho",
	-- 	-- Sem index(key), só aparecer na aba global
	-- 	{
	-- 		{"consumable_vodka", 1, 50}
	-- 	}
	-- },
	-- {
	-- 	name = "PlanetaSemente",
	-- 	{
	-- 		{"tobacco_seed", 1, 1}
	-- 	}
	-- },
	{
		name = "Geral",
		{
			{"tobacco_seed", 0, 1, 1},
			{"corn_seed", 0, 1,1},
			{"sugarcane_seed", 0, 1, 1},
		}
	}
}

Config.ShopLocations = {
	-- x, y, z, heading(optional)
	-- ["Ammunation"] = {
	-- 	{1193.196, -1866.593, 51.696}
	-- },
	["Policia"] = {
		{-764.768,-1272.072,44.041},
		{-1813.974,-354.651,164.649},
		{-278.365,805.207,119.380},
		{2494.206,-1304.434,48.954},
		{2494.392,-1312.568,48.954},
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
	['Geral'] = {
		{1327.907,-1292.865,77.023},
	}
}
