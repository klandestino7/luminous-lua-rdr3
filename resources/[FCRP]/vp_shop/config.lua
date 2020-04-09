Config = {}

Config.ShopDatas = {
	{
		name = "Ammunation",
		["Armas"] = {
			-- Level, Price
			{"weapon_combatpistol", 1, 50},
			{"weapon_assaultrifle", 6, 10},
			{"weapon_specialcarbine", 6, 10},
			{"weapon_carbinerifle_mk2", 6, 10},
			{"weapon_vintagepistol", 6, 10},
			{"weapon_smg_mk2", 6, 10},
		},
		["Munições"] = {
			-- Level, Price
			{"ammo_assaultrifle", 2, 25}
		},
		["Armas Brancas"] = {
			-- Level, Price
			{"weapon_knife", 7, 65}
		}
	},
	{
		name = "Policia",
		["Armas"] = {
			{"weapon_combatpistol", 0, 0},
			{"weapon_assaultrifle", 0, 0}
		},
		["Munições"] = {
			{"ammo_combatpistol", 0, 0}
		},
		["Armas Brancas"] = {
			{"weapon_knife", 0, 0}
		}
	},
	{
		name = "Mercadinho",
		-- Sem index(key), só aparecer na aba global
		{
			{"consumable_vodka", 1, 50}
		}
	}
}

Config.ShopLocations = {
	-- x, y, z, heading(optional)
	["Ammunation"] = {
		{21.92, -1107.15, 29.80, 338.07}
	},
	["Policia"] = {
		{452.37, -980.07, 30.69}
	},
	["Mercadinho"] = {
		{373.875, 325.896, 103.566},
		{2557.458, 382.282, 107.622},
		{-3038.939, 585.954, 6.908},
		{-3241.927, 1001.462, 11.830},
		{547.431, 2671.710, 41.156},
		{1961.464, 3740.672, 31.343},
		{2678.916, 3280.671, 54.241},
		{-2540.81, 2313.85, 33.41},
		{161.41, 6640.7, 31.71},
		{1729.216, 6414.131, 35.037}
	}
	-- ['liquor'] = {
	-- 	{x = 1135.808,  y = -982.281,  z = 45.415},
	-- 		{x = -1222.915, y = -906.983,  z = 11.326},
	-- 		{x = -1487.553, y = -379.107,  z = 39.163},
	-- 		{x = -2968.243, y = 390.910,   z = 14.043},
	-- 		{x = 1166.024,  y = 2708.930,  z = 37.157},
	-- 		{x = 1392.562,  y = 3604.684,  z = 33.980},
	-- 		{x = 25.723,   y = -1346.966, z = 28.497},
	-- 		{x = -1393.409, y = -606.624,  z = 29.319},
	-- 		{x = 387.41,  y = -779.52, z = 29.36},
	-- 		{x = -160.34,  y = 6322.73, z = 31.6} ,
	-- },
	-- ['gasoline'] ={
	-- 	{x = -48.519,   y = -1757.514, z = 28.421},
	-- 		{x = 1163.373,  y = -323.801,  z = 68.205},
	-- 		{x = -707.501,  y = -914.260,  z = 18.215},
	-- 		{x = -1820.523, y = 792.518,   z = 137.118},
	-- 		{x = 1698.388,  y = 4924.404,  z = 41.063}
	-- },
	-- ['vanilla'] = {
	-- 	{x = 127.09,   y = -1284.10, z = 29.28}
	-- }
}
