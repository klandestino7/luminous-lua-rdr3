local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

local spotPool = {
    vec3(-1753.07, -394.78, 156.18), --Cabana de Açougue de Strawberry
    vec3(-341.08, 767.16, 116.71), --Cabana de Açougue de Valentine
    vec3(1296.28, -1279.22, 75.84), --Cabana de Açougue de Rhodes
    vec3(-5507.733, -2947.984, -1.861), --Cabana de Açougue de Tumbleweed
    vec3(-930.643, -1392.803, 50.365)
}

local closestSpotIndex

local prompt
-- local prompt_name = CreateVarString(10, "LITERAL_STRING", "Açogueiro")

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            closeToButcher = false

            local ped = PlayerPedId()
            local pedVec = GetEntityCoords(ped)

            local closestDist

            for _, v in pairs(spotPool) do
                local dist = #(pedVec - v)
                if (dist <= 50 and closestDist == nil) or (closestDist ~= nil and dist < closestDist) then
                    closestDist = dist
                    closestSpotIndex = _
                end
            end
        end
    end
)

local lastCarriable

Citizen.CreateThread(
    function()
        InitiatePrompts()

        while true do
            Citizen.Wait(0)

            if lastCarriable ~= nil then
                if not DoesEntityExist(lastCarriable) then
                    lastCarriable = nil
                else
                    local ped = PlayerPedId()
                    local pedVec = GetEntityCoords(ped)

                    local carriableVec = GetEntityCoords(lastCarriable)

                    if #(pedVec - carriableVec) >= 500 then
                        lastCarriable = nil
                    end
                end
            end

            if closestSpotIndex ~= nil then
                local spotPosition = spotPool[closestSpotIndex]

                local pedPosition = GetEntityCoords(PlayerPedId())

                if #(pedPosition - spotPosition) <= 1.5 then
                    PromptSetActiveGroupThisFrame(prompt_group, CreateVarString(10, "LITERAL_STRING", "Açogueiro"))
                    HandlePrompts()
                end

                local carriedEntity = GetPedCarriedEntity()
                local type = GetEntityType(carriedEntity)
                -- 1 : animal
                -- 3 : pelt
                if carriedEntity ~= false and (type == 1 or type == 3) and not IsPedHuman(carriedEntity) then
                    lastCarriable = carriedEntity
                end

                if carriedEntity == false and lastCarriable ~= nil then
                    local carriableVec = GetEntityCoords(lastCarriable)

                    if #(carriableVec - spotPosition) <= 2.5 then
                        Citizen.InvokeNative(0x18FF3110CF47115D, lastCarriable, 2, false)
                        TriggerServerEvent("VP:ANIMAL_HUNTING:TryToEndQuest", type, GetEntityModel(lastCarriable), lastCarriable, GetAnimalCarcassQuality(lastCarriable))

                        lastCarriable = nil
                    end
                end
            end
        end
    end
)

-- RegisterNetEvent("VP:ANIMAL_HUNTING:taskMission")
-- AddEventHandler("VP:ANIMAL_HUNTING:taskMission", function(modelHash, modelName)
--         if DoesEntityExist(entity) then
--             -- if GetEntityModel(entity) == entModel then
--             Citizen.InvokeNative(0x18FF3110CF47115D, entity, 2, true)
--         -- end
--         end
-- end)

-- 0x964000D355219FC0
-- Hash _GET_ENTITY_NAME

function GetModelAnimalName(entityModel)
    if not HasModelLoaded(entityModel) then
        RequestModel(entityModel)
        while not HasModelLoaded(entityModel) do
            Citizen.Wait(10)
        end
    end

    local pedToDestroy = CreatePed(entityModel, GetEntityCoords(PlayerPedId()) + vec3(0, 0, 10.0), false, true, false)
    SetEntityAlpha(pedToDestroy, 0, 0)

    local animalNameLabelHash = Citizen.InvokeNative(0x964000D355219FC0, pedToDestroy)

    DeletePed(pedToDestroy)

    return GetLabelTextByHash(animalNameLabelHash)
