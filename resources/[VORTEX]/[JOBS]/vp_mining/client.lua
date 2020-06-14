local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local nearMiningSpotIndex
local nearRefiningSpotIndex
local prompt
local promptGroup
local varString
local carriables = {}

Citizen.CreateThread(
    function()
        -- // 0x18FF3110CF47115D
        -- void _TOGGLE_FLAG

        -- flags
        -- 2 = can pickup from ground
        -- 11 = ? place on ground when spawned
        -- 4 = can put on the ground

        while true do
            Citizen.Wait(1000)
            local pedVector = GetEntityCoords(PlayerPedId())

            nearMiningSpotIndex = nil
            nearRefiningSpotIndex = nil

            local lastDist = 50

            for _, v in pairs(Config.Locations) do
                local ve = vec3(v[1], v[2], v[3])
                local dist = #(pedVector - ve)
                if dist < lastDist then
                    nearMiningSpotIndex = _
                    lastDist = dist
                    if GetClosestObjectOfType(ve, 2.5, 942176598, false, false, false) == 0 then
                        if not HasModelLoaded(942176598) then
                            RequestModel(942176598)
                            while not HasModelLoaded(942176598) do
                                Citizen.Wait(10)
                            end
                        end

                        local obj = CreateObject(942176598, ve, true, true, false, true, true)
                        PlaceObjectOnGroundProperly(obj)
                        FreezeEntityPosition(obj, true)
                        -- SetModelAsNoLongerNeeded(942176598)

                        Citizen.InvokeNative(0x7DFB49BCDB73089A, obj, true)
                    end
                end
            end

            for _, v in pairs(Config.LocationsProcess) do
                local ve = vec3(v[1], v[2], v[3])
                local dist = #(pedVector - ve)
                if dist < lastDist then
                    nearRefiningSpotIndex = _
                    lastDist = dist

                    if GetClosestObjectOfType(ve, 2.5, 942176598, false, false, false) == 0 then
                        if not HasModelLoaded(942176598) then
                            RequestModel(942176598)
                            while not HasModelLoaded(942176598) do
                                Citizen.Wait(10)
                            end
                        end

                        local obj = CreateObject(942176598, ve, true, true, false, true, true)
                        PlaceObjectOnGroundProperly(obj)
                        FreezeEntityPosition(obj, true)
                        -- SetModelAsNoLongerNeeded(942176598)

                        Citizen.InvokeNative(0x7DFB49BCDB73089A, obj, true)
                    end
                end
            end

            if nearMiningSpotIndex == nil and nearRefiningSpotIndex == nil then
                PromptDelete(prompt)
                prompt = nil
                promptGroup = nil
                varString = nil
            end

            for _, carriable in pairs(carriables) do
                if not DoesEntityExist(carriable) then
                    carriables[_] = nil
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if nearMiningSpotIndex ~= nil then
                local d = Config.Locations[nearMiningSpotIndex]
                local v = vec3(d[1], d[2], d[3])

                local ped = PlayerPedId()
                local pedVector = GetEntityCoords(ped)

                local carriableCloseToPrompt = false

                for _, carriable in pairs(carriables) do
                    local carriableV = GetEntityCoords(carriable)
                    if #(carriableV - v) <= 2.5 then
                        carriableCloseToPrompt = true
                        break
                    end
                end

                if carriableCloseToPrompt == false then
                    if #(pedVector - v) <= 1.5 then
                        drawPrompt()
                        if PromptIsJustPressed(prompt) and GetScriptTaskStatus(ped, 0x3B3A458F, 0) ~= 1 then
                            TriggerServerEvent("VP:MINING:TryToStartMining")
                            Wait(1000)
                        end
                    end
                end
            end

            if nearRefiningSpotIndex ~= nil and isRefining == false then
                local d = Config.LocationsProcess[nearRefiningSpotIndex]
                local v = vec3(d[1], d[2], d[3])

                if #(pedVector - v) <= 1.5 then
                    drawPrompt()
                    if PromptIsJustPressed(prompt) then
                        TriggerServerEvent("VP:MINING:TryToStartRefining")
                        Wait(1000)
                    end
                end
            end
        end
    end
)

function drawPrompt(refining)
    if prompt == nil then
        local text = "Começar"
        varString = CreateVarString(10, "LITERAL_STRING", "Mineirar")
        if refining then
            text = "Começar"
            varString = CreateVarString(10, "LITERAL_STRING", "Processamento")
        end

        prompt = PromptRegisterBegin()
        promptGroup = GetRandomIntInRange(0, 0xffffff)
        PromptSetControlAction(prompt, 0x7F8D09B8)
        PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", text))
        PromptSetEnabled(prompt, 1)
        PromptSetVisible(prompt, 1)
        PromptSetStandardMode(prompt, true)
        PromptSetGroup(prompt, promptGroup)
        PromptRegisterEnd(prompt)
    end
    PromptSetActiveGroupThisFrame(promptGroup, varString)
end

