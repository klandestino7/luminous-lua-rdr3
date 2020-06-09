local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

-- // 0x255A5EF65EDA9167
-- BOOL NETWORK_IS_PLAYER_IN_MY_SESSION(int player) // NETWORK_IS_PLAYER_ID_FREE // NETWORK_IS_PLAYER_ID_VALID

-- // 0x5A91BCEF74944E93
-- void NETWORK_ADD_PLAYER_TO_MY_SESSION?

-- PEDSHOT
-- 0x27B1AE4D8C652F08
-- 0xE59F4924BD3A718D

-- 0x8FB7C254CFCBF78E
-- NETWORK_SESSION_SETMATCHMAKING_GROUP?

-- 0xE72E5C1289BD1F40
-- NETWORK_SET_SESSION_PLAYERS? // MATCHMAKING

-- 0xA4484173759749B1
-- NETWORK_CL // NETWORK_FOLLOW_INVITE?

-- 0xA4484173759749B1
-- NETWORK_CLEAR_MY_SESSION?

-- 0x39A8EF7AF29A192C
-- NETWORK_SESSION_OPEN? // NETWORK_SESSION_SETMATCHMAKING

-- // 0xE47001B7CB8B98AE
-- NetworkSendTransitionGamerInstruction

RegisterCommand(
	"teste",
	function(source, args, rawCommand)
		-- Citizen.InvokeNative(0xE72E5C1289BD1F40, 1, 0)
		-- Citizen.InvokeNative(0x309BBEBEA8A3986C, 1, 0)

		-- NETWORK::_0x : l128

		-- local networkHandle = NetworkHandleFromPlayer(PlayerPedId())
		-- print(networkHandle)
		-- local isPlayerIdValid = Citizen.InvokeNative(0x255A5EF65EDA9167, 31)
		-- print(PlayerId(), isPlayerIdValid)

		-- Citizen.InvokeNative(0xFD4272A137703449)

		-- print(NetworkGetPlayerIndex(player))

		-- Citizen.InvokeNative(0x5A91BCEF74944E93, PlayerId(), 30.0)
		-- Citizen.InvokeNative(0x51951DE06C0D1C40, PlayerId(), 1)
		-- Citizen.InvokeNative(0xA4484173759749B1)
		-- print(NetworkIsSessionActive())
		--
		-- 	Global_1572887->f_342.f_4 = 4;
		-- Global_1572887->f_342.f_21 = iParam0; // 1,
		-- Global_1572887->f_342.f_5 = 18;                   -- IS_PRIVATE
		-- Global_1572887->f_342.f_6 = 0;
		-- Global_1572887->f_342.f_25 = 0;
		-- Global_1572887->f_342.f_26 = 0;

		-- for i = 8, 8 * 32, 8 do
		-- 	print(i)
		-- end

		-- exports.research:DataViewNetowrk()

		-- local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 0.0)
		-- local _, groundZ, normal = GetGroundZAndNormalFor_3dCoord(coords.x, coords.y, coords.z)
		-- coords = vec3(coords.xy, groundZ)

		-- TaskSwapFishingBait(PlayerPedId(), "p_baitWorm01x", 1)
		Citizen.InvokeNative(0x9B0C7FA063E67629, PlayerPedId(), "p_baitWorm01x", 0, 1)

		-- local objHash = GetHashKey("P_CARCASSHANGFISH01A")
		-- if IsModelValid(objHash) then
		-- 	if not HasModelLoaded(objHash) then
		-- 		RequestModel(objHash)
		-- 		while not HasModelLoaded(objHash) do
		-- 			Citizen.Wait(10)
		-- 		end
		-- 	end
		-- end

		-- WB_HERB_ALASKAN_GINSENG

		-- S_INDIANTOBACCO01X
		-- WB_HERB_INDIAN_TOBACCO

		-- 		WB_HERB_AMERICAN_GINSENG, 6
		-- WB_HERB_BLACK_CURRANT, 6
		-- WB_HERB_BURDOCK_ROOT, 6
		-- WB_HERB_BURDOCK_ROOT_SINGLE, 2
		-- WB_HERB_DESERT_SAGE, 6
		-- WB_HERB_ENGLISH_MACE, 6
		-- WB_HERB_ENGLISH_MACE_SINGLE, 2
		-- WB_HERB_GOLDEN_CURRANT, 6
		-- WB_HERB_HUMMINGBIRD_SAGE, 6
		-- WB_HERB_INDIAN_TOBACCO, 6
		-- WB_HERB_MILKWEED, 6
		-- WB_HERB_MILKWEED_SINGLE, 2
		-- WB_HERB_OLEANDER_SAGE, 6
		-- WB_HERB_OLEANDER_SAGE_SINGLE, 2
		-- WB_HERB_PRAIRIE_POPPY, 6

		-- 		S_INV_WILDCARROT01BX, 4
		-- S_INV_WILDCARROT01CX, 4
		-- S_INV_WILDCARROT01DX, 4
		-- S_INV_WILDCARROT01X, 4

		-- local obj = CreateObject("S_INDIANTOBACCO01X", coords, 1, 1, 1)

		-- Wait(1000)

		-- local scenario_type = 0xB5800B30

		-- print(scenario_type)

		-- -- // 0x19A6BE7D9C6884D3
		-- -- void _REQUEST_SCENARIO_TYPE(Hash scenarioType, int p1, Hash p2, Hash p3)
		-- Citizen.InvokeNative(0x19A6BE7D9C6884D3, scenario_type, 3, GetEntityModel(obj), 0)
		-- while not Citizen.InvokeNative(0x9427C94D2E4094A4, scenario_type, 0) do
		-- 	print("scenario not loaded")
		-- 	Wait(10)
		-- end
		-- -- func_1963

		-- local scenario = Citizen.InvokeNative(0x94B745CE41DB58A1, scenario_type, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), 0.0, 0, 1)
		-- local scenario = Citizen.InvokeNative(0x794AB1379A74064D, scenario_type, obj, GetEntityHeading(obj), 0.0, 0, 0)
		-- TaskUseScenarioPoint(PlayerPedId(), scenario, "", -1.0, 0, 0, 0, 0, 0)

		-- Citizen.InvokeNative(0xEEE4829304F93EEE, scenario, true)

		-- print(scenario)

		-- Wait(250)

		-- local scenario = Citizen.InvokeNative(0x94B745CE41DB58A1, GetHashKey("WORLD_FLOURISH_TABLE_SMASH"), coords, GetEntityHeading(PlayerPedId()), 0.0, 0, 1)
		-- local scenario2 = Citizen.InvokeNative(0x94B745CE41DB58A1, GetHashKey("WORLD_PLAYER_CHORES_SACK_PUT_DOWN_1"), coords, GetEntityHeading(PlayerPedId()), 0.0, 0, 1)

		-- TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_HUMAN_STERNGUY_IDLES"), 0, true, 0, 0, 0)
		-- Citizen.InvokeNative(0x19A6BE7D9C6884D3, GetHashKey("WB_HERB_INDIAN_TOBACCO"), 15, 0, 0)
		-- if (Citizen.InvokeNative(0x9427C94D2E4094A4, GetHashKey("WB_HERB_INDIAN_TOBACCO"), 0)) then

		-- // 0x2056AB38DF06825C
		-- void _SET_SCENARIO_POINT_COORDS(int scenario, number xPos, number yPos, number zPos, BOOL p4)

		-- // 0xD3A0DA8F91612C6E
		-- void _SET_SCENARIO_POINT_HEADING(int scenario, float heading, BOOL p2)

		-- // 0xB8E213D02F37947D
		-- void _GET_SCENARIO_POINTS_INSIDE_VOLUME
		--
		-- local ojb = CreateObject("P_CABINET13X", coords, true, true, true)

		-- local wb = GetHashKey(args[1])
		-- wb = GetHashKey("HERB_CREEPING_THYME")

		-- -- WB_HERB_AMERICAN_GINSENG
		-- if not Citizen.InvokeNative(0x9427C94D2E4094A4, wb, 0) then
		-- 	Citizen.InvokeNative(0x19A6BE7D9C6884D3, wb, 15, 0, 0)
		-- 	print("requested")
		-- end
		-- -- print(Citizen.InvokeNative(0x9427C94D2E4094A4, wb, 0))
		-- Citizen.InvokeNative(0xD00E50E673802D71, wb, true)
		-- local scenario = Citizen.InvokeNative(0x94B745CE41DB58A1, wb, coords, 0.0, 0.0, 0, 1)
		-- -- local scenario = Citizen.InvokeNative(0x794AB1379A74064D, ojb, wb, 0.0, -0.25, 0.0, 0, 0, 0, 0)

		-- print(scenario)

		-- TaskUseScenarioPoint(PlayerPedId(), scenario, "", -1.0, true, 0, 0, 0, true)
	end
)

