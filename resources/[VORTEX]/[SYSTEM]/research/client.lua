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
		-- SetObjectTextureVariation(5765379, 5)

		-- Citizen.InvokeNative(0xB35370D5353995CB,PlayerPedId(), GetHashKey("MP_MOONSHINE_DRINKING_SOBER_TABLE_LH_HOLD"), 1048576000)

		-- local comp = GetHashKey("COMPOSITE_LOOTABLE_VULTURE_EGG_DEF")
		-- Citizen.InvokeNative(0x73F0D0327BFA0812, comp)
		-- while not Citizen.InvokeNative(0x5E5D96BE25E9DF68, comp) do
		-- 	Citizen.Wait(10)
		-- end
		-- Citizen.InvokeNative(0x7563CBCA99253D1A, PlayerId(), GetHashKey("BLIP_MP_ROLE_COLLECTOR_ILO"))
		-- Citizen.InvokeNative(0x62ED71E133B6C9F1, PlayerId(), 255, 255, 0)
		-- exports['research']:DataViewNetowrk(comp)
		-- local w = Citizen.InvokeNative(0x5B4BBE80AD5972DC, comp, GetEntityCoords(PlayerPedId()), 0.0, 0, 0, -1)
		-- print(w)
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
		-- Citizen.InvokeNative(0x9B0C7FA063E67629, PlayerPedId(), "p_baitWorm01x", 0, 1)
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
		-- -- void _REQUEST_SCENARIO_TYPE(Hash scenarioType, int prompt_grip, Hash prompt_hook, Hash prompt_reel_in)
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
		-- void _SET_SCENARIO_POINT_HEADING(int scenario, float heading, BOOL prompt_hook)
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

RegisterNetEvent("VP:EVENTS:PedFinishedGatheringEntity")
RegisterNetEvent("VP:EVENTS:PedWhistle")
RegisterNetEvent("VP:EVENTS:PedInteractionRansackScenario")

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

					-- if eventAtIndex ~= 1626561060 and eventAtIndex ~= 735942751 then
					-- print(eventAtIndex)
					-- end

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
						local view = exports["research"]:DataViewNativeGetEventData(0, i, 4)
						local pedInteracting = view["0"]
						local containerEntity = view["2"]
						local containerScenario = view["4"]
						local isClosing = view["6"]
						TriggerEvent("VP:EVENTS:PedInteractionRansackScenario", pedInteracting, containerEntity, containerScenario, isClosing)
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
						local entity = view["2"]
						local bool_unk = view["4"]

						print(ped, entity, bool_unk, IsEntityAPed(entity))
						print(GetEntityModel(entity))

						TriggerEvent("VP:EVENTS:PedFinishedGatheringEntity", ped, entity, bool_unk)
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

-- RegisterCommand(
-- 	"bait",
-- 	function(source, args, raw)
-- 		Citizen.InvokeNative(0x9B0C7FA063E67629, PlayerPedId(), "p_baitWorm01x", 0, 1)
-- 	end,
-- 	false
-- )

local myFish
local lastFishCoords

-- RegisterCommand(
-- 	"hook",
-- 	function(source, args, rawCommand)
-- 		Citizen.InvokeNative(0xF0FBF193F1F5C0EA, myFish)
-- 		SetEntityInvincible(myFish, true)
-- 		SetPedConfigFlag(myFish, 17, true)
-- 		Citizen.InvokeNative(0x1A52076D26E09004, PlayerPedId(), myFish)

-- 		--[[
-- 			CRIAR UM OBJETO DE BAIT
-- 			SETAR COMO O BAIT
-- 			E PEGAR OS PEIXES PROXIMO DELE
-- 		]]
-- 	end
-- )

