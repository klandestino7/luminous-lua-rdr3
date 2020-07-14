local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

RegisterNetEvent("VP:ADMIN:Model")
AddEventHandler(
	"VP:ADMIN:Model",
	function(pedInfo, clothes)
		local pModel = GetHashKey(pedInfo.model)
		local pBodySize = tonumber(pedInfo.bodySize)
		local pSkin = json.decode(pedInfo.modSkin)
		local pFaceFeatures = json.decode(pedInfo.features)
		local pScale = tonumber(pedInfo.pedSize)
		local pClothing
		if not cAPI.IsWanted() then
			if json.decode(clothes).Outfit ~= nil then
				if tonumber(json.decode(clothes).Outfit) <= 100 then
					pClothing = tonumber(json.decode(clothes).Outfit)
				end
			else
				pClothing = json.decode(clothes)
			end

			cAPI.SetPlayerPed(pModel)
			Wait(130)
			cAPI.SetPedBodyType(PlayerPedId(), pBodySize)
			cAPI.SetSkin(PlayerPedId(), pSkin)
			Wait(300)
			cAPI.SetPedFaceFeature(PlayerPedId(), pFaceFeatures)
			Wait(30)
			cAPI.SetPedScale(PlayerPedId(), pScale)
			cAPI.SetPedClothing(PlayerPedId(), pClothing)
		else
			TriggerEvent("VP:NOTIFY:Simple", "Você ainda está como procurado, não pode trocar de roupa. ", 10000)
		end
	end
)

RegisterNetEvent("VP:ADMIN:SpawnPed")
AddEventHandler(
	"VP:ADMIN:SpawnPed",
	function(pedModel, outfit)
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

		SetEntityAsMissionEntity(ped)
		-- SetModelAsNoLongerNeeded(pedModelHash)

		SetPedAsGroupMember(ped, GetDefaultRelationshipGroupHash(pedModelHash))

		Citizen.InvokeNative(0xC80A74AC829DDD92, ped, GetDefaultRelationshipGroupHash(pedModelHash))

		--	TaskCombatPed(ped ,PlayerPedId(), 0, 16)
		--	Citizen.InvokeNative(0xB282DC6EBD803C75, ped, GetHashKey("Weapon_melee_knife"), 500, true, 0)

		if outfit ~= nil then
			SetPedOutfitPreset(ped, tonumber(outfit))
			Citizen.InvokeNative(0x7528720101A807A5, ped, 2)
		end
		-- Citizen.InvokeNative(0x23f74c2fda6e7c61, -1230993421, ped)
		-- SetModelAsNoLongerNeeded(pedModelHash)
	end
)

RegisterCommand(
	"guarma",
	function()
		N_0xa657ec9dbc6cc900(1)
		Citizen.InvokeNative(0x74E2261D2A66849A, 1)
		Citizen.InvokeNative(0xE8770EE02AEE45C2, 1)
	end
)

function SET_PED_RELATIONSHIP_GROUP_HASH(iVar0, iParam0)
	return Citizen.InvokeNative(0xC80A74AC829DDD92, iVar0, _GET_DEFAULT_RELATIONSHIP_GROUP_HASH(iParam0))
end

function _GET_DEFAULT_RELATIONSHIP_GROUP_HASH(iParam0)
	return Citizen.InvokeNative(0xC80A74AC829DDD92, iParam0)
end

RegisterNetEvent("VP:ADMIN:SpawnObject")
AddEventHandler(
	"VP:ADMIN:SpawnObject",
	function(model)
		local modelHash = tonumber(model) == nil and GetHashKey(model) or tonumber(model)
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

		local x, y, z = table.unpack(GetEntityCoords(PlayerPedId()))
		local hasCollision, groundZ, normal = GetGroundZAndNormalFor_3dCoord(x, y, z)
		z = groundZ

		local obj = CreateObject(modelHash, x, y, z, 1, 1, 1)

		print("spawned", obj)
		-- SetModelAsNoLongerNeeded(pedModelHash)
	end
)

