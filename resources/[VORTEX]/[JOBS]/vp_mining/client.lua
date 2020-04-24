local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local nearMiningSpotIndex
local prompt
local promptGroup
local holdModeOn = false
local isMining = false
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
            local lastDist = 50
            for _, v in pairs(Config.Locations) do
                local dist = #(pedVector - vec3(v[1], v[2], v[3]))
                if dist < lastDist then
                    nearMiningSpotIndex = _
                    lastDist = dist
                end
            end
            if nearMiningSpotIndex == nil then
                PromptDelete(prompt)
                prompt = nil
                promptGroup = nil
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if nearMiningSpotIndex ~= nil and isMining == false then
                local d = Config.Locations[nearMiningSpotIndex]
                local v = vec3(d[1], d[2], d[3])

                local ped = PlayerPedId()
                local pedVector = GetEntityCoords(ped)

                local carriableCloseToPrompt = false

                for carriable, _ in pairs(carriables) do
                    local carriableV = GetEntityCoords(carriable)
                    if #(carriableV - v) <= 2.5 then
                        carriableCloseToPrompt = true
                        break
                    end
                end

                if carriableCloseToPrompt == false then
                    if #(pedVector - v) <= 2.0 then
                        drawPrompt()
                        if PromptIsJustPressed(prompt) then
                            TriggerServerEvent("VP:MINING:TryToStartMining")
                        end
                    end
                end
            end
        end
    end
)

function drawPrompt()
    if prompt == nil then
        prompt = PromptRegisterBegin()
        promptGroup = GetRandomIntInRange(0, 0xffffff)
        PromptSetControlAction(prompt, 0x7F8D09B8)
        PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "Mineirar"))
        PromptSetEnabled(prompt, 1)
        PromptSetVisible(prompt, 1)
        PromptSetStandardMode(prompt, true)
        PromptSetGroup(prompt, promptGroup)
        PromptRegisterEnd(prompt)
    end
    PromptSetActiveGroupThisFrame(promptGroup, CreateVarString(10, "LITERAL_STRING", "Ação"))
end

RegisterNetEvent("VP:MINING:DropMineral")
AddEventHandler(
    "VP:MINING:DropMineral",
    function(mineral_item)
        local prop
        if mineral_item == "stone" then
            prop = "s_meteoriteshard01x"
        elseif mineral_item == "raw_coal" then
            prop = "p_coal01x"
        elseif mineral_item == "raw_copper" then
            prop = "s_meteoriteshard01x"
        elseif mineral_item == "raw_gold" then
            prop = "s_pickup_goldbar01x"
        elseif mineral_item == "ammolite" then
            prop = "s_dis_ammolite01x"
        elseif mineral_item == "flourite" then
            prop = "s_dis_flourite01x"
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

            local obj = CreateObject(prop, s, false, true, true, true, true)
            ApplyForceToEntityCenterOfMass(obj, 1, 0, 0, 0, 0, 1, 1, 1)
            SetModelAsNoLongerNeeded(prop)

            local carriable = Citizen.InvokeNative(0xF0B4F759F35CC7F5, obj, GetHashKey("USABLE_CARRIABLE_INVENTORY_ITEM"), 0, 0, 0)

            Citizen.InvokeNative(0x7DFB49BCDB73089A, carriable, true)

            carriables[carriable] = true

            Citizen.CreateThread(
                function()
                    while true do
                        Citizen.Wait(250)

                        if not DoesEntityExist(carriable) then
                            carriables[carriable] = nil
                            TriggerServerEvent("VP:MINING:TryToGetMineral", mineral_item)
                            break
                        end
                    end
                end
            )
        end
    end
)

RegisterNetEvent("VP:MINING:StartMiningAnimation")
AddEventHandler(
    "VP:MINING:StartMiningAnimation",
    function()
        isMining = true
        TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_HUMAN_PICKAXE_WALL"), 20000, true, false, false, false)
        -- exports['progressBars']:startUI(2000, 'Minerando')
        Wait(20000)
        ClearPedTasksImmediately(PlayerPedId())
        isMining = false

        TriggerServerEvent("VP:MINING:CollectMineral")
    end
)

RegisterNetEvent("VP:MINING:processanim")
AddEventHandler(
    "VP:MINING:processanim",
    function(num)
        TaskStartScenarioInPlace(PlayerPedId(), GetHashKey("WORLD_HUMAN_CLEAN_TABLE"), 20000, true, false, false, false) -- colocar uma animação para processar
        --exports['progressBars']:startUI(20000, Language.translate[Config.lang]['process'])
        Wait(20000)
        TriggerServerEvent("VP:MINING:processitem", num)
        ClearPedTasksImmediately(PlayerPedId())
    end
)

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str, Citizen.ResultAsLong())
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then
        SetTextDropshadow(1, 0, 0, 0, 255)
    end
    Citizen.InvokeNative(0xADA9255D, 10)
    DisplayText(str, x, y)
end

function CreateVarString(p0, p1, variadic)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end
