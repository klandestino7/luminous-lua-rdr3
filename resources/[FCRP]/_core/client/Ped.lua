cPed = {}
Tunnel.bindInterface("API:cPed", cPed)
Proxy.addInterface("API:cPed", cPed)

local weaponModels = {
	"WEAPON_KNIFE",
	"WEAPON_STUNGUN",
	"WEAPON_FLASHLIGHT",
	"WEAPON_NIGHTSTICK",
	"WEAPON_HAMMER",
	"WEAPON_BAT",
	"WEAPON_GOLFCLUB",
	"WEAPON_CROWBAR",
	"WEAPON_PISTOL",
	"WEAPON_COMBATPISTOL",
	"WEAPON_APPISTOL",
	"WEAPON_PISTOL50",
	"WEAPON_MICROSMG",
	"WEAPON_SMG",
	"WEAPON_ASSAULTSMG",
	"WEAPON_ASSAULTRIFLE",
	"WEAPON_CARBINERIFLE",
	"WEAPON_ADVANCEDRIFLE",
	"WEAPON_MG",
	"WEAPON_COMBATMG",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_ASSAULTSHOTGUN",
	"WEAPON_BULLPUPSHOTGUN",
	"WEAPON_STUNGUN",
	"WEAPON_SNIPERRIFLE",
	"WEAPON_HEAVYSNIPER",
	"WEAPON_REMOTESNIPER",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_GRENADELAUNCHER_SMOKE",
	"WEAPON_RPG",
	"WEAPON_PASSENGER_ROCKET",
	"WEAPON_AIRSTRIKE_ROCKET",
	"WEAPON_STINGER",
	"WEAPON_MINIGUN",
	"WEAPON_GRENADE",
	"WEAPON_STICKYBOMB",
	"WEAPON_SMOKEGRENADE",
	"WEAPON_BZGAS",
	"WEAPON_MOLOTOV",
	"WEAPON_FIREEXTINGUISHER",
	"WEAPON_PETROLCAN",
	"WEAPON_DIGISCANNER",
	"WEAPON_BRIEFCASE",
	"WEAPON_BRIEFCASE_02",
	"WEAPON_BALL",
	"WEAPON_FLARE"
}

function cAPI.getWeapons()
	local ped = PlayerPedId()
	local ammo_types = {}
	local weapons = {}
	for _, v in pairs(weaponModels) do
		local hash = GetHashKey(v)
		if HasPedGotWeapon(ped, hash) then
			local atype = GetPedAmmoTypeFromWeapon(ped, hash)
			if ammo_types[atype] == nil then
				ammo_types[atype] = true
				weapons[v] = GetAmmoInPedWeapon(ped, hash)
			else
				weapons[v] = 0
			end
		end
	end

	return weapons
end

function cAPI.replaceWeapons(weapons)
	local old_weapons = cAPI.getWeapons()
	cAPI.giveWeapons(weapons, true)
	return old_weapons
end

function cAPI.giveWeapon(weapon, ammo, clear_before)
	cAPI.giveWeapons(
		{
			weapon = ammo
		},
		clear_before
	)
end

function cAPI.giveWeapons(weapons, clear_before)
	local ped = PlayerPedId()

	if clear_before then
		RemoveAllPedWeapons(ped, true, true)
	end

	for weapon, ammo in pairs(weapons) do
		local hash = GetHashKey(weapon)

		GiveWeaponToPed(PlayerPedId(), hash, ammo or 0, false, true)
	end
end

function cAPI.setPlayerArmour(amount)
	SetPedArmour(PlayerPedId(), amount)
end

function cAPI.getPlayerArmour()
	return GetPedArmour(PlayerPedId())
end

function cAPI.getPlayerHealth()
	return GetEntityHealth(PlayerPedId())
end

function cAPI.setPlayerHealth(v)
	setEntityHealth(PlayerPedId(), v)
end

function  cPed.PlayAnimation(dictionary, animation, speed, targetPed)
	local ped = targetPed or PlayerPedId()
	if not IsEntityPlayingAnim(ped, dictionary, animation) then
		cWrapper.RequestAnimDict(dictionary)
		TaskPlayAnim(ped, dictionary, animation, speed or 1.0, 1.0, -1, 0, 0, 0, 0, 0, 0, 0)
	end
end

function cPed.SetModel(hash)
	cWrapper.RequestModel(hash)

	SetPlayerModel(PlayerId(), hash)

	SetPedDefaultComponentVariation(PlayerPedId(), true)
end

