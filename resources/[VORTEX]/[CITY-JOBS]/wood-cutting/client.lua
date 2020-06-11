local oldscenarios = {}

RegisterCommand(
    "scenarios",
    function()
        local r = {
            -- "PG_SCENARIO_CHOPWOOD", -- DW
            -- "PG_AMBIENT_CAMP_ADD_WOOD", -- DW
            -- "PROP_HUMAN_WOOD_CHOP",
            -- "PROP_HUMAN_WOOD_CHOP_AXESTUCK_01_02",
            -- "WORLD_HUMAN_PLANE_WOOD_NO_PLANK",
            -- "WORLD_HUMAN_PLANE_WOOD",
            -- "PLAYER_CAMP_CHORES_WOOD_CHOP",
            -- "BCH_WOOD_CHOP_PRESADIE3",
            -- "PROP_HUMAN_WOOD_CHOP_AND_SHARPEN_AXE",
            -- "WORLD_PLAYER_CHORES_FEEDBAG_PICKUP",
            -- "WORLD_PLAYER_CHORES_FEEDBAG_PUTDOWN",
            -- "WORLD_HUMAN_CHICKEN_CRATE_PICKUP_2",
            -- "WORLD_HUMAN_CHAMBERPOT_PICKUP_PUTDOWN"
            -- "WORLD_HUMAN_CHAMBERPOT_PICKUP"
            -- "WORLD_HUMAN_SACK_OUT_BIN_TARP",
            -- "WORLD_PLAYER_CHORES_SACK_PICKUP_1",
            -- "WORLD_PLAYER_CHORES_SACK_PUT_DOWN_1",
            -- "RANSACK_PROP_CHEST_PICKUP",
            -- "RANSACK_PROP_CHEST_PUTDOWN",
            -- "WORLD_HUMAN_NEWSPAPER_PICKUP",
            "PROP_HUMAN_BUTCHER_DEER_MALE_A_MEAT_DROP",
            -- PROP_HUMAN_PUMP_WATER
            -- PROP_HUMAN_PUMP_WATER_BUCKET
            -- PROP_HUMAN_PUMP_WATER_BUCKET_FEMALE_B
            -- PROP_HUMAN_PUMP_WATER_BUCKET_MALE_A  
            -- PROP_HUMAN_PUMP_WATER_FEMALE_B
            -- PROP_HUMAN_PUMP_WATER_MALE_A
        }

        -- _NO : Means you can attach the scenario to your on prop

        local ped = PlayerPedId()
        local pcoords = GetEntityCoords(ped)
        for _, v in pairs(r) do
            SetScenarioGroupEnabled(v, true)
            print("#" .. _)

            local offset = vec3(pcoords.x + math.random(-5.0, 5.0), pcoords.y + math.random(-5.0, 5.0), pcoords.z)
            local _, groundZ, normal = GetGroundZAndNormalFor_3dCoord(offset.x, offset.y, offset.z)
            offset = vec3(offset.xy, groundZ)

            local stype = v
            local s
            local scenarioTypeHash = GetHashKey(stype)

            if type(v) == "table" then
                stype = v[1]

                local pmodel = GetHashKey(v[2])

                if IsModelValid(pmodel) then
                    if not HasModelLoaded(pmodel) then
                        RequestModel(pmodel)
                        while not HasModelLoaded(pmodel) do
                            Citizen.Wait(10)
                        end
                    end
                end

                local entity = CreateObject(pmodel, offset, true, 1, 1)

                s = NativeCreateScenarioPointAttachedToEntity(entity, scenarioTypeHash)
            else
                s = NativeCreateScenarioPoint(scenarioTypeHash, offset, 180.0)
            end

            if NativeDoesScenarioPointExist(s) then
                table.insert(oldscenarios, s)
            end
        end
    end,
    false
)

Citizen.CreateThread(
    function()
        local DRAW_LINE = GetHashKey("DRAW_LINE")

        -- print(GetVehiclePedIsIn(PlayerPedId(), false))
        -- Citizen.InvokeNative(0x2208438012482A1A, ped, false, false)

        -- local veh = 8279559
        -- Citizen.InvokeNative(0x75F90E4051CC084C, veh, GetHashKey("PG_MP005_HUNTINGWAGONTARP01"))
        -- Citizen.InvokeNative(0xC0F0417A90402742, veh, GetHashKey("PG_VEH_CART06_LANTERNS01"))
        -- local propset =Citizen.InvokeNative(0xA079300AF757FB1A, 3370002)

        local sc = Citizen.InvokeNative(0xF533D68FF970D190, GetEntityCoords(PlayerPedId()), GetHashKey("MP005_P_HUNTINGWAGONTARP01"), 50.0, 0, false)
        print(sc)

        while true do
            Citizen.Wait(0)
            local ped = PlayerPedId()
            local pcoords = GetEntityCoords(ped)

            local closest
            local lastdist

            for _, scenario in pairs(oldscenarios) do
                scoords = NativeGetScenarioPointCoords(scenario)

                if lastdist == nil or #(pcoords - scoords) < lastdist then
                    closest = scenario
                end

                Citizen.InvokeNative(DRAW_LINE & 0xFFFFFFFF, scoords, scoords + vec3(0, 0, 2.0), 255, 0, 0, 255)
                Citizen.InvokeNative(DRAW_LINE & 0xFFFFFFFF, pcoords, scoords, 255, 0, 0, 255)
            end

            if closest ~= nil then
                if IsControlJustPressed(0, 0xB4E465B4) then
                    print("using scenario", ped, closest)

                    -- PROP_HUMAN_WOOD_CHOP_PICKUPLSIDE2
                    TaskUseScenarioPoint(ped, closest, "", 0, false, false, 0, false, -1.0, false)
                    -- Wait(5000)
                    -- TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("PROP_HUMAN_WOOD_CHOP_PICKUPLSIDE1"), 0, true, 0, 0, 0)
                end
            end
        end
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if GetCurrentResourceName() == resourceName then
            for _, scenario in pairs(oldscenarios) do
                NativeDeleteScenarioPoint(scenario)
            end
        end
    end
)

function NativeCreateScenarioPoint(scenarioTypeHash, scenarioCoords, scenarioHeading)
    return Citizen.InvokeNative(0x94B745CE41DB58A1, scenarioTypeHash, scenarioCoords, scenarioHeading, 0.0, 0.0, 0)
end

function NativeCreateScenarioPointAttachedToEntity(entity, scenarioTypeHash)
    return Citizen.InvokeNative(0x794AB1379A74064D, entity, scenarioTypeHash, 0.0, 0.0, 0.0, 0, 4.0, 0.0, 0)
end

function NativeDeleteScenarioPoint(scenario)
    Citizen.InvokeNative(0x81948DFE4F5A0283, scenario)
end

function NativeGetScenarioPointCoords(scenario)
    return Citizen.InvokeNative(0xA8452DD321607029, scenario, Citizen.ResultAsVector())
end

function NativeDoesScenarioPointExist(scenario)
    return Citizen.InvokeNative(0x841475AC96E794D1, scenario)
end

function _NativeGetPlayerAnim()
    return Citizen.InvokeNative(0xC22AA08A8ADB87D4, PlayerPedId())
end