-- RegisterCommand(
-- 	"fish",
-- 	function(source, args, rawCommand)
-- 		local r = {
-- 			"A_C_FISHBLUEGIL_01_SM",
-- 			"A_C_FISHBULLHEADCAT_01_SM",
-- 			"A_C_FISHCHAINPICKEREL_01_SM",
-- 			"A_C_FISHCHANNELCATFISH_01_LG",
-- 			"A_C_FISHLAKESTURGEON_01_LG",
-- 			"A_C_FISHLARGEMOUTHBASS_01_MS",
-- 			"A_C_FISHLONGNOSEGAR_01_LG",
-- 			"A_C_FISHMUSKIE_01_LG",
-- 			"A_C_FISHNORTHERNPIKE_01_LG",
-- 			"A_C_FISHPERCH_01_SM",
-- 			"A_C_FISHREDFINPICKEREL_01_SM",
-- 			"A_C_FISHROCKBASS_01_SM",
-- 			"A_C_FISHSMALLMOUTHBASS_01_MS",
-- 			"A_C_FISHSALMONSOCKEYE_01_MS",
-- 			"A_C_FISHRAINBOWTROUT_01_MS"
-- 		}

-- 		local pedModel = r[math.random(1, #r)]

-- 		local pedModelHash = GetHashKey(pedModel)
-- 		if not IsModelValid(pedModelHash) then
-- 			print("model is not valid")
-- 			return
-- 		end

-- 		if not HasModelLoaded(pedModelHash) then
-- 			RequestModel(pedModelHash)
-- 			while not HasModelLoaded(pedModelHash) do
-- 				Citizen.Wait(10)
-- 			end
-- 		end

-- 		local plped = PlayerPedId()
-- 		local forward = GetEntityForwardVector(plped)
-- 		local c = GetEntityCoords(plped) + (forward * 10.0)

-- 		local ped = CreatePed(pedModelHash, c, GetEntityHeading(plped), 1, 0)
-- 		Citizen.InvokeNative(0x283978A15512B2FE, ped, true)
-- 		Citizen.InvokeNative(0x58A850EAEE20FAA3, ped)
-- 		myFish = ped
-- 		lastFishCoords = c
-- 	end
-- )

local prompt_grip
local prompt_hook
local prompt_reel_in
local prompt_reset

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

-- 		RequestAnimDict("mini_games@fishing@shore")

-- 		-- RequestAnimDict("script_proc@bounty@riding_punch")
-- 		-- TaskPlayAnim(PlayerPedId(), "script_proc@bounty@riding_punch", "punch_player", 4.0, -4.0, -1, 24, 0.0, false, 0, false, 0, false);
-- 		-- TaskPlayAnim(PlayerPedId(), "script_proc@bounty@riding_punch", "punch_ped", 4.0, -4.0, -1, 24, 0.0, false, 0, false, 0, false);

-- 		-- TaskPlayAnim(PlayerPedId(), "mini_games@fishing@shore", "reel_in", 4.0, -2.0, -1, 34, 0.0, false, 0, false, 0, false)

-- 		while true do
-- 			-- Citizen.InvokeNative(0x11A7FF918EF6BC66, PlayerId(), 0.0)

-- 			Citizen.Wait(0)

-- 			drawcircle()

-- 			-- PromptSetActiveGroupThisFrame(promptGroup, prompt_group_name)

-- 			-- if IsControlPressed(0, GetHashKey("INPUT_AIM")) then
-- 			-- 	if IsControlJustPressed(0, GetHashKey("INPUT_ATTACK")) then
-- 			-- 		-- 0x8AC1D721B2097B6E

-- 			-- 		-- local a =	Citizen.InvokeNative(0xF3735ACD11ACD500, PlayerPedId(), myFish)
-- 			-- 		-- IS_FISH_HOOKED?
-- 			-- 		-- Citizen.InvokeNative(0xF3735ACD11ACD501, PlayerPedId(), 0)
-- 			-- 		-- exports['research']:DataViewNetowrk();
-- 			-- 		-- -- print(a)
-- 			-- 		print("yes")
-- 			-- 		TaskGoToEntity(myFish, PlayerPedId(), -1, 0.1, 1.5, 0.1, 1)
-- 			-- 	end
-- 			-- end

-- 			if PromptIsJustPressed(prompt_reel_in) then

-- 				TaskPlayAnim(PlayerPedId(), "mini_games@fishing@shore", "reel_in", 1.0, -2.0, -1, 34, 0.0, false, 0, false, 0, false)

-- 				-- if HasAnimStartedPlaying(animDict, "missed_bite", 1000) then
-- 				-- 	print("started")
-- 				-- end
-- 			end

-- 			if PromptIsJustPressed(prompt_reset) then
-- 				TaskPlayAnim(PlayerPedId(), "mini_games@fishing@shore", "reel_in_fast_2_base_2h", 4.0, -2.0, -1, 0, 0.0, false, 0, false, 0, false)
-- 			end

-- 			if PromptIsJustPressed(prompt_hook) then
-- 				-- 0x5952DFA38FA529FE
-- 				-- Citizen.InvokeNative(0x2208438012482A1A, PlayerPedId(), false, false)
-- 				-- TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_HUMAN_STAND_FISHING"), 0, true, 0, 0, 0)

-- 				-- GRAPHICS::ANIMPOSTFX_PLAY("PlayerDrunk01_PassOut");

-- 				-- ATTACH_ROPE_TO_BONE
-- 				-- // PHYSICS::_0xC64E7A62632AD2FE(iLocal_881, Global_35, 0f, 0f, 0f, "SKEL_L_Finger12", 1, 0);
-- 				-- }

-- 				--[[
-- 					mini_games@fishing@shore
-- 					mini_games@fishing@shore@unhook@lrg_northern_pike
-- 					mini_games@fishing@shore@unhook@med
-- 					mini_games@fishing@shore@unhook@sml
-- 				]]
-- 				local animDict = "mini_games@fishing@shore"
-- 				RequestAnimDict(animDict)

-- 				while not HasAnimDictLoaded(animDict) do
-- 					Wait(10)
-- 				end

-- 				print("anim")
-- 				TaskPlayAnim(PlayerPedId(), animDict, "unhook_fish_med_keep", 4.0, -2.0, -1, 0, 0.0, false, 0, false, 0, false)

-- 				if HasAnimStartedPlaying(animDict, "missed_bite", 1000) then
-- 					print("started")
-- 				end
-- 				-- HasAnimStoppedPlaying

-- 				-- while IsEntityPlayingAnim(PlayerPedId(), dict, "enter", 1) do
-- 				-- 	Citizen.Wait(0)
-- 				-- end

-- 				Wait(5000)

-- 				-- TaskPlayAnim(PlayerPedId(), animDict, "throw_back", 4.0, -2.0, 5000, 0, 0.0, false, 0, false, 0, false)

-- 				-- Citizen.InvokeNative(0x58F7DB5BD8FA2288, PlayerPedId())
-- 				-- Citizen.InvokeNative(0x7B6A04F98BBAFB2C, PlayerPedId(), "Script_WNT4_DynamiteTerminals_Refactored", GetHashKey("MINI_GAMES@STORY@WNT4@DYNAMITE_TERMINALS@ARTHUR"), -633.139, -2513.614, 41.368, 0.0, 0.0, -32.83, 2, 1.0, 0, 0, 128, 0)
-- 				-- Citizen.InvokeNative(0x2208438012482A1A, PlayerPedId(), true, false)

-- 				local pole = GetCurrentPedWeaponEntityIndex(PlayerPedId(), 0)

-- 				print(pole)

-- 				animDict = "mini_games@fishing@shore_pole"
-- 				RequestAnimDict(animDict)

-- 				while not HasAnimDictLoaded(animDict) do
-- 					Wait(10)
-- 				end

-- 			-- TaskPlayAnim(pole, dict, "line_snapped_rt", 4.0, -2.0, 5000, 0, 0.0, false, 0, false, 0, false)
-- 			-- TaskPlayAnim(PlayerPedId(), dict, "line_snapped_rt", 4.0, -2.0, 5000, 0, 0.0, false, 0, false, 0, false)
-- 			end

-- 			-- print(IsEntityDead(myFish), IsEntityAttached(myFish), IsEntityInWater(myFish))

-- 			if myFish ~= nil then
-- 				Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, GetEntityCoords(PlayerPedId()), GetEntityCoords(myFish), 255, 255, 0, 255)
-- 				Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, GetEntityCoords(myFish), lastFishCoords, 255, 0, 255, 255)
-- 				-- if carriedOnce == false then
-- 				-- 	if not Citizen.InvokeNative(0xA911EE21EDF69DAF, PlayerPedId()) and IsEntityDead(myFish) and not IsEntityInWater(myFish) then
-- 				-- 		DisableControlAction(0, GetHashKey("INPUT_AIM"), true)
-- 				-- 		TaskPickupCarriableEntity(PlayerPedId(), myFish)
-- 				-- 		carriedOnce = true
-- 				-- 	end
-- 				-- end

