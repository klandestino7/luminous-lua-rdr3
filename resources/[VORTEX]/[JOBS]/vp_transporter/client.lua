-- local Tunnel = module("_core", "lib/Tunnel")
-- local Proxy = module("_core", "lib/Proxy")

-- API = Proxy.getInterface("API")
-- cAPI = Tunnel.getInterface("API")

local scenario_usable
local scenario_usable_type

local scenario_active
local scenario_active_type
local scenario_active_entity

local promptGroup
local prompt_pickup
local prompt_putdown
local var_bale = CreateVarString(10, "LITERAL_STRING", "Bloco de Feno")
local var_sack = CreateVarString(10, "LITERAL_STRING", "Saco")

local scenarios = {
    -- "WORLD_PLAYER_CHORES_BALE_PICKUP_1",
    -- "WORLD_PLAYER_CHORES_BALE_PUT_DOWN_1",
    "WORLD_HUMAN_BALE_PICKUP_1",
    "WORLD_HUMAN_BALE_PICKUP_1_MALE_A",
    "WORLD_HUMAN_BALE_PICKUP_2",
    "WORLD_HUMAN_BALE_PICKUP_2_MALE_A",
    "WORLD_HUMAN_SUGAR_SACK_PICKUP_1",
    "WORLD_HUMAN_SUGAR_SACK_PICKUP_2",
    "WORLD_HUMAN_SUGAR_SACK_PICKUP_COUNTER",
    "WORLD_HUMAN_SACK_PICKUP_1",
    "WORLD_HUMAN_SACK_PICKUP_1_MALE_A",
    "WORLD_HUMAN_SACK_PICKUP_2",
    "WORLD_HUMAN_SACK_PICKUP_2_MALE_A",
    "WORLD_HUMAN_SACK_PICKUP_COUNTER",
    "WORLD_HUMAN_SACK_PICKUP_COUNTER_MALE_A"
    --
    -- WORLD_HUMAN_BALE_PUT_DOWN_1
    -- WORLD_HUMAN_BALE_PUT_DOWN_1_MALE_A
    -- WORLD_HUMAN_BALE_PUT_DOWN_2
    -- WORLD_HUMAN_BALE_PUT_DOWN_2_MALE_A
    --
    -- WORLD_HUMAN_SACK_PUT_DOWN_1
    -- WORLD_HUMAN_SACK_PUT_DOWN_1_MALE_A
    -- WORLD_HUMAN_SACK_PUT_DOWN_2
    -- WORLD_HUMAN_SACK_PUT_DOWN_2_MALE_A
    -- WORLD_HUMAN_SACK_PUT_DOWN_COUNTER
    -- WORLD_HUMAN_SACK_PUT_DOWN_COUNTER_MALE_A
}

