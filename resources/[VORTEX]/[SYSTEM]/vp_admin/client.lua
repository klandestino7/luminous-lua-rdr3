local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

RegisterNetEvent("VP:ADMIN:SpawnPed")
AddEventHandler(
	"VP:ADMIN:SpawnPed",
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
		SetModelAsNoLongerNeeded(pedModelHash)
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
			Citizen.InvokeNative(0xB282DC6EBD803C75, ped, GetHashKey(modelw), 500, true, 0)
		end
	end
)

RegisterNetEvent("VP:ADMIN:outift")
AddEventHandler(
	"VP:ADMIN:outift",
	function(kek)
		SetPedOutfitPreset(PlayerPedId(), kek)
	end
)

local showGamerTags = false
local gamerTags = {}
local gamerTagsInfo

RegisterCommand(
	"gt",
	function(source, args, rawCommand)
		if showGamerTags then
			showGamerTags = false

			for _, gamerTagId in pairs(gamerTags) do
				-- RemoveMpGamerTag(gamerTagId)

				Citizen.InvokeNative(0x93171DDDAB274EB8, gamerTagId, 0)
				--_SET_MP_GAMER_TAG_VISIBILITY
			end

			gamerTags = {}
		else
			TriggerServerEvent("VP:ADMIN:TryToGetGamerTagsInfo")
		end
	end
)

RegisterNetEvent("VP:ADMIN:ReceiveGamerTagsInfo")
AddEventHandler(
	"VP:ADMIN:ReceiveGamerTagsInfo",
	function(gtInfo)
		gamerTagsInfo = gtInfo
		showGamerTags = true
	end
)

RegisterNetEvent("VP:ADMIN:ReceiveGamerTagInfo")
AddEventHandler(
	"VP:ADMIN:ReceiveGamerTagInfo",
	function(s, uid)
		gamerTagsInfo[s] = uid
	end
)

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1000)

			if showGamerTags then
				for gamerId, gamerTagId in pairs(gamerTags) do
					if IsMpGamerTagActive(gamerTagId) then
						local ped = gamerId

						if gamerId <= 32 then -- IT'S A PLAYER
							ped = GetPlayerPed(gamerId)
						end

						if ped == 0 or not DoesEntityExist(ped) then
							-- RemoveMpGamerTag(gamerTagId)

							Citizen.InvokeNative(0x93171DDDAB274EB8, gamerTagId, 0)
							--_SET_MP_GAMER_TAG_VISIBILITY

							gamerTags[gamerId] = nil
						end
					end
				end

				for i = 0, 32 do
					if NetworkIsPlayerActive(i) then
						if not gamerTags[i] then
							local gamerTagId = Citizen.InvokeNative(0xE961BF23EAB76B12, GetPlayerPed(i), "" .. (gamerTagsInfo[GetPlayerServerId(i)] or "s:" .. GetPlayerServerId(i)))
							-- _CREATE_ENTITY_MP_GAMER_TAG

							-- local gamerTagId = CreateMpGamerTag(i, GetPlayerName(i), false, false, "", 0)

							Citizen.InvokeNative(0x1EA716E0628A6F44, gamerTagId, GetPlayerName(i))
							-- _SET_MP_GAMER_TAG_POSSE_NAME

							Citizen.InvokeNative(0x25B9C78A25105C35, gamerTagId, GetHashKey("GENERIC_PLAYER"))
							-- _SET_MP_GAMER_TAG_TYPE

							Citizen.InvokeNative(0x84BD27DDF9575816, gamerTagId, GetHashKey("COLOR_ORANGE"))
							-- _SET_MP_GAMER_TAG_COLOUR

							-- Citizen.InvokeNative(0x5F57522BC1EB9D9D, gamerTagId, GetHashKey("DEADEYE"))
							-- _SET_MP_GAMER_TAG_ICON

							-- Citizen.InvokeNative(0x95384C6CE1526EFF, gamerTagId, GetHashKey("SPEAKER"))
							-- _SET_MP_GAMER_TAG_SECONDARY_ICON

							Citizen.InvokeNative(0x93171DDDAB274EB8, gamerTagId, 4)
							--_SET_MP_GAMER_TAG_VISIBILITY

							SetMpGamerTagBigText(gamerTagId, "")

							gamerTags[i] = gamerTagId
						end

						local playerHorse = cAPI.GetPlayerHorse(i)
						if playerHorse ~= nil and playerHorse ~= 0 then
							if not gamerTags[playerHorse] then
								local gamerTagId_horse = Citizen.InvokeNative(0xE961BF23EAB76B12, playerHorse, "")

								SetMpGamerTagBigText(gamerTagId_horse, "" .. i)

								Citizen.InvokeNative(0x25B9C78A25105C35, gamerTagId_horse, GetHashKey("MINIGAMES"))
								-- _SET_MP_GAMER_TAG_TYPE

								Citizen.InvokeNative(0x84BD27DDF9575816, gamerTagId_horse, GetHashKey("COLOR_ORANGE"))
								-- _SET_MP_GAMER_TAG_COLOUR

								Citizen.InvokeNative(0x93171DDDAB274EB8, gamerTagId_horse, 4)
								--_SET_MP_GAMER_TAG_VISIBILITY

								Citizen.InvokeNative(0x5F57522BC1EB9D9D, gamerTagId_horse, GetHashKey("PLAYER_HORSE"))

								gamerTags[playerHorse] = gamerTagId_horse
							end
						end
					end
				end
			end
		end
	end
)

