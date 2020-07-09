local MeeleWeapons = {
    ["WEAPON_HORSE"] = 0.02,
    ["WEAPON_FIRE"] = 0.09,
    ["WEAPON_UNARMED"] = 0.02
}

local FireWeapons = {
    ["weapon_bow"] = 0.09,
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5)
		local retval, weaponHash = GetCurrentPedWeapon(PlayerPedId(), 1)
		
		for weapon, modifier in pairs(MeeleWeapons) do
			if weaponHash == GetHashKey(weapon) then
				SetPlayerMeleeWeaponDamageModifier(PlayerPedId(), modifier)
			end
		end

		for weapon, modifier in pairs(FireWeapons) do
			if weaponHash == GetHashKey(weapon) then
				SetPlayerWeaponDamageModifier(PlayerPedId(), modifier)
			end
		end
    end
end)