RegisterNetEvent("VP:EVENTS:PedFinishedGatheringPed")
RegisterNetEvent("VP:EVENTS:PedWhistle")

Citizen.CreateThread(
	function()
		-- print("PLAYERPED: " .. PlayerPedId())

		-- print(" ")

		-- local obj = CreateObject("p_cs_woodPile01x", GetEntityCoords(PlayerPedId()), 1, 1, 1)

		-- Citizen.InvokeNative(0xF0B4F759F35CC7F5, obj, GetHashKey("FIREWOOD"), 0, 0, 0)
		-- Citizen.InvokeNative(0x18FF3110CF47115D, obj, 2, true)
		-- Citizen.InvokeNative(0x18FF3110CF47115D, obj, 4, true)

		while true do
			Citizen.Wait(0)

			local size = GetNumberOfEvents(0)

			if size > 0 then
				for i = 0, size - 1 do
					local eventAtIndex = GetEventAtIndex(0, i)

					-- print(eventAtIndex)

					if eventAtIndex == 1327216456 then
						-- [bit 0] = Ped who is whistling
						-- print("EVENT_PED_WHISTLE", PlayerPedId(), i)
						-- exports["vp_admin"]:js_teste_native(0, i, 2)

						local view = exports["research"]:DataViewNativeGetEventData(0, i, 2)
						TriggerEvent("VP:EVENTS:PedWhistle", view["0"], view["2"])
					elseif eventAtIndex == GetHashKey("EVENT_PLAYER_PROMPT_TRIGGERED") then
						-- exports["vp_admin"]:js_teste_native(0, i, 10)
						-- exports["research"]:DataViewNativeGetEventData(0, i, 10)
						-- Wait(1000)
						print("EVENT_PLAYER_PROMPT_TRIGGERED", PlayerPedId(), i)
					elseif eventAtIndex == -1246119244 then
						-- [bit 0] Ped -- Mostly the animal being interacted
						-- [bit 2] Ped -- Mostly the one who is interacting
						-- [bit 4] Interaction
						-- print(GetHashKey("INTERACTION_POSITIVELONG"), GetHashKey("INTERACTION_POSITIVESHORT"), GetHashKey("INTERACTION_CANCEL"), GetHashKey("INTERACTION_COMPLETE"))
						-- print("EVENT_PED_ANIMAL_INTERACTION", PlayerPedId(), i)
						-- exports["vp_admin"]:js_teste_native(0, i, 3)
						-- exports["research"]:DataViewNativeGetEventData(0, i, 3)
					elseif eventAtIndex == -2091944374 then
						-- 24 Player
						-- 25 Lotter
						-- print("EVENT_PLAYER_LOOT_PED")
						-- exports["vp_admin"]:js_teste_native(0, i, 26)
						-- exports["research"]:DataViewNativeGetEventData(0, i, 26)
					elseif eventAtIndex == -1511724297 then
						-- exports["vp_admin"]:js_teste_native(0, i, 36)
						-- print("EVENT_PLAYER_LOOT_?")
					elseif eventAtIndex == 1352063587 then
						-- print("EVENT | PED_INTERACTION_RANSACK_SCENARIO", Citizen.InvokeNative(0xD04241BBF6D03A5E, PlayerPedId()))
						-- local view = exports["research"]:DataViewNativeGetEventData(0, i, 4)
						-- local pedInteracting = view["0"]
						-- local containerEntity = view["2"]
						-- local containerScenario = view["4"]
						-- local isClosing = view["6"]
						-- print(pedInteracting, containerEntity, containerScenario, isClosing)
					elseif eventAtIndex == 1208357138 then
						-- local carriableEntity = view["0"]
						-- local pedCarrier
						-- print("EVENT | Carriable state change / Carriable carrier changes?")
						-- exports["research"]:DataViewNativeGetEventData(0, i, 5)
					elseif eventAtIndex == -687266558 then
						-- index\bitIndex
						-- 1\0: Entity
						-- 3\3: Entity
						-- print("EVENT | PED_STARTS_CARRYING")
						-- exports["research"]:DataViewNativeGetEventData(0, i, 4)
					elseif eventAtIndex == 1376140891 then
						-- 1\0: Entity/Ped/Player Ped
						-- 2\2: Entity/Ped carriable
						-- 3\3: BOOL, used to determine theft?
						--[[

						]]
						-- print("EVENT | PED_FINISHED_GATHERING_PED *totally not real name*")
						local view = exports["research"]:DataViewNativeGetEventData(0, i, 3)
						local ped = view["0"]
						local pedGathered = view["2"]
						local bool_unk = view["4"]

						TriggerEvent("VP:EVENTS:PedFinishedGatheringPed", ped, pedGathered, bool_unk)
					elseif eventAtIndex == 218595333 then
					-- print("Horse broken")
					end

					-- if eventAtIndex == 2099179610 then
					-- 	print("EVENT | Has looteable nearby?")
					-- 	exports["research"]:DataViewNativeGetEventData(0, i, 2)
					-- end
				end
			end

			-- size = GetNumberOfEvents(2)

			-- if size > 0 then
			-- 	for i = 0, size - 1 do
			-- 		local eventAtIndex = GetEventAtIndex(2, i)
			-- 		-- if eventAtIndex == -45008988 then
			-- 		-- 	print("enter")
			-- 		-- end
			-- 		if eventAtIndex == -456923784 then
			-- 			print("openchest / left scenario")
			-- 			-- bit 1 scenarioid/type
			-- 			-- bit2 ped
			-- 			SetEventFlagForDeletion(2, i, 1)
			-- 		-- exports["vp_admin"]:js_teste_native(2, i, 2)
			-- 		end
			-- 		if eventAtIndex == -843555838 then
			-- 			print("wha")
			-- 		end
			-- 	end
			-- end
		end
	end
)