-- Citizen.CreateThread(
-- 	function()
-- 		while true do
-- 			Citizen.Wait(0)
-- 			if showGamerTags then
-- 				if #gamerTags > 0 then

-- 					for playerId, gamerTagId in pairs(gamerTags) do
-- 						if IsMpGamerTagActive(gamerTagId) and NetworkIsPlayerActive(playerId) then

-- 						end
-- 					end
-- 				end
-- 			else
-- 				Citizen.Wait(1000)
-- 			end
-- 		end
-- 	end
-- )

RegisterNetEvent("VP:ADMIN:CreateVehicle")
AddEventHandler(
	"VP:ADMIN:CreateVehicle",
	function(model)
		local veh = GetHashKey(model)

		print(IsModelValid(model))
		if IsModelValid(model) then
			if not HasModelLoaded(model) then
				RequestModel(veh)
				while not HasModelLoaded(veh) do
					Wait(10)
				end
			end

			local ped = PlayerPedId()
			local loc = GetEntityCoords(ped) + (GetEntityForwardVector(ped) * 2.0)

			CreateVehicle(model, loc, GetEntityHeading(ped), true, true, false, true)
			print("Spawned vehicle: " .. model)
		end
	end
)

AddEventHandler(
	"onResourceStop",
	function(resourceName)
		if resourceName == GetCurrentResourceName() then
			for _, gamerTagId in pairs(gamerTags) do
				if IsMpGamerTagActive(gamerTagId) then
					-- RemoveMpGamerTag(gamerTagId)

					Citizen.InvokeNative(0x93171DDDAB274EB8, gamerTagId, 0)
				--_SET_MP_GAMER_TAG_VISIBILITY
				end
			end
		end
	end
)

RegisterCommand(
	"teste",
	function(source, args, rawCommand)
		-- print("ies")

		local mount = GetMount(PlayerPedId())
		-- mount = 325123

		print()
		-- 92442
		-- 315933

		-- TaskAnimalInteraction(PlayerPedId(), 92442, -224471938, 0, 0) -- FEED HORSE
		-- TaskAnimalInteraction(PlayerPedId(), 92442, -1355254781, GetHashKey("p_cs_syringe01x"), 0) -- INJECT HORSE
		-- TaskAnimalInteraction(PlayerPedId(), 92442, 1968415774, 0, 0) -- HORSE POMADE
		TaskAnimalInteraction(PlayerPedId(), mount, GetHashKey("INTERACTION_TUCKMEDIUMPELT"), 0, 0) -- BRUSH HORSE

		-- local carried = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
		-- print(carried)

		-- 0xF49F14462F0AE27C
		-- Entity _GET_MOUNT_OWNED_BY_PLAYER(Player player)

		-- 0xB9D5BDDA88E1BB66
		-- BOOL _IS_THIS_MODEL_A_CART(Hash model)

		-- 0xB9050A97594C8832
		-- Entity _GET_VEHICLE_OWNED_BY_PLAYER(Player player)

		-- 0xD0E02AA618020D17
		-- _SET_PLAYER_OWNS_VEHICLE(Player player)

		-- 0x838C216C2B05A009
		-- _SET_PED_OWNS_VEHICLE(Ped ped)

		-- 0xB729679356A889AE
		-- _GET_VEHICLE_OWNER(Vehicle vehicle)

		-- print(carried)
		-- ResurrectPed(288517)
		-- FreezeEntityPosition(288517, true)

		-- UnlockSetUnlocked(GetHashKey("SP_WEAPON_DUALWIELD"), true)
		-- UnlockSetVisible(GetHashKey("SP_WEAPON_DUALWIELD"), true)
		-- Citizen.InvokeNative(0x8F4F050054005C27, PlayerId(), 16)
		-- Citizen.InvokeNative(0xFB6E111908502871, 15)

		-- UNLOCK__ROLE__EAGLE_EYE_PLUS_EFFECT
		-- SetPedConfigFlag(PlayerPedId(), 556, true)
		-- SetPedConfigFlag(PlayerPedId(), 263, true)
	end
)

-- 0xCE285A4413B00B7F
-- UNLOCK::_UNLOCK_SET_UNLOCKED(joaat("SP_WEAPON_DUALWIELD"), true);
-- UNLOCK::_UNLOCK_SET_VISIBLE(joaat("SP_WEAPON_DUALWIELD"), true);

-- // 0x6BCF5F3D8FFE988D
-- void _SET_IS_LOOTED(Entity, BOOL)
-- SET_ENTITY_GATHERED

-- // 0x8DE41E9902E85756
-- BOOL _GET_IS_LOOTED(Entity)
-- _IS_ENTITY_GATHERED

-- // 0xDACE03C65C6666DB
-- void _SET_0x6CFC373008A1EDAF -- related
-- void _SET_PED_CORPSE_*
-- ROTTEN?

-- // 0x90403E8107B60E81
-- int  GET_NUM_COMPONENTS_IN_ENTITY
-- // 0x77BA37622E22023B
-- Hash GET_PED_COMPONENT_AT_INDEX

-- SKINNING_DAMAGE_POOR_QUALITY_LEGENDARY