function  cPed.SetClothing(encoded)
	local decoded = json.decode(encoded)

	local ped = PlayerPedId()

	local drawablesTable = decoded.drawables
	local texturesTable = decoded.drawTextures

	local drawable_names = {"face", "masks", "hair", "torsos", "legs", "bags", "shoes", "neck", "undershirts", "vest", "decals", "jackets"}

	for i = 1, #drawable_names do
		if drawablesTable[0] == nil then
			if drawable_names[i] == "undershirts" and drawablesTable[tostring(i - 1)][2] == -1 then
				SetPedComponentVariation(ped, i - 1, 15, 0, 2)
			else
				SetPedComponentVariation(ped, i - 1, drawablesTable[tostring(i - 1)][2], texturesTable[i][2], 2)
			end
		else
			if drawable_names[i] == "undershirts" and drawablesTable[i - 1][2] == -1 then
				SetPedComponentVariation(ped, i - 1, 15, 0, 2)
			else
				SetPedComponentVariation(ped, i - 1, drawablesTable[i - 1][2], texturesTable[i][2], 2)
			end
		end
	end

	local hairTable = decoded.getHair

	SetPedHairColor(player, tonumber(hairTable[0]), tonumber(hairTable[1]))
end

function  cPed.SetHeadData(encoded)
	local decoded = json.decode(encoded)

	local ped = PlayerPedId()
	if decoded ~= nil and #decoded > 0 then
		local headBlendTable = decoded.headBlend
		SetPedHeadBlendData(
			ped,
			tonumber(headBlendTable["shapeFirst"]),
			tonumber(headBlendTable["shapeSecond"]),
			tonumber(headBlendTable["shapeThird"]),
			tonumber(headBlendTable["skinFirst"]),
			tonumber(headBlendTable["skinSecond"]),
			tonumber(headBlendTable["skinThird"]),
			tonumber(headBlendTable["shapeMix"]),
			tonumber(headBlendTable["skinMix"]),
			tonumber(headBlendTable["thirdMix"]),
			false
		)

		local overlayTable = decoded.overlayHead

		if overlayTable ~= nil and #overlayTable > 0 then
			for i = 1, 13 do
				SetPedHeadOverlay(ped, i - 1, tonumber(overlayTable[i].overlayValue), tonumber(overlayTable[i].overlayOpacity))
				-- SetPedHeadOverlayColor(ped, i-1, overlayTable[i].colourType, overlayTable[i].firstColour, overlayTable[i].secondColour)
			end

			SetPedHeadOverlayColor(ped, 0, 0, tonumber(overlayTable[1].firstColour), tonumber(overlayTable[1].secondColour))
			SetPedHeadOverlayColor(ped, 1, 1, tonumber(overlayTable[2].firstColour), tonumber(overlayTable[2].secondColour))
			SetPedHeadOverlayColor(ped, 2, 1, tonumber(overlayTable[3].firstColour), tonumber(overlayTable[3].secondColour))
			SetPedHeadOverlayColor(ped, 3, 0, tonumber(overlayTable[4].firstColour), tonumber(overlayTable[4].secondColour))
			SetPedHeadOverlayColor(ped, 4, 2, tonumber(overlayTable[5].firstColour), tonumber(overlayTable[5].secondColour))
			SetPedHeadOverlayColor(ped, 5, 2, tonumber(overlayTable[6].firstColour), tonumber(overlayTable[6].secondColour))
			SetPedHeadOverlayColor(ped, 6, 0, tonumber(overlayTable[7].firstColour), tonumber(overlayTable[7].secondColour))
			SetPedHeadOverlayColor(ped, 7, 0, tonumber(overlayTable[8].firstColour), tonumber(overlayTable[8].secondColour))
			SetPedHeadOverlayColor(ped, 8, 2, tonumber(overlayTable[9].firstColour), tonumber(overlayTable[9].secondColour))
			SetPedHeadOverlayColor(ped, 9, 0, tonumber(overlayTable[10].firstColour), tonumber(overlayTable[10].secondColour))
			SetPedHeadOverlayColor(ped, 10, 1, tonumber(overlayTable[11].firstColour), tonumber(overlayTable[11].secondColour))
			SetPedHeadOverlayColor(ped, 11, 0, tonumber(overlayTable[12].firstColour), tonumber(overlayTable[12].secondColour))
		end

		local faceFeatureTable = decoded.headStruct

		for i = 1, 20 do
			SetPedFaceFeature(ped, i - 1, faceFeatureTable[i])
		end
	end

	cWrapper.OutFade(500)
end

function cPed.getCoords(targetPed)
	return GetEntityCoords(targetPed or PlayerPedId())
end