local myFish
local lastFishCoords

RegisterCommand(
	"hook",
	function(source, args, rawCommand)
		Citizen.InvokeNative(0xF0FBF193F1F5C0EA, myFish)
		SetEntityInvincible(myFish, true)
		SetPedConfigFlag(myFish, 17, true)
		Citizen.InvokeNative(0x1A52076D26E09004, PlayerPedId(), myFish)

		--[[
			CRIAR UM OBJETO DE BAIT
			SETAR COMO O BAIT
			E PEGAR OS PEIXES PROXIMO DELE
		]]

	end
)

RegisterCommand(
	"fish",
	function(source, args, rawCommand)
		local r = {
			"A_C_FISHBLUEGIL_01_SM",
			"A_C_FISHBULLHEADCAT_01_SM",
			"A_C_FISHCHAINPICKEREL_01_SM",
			"A_C_FISHCHANNELCATFISH_01_LG",
			"A_C_FISHLAKESTURGEON_01_LG",
			"A_C_FISHLARGEMOUTHBASS_01_MS",
			"A_C_FISHLONGNOSEGAR_01_LG",
			"A_C_FISHMUSKIE_01_LG",
			"A_C_FISHNORTHERNPIKE_01_LG",
			"A_C_FISHPERCH_01_SM",
			"A_C_FISHREDFINPICKEREL_01_SM",
			"A_C_FISHROCKBASS_01_SM",
			"A_C_FISHSMALLMOUTHBASS_01_MS",
			"A_C_FISHSALMONSOCKEYE_01_MS",
			"A_C_FISHRAINBOWTROUT_01_MS"
		}

		local pedModel = r[math.random(1, #r)]

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

		local plped = PlayerPedId()
		local forward = GetEntityForwardVector(plped)
		local c = GetEntityCoords(plped) + (forward * 10.0)

		local ped = CreatePed(pedModelHash, c, GetEntityHeading(plped), 1, 0)
		Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
		Citizen.InvokeNative(0x58A850EAEE20FAA3, ped)
		myFish = ped
		lastFishCoords = c
	end
)

local p1
local p2
local p3
local promptGroup = GetRandomIntInRange(0, 0xffffff)
local prompt_group_name = CreateVarString(10, "LITERAL_STRING", "Pesca")

local carriedOnce = false

print(1.0 / (1.0 + 0.0))

-- Citizen.CreateThread(
-- 	function()
-- 		Citizen.InvokeNative(0xF66090013DE648D5, "MGFSH")
-- 		Citizen.InvokeNative(0x8BC7C1F929D07BF3, GetHashKey("HUD_CTX_FISHING"))
-- 		prompts()

-- 		Citizen.InvokeNative(0xA63FCAD3A6FEC6D2, PlayerId(), 1) -- ENABLE_EAGLE_EYE(PLayer player, BOOL, enable)
-- 		Citizen.InvokeNative(0x95EE1DEE1DCD9070, PlayerId(), 1) -- ENABLE_DEADEYE(Player player, BOOL enable)
-- 		Citizen.InvokeNative(0x2C41D93F550D5E37, PlayerId(), 0) -- ENABLE_?(Player player, BOOL enable) /*default eagleeye when 0, green eagleye when wrong params */

-- 		Citizen.InvokeNative(0x28A13BF6B05C3D83, PlayerId(), 1) -- SETS DEADEYE/EAGLEEYE INFINITE
-- 		-- Citizen.InvokeNative(0x1710BC33CFB83634, PlayerId()) -- SET_ACTIVE_DEADEYE
-- 		-- true: transition
-- 		-- Citizen.InvokeNative(0x64FF4BF9AF59E139, PlayerId(), 0) -- SET_*_DEADEYE_DISABLED
-- 		-- Citizen.InvokeNative(0x06E1FB78B1E59CA5, PlayerId(), 1)
-- 		-- Citizen.InvokeNative(0xCE285A4413B00B7F, PlayerId(), 0)

-- 		-- Citizen.InvokeNative(0xBC02B3D151D3859F, PlayerId(), 1)
-- 		-- Citizen.InvokeNative(0x62ED71E133B6C9F1, PlayerId(), 0, 255, 255)

-- 		while true do
-- 			-- Citizen.InvokeNative(0x11A7FF918EF6BC66, PlayerId(), 0.0)

-- 			Citizen.Wait(0)

-- 			drawcircle()

-- 			-- PromptSetActiveGroupThisFrame(promptGroup, prompt_group_name)

-- 			if IsControlPressed(0, GetHashKey("INPUT_AIM")) then
-- 				if IsControlJustPressed(0, GetHashKey("INPUT_ATTACK")) then


-- 					-- 0x8AC1D721B2097B6E

-- 					-- local a =	Citizen.InvokeNative(0xF3735ACD11ACD500, PlayerPedId(), myFish)
-- 					-- IS_FISH_HOOKED?
-- 					-- Citizen.InvokeNative(0xF3735ACD11ACD501, PlayerPedId(), 0)
-- 					-- exports['research']:DataViewNetowrk();
-- 					-- -- print(a)
-- 					print('yes')
-- 					TaskGoToEntity(myFish, PlayerPedId(), -1, 0.1, 1.5, 0.1, 1)
-- 				end
-- 			end

-- 			if PromptIsJustPressed(p3) then
-- 				-- 0x5952DFA38FA529FE
-- 				Citizen.InvokeNative(0x2208438012482A1A, PlayerPedId(), false, false)
-- 			end

-- 			-- print(IsEntityDead(myFish), IsEntityAttached(myFish), IsEntityInWater(myFish))

-- 			if myFish ~= nil then
-- 				Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF,GetEntityCoords(PlayerPedId()), GetEntityCoords(myFish), 255, 255, 0, 255)
-- 				Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, GetEntityCoords(myFish), lastFishCoords, 255, 0, 255, 255)
-- 				-- if carriedOnce == false then
-- 				-- 	if not Citizen.InvokeNative(0xA911EE21EDF69DAF, PlayerPedId()) and IsEntityDead(myFish) and not IsEntityInWater(myFish) then
-- 				-- 		DisableControlAction(0, GetHashKey("INPUT_AIM"), true)
-- 				-- 		TaskPickupCarriableEntity(PlayerPedId(), myFish)
-- 				-- 		carriedOnce = true
-- 				-- 	end
-- 				-- end

-- 				local rand = math.random(100)

-- 				if rand <= 5 then
-- 					print('fleeing')
-- 					TaskSmartFleeCoord(myFish, GetEntityCoords(PlayerPedId()), 40.0, 20000, 8, 1077936128)
-- 				end
-- 			end

-- 			if HasAnimEventFired(PlayerPedId(), -1947554776) then
-- 				print("fired")
-- 			end
-- 		end
-- 	end
-- )

