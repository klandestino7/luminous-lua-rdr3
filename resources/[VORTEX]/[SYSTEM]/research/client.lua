local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

RegisterCommand(
	"teste",
	function(source, args, rawCommand)
		local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.0, 0.0)
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

		-- WB_HERB_ALASKAN_GINSENG

		-- local obj = CreateObject("s_oleander01x", coords, 1, 1, 1)

		-- local scenario_type = GetHashKey("WB_HERB_ALASKAN_GINSENG")

		-- -- // 0x19A6BE7D9C6884D3
		-- -- void _REQUEST_SCENARIO_TYPE(Hash scenarioType, int p1, Hash p2, Hash p3)
		-- Citizen.InvokeNative(0x19A6BE7D9C6884D3, scenario_type, 3, GetEntityModel(obj), 0)
		-- while not Citizen.InvokeNative(0x9427C94D2E4094A4, scenario_type, 0) do
		-- 	print("scenario not loaded")
		-- 	Wait(10)
		-- end
		-- -- func_1963

		-- -- local scenario = Citizen.InvokeNative(0x94B745CE41DB58A1, herb_scenario, coords, GetEntityHeading(PlayerPedId()), 0.0, 0, 1)
		-- local scenario = Citizen.InvokeNative(0x794AB1379A74064D, scenario_type, obj, GetEntityHeading(obj), 0.0, 0, 0)
		-- TaskUseScenarioPoint(PlayerPedId(), scenario, "", -1.0, 0, 0, 0, 0, 0)

		-- Citizen.InvokeNative(0xEEE4829304F93EEE, scenario, false)

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

		local wb = GetHashKey(args[1])
		-- wb = GetHashKey("RANSACK_ATTACHED_P_CABINET13X")

		-- WB_HERB_AMERICAN_GINSENG
		-- if not Citizen.InvokeNative(0x9427C94D2E4094A4, wb, 0) then
		-- 	Citizen.InvokeNative(0x19A6BE7D9C6884D3, wb, 15, 0, 0)
		-- end
		-- print(Citizen.InvokeNative(0x9427C94D2E4094A4, wb, 0))
		local scenario = Citizen.InvokeNative(0x94B745CE41DB58A1, wb, coords, 0.0, 0.0, 0, 1)
		-- local scenario = Citizen.InvokeNative(0x794AB1379A74064D, ojb, wb, 0.0, -0.25, 0.0, 0, 0, 0, 0)
		-- Citizen.InvokeNative(0x5A40040BB5AE3EA2, scenario)
		-- Citizen.InvokeNative(0xC47D9080A9A8856A, scenario, 230.0)
		-- Citizen.InvokeNative(0xEEE4829304F93EEE, scenario, true)
		-- print(scenario)
		-- print(Citizen.InvokeNative(0xF533D68FF970D190, coords, wb, 500.0, 0, false))
		-- Wait(1000)
		-- print(Citizen.InvokeNative(0x7467165EE97D3C68, scenario), ojb)
		-- SetEntityCoords(obj, coords, 0, 0, 0, 0)
		-- SetEntityCoords(PlayerPedId(), GetEntityCoords(obj), 0, 0, 0, 0)

		-- Wait(2000)

		-- TaskUseScenarioPoint(PlayerPedId(), scenario, "", -1.0, true, 0, 0, 0, true)

		-- local itemset = CreateItemset(true)
		-- Citizen.InvokeNative(0x9C8F42A5D1859DC1, coords)
		-- Citizen.InvokeNative(0xB8E213D02F37947D, coords, itemset, wb, 0, 0, 0, 0)

		-- print(GetItemsetSize(itemset))

		-- print(Citizen.InvokeNative(0xA8452DD321607029, scenario, true, Citizen.ResultAsVector()))
		-- print(Citizen.InvokeNative(0xA8452DD321607029, scenario, true, Citizen.ResultAsVector()))
		-- print(Citizen.InvokeNative(0xF533D68FF970D190 , coords, wb, 500.0, 0, false))
		-- 0x2056AB38DF06825C
		-- print(Citizen.InvokeNative(0x841475AC96E794D1, 1926127072))
		-- print(GetEntityCoords(1926127072))
		-- print(IsModelValid(1926127072))
		-- Citizen.InvokeNative(0xEEE4829304F93EEE, scenario, true)
		-- print(scenario)
		-- end

		-- print(Citizen.InvokeNative(0x841475AC96E794D1,32512))

		-- exports['vp_admin']:js_teste_native();

		Citizen.InvokeNative(0x51345AE20F22C261, PlayerId(), 0, 0, 0)
		-- print(Citizen.InvokeNative(0xAB3773E7AA1E9DCC, PlayerId(), Citizen.ResultAsFloat()))
	end
)

-- EVENT_PED_WHISTLE
-- case 1327216456:
-- func_157(iParam0);

