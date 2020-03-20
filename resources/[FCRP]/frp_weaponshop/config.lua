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
							imglink = "itens/weapon_pistol_semiauto.png",
							itemId = "weapon_pistol_semiauto",
							itemName = "Pistola Semi-Auto",
							amount = 1,
							level = 1,
							money = 100,
							gold = 2
						},
						{
							imglink = "itens/weapon_revolver_cattleman.png",
							itemId = "weapon_revolver_cattleman",
							itemName = "Revolver Cattleman",
							amount = 1,
							level = 1,
							money = 100,
							gold = 2
						}, 
						{
							imglink = "itens/weapon_repeater_carbine.png",
							itemId = "weapon_repeater_carbine",
							itemName = "Rifle de Repetição Carbine",
							amount = 1,
							level = 1,
							money = 100,
							gold = 2
						}, 
					},
					Ammo = {
						{
							imglink = "itens/weapon_revolver_cattleman.png",
							itemId = "ammo_pistol",
							itemName = "Munição de Pistola",
							amount = 20,
							level = 1,
							money = 10,
							amount = 20,
							gold = 2
						},
						{
							imglink = "itens/weapon_repeater_carbine.png",
							itemId = "ammo_repeater",
							itemName = "Munição de Carbina",
							amount = 20,
							level = 1,
							money = 10,
							amount = 20,
							gold = 2
						},
					},
					Melee ={
						{
							imglink = "itens/weapon_melee_knife.png",
							itemId = "weapon_melee_knife",
							itemName = "Faca",
							amount = 1,
							level = 1,
							money = 10,
							gold = 2
					}	
				}
			},
		Locations = {
			vector3(-281.99,780.92,119.52),  -- VALENTINE
			vector3(1322.87, -1321.48, 76.89),
			vector3(2715.91, -1285.65, 48.63),
			vector3(2946.53, 1319.66, 44.82),
			vector3(-5508.16, -2964.47, -0.63)
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
