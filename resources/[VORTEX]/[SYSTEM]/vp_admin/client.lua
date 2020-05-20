local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")




RegisterNetEvent("VP:ADMIN:Model")
AddEventHandler(
	"VP:ADMIN:Model",
	function(model, clothes)

		cAPI.SetModel(model.model)
		Wait(130)
		cAPI.SetBodyType(PlayerPedId(), model.bodySize)
		cAPI.SetSkin(PlayerPedId(), model.modSkin)
		Wait(300)
		cAPI.SetFaceFeature(PlayerPedId(), json.decode(model.features))
		Wait(30)
		cAPI.SetPedSize(PlayerPedId(), model.pedSize)

		cAPI.SetCloth(clothes)

	end
)


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
		-- SetModelAsNoLongerNeeded(pedModelHash)
	end
)

RegisterNetEvent("VP:ADMIN:SpawnObject")
AddEventHandler(
	"VP:ADMIN:SpawnObject",
	function(model)
		local modelHash = GetHashKey(model)
		if not IsModelValid(modelHash) then
			print("model is not valid")
			return
		end

		if not HasModelLoaded(modelHash) then
			RequestModel(modelHash)
			while not HasModelLoaded(modelHash) do
				Citizen.Wait(10)
			end
		end

		local obj = CreateObject(modelHash, GetEntityCoords(PlayerPedId()), 1, 1, 1)

		-- SetModelAsNoLongerNeeded(pedModelHash)
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

RegisterNetEvent("VP:ADMIN:DestroyTargetEntity")
AddEventHandler(
	"VP:ADMIN:DestroyTargetEntity",
	function()
		print("a")
		local ped = PlayerPedId()
		local pedVector = GetEntityCoords(ped)

		local cameraRotation = GetGameplayCamRot()
		local cameraCoord = GetGameplayCamCoord()
		local direction = RotationToDirection(cameraRotation)
		local lastCoords = vec3(cameraCoord.x + direction.x * 10.0, cameraCoord.y + direction.y * 10.0, cameraCoord.z + direction.z * 10.0)

		local rayHandle = StartShapeTestRay(cameraCoord, lastCoords, -1, ped, 0)
		local _, hit, endCoords, _, entityHit = GetShapeTestResult(rayHandle)

		if hit == 1 and entityHit ~= 0 then
			SetEntityAsMissionEntity(entityHit, true, true)
			DeleteEntity(entityHit)
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
		local coords = GetEntityCoords(PlayerPedId())
		local _, groundZ, normal = GetGroundZAndNormalFor_3dCoord(coords.x, coords.y, coords.z)
		coords = vec3(coords.xy, groundZ)

		-- local objHash = GetHashKey("P_CARCASSHANGFISH01A")
		-- if IsModelValid(objHash) then
		-- 	if not HasModelLoaded(objHash) then
		-- 		RequestModel(objHash)
		-- 		while not HasModelLoaded(objHash) do
		-- 			Citizen.Wait(10)
		-- 		end
		-- 	end
		-- end

		-- local scenario = Citizen.InvokeNative(0x94B745CE41DB58A1, GetHashKey("WORLD_HUMAN_BALE_PICKUP_1"), coords, GetEntityHeading(PlayerPedId()), 0.0, 0, 1)
		-- TaskUseScenarioPoint(PlayerPedId(), scenario, "", -1.0, 0, 0, 0, 0, 0)

		-- -- Citizen.InvokeNative(0xEEE4829304F93EEE, scenario, false)

		-- Wait(250)

		-- local a = Citizen.InvokeNative(0x345EC3B7EBDE1CB5, coords, 1.0 ,  1 )
		-- local b = Citizen.InvokeNative(0x91CB5E431F579BA1, scenario)
		-- local c = Citizen.InvokeNative(0xA92450B5AE687AAF, scenario)
		-- local d = Citizen.InvokeNative(0xDF7993356F52359A, PlayerPedId())
		-- local e = Citizen.InvokeNative(0x2D0571BB55879DA2, PlayerPedId())
		-- print(" ", scenario)
		-- print(a)
		-- print(b)
		-- print(c)
		-- print(d)
		-- print(e)
		-- local ff
		-- print(GetPedNearbyPeds(PlayerPedId(), f, -1, -1))
		-- print(ff)
	end
)

-- ? // 0xD04241BBF6D03A5E
-- ? Scenario _GET_SCENARIO_POINT_*

-- ? // _0x345EC3B7EBDE1CB5
-- ? int _GET_SCENARIO_POINT_CLOSE_TO_COORDS(float posX, float posY, float posZ, float ?radius, int p4)

-- // 0xDF7993356F52359A
-- int _GET_SCENARIO_POINT_PED_IS_USING(Ped ped, BOOL p1)

-- ? // 0x6718F40313A2B5A6
-- ? float _GET_SCENARIO_POINT_PHASE(int scenario)

-- // 0xA92450B5AE687AAF
-- Hash GET_SCENARIO_POINT_TYPE(int scenario)

-- // 0x2D0571BB55879DA2
-- int _GET_SCENARIO_POINT_TYPE_PED_IS_USING(Ped)

-- // 0x19A6BE7D9C6884D3
-- BOOL _REQUEST_SCENARIO_TYPE(Hash scenarioType)

-- // 0x9427C94D2E4094A4
-- BOOL _HAS_SCENARIO_TYPE_LOADED(Hash scenarioType)

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

function RotationToDirection(rotation)
	local adjustedRotation = {
		x = (math.pi / 180) * rotation.x,
		y = (math.pi / 180) * rotation.y,
		z = (math.pi / 180) * rotation.z
	}
	local direction = {
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
		z = math.sin(adjustedRotation.x)
	}
	return direction
end