-- 				local rand = math.random(100)

-- 				if rand <= 5 then
-- 					print("fleeing")
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

	prompt_grip = PromptRegisterBegin()
	Citizen.InvokeNative(0xF4A5C4509BF923B1, prompt_grip, 0)
	PromptSetControlAction(prompt_grip, 0xCEFD9220)
	PromptSetText(prompt_grip, "MGFSH_CTX_GRIP")
	PromptSetEnabled(prompt_grip, 1)
	PromptSetVisible(prompt_grip, 1)
	-- PromptSetStandardMode(prompt_grip, 1)
	PromptSetHoldIndefinitelyMode(prompt_grip, true)
	-- PromptSetGroup(prompt_grip, promptGroup)
	PromptRegisterEnd(prompt_grip)
	PromptSetTag(prompt_grip, "CTX_GRIP")

	prompt_hook = PromptRegisterBegin()
	Citizen.InvokeNative(0xF4A5C4509BF923B1, prompt_hook, 0)
	PromptSetControlAction(prompt_hook, 0x05CA7C52)
	PromptSetText(prompt_hook, "MGFSH_CTX_HOOK")
	PromptSetEnabled(prompt_hook, 1)
	PromptSetVisible(prompt_hook, 1)
	PromptSetStandardMode(prompt_hook, 0)
	-- PromptSetGroup(prompt_hook, promptGroup)
	PromptRegisterEnd(prompt_hook)

	prompt_reel_in = PromptRegisterBegin()
	Citizen.InvokeNative(0xF4A5C4509BF923B1, prompt_reel_in, 0)
	PromptSetControlAction(prompt_reel_in, 0x6319DB71)
	PromptSetText(prompt_reel_in, "MGFSH_CTX_REEL_IN")
	PromptSetEnabled(prompt_reel_in, 1)
	PromptSetVisible(prompt_reel_in, 1)
	-- PromptSetRotateMode(prompt_reel_in, 0.0, 0)
	PromptSetAttribute(prompt_reel_in, 10, 1)
	PromptSetAttribute(prompt_reel_in, 11, 1)
	PromptSetAttribute(prompt_reel_in, 18, 1)
	PromptSetStandardMode(prompt_reel_in, 0)
	-- PromptSetGroup(prompt_reel_in, promptGroup)
	PromptRegisterEnd(prompt_reel_in)
	PromptSetTag(prompt_reel_in, "CTX_REEL")

	prompt_reset = PromptRegisterBegin()
	Citizen.InvokeNative(0xF4A5C4509BF923B1, prompt_reset, 0)
	PromptSetControlAction(prompt_reset, 0xE3BF959B)
	PromptSetText(prompt_reset, "MGFSH_CTX_RESET")
	PromptSetEnabled(prompt_reset, 1)
	PromptSetVisible(prompt_reset, 1)
	PromptSetStandardMode(prompt_reset, 0)
	PromptRegisterEnd(prompt_reset)

	-- func_326