end

RegisterNetEvent("VP:ANIMAL_HUNTING:NotifyAnimalName")
AddEventHandler(
    "VP:ANIMAL_HUNTING:NotifyAnimalName",
    function(type, entityModel)

        local r = {}

        if type == 1 then
            r = {"success", "Procure um(a) " .. GetModelAnimalName(entityModel) .. ' e traga para o açogueiro'}
        elseif type == 2 then
            r = {"alert", "O açougueiro ainda está a procura de um(a) " .. GetModelAnimalName(entityModel)}
        elseif type == 3 then
            r = {'error', 'Termine a caça atual para poder começar outra!'}
        end

        cAPI.notify(table.unpack(r))
    end
)

RegisterNetEvent("VP:ANIMAL_HUNTING:EntityAccepted")
AddEventHandler(
    "VP:ANIMAL_HUNTING:EntityAccepted",
    function(entity)
        if DoesEntityExist(entity) then
            -- if GetEntityModel(entity) == entModel then
            Citizen.InvokeNative(0x18FF3110CF47115D, entity, 2, true)

            while GetEntityAlpha(entity) > 0 do
                Citizen.Wait(1500)
                SetEntityAlpha(entity, GetEntityAlpha(entity) - 51)
            end

            DeleteEntity(entity)
        -- end
        end
    end
)

RegisterNetEvent("VP:ANIMAL_HUNTING:EntityNotAccepted")
AddEventHandler(
    "VP:ANIMAL_HUNTING:EntityNotAccepted",
    function(entity)
        if DoesEntityExist(entity) then
            -- if GetEntityModel(entity) == entModel then
            Citizen.InvokeNative(0x18FF3110CF47115D, entity, 2, true)
        -- end
        end
    end
)

function GetPedCarriedEntity()
    return Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
end

function GetAnimalCarcassQuality(Ped)
    local ret = Citizen.InvokeNative(0x88EFFED5FE8B0B4A, Ped)
    return ret ~= false and ret or 0
end

function HandlePrompts()
    if PromptHasHoldModeCompleted(prompt) then
        if IsControlPressed(0, 0xE8342FF2) then
            TriggerServerEvent("VP:ANIMAL_HUNTING:TryToStartQuest")
            Citizen.Wait(1000)
        end
    end
end

function InitiatePrompts()
    -- prompt_butcher = PromptRegisterBegin()
    -- PromptSetControlAction(prompt_butcher, 0x5966D52A)
    -- PromptSetText(prompt_butcher, CreateVarString(10, "LITERAL_STRING", ""))
    -- PromptSetEnabled(prompt_butcher, 1)
    -- PromptSetVisible(prompt_butcher, 1)
    -- PromptSetStandardMode(prompt_butcher, 1)
    -- Citizen.InvokeNative(0x0C718001B77CA468, prompt_butcher, 1.5)
    -- PromptRegisterEnd(prompt_butcher)

    prompt_group = GetRandomIntInRange(0, 0xffffff)

    prompt = PromptRegisterBegin()

    print(position, prompt, prompt_group)

    PromptSetControlAction(prompt, 0xE8342FF2)
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "Começar Caça de um ?"))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetHoldMode(prompt, true)
    -- Citizen.InvokeNative(0xAE84C5EE2C384FB3, prompt, position)
    -- Citizen.InvokeNative(0x0C718001B77CA468, prompt, 3.0)
    PromptSetGroup(prompt, prompt_group)
    PromptRegisterEnd(prompt)
end

-- RegisterNetEvent("VP:ANIMAL_HUNTING:AnimalHuntingPromptEnabled")
-- AddEventHandler(
--     "VP:ANIMAL_HUNTING:AnimalHuntingPromptEnabled",
--     function(toggle)
--         PromptSetEnabled(prompt, toggle)
--     end
-- )

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if GetCurrentResourceName() == resourceName then
            -- for _, prompt in pairs(prompts) do
            PromptDelete(prompt)
        -- end
        end
    end
)