-- 0 : MGFSH_CTX_GRIP
-- 1 : MGFSH_CTX_RESET & MGFSH_CTX_CUT_LINE
-- 2 : MGFSH_CTX_HOOK
-- 3 : MGFSH_CTX_REEL_LURE & MGFSH_CTX_REEL_IN
-- 4 : MGFSH_CTX_CONTROL
-- 5 : MGFSH_CTX_THROW_BACK
-- 6 : MGFSH_CTX_KEEP
-- 7 : MGFSH_CTX_CHOOSE
-- 8 : MGFSH_CTX_EQUIP

-- func_234 -- IS_PROMPT_VALID
-- func_408 -- IS_PROMPT_JUST_PRESSED

-- WATER::_0xF0FBF193F1F5C0EA(Ped fish)

function prompts()
	-- 0x05CA7C52
	-- 0x6319DB71
	-- 0xA65EBAB4
	-- 0xDEB34313

	p1 = PromptRegisterBegin()
	Citizen.InvokeNative(0xF4A5C4509BF923B1, p1, 0)
	PromptSetControlAction(p1, 0xCEFD9220)
	PromptSetText(p1, "MGFSH_CTX_GRIP")
	PromptSetEnabled(p1, 1)
	PromptSetVisible(p1, 1)
	-- PromptSetStandardMode(p1, 1)
	PromptSetHoldIndefinitelyMode(p1, true)
	-- PromptSetGroup(p1, promptGroup)
	PromptRegisterEnd(p1)
	PromptSetTag(p1, "CTX_GRIP")

	p2 = PromptRegisterBegin()
	Citizen.InvokeNative(0xF4A5C4509BF923B1, p2, 0)
	PromptSetControlAction(p2, 0x05CA7C52)
	PromptSetText(p2, "MGFSH_CTX_HOOK")
	PromptSetEnabled(p2, 1)
	PromptSetVisible(p2, 1)
	PromptSetStandardMode(p2, 0)
	-- PromptSetGroup(p2, promptGroup)
	PromptRegisterEnd(p2)

	p3 = PromptRegisterBegin()
	Citizen.InvokeNative(0xF4A5C4509BF923B1, p3, 0)
	PromptSetControlAction(p3, 0x6319DB71)
	PromptSetText(p3, "MGFSH_CTX_REEL_IN")
	PromptSetEnabled(p3, 1)
	PromptSetVisible(p3, 1)
	-- PromptSetRotateMode(p3, 0.0, 0)
	PromptSetAttribute(p3, 10, 1)
	PromptSetAttribute(p3, 11, 1)
	PromptSetAttribute(p3, 18, 1)
	PromptSetStandardMode(p3, 0)
	-- PromptSetGroup(p3, promptGroup)
	PromptRegisterEnd(p3)
	PromptSetTag(p3, "CTX_REEL")

	-- func_326