Citizen.CreateThread(
    function()
        setupPrompts()

        while true do
            Citizen.Wait(1000)

            local ped = PlayerPedId()
            local pCoords = GetEntityCoords(ped)

            if scenario_active == nil then
                local lastDist
                local foundPickupScenario
                for _, scenarioType in pairs(scenarios) do
                    local s = _FindClosestActiveScenarioPointOfType(pCoords, scenarioType, 1.5)
                    if s then
                        local dist = #(pCoords - _GetScenarioPointCoords(s))
                        if lastDist == nil or dist < lastDist then
                            foundPickupScenario = s
                            scenario_usable_type = scenarioType
                        end
                    end
                end

                scenario_usable = foundPickupScenario

                if scenario_usable == nil then
                    scenario_usable_type = nil
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        local aimMaxDistance = 7.0
        local drawcoords
        while true do
            Citizen.Wait(0)

            -- if drawcoords ~= nil then
            --     Citizen.InvokeNative(`DRAW_LINE` & 0xFFFFFFFF, GetEntityCoords(PlayerPedId()), drawcoords, 255, 0, 0, 255)
            -- end

            local ped = PlayerPedId()
            local pCoords = GetEntityCoords(ped)

            if scenario_active ~= nil then
                draw_putdown(scenario_active_type:find("_SACK_"))

                if IsControlJustPressed(2, 0x7F8D09B8) then
                    local putDownScenario = scenario_active_type

                    if putDownScenario:find("_SACK_") then
                        -- putDownScenario = putDownScenario:gsub('_SUGAR', '')
                        -- putDownScenario = putDownScenario:gsub('PICKUP', 'PUT_DOWN')
                        putDownScenario = "WORLD_HUMAN_SACK_PUT_DOWN_2"
                    elseif putDownScenario:find("_BALE_") then
                        -- putDownScenario = putDownScenario:gsub('PICKUP', 'PUT_DOWN')
                        putDownScenario = "WORLD_HUMAN_BALE_PUT_DOWN_1"
                    end

                    scenario_active = nil

                    local putdown_coords = pCoords + (GetEntityForwardVector(ped) * 1.0)

                    local rayHandle = StartShapeTestRay(pCoords, putdown_coords, -1, ped, 0)
                    local _, hit, endCoords, _, _ = GetShapeTestResult(rayHandle)

                    if hit then
                        putdown_coords = endCoords
                    end

                    -- local _, groundZ, normal = GetGroundZAndNormalFor_3dCoord(pCoords.x, pCoords.y, pCoords.z)
                    local scenario = Citizen.InvokeNative(0x94B745CE41DB58A1, GetHashKey(putDownScenario), putdown_coords, GetEntityHeading(PlayerPedId()), 0.0, 0.0, 0)

                    TaskUseScenarioPoint(ped, scenario, putDownScenario, -1, false, true, 0, false, -1.0, 0)

                    Citizen.Wait(250)

                    TaskStartScenarioInPlace(ped, GetHashKey(putDownScenario), -1, 1, 0, -1, 0)

                    Citizen.Wait(2500)

                    ClearPedTasks(ped)

                    local scene_entity_coords = GetEntityCoords(scenario_active_entity)
                    local scene_entity_heading = GetEntityHeading(scenario_active_entity)

                    SetEntityAsMissionEntity(scenario_active_entity, true, true)
                    DeleteEntity(scenario_active_entity)

                    Citizen.InvokeNative(0x94B745CE41DB58A1, GetHashKey(scenario_active_type), scene_entity_coords, scene_entity_heading, 0.0, 0.0, 0)

                    scenario_active_entity = nil
                    scenario_active_type = nil
                end
            elseif scenario_usable ~= nil then
                draw_pickup(scenario_usable_type:find("_SACK_"))

                if IsControlJustPressed(2, 0xDFF812F9) then
                    scenario_active = scenario_usable
                    scenario_active_type = scenario_usable_type

                    scenario_usable = nil
                    scenario_usable_type = nil

                    local possible_entity_models = {
                        "P_CS_SACKCORN01X",
                        "p_cs_sugarcorn01x"
                    }

                    local i = 1
                    while i < #possible_entity_models + 1 do
                        Citizen.Wait(0)
                        scenario_active_entity = Citizen.InvokeNative(0x295514F198EFD0CA, scenario_active, possible_entity_models[i] .. "_PH_R_HAND")

                        if scenario_active_entity ~= 0 then
                            break
                        end

                        i = i + 1
                    end

                    print("scenario_active_entity", scenario_active_entity)

                    local scenario_coords = Citizen.InvokeNative(0xA8452DD321607029, scenario_usable)

                    TaskUseScenarioPoint(ped, scenario_active, scenario_active_type, -1, false, true, 0, false, -1.0, 0)

                    Citizen.Wait(250)

                    TaskStartScenarioInPlace(ped, GetHashKey(scenario_active_type), -1, 1, 0, -1, 0)
                end
            end
        end
    end
)

function _FindClosestActiveScenarioPointOfType(pCoords, scenarioType, distance)
    return Citizen.InvokeNative(0xF533D68FF970D190, pCoords, GetHashKey(scenarioType), distance, 0, 0)
end

function _GetScenarioPointCoords(scenario)
    return Citizen.InvokeNative(0xA8452DD321607029, scenario, true, Citizen.ResultAsVector())
end

function setupPrompts()
    promptGroup = GetRandomIntInRange(0, 0xffffff)

    prompt_pickup = PromptRegisterBegin()
    PromptSetControlAction(prompt_pickup, 0xDFF812F9)
    PromptSetText(prompt_pickup, CreateVarString(10, "LITERAL_STRING", "Pegar"))
    PromptSetEnabled(prompt_pickup, 1)
    PromptSetVisible(prompt_pickup, 1)
    PromptSetStandardMode(prompt_pickup, true)
    PromptSetGroup(prompt_pickup, promptGroup)
    PromptRegisterEnd(prompt_pickup)

    prompt_putdown = PromptRegisterBegin()
    PromptSetControlAction(prompt_putdown, 0x7F8D09B8)
    PromptSetText(prompt_putdown, CreateVarString(10, "LITERAL_STRING", "Colocar no Chão"))
    PromptSetEnabled(prompt_putdown, 1)
    PromptSetVisible(prompt_putdown, 1)
    PromptSetStandardMode(prompt_putdown, true)
    PromptSetGroup(prompt_putdown, promptGroup)
    PromptRegisterEnd(prompt_putdown)
end

function draw_pickup(isBale)
    PromptSetEnabled(prompt_pickup, true)
    PromptSetEnabled(prompt_putdown, false)
    PromptSetActiveGroupThisFrame(promptGroup, isBale == true and var_bale or var_sack)
end

function draw_putdown(isBale)
    PromptSetEnabled(prompt_putdown, true)
    PromptSetEnabled(prompt_pickup, false)
    PromptSetActiveGroupThisFrame(promptGroup, isBale == true and var_bale or var_sack)
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            PromptDelete(prompt_pickup)
            PromptDelete(prompt_putdown)
        end
    end
)
