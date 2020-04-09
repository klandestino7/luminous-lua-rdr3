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