-- exports('js_teste_native', (group, i, size) => {

--     let buffer = new ArrayBuffer(256 * 2);
--     let view = new DataView(buffer);
--     // dataView.setInt32(0, 3);
--     // dataView.setInt32(3, );

--     Citizen.invokeNative("0x57EC5FA4D4D6AFCA", group, i, view, size, Citizen.returnResultAnyway());
--     let out = new Int32Array(buffer);

--     console.log(out);
--     // console.log(JSON.stringify(out));
-- });

-- function DataViewNativeGetEventData(eventGroup, index, argStructSize)
-- 	local view = DataView.ArrayBuffer(256 * 2)
-- 	Citizen.InvokeNative(0x57EC5FA4D4D6AFCA, eventGroup, index, view:Buffer(), argStructSize, Citizen.ReturnResultAnyway())
-- 	return view
-- end

Citizen.CreateThread(
	function()
		print("PLAYERPED: " .. PlayerPedId())
		print("Scenario exists? ", Citizen.InvokeNative(0x841475AC96E794D1, 138242))
		print("Entity exists?", DoesEntityExist(4948228))

		print(" ")

		-- SetEntityCoords(PlayerPedId(), GetEntityCoords(4948228))

		while true do
			Citizen.Wait(10)

			local size = GetNumberOfEvents(0)

			if size > 0 then
				for i = 0, size - 1 do
					local eventAtIndex = GetEventAtIndex(0, i)

					if eventAtIndex == 1327216456 then
						-- [bit 0] = Ped who is whistling
						print("EVENT_PED_WHISTLE", PlayerPedId(), i)
						-- exports["vp_admin"]:js_teste_native(0, i, 2)
						exports["research"]:DataViewNativeGetEventData(0, i, 2)
					elseif eventAtIndex == GetHashKey("EVENT_PLAYER_PROMPT_TRIGGERED") then
						print("EVENT_PLAYER_PROMPT_TRIGGERED", PlayerPedId(), i)
						-- exports["vp_admin"]:js_teste_native(0, i, 10)
						exports["research"]:DataViewNativeGetEventData(0, i, 10)
						Wait(1000)
					elseif eventAtIndex == -1246119244 then
						-- [bit 0] Ped -- Mostly the animal being interacted
						-- [bit 2] Ped -- Mostly the one who is interacting
						-- [bit 4] Interaction
						-- print(GetHashKey("INTERACTION_POSITIVELONG"), GetHashKey("INTERACTION_POSITIVESHORT"), GetHashKey("INTERACTION_CANCEL"), GetHashKey("INTERACTION_COMPLETE"))
						print("EVENT_PED_ANIMAL_INTERACTION", PlayerPedId(), i)
						-- exports["vp_admin"]:js_teste_native(0, i, 3)
						exports["research"]:DataViewNativeGetEventData(0, i, 3)
					elseif eventAtIndex == -2091944374 then
						-- 24 Player
						-- 25 Lotter
						print("EVENT_PLAYER_LOOT_PED")
						-- exports["vp_admin"]:js_teste_native(0, i, 26)
						exports["research"]:DataViewNativeGetEventData(0, i, 26)
					elseif eventAtIndex == -1511724297 then
						-- exports["vp_admin"]:js_teste_native(0, i, 36)
						print("EVENT_PLAYER_LOOT_?")
					elseif eventAtIndex == 1352063587 then
						print("EVENT | PED_INTERACTION_RANSACK_SCENARIO", Citizen.InvokeNative(0xD04241BBF6D03A5E, PlayerPedId()))
						local view = exports["research"]:DataViewNativeGetEventData(0, i, 4)
						local pedInteracting = view["0"]
						local containerEntity = view["2"]
						local containerScenario = view["4"]
						local isClosing = view["6"]

						print(pedInteracting, containerEntity, containerScenario, isClosing)
					elseif eventAtIndex == 1208357138 then
						-- local carriableEntity = view["0"]
						-- local pedCarrier
						print("EVENT | Carriable state change / Carriable carrier changes?")
						exports["research"]:DataViewNativeGetEventData(0, i, 5)
					elseif eventAtIndex == -687266558 then
						-- index\bitIndex
						-- 1\0: Entity
						-- 3\3: Entity
						print("EVENT | PED_STARTS_CARRYING")
						exports["research"]:DataViewNativeGetEventData(0, i, 4)
					elseif eventAtIndex == 1376140891 then
						-- 1\0: Entity/Ped/Player Ped
						-- 2\2: Entity/Ped carriable
						-- 3\3: BOOL, used to determine theft?
						--[[

						]]
						print("EVENT | PED_FINISHED_GATHERING_PED *totally not real name*")
						local view = exports["research"]:DataViewNativeGetEventData(0, i, 3)
						local ped = view["0"]
						local pedGathered = view["2"]
						local bool_unk = view["4"]

						TriggerEvent('VP:EVENTS:PedFinishedGatheringPed', ped, pedGathered, bool_unk)
					elseif eventAtIndex == 218595333 then
						print("Horse broken")
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

RegisterNetEvent('VP:EVENTS:PedFinishedGatheringPed')

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