end

function delprompts()
	PromptDelete(p1)
	PromptDelete(p2)
	PromptDelete(p3)
	DeletePed(myFish)
end

AddEventHandler(
	"onResourceStop",
	function(resourceName)
		if GetCurrentResourceName() == resourceName then
			delprompts()
		end
	end
)

function drawcircle()
	local center = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 15.0, 0.0)

			local r = 10.0

			local Cx = center.x
			local Cy = center.y
			local z = center.z

			X_deg0 = Cx + (r * math.cos(0))
			Y_deg0 = Cy + (r * math.sin(0))

			-- Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF,GetEntityCoords(PlayerPedId()), center, 255, 0, 0, 255)

			for i = 0, 360, 45 do
				i = math.rad(i)
				local X_deg0 = Cx + (r * math.cos(i))
				local Y_deg0 = Cy + (r * math.sin(i))

				local Vec = vec3(X_deg0, Y_deg0, z)

				-- local _, groundZ, _ = GetGroundZAndNormalFor_3dCoord(camVec.x, camVec.y, camVec.z)

				-- if math.abs(z - groundZ) < minHeightAboveGround then
				-- 	Vec = vec3(Vec)
				-- end

				Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF,center, Vec, 255, 0, 0, 255)
			end
end

-- 0x14169FA823679E41

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
