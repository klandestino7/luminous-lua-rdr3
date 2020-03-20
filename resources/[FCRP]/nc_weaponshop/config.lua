Config               = {}

Config.DrawDistance  = 100
Config.Size          = { x = 1.5, y = 1.5, z = 0.5 }
Config.Color         = { r = 0, g = 155, b = 253 }
Config.Type          = 23

--Config.LicenseEnable = true -- only turn this on if you are using esx_license
--Config.LicensePrice  = 5000

Config.Zones = {

	GunShop = {
		Legal = true,
		Items =	{
					Weapon = {			
						{				
							imglink = "/html/items/WEAPON_COMBATPISTOL.png",
							itemId = "WEAPON_COMBATPISTOL",
							itemName = "Pistola",
							level = 1,
							money = 100,
							gold = 2
						},
						{
							imglink = "WEAPON_ASSAULTRIFLE.png",
							itemId = "weapon_assaultrifle",
							itemName = "AK 47",
							level = 1,
							money = 100,
							gold = 2
						}, 
					},
					Ammo = {
						{
							imglink = "/html/itens/WEAPON_PISTOL.png",
							itemId = "ammo_pistol",
							itemName = "Munição de Pistola",
							level = 1,
							money = 10,
							gold = 2
						},
					},
					Melee ={
						{
							imglink = "/html/itens/WEAPON_KNIFE.png",
							itemId = "weapon_knife",
							itemName = "Faca",
							level = 1,
							money = 10,
							gold = 2
					}	
				}
			},
		Locations = {
			vector3(22.0, -1107.2, 28.8)
		}
	},

	BlackWeashop = {
		Legal = false,
		Items = {
			{
				imglink = "/html/itens/WEAPON_ASSAULTRIFLE.png",
                itemId = "consumable_apple",
                itemName = "AK 47",
                level = 1,
                money = 100,
                gold = 2
			}
		},
		Locations = {
			vector3(728.92, 4188.70, 39.75)
		}
	}
}