end

function delprompts()
	PromptDelete(prompt_grip)
	PromptDelete(prompt_hook)
	PromptDelete(prompt_reel_in)
	PromptDelete(prompt_reset)
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

	-- Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF,GetEntityCoords(PlayerPedId()), center, 255, 0, 0, 255)

	for i = 0, 360, 45 do
		i = math.rad(i)
		local X_deg0 = Cx + (r * math.cos(i))
		local Y_deg0 = Cy + (r * math.sin(i))

		local Vec = vec3(X_deg0, Y_deg0, z)

		-- local _, groundZ, _ = GetGroundZAndNormalFor_3dCoord(camVec.x, camVec.y, camVec.z)

		-- if math.abs(z - groundZ) < minHeightAboveGround then
		-- 	Vec = vec3(Vec)
		-- end

		Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, center, Vec, 255, 0, 0, 255)
	end
end

function HasAnimStartedPlaying(animDict, animName, timeout)
	local ped = PlayerPedId()
	timeout = timeout * 1000

	while not IsEntityPlayingAnim(ped, animDict, animName, 1) do
		Citizen.Wait(0)
		timeout = timeout - 1

		if timeout <= 0 then
			return false
		end
	end

	return true
end

function HasAnimStoppedPlaying(animDict, anim)
	local ped = PlayerPedId()

	while IsEntityPlayingAnim(ped, animDict, animName, 1) do
		Citizen.Wait(0)
	end

	return true
end

-- 0x14169FA823679E41

-- ? // 0xD04241BBF6D03A5E
-- ? Scenario _GET_SCENARIO_POINT_*

-- ? // _0x345EC3B7EBDE1CB5
-- ? int _GET_SCENARIO_POINT_CLOSE_TO_COORDS(float posX, float posY, float posZ, float ?radius, int p4)

-- // 0xDF7993356F52359A
-- int _GET_SCENARIO_POINT_PED_IS_USING(Ped ped, BOOL prompt_grip)

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