RegisterNetEvent("VP:MINING:DropMineral")
AddEventHandler(
    "VP:MINING:DropMineral",
    function(mineral_item)
        local prop
        if mineral_item == "raw_iron" then
            prop = "p_iron01x"
        elseif mineral_item == "raw_coal" then
            prop = "s_meteoriteshard01x"
        elseif mineral_item == "raw_copper" then
            prop = "s_meteoriteshard01x"
        elseif mineral_item == "raw_gold" then
            prop = "s_pickup_goldbar01x"
        end

        if prop ~= nil then
            if not HasModelLoaded(prop) then
                RequestModel(prop)
                while not HasModelLoaded(prop) do
                    Citizen.Wait(10)
                end
            end

            local ped = PlayerPedId()

            local s = GetEntityCoords(ped) + (GetEntityForwardVector(ped) * 1.0)

            local rand = math.random(1, 2)

            for i = 0, rand - 1 do
                local obj = CreateObject(prop, s, true, true, true, true, true)
                ApplyForceToEntityCenterOfMass(obj, 1, 0, 0, 0, 0, 1, 1, 1)
                -- SetModelAsNoLongerNeeded(prop)

                Citizen.InvokeNative(0xF0B4F759F35CC7F5, obj, Citizen.InvokeNative(0x34F008A7E48C496B, obj, 3), 0, 0, 512)

                Citizen.InvokeNative(0x7DFB49BCDB73089A, obj, true)
                Citizen.InvokeNative(0xAEE6C800E124CFE1, obj, "Oi")

                table.insert(carriables, obj)
            end
        end
    end
)

RegisterNetEvent("VP:MINING:StartMiningAnimation")
AddEventHandler(
    "VP:MINING:StartMiningAnimation",
    function()        
        if not IsPedMale(PlayerPedId()) then
            local waiting = 0
            local dict = "amb_work@world_human_pickaxe@wall@male_d@base"
            RequestAnimDict(dict)
            while not HasAnimDictLoaded(dict) do
                waiting = waiting + 100
                Citizen.Wait(100)
                if waiting > 5000 then
                  --  TriggerEvent("redemrp_notification:start", "Request Animation is broken, Relog", 4, "warning")
                    break
                end
            end

            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local boneIndex = GetEntityBoneIndexByName(ped, "SKEL_R_HAND")
            local modelHash = GetHashKey("P_PICKAXE01X")
            LoadModel(modelHash)
            entity = CreateObject(modelHash, coords.x, coords.y, coords.z, true, false, false)
            SetEntityVisible(entity, true)
            SetEntityAlpha(entity, 255, false)
            Citizen.InvokeNative(0x283978A15512B2FE, entity, true)
            SetModelAsNoLongerNeeded(modelHash)
            AttachEntityToEntity(entity, ped, boneIndex, -0.030, -0.300, -0.010, 0.0, 100.0, 68.0, false, false, false, true, 2, true) ---6th rotates axe point
            TaskPlayAnim(ped, dict, "base", 1.0, 8.0, -1, 1, 0, false, false, false)
        else
            TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("EA_WORLD_HUMAN_PICKAXE_NEW"), 0, true, false, -1.0, false)
        end

       --- TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("EA_WORLD_HUMAN_PICKAXE_NEW"), 0, true, 0, -1.0, false)

        local timeout = 2000
        while GetScriptTaskStatus(PlayerPedId(), 0x3B3A458F, 0) ~= 1 do
            Citizen.Wait(100)
            timeout = timeout - 100
        end

        if timeout > 0 then
            local running = true

            Citizen.CreateThread(
                function()
                    Citizen.Wait(20000)
                    if running then
                        print("ended")
                        running = false

                        SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"), true)
                        ClearPedTasks(PlayerPedId())
                        TriggerServerEvent("VP:MINING:CollectMineral")
                    end
                end
            )

            Citizen.CreateThread(
                function()
                    while running do
                        Citizen.Wait(100)

                        if GetScriptTaskStatus(PlayerPedId(), 0x3B3A458F, 0) ~= 1 then
                            print("stoped scenario")
                            ClearPedTasks(PlayerPedId())
                            running = false
                            break
                        end
                    end
                end
            )
        end
    end
)

RegisterNetEvent("VP:MINING:StartProcessingAnimation")
AddEventHandler(
    "VP:MINING:StartProcessingAnimation",
    function(num)
        TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_HUMAN_CLEAN_TABLE"), 20000, true, false, false, false) -- colocar uma animação para processar
        --exports['progressBars']:startUI(20000, Language.translate[Config.lang]['process'])
        Wait(20000)
        -- TriggerServerEvent("VP:MINING:processitem", num)
        ClearPedTasksImmediately(PlayerPedId())
    end
)

function CreateVarString(p0, p1, variadic)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end

function NativeFindClosestActiveScenarioPointOfType(position, type, radius)
    return Citizen.InvokeNative(0xF533D68FF970D190, position, type, radius, 0, 0, Citizen.ResultAsInteger())
end