-- RegisterCommand(
-- 	"weapon",
-- 	function(source, args)
-- 		local modelw = args[1]
-- 		if modelw == nil then
-- 			print("Please set the specific name for weapon")
-- 		else
-- 			local ped = Citizen.InvokeNative(0x275F255ED201B937, 0)
-- 			Citizen.InvokeNative(0xB282DC6EBD803C75, ped, GetHashKey(modelw), 500, true, 0)
-- 		end
-- 	end
-- )

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

Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(0)
			if showGamerTags then
				for _, pid in pairs(GetActivePlayers()) do
					local ply = GetPlayerPed(pid)
					local pelvis = GetPedBoneCoords(ply, 33219, 0, 0, 0)
					local spine = GetPedBoneCoords(ply, 6757, 0, 0, 0)
					local neck = GetPedBoneCoords(ply, 14283, 0, 0, 0)
					local head = GetPedBoneCoords(ply, 21030, 0, 0, 0)
					local leftEye = GetPedBoneCoords(ply, 47668, 0, 0, 0)
					local rightEye = GetPedBoneCoords(ply, 47668, 0, 0, 0)
					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, pelvis.x, pelvis.y, pelvis.z, spine.x, spine.y, spine.z, 255, 0, 0, 255)
					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, spine.x, spine.y, spine.z, neck.x, neck.y, neck.z, 255, 0, 0, 255)
					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, neck.x, neck.y, neck.z, head.x, head.y, head.z, 255, 0, 0, 255)
					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, head.x, head.y, head.z, leftEye.x, leftEye.y, leftEye.z, 255, 0, 0, 255)
					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, head.x, head.y, head.z, rightEye.x, rightEye.y, rightEye.z, 255, 0, 0, 255)
					local leftFoot = GetPedBoneCoords(ply, 45454, 0, 0, 0)
					local leftThigh = GetPedBoneCoords(ply, 65478, 0, 0, 0)
					local leftToes = GetPedBoneCoords(ply, 53081, 0, 0, 0)
					local leftKnee = GetPedBoneCoords(ply, 22173, 0, 0, 0)
					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, leftKnee.x, leftKnee.y, leftKnee.z, leftThigh.x, leftThigh.y, leftThigh.z, 255, 0, 0, 255)
					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, leftToes.x, leftToes.y, leftToes.z, leftFoot.x, leftFoot.y, leftFoot.z, 255, 0, 0, 255)
					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, leftFoot.x, leftFoot.y, leftFoot.z, leftKnee.x, leftKnee.y, leftKnee.z, 255, 0, 0, 255)
					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, leftThigh.x, leftThigh.y, leftThigh.z, pelvis.x, pelvis.y, pelvis.z, 255, 0, 0, 255)
					local rightFoot = GetPedBoneCoords(ply, 52301, 0, 0, 0)
					local rightThigh = GetPedBoneCoords(ply, 51826, 0, 0, 0)
					local rightToes = GetPedBoneCoords(ply, 20781, 0, 0, 0)
					local rightKnee = GetPedBoneCoords(ply, 16335, 0, 0, 0)
					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, rightKnee.x, rightKnee.y, rightKnee.z, rightThigh.x, rightThigh.y, rightThigh.z, 255, 0, 0, 255)
					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, rightToes.x, rightToes.y, rightToes.z, rightFoot.x, rightFoot.y, rightFoot.z, 255, 0, 0, 255)
					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, rightFoot.x, rightFoot.y, rightFoot.z, rightKnee.x, rightKnee.y, rightKnee.z, 255, 0, 0, 255)
					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, rightThigh.x, rightThigh.y, rightThigh.z, pelvis.x, pelvis.y, pelvis.z, 255, 0, 0, 255)
					local leftHand = GetPedBoneCoords(ply, 34606, 0, 0, 0)
					local leftFinger1 = GetPedBoneCoords(ply, 41403, 0, 0, 0)
					local leftFinger2 = GetPedBoneCoords(ply, 41323, 0, 0, 0)
					local leftFinger3 = GetPedBoneCoords(ply, 41307, 0, 0, 0)
					local leftFinger4 = GetPedBoneCoords(ply, 41355, 0, 0, 0)
					local leftFinger5 = GetPedBoneCoords(ply, 41339, 0, 0, 0)
					local leftForearm = GetPedBoneCoords(ply, 53675, 0, 0, 0)
					local leftUpperarm = GetPedBoneCoords(ply, 37873, 0, 0, 0)
					local leftClavicle = GetPedBoneCoords(ply, 30226, 0, 0, 0)
					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, leftHand.x, leftHand.y, leftHand.z, leftFinger1.x, leftFinger1.y, leftFinger1.z, 255, 0, 0, 255)
					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, leftHand.x, leftHand.y, leftHand.z, leftFinger2.x, leftFinger2.y, leftFinger2.z, 255, 0, 0, 255)
					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, leftHand.x, leftHand.y, leftHand.z, leftFinger3.x, leftFinger3.y, leftFinger3.z, 255, 0, 0, 255)
					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, leftHand.x, leftHand.y, leftHand.z, leftFinger4.x, leftFinger4.y, leftFinger4.z, 255, 0, 0, 255)
					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, leftHand.x, leftHand.y, leftHand.z, leftFinger5.x, leftFinger5.y, leftFinger5.z, 255, 0, 0, 255)
					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, leftHand.x, leftHand.y, leftHand.z, leftForearm.x, leftForearm.y, leftForearm.z, 255, 0, 0, 255)
					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, leftForearm.x, leftForearm.y, leftForearm.z, leftUpperarm.x, leftUpperarm.y, leftUpperarm.z, 255, 0, 0, 255)
					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, leftUpperarm.x, leftUpperarm.y, leftUpperarm.z, leftClavicle.x, leftClavicle.y, leftClavicle.z, 255, 0, 0, 255)
					local rightHand = GetPedBoneCoords(ply, 22798, 0, 0, 0)
					local rightFinger1 = GetPedBoneCoords(ply, 16827, 0, 0, 0)
					local rightFinger2 = GetPedBoneCoords(ply, 16747, 0, 0, 0)
					local rightFinger3 = GetPedBoneCoords(ply, 16731, 0, 0, 0)
					local rightFinger4 = GetPedBoneCoords(ply, 16779, 0, 0, 0)
					local rightFinger5 = GetPedBoneCoords(ply, 16763, 0, 0, 0)
					local rightForearm = GetPedBoneCoords(ply, 54187, 0, 0, 0)
					local rightUpperarm = GetPedBoneCoords(ply, 46065, 0, 0, 0)
					local rightClavicle = GetPedBoneCoords(ply, 54802, 0, 0, 0)
					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, rightHand.x, rightHand.y, rightHand.z, rightFinger1.x, rightFinger1.y, rightFinger1.z, 255, 0, 0, 255)
					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, rightHand.x, rightHand.y, rightHand.z, rightFinger2.x, rightFinger2.y, rightFinger2.z, 255, 0, 0, 255)
					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, rightHand.x, rightHand.y, rightHand.z, rightFinger3.x, rightFinger3.y, rightFinger3.z, 255, 0, 0, 255)
					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, rightHand.x, rightHand.y, rightHand.z, rightFinger4.x, rightFinger4.y, rightFinger4.z, 255, 0, 0, 255)
					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, rightHand.x, rightHand.y, rightHand.z, rightFinger5.x, rightFinger5.y, rightFinger5.z, 255, 0, 0, 255)
					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, rightHand.x, rightHand.y, rightHand.z, rightForearm.x, rightForearm.y, rightForearm.z, 255, 0, 0, 255)
					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, rightForearm.x, rightForearm.y, rightForearm.z, rightUpperarm.x, rightUpperarm.y, rightUpperarm.z, 255, 0, 0, 255)
					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, rightUpperarm.x, rightUpperarm.y, rightUpperarm.z, rightClavicle.x, rightClavicle.y, rightClavicle.z, 255, 0, 0, 255)

					Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, leftClavicle.x, leftClavicle.y, leftClavicle.z, rightClavicle.x, rightClavicle.y, rightClavicle.z, 255, 0, 0, 255)
				end
			else
				Citizen.Wait(1000)
			end
		end
	end
)

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

local adminModeOn = false

RegisterCommand(
	"adminmode",
	function()
		if cAPI.hasGroup("admin") then
			adminModeOn = not adminModeOn
			cAPI.notify("error", "ADMIN :o")
		else
			cAPI.notify("error", "Não não")
		end
	end,
	false
)
