Config = {}
Config.Sheriff = 1
Config.DoorList = {
	{
		doorName = 'P_DOORl3X',
		objCoords  = vector3(1285.14, -1303.12, 76.04),
		objYaw = -35.0,
		locked = false,
		distance = 3.0
	},	
	{
		doorName = 'P_DOOR_VAL_BANKVAULT',
		objCoords  = vector3(1282.53, -1309.12, 76.03),
		objYaw = -250.0,
		CharDetonateHeading = 233.82,
		xOffset = 0,
		yOffset = 1,
		ClosedRotation = -135.0,
		detonate = false,
		distance = 3.0
	},	
	{
		textCoords = vector3(1296.27, -1299.02, 76.03),
		locked = false,
		distance = 2.5,
		doors = {
			{
			--	objName = 'v_ilev_ph_door01',
				objYaw = 231.0,
				objCoords = vector3(1296.27, -1299.02, 76.03)
			},
			{
			-- objName = 'v_ilev_ph_door002',
				objYaw = -91.0,
				objCoords = vector3(1294.54, -1297.59, 76.03)
			}
		}
	},
}

Config.SafeList = {
	{
		heading = 234.96,
		locked = false,
		coords = vector3(1288.4, -1313.8, 75.84)
	},	
	{
		heading = 234.96,
		locked = false,
		coords = vector3(1287.0, -1315.52, 75.84)
	},	
	{
		heading = 234.96,
		locked = false,
		coords = vector3(1287.59, -1314.73, 75.84)
	}
}