RegisterNetEvent("FCRP:ADMIN:SpawnPed")
AddEventHandler(
	"FCRP:ADMIN:SpawnPed",
	function(pedModel)
		local pedModelHash = GetHashKey(pedModel)
		if not IsModelValid(pedModelHash) then
			print("model is not valid")
			return
		end

		if not HasModelLoaded(pedModelHash) then
			RequestModel(pedModelHash)
			while not HasModelLoaded(pedModelHash) do
				Citizen.Wait(10)
			end
		end

		local ped = CreatePed(pedModelHash, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), 1, 0)
		Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
		Citizen.InvokeNative(0x58A850EAEE20FAA3, ped)
		-- Citizen.InvokeNative(0x23f74c2fda6e7c61, -1230993421, ped)
	end
)

RegisterCommand(
	"weapon",
	function(source, args)
		local modelw = args[1]
		if modelw == nil then
			print("Please set the specific name for weapon")
		else
			local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
			-- Citizen.InvokeNative(0xB282DC6EBD803C75, ped, GetHashKey(modelw), 500, true, 0)
			RemoveAllPedWeapons(ped, true, true)
			GiveWeaponToPed_2(ped, 0xDB21AC8C, 1, true, true, GetWeapontypeGroup(0xDB21AC8C), true, 0.9, 0.7, 0.6, true, 0.1, 0)
		end
	end
)

RegisterCommand(
	"vd",
	function(source, args)
		print(" ")

		print(Citizen.InvokeNative(0xF8204EF17410BF43, -1101297303, 1056964608, 1065353216, 0, Citizen.ResultAsLong()))

		local _, weaponHash = GetCurrentPedWeapon(PlayerPedId())
		local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())

		-- 0xA2091482ED42EF85
		-- 0x7E7B19A4355FEE13
		-- 0x1B83C0DEEBCBB214
		-- 0x0DE0944ECCB3DF5D
		-- 0x5B23DFF8E0948BB2

		-- 0xA9EF4AD10BDDDB57 : 0
		-- 0x812CE61DEBCAB948 : 0

		-- Citizen.InvokeNative(0xA7A57E89E965D839, weaponEntityIndex, 1.0) -- _SET_WEAPON_BROKEN_LEVEL 0.0 - 1.0, 0.0 = PERFECT CONDITION
		-- Citizen.InvokeNative(0xA9EF4AD10BDDDB57, weaponEntityIndex, 0.7, 1) -- _SET_WEAPON_MUD_LEVEL 0.0 - 1.0, 0.0 = NO MUDS 0x4BF66F8878F67663
		-- Citizen.InvokeNative(0xE22060121602493B, weaponEntityIndex, 0.5, 1) -- _SET_WEAPON_RUST_LEVEL 0.0 - 1.0, 0.0 = NO RUST 0xE22060121602493B
		-- Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, 0.4, 1) -- _SET_WEAPON_DIRT_LEVEL 0.0 - 1.0, 0.0 = NO DIRT 0x810E8AE9AFEA7E54
		-- Citizen.InvokeNative(0xD4071EFC83794B2F, weaponEntityIndex, 0.5) -- _SET_WEAPON_BREAKING_THRESHOLD

		-- GET
		-- < 0.2 = GOOD STATE
		-- > 0.7 = POOR STATE

		print("oil", Citizen.InvokeNative(0xD56E5F336C675EFA, weaponEntityIndex, Citizen.ResultAsFloat())) -- _GET_WEAPON_OIL_LEVEL
		print("broke", Citizen.InvokeNative(0x0D78E1097F89E637, weaponEntityIndex, Citizen.ResultAsFloat())) -- _GET_WEAPON_BROKEN_LEVEL
		print("mud", Citizen.InvokeNative(0x4BF66F8878F67663, weaponEntityIndex, Citizen.ResultAsFloat())) -- _GET_WEAPON_MUD_LEVEL
		print("rust", Citizen.InvokeNative(0x904103D5D2333977, weaponEntityIndex, Citizen.ResultAsFloat())) -- _GET_WEAPON_RUST_LEVEL
		print("dirt", Citizen.InvokeNative(0x810E8AE9AFEA7E54, weaponEntityIndex, Citizen.ResultAsFloat())) -- _GET_WEAPON_DIRT_LEVEL

