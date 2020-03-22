Config = {}

Config.DrawDistance = 100
Config.Size = {x = 1.5, y = 1.5, z = 0.5}
Config.Color = {r = 0, g = 155, b = 253}
Config.Type = 23

Config.ShopDatas = {
	{
		name = "Ammunation",
		weapon = {
			{
				itemId = "weapon_combatpistol",
				level = 1,
				price = 50
			},
			{
				itemId = "weapon_assaultrifle",
				level = 6,
				price = 10
			}
		},
		ammo = {
			{
				itemId = "ammo_combatpistol",
				level = 2,
				price = 25
			}
		},
		melee = {
			{
				itemId = "weapon_knife",
				level = 7,
				price = 65
			}
		}
	},
	{
		name = "Policia",
		weapon = {
			{
				itemId = "weapon_combatpistol",
				level = 0,
				price = 0
			},
			{
				itemId = "weapon_assaultrifle",
				level = 0,
				price = 0
			}
		},
		ammo = {
			{
				itemId = "ammo_pistol",
				level = 0,
				price = 0
			}
		},
		melee = {
			{
				itemId = "weapon_knife",
				level = 0,
				price = 0
			}
		}
	}
}

Config.ShopLocations = {
	-- x, y, z, headingadad
	["Ammunation"] = {
		{21.92,-1107.15,29.80, 338.07}
	},
	["Policia"] = {
		{452.37,-980.07,30.69}
	}
}