-- ["mini_games@fishing@shore"] = {
-- 	"caught_fish_no_reel_lt",
-- 	"caught_fish_sml_resist_lt",
-- 	"caught_fish_sml_resist",
-- 	"base_reel_2_reel_in_fast",
-- 	"caught_fish_med_no_reel_lt",
-- 	"caught_fish_med_no_reel_rt",
-- 	"caught_fish_sml_no_reel_rt",
-- 	"caught_fish_sml_no_reel_lt",
-- 	"caught_fish_med_resist",
-- 	"player_idle_2_base_2h",
-- 	"caught_fish_med_resist_lt",
-- 	"caught_fish_no_reel_rt",
-- 	"caught_fish_sml_no_reel",
-- 	"reel_in_fast_2_base_2h",
-- 	"caught_fish_lrg_no_reel",
-- 	"caught_fish_lrg_no_reel_lt",
-- 	"caught_fish_med_resist_rt",
-- 	"caught_fish_lrg_no_reel_rt",
-- 	"caught_fish_lrg_resist",
-- 	"caught_fish_lrg_resist_lt",
-- 	"caught_fish_lrg_resist_rt",
-- 	"unhook_fish_med_enter",
-- 	"unhook_fish_med_enter_fish",
-- 	"unhook_fish_med_hold_dead",
-- 	"caught_fish_sml_resist_rt",
-- 	"unhook_fish_med_hold_dead_fish",
-- 	"unhook_fish_med_hold_fish",
-- 	"base_2h_2_player_idle",
-- 	"unhook_fish_med_keep_fish",
-- 	"unhook_fish_med_release",
-- 	"unhook_fish_med_release_fish",
-- 	"caught_fish_med_no_reel",
-- 	"caught_fish_sml",
-- 	"rh_hold",
-- 	"caught_fish_sml_lt",
-- 	"idle_turn_r_0",
-- 	"uh_cast_action_short",
-- 	"caught_fish_sml_pole",
-- 	"uh_cast_exit",
-- 	"idle_turn_r_90",
-- 	"caught_fish_sml_rt",
-- 	"uh_cast_idle",
-- 	"line_snapped",
-- 	"caught_line_a",
-- 	"caught_line_b",
-- 	"uh_cast_intro",
-- 	"equip_clps",
-- 	"unequip_clps",
-- 	"bait_hook",
-- 	"bait_hook_alt",
-- 	"base_2h",
-- 	"base_2h_idle_a",
-- 	"line_snapped_lt",
-- 	"base_2h_idle_b",
-- 	"base_2h_idle_c",
-- 	"base_2h_idle_d",
-- 	"base_2h_idle_e",
-- 	"base_2h_idle_f",
-- 	"base_2h_idle_g",
-- 	"base_2h_idle_h",
-- 	"base_2h_idle_i",
-- 	"base_reel",
-- 	"unhook_fish",
-- 	"base_reel_flick",
-- 	"line_snapped_rt",
-- 	"base_reel_flick_lt",
-- 	"base_reel_flick_rt",
-- 	"base_reel_idle_a",
-- 	"base_reel_idle_b",
-- 	"base_reel_idle_c",
-- 	"base_reel_idle_d",
-- 	"base_reel_idle_e",
-- 	"base_reel_idle_f",
-- 	"lt_hold",
-- 	"hooked_fish_lrg",
-- 	"base_reel_idle_g",
-- 	"unhook_fish_bobber",
-- 	"base_reel_idle_h",
-- 	"missed_bite",
-- 	"unhook_fish_cam",
-- 	"base_reel_idle_i",
-- 	"unhook_fish_fish",
-- 	"base_reel_lt",
-- 	"base_reel_rt",
-- 	"hooked_fish_lrg_lt",
-- 	"cast_action",
-- 	"cast_action_short",
-- 	"missed_strike",
-- 	"cast_exit",
-- 	"hooked_fish_lrg_rt",
-- 	"cast_idle",
-- 	"no_hook_fish",
-- 	"cast_idle_turn_l_0",
-- 	"cast_idle_turn_r_0",
-- 	"hooked_fish_med",
-- 	"cast_intro",
-- 	"cast_pole",
-- 	"unhook_fish_med_hold",
-- 	"caught_fish_lrg",
-- 	"hooked_fish_med_lt",
-- 	"caught_fish_lrg_lt",
-- 	"reel_in",
-- 	"reel_in_fast",
-- 	"hooked_fish_med_rt",
-- 	"caught_fish_lrg_rt",
-- 	"hooked_fish_sml",
-- 	"caught_fish_med",
-- 	"unhook_fish_med_keep",
-- 	"caught_fish_med_lt",
-- 	"hooked_fish_sml_lt",
-- 	"hooked_fish_sml_rt",
-- 	"reel_in_lt",
-- 	"caught_fish_med_pole",
-- 	"idle_turn_l_-90",
-- 	"reel_in_rt",
-- 	"caught_fish_med_rt",
-- 	"caught_fish_no_reel",
-- 	"idle_turn_l_0",
-- 	"reel_in_up",
-- 	"cast",
-- },