-- ```cpp
-- weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())

-- // 0x0D78E1097F89E637
-- float _GET_WEAPON_BROKEN_LEVEL(entity weaponEntityIndex, Citizen.ResultAsFloat())
-- @return float 0.0 - 1.0
-- 0.0: GOOD CONDITION 1.0: POOR CONDITION

-- // 0xA7A57E89E965D839
-- void _SET_WEAPON_BROKEN_LEVEL(entity weaponEntityIndex, float level)
-- @param2 float 0.0 - 1.0

-- // 0x4BF66F8878F67663
-- float _GET_WEAPON_MUD_LEVEL(entity weaponEntityIndex, Citizen.ResultAsFloat())
-- @return float 0.0 - 1.0

-- // 0xA9EF4AD10BDDDB57
-- void _SET_WEAPON_MUD_LEVEL(entity weaponEntityIndex, float level, bool unk)
-- @param2 float 0.0 - 1.0

-- // 0x810E8AE9AFEA7E54
-- float _GET_WEAPON_DIRT_LEVEL(entity weaponEntityIndex, Citizen.ResultAsFloat())
-- @return float 0.0 - 1.0

-- // 0x812CE61DEBCAB948
-- void _SET_WEAPON_DIRT_LEVEL(entity weaponEntityIndex, float level, bool unk)
-- @param2 float 0.0 - 1.0

-- // 0x904103D5D2333977
-- float _GET_WEAPON_RUST_LEVEL(entity weaponEntityIndex, Citizen.ResultAsFloat())
-- @return float 0.0 - 1.0

-- // 0xE22060121602493B
-- void _SET_WEAPON_RUST_LEVEL(entity weaponEntityIndex, float level, bool unk)
-- @param2 float 0.0 - 1.0

-- // 0xD4071EFC83794B2F
-- void _SET_WEAPON_LEVEL_THRESHOLD(entity weaponEntityIndex, float level)
-- @param2 float 0.0 - 1.0
-- @info every other level will have the max value of (brokeLevel - threshold)

-- // 0xD56E5F336C675EFA
-- // MIGHT NOT BE CORRECT AS A SETTER HASNT BEEN FOUND
-- float _GET_WEAPON_OIL_LEVEL(entity weaponEntityIndex, Citizen.ResultAsFloat())
-- @return float 0.0 - 1.0
-- ```

		--- Caso a arma nao tenha sofrido nenhum dado
		-- print(GetLabelTextByHash(1803343570))
		-- A arma foi limpa alguma vez e a arma nao sofre nada após essa vez
		-- print(GetLabelTextByHash(-1933427003))
		-- A armas precisa ser limpa
		-- print(GetLabelTextByHash(-54957657))
	end
)

Citizen.CreateThread(
	function()
		local lastCondition

		-- local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
		-- Citizen.InvokeNative(0xA9EF4AD10BDDDB57, weaponEntityIndex, 0.0, 0) -- SET 0x4BF66F8878F67663
		-- Citizen.InvokeNative(0x812CE61DEBCAB948, weaponEntityIndex, 1.0, 0) -- SET 0x810E8AE9AFEA7E54
		-- Citizen.InvokeNative(0xE22060121602493B, weaponEntityIndex, 0.0, 0) -- SET 0xE22060121602493B
		while true do
			Citizen.Wait(0)
			if IsPedShooting(PlayerPedId()) then
				local weaponEntityIndex = GetCurrentPedWeaponEntityIndex(PlayerPedId())
				local condition = tonumber(string.format("%.2f", Citizen.InvokeNative(0x0D78E1097F89E637, weaponEntityIndex, Citizen.ResultAsFloat())))
				if lastCondition ~= nil then
					print(".")
					print(lastCondition .. " to " .. condition)
				end
				lastCondition = condition
			end
		end
	end
)
