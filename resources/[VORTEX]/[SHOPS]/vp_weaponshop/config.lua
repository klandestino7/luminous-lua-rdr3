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
							imglink = "itens/weapon_revolver_lemat.png",
							itemId = "revolver_lemat",
							itemName = "Revolver Lemat",
							amount = 1,
							level = 7,
							money = 317,
							gold = 13
						},
						{
							imglink = "itens/weapon_revolver_cattleman.png",
							itemId = "revolver_cattleman",
							itemName = "Revolver Cattleman",
							amount = 1,
							level = 1,
							money = 50,
							gold = 2
						}, 
						{
							imglink = "itens/WEAPON_REVOLVER_NAVY.png",
							itemId = "REVOLVER_NAVY",
							itemName = "Revolver Militar",
							amount = 1,
							level = 5,
							money = 257,
							gold = 11
						}, 
						{
							imglink = "itens/weapin_pistol_volcanic.png",
							itemId = "pistol_volcanic",
							itemName = "Pistola Volcani",
							amount = 1,
							level = 24,
							money = 300,
							gold = 14
						}, 
						{
							imglink = "itens/weapon_shotgun_sawedoff.png",
							itemId = "shotgun_sawedoff",
							itemName = "Escopeta Cano serrado",
							amount = 1,
							level = 5,
							money = 111,
							gold = 13
						}, 
						{
							imglink = "itens/weapon_repeater_carbine.png",
							itemId = "repeater_carbine",
							itemName = "Carabina de Repetição",
							amount = 1,
							level = 2,
							money = 90,
							gold = 4
						}, 
						{
							imglink = "itens/weapon_repeater_henry.png",
							itemId = "repeater_henry",
							itemName = "Litchfield de Repetição",
							amount = 1,
							level = 17,
							money = 234,
							gold = 10
						}, 
						{
							imglink = "itens/weapon_sniperrifle_rollingblock.png",
							itemId = "sniperrifle_rollingblock",
							itemName = "Rifle Rolling Block",
							amount = 1,
							level = 15,
							money = 500,
							gold = 20
						}, 
						{
							imglink = "itens/weapon_rifle_varmint.png",
							itemId = "rifle_varmint",
							itemName = "Rifle Anti-pragas",
							amount = 1,
							level = 7,
							money = 72,
							gold = 3
						}, 
						{
							imglink = "itens/weapon_rifle_boltaction.png",
							itemId = "rifle_boltaction",
							itemName = "Rifle de Ferrolho",
							amount = 1,
							level = 9,
							money = 216,
							gold = 9
						}, 

						{
							imglink = "itens/weapon_thrown_throwing_knives.png",
							itemId = "thrown_throwing_knives",
							itemName = "Faca Arremeçavel",
							amount = 1,
							level = 1,
							money = 2.5,
							gold = 0.5
						}, 
						{
							imglink = "itens/weapon_melee_cleaver.png",
							itemId = "melee_cleaver",
							itemName = "Machado Cutelo",
							amount = 1,
							level = 5,
							money = 8,
							gold = 1
						}, 
						{
							imglink = "itens/weapon_melee_knife.png",
							itemId = "melee_knife",
							itemName = "Faca de Caça",
							amount = 1,
							level = 1,
							money = 0.5,
							gold = 0.1
						}		
					},
					Ammo = {

						{
							imglink = "itens/ammo_revolver.png",
							itemId = "ammo_revolver",
							itemName = "Munição de Revolver",
							amount = 20,
							level = 1,
							money = 10,
							amount = 20,
							gold = 2
						},
						{
							imglink = "itens/ammo_pistol.png",
							itemId = "ammo_pistol",
							itemName = "Munição de Pistola",
							amount = 20,
							level = 1,
							money = 10,
							amount = 20,
							gold = 2
						},
						{
							imglink = "itens/ammo_repeater.png",
							itemId = "ammo_repeater",
							itemName = "Munição de Carbina",
							amount = 20,
							level = 1,
							money = 10,
							amount = 20,
							gold = 2
						},
						{
							imglink = "itens/ammo_rifle.png",
							itemId = "ammo_rifle",
							itemName = "Munição de Rifle",
							amount = 20,
							level = 1,
							money = 10,
							amount = 20,
							gold = 2
						},
						{
							imglink = "itens/ammo_shotgun.png",
							itemId = "ammo_shotgun",
							itemName = "Munição de Shotgun",
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
							itemId = "melee_knife",
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
