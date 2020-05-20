local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

local horseModel
local horseName
local horseComponents = {}

horseModel = "A_C_Horse_Turkoman_Gold"
horseName = "Meu Cavalo"

local isHorseActive = false

local isHorseActivationBlocked = false
local horseActivationSeconds
local isHorseInWrithe = false

local prompt_inventory

playerHorse = 0

function NativeSetPlayerHorse(horseEntity)
    Citizen.InvokeNative(0xD2CB0FB0FDCB473D, PlayerId(), horseEntity)
end

function NativeSetPedComponentEnabled(ped, component)
    Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, component, true, true, true)
end

function SetHorseInfo(horse_model, horse_name, horse_components)
    horseModel = horse_model
    horseName = horse_name
    horseComponents = horse_components
end

function InitiateHorse(atCoords)
    DestroyHorse()

    isHorseActive = true

    local ped = PlayerPedId()
    local pCoords = GetEntityCoords(ped)

    local modelHash = GetHashKey(horseModel)

    if not HasModelLoaded(modelHash) then
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Citizen.Wait(10)
        end
    end

    local spawnPosition

    if atCoords == nil then
        local x, y, z = table.unpack(pCoords)
        local bool, nodePosition = GetClosestVehicleNode(x, y, z, 1, 3.0, 0.0)

        local index = 0
        while index <= 25 do
            local _bool, _nodePosition = GetNthClosestVehicleNode(x, y, z, index, 1, 3.0, 2.5)
            if _bool == true or _bool == 1 then
                bool = _bool
                nodePosition = _nodePosition
                index = index + 3
            else
                break
            end
        end

        spawnPosition = nodePosition
    else
        spawnPosition = atCoords
    end

    local entity = CreatePed(modelHash, spawnPosition, GetEntityHeading(ped), true, true)
    -- -- SetModelAsNoLongerNeeded(modelHash)

    Citizen.InvokeNative(0x283978A15512B2FE, entity, true)

    NativeSetPlayerHorse(entity)

    if horseModel == GetHashKey("A_C_Horse_Turkoman_Gold") then
        NativeSetPedComponentEnabled(playerHorse, 0x106961A8) --sela
        NativeSetPedComponentEnabled(playerHorse, 0x508B80B9) --blanket
    end

    Citizen.InvokeNative(0x283978A15512B2FE, playerHorse, true)

    -- SetVehicleHasBeenOwnedByPlayer(playerHorse, true)
    SetPedNameDebug(playerHorse, horseModel)
    SetPedPromptName(playerHorse, horseName)

    prompt_inventory = PromptRegisterBegin()
    PromptSetControlAction(prompt_inventory, 0xE8342FF2) -- L:ALT
    PromptSetText(prompt_inventory, CreateVarString(10, "LITERAL_STRING", "Inventário"))
    PromptSetEnabled(prompt_inventory, 1)
    PromptSetVisible(prompt_inventory, 1)
    PromptSetHoldMode(prompt_inventory, 1)

    PromptSetGroup(prompt_inventory, PromptGetGroupIdForTargetEntity(playerHorse))
    PromptRegisterEnd(prompt_inventory)

    if horseComponents ~= nil then
        for _, componentHash in pairs(horseComponents) do
            NativeSetPedComponentEnabled(playerHorse, tonumber(componentHash))
        end
    end

    TaskGoToEntity(playerHorse, ped, -1, 7.2, 2.0, 0, 0)

    SetPedConfigFlag(playerHorse, 297, true) -- Enable_Horse_Leadin

    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseSpeedValue", 8)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseSpeedMinValue", false)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseSpeedMaxValue", 10);
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseSpeedEquipmentValue", bVar2)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseSpeedEquipmentMinValue", false)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseSpeedEquipmentMaxValue", 10)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseSpeedCapacityValue", bVar3)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseSpeedCapacityMinValue", false)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseSpeedCapacityMaxValue", 10)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseAccValue", bVar4)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseAccMinValue", false)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseAccMaxValue", 10)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseAccEquipmentValue", bVar5)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseAccEquipmentMinValue", false)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseAccEquipmentMaxValue", 10)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseAccCapacityValue", bVar6)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseAccCapacityMinValue", false)
    -- Citizen.InvokeNative(0x307A3247C5457BDE, horseEntity, "HorseAccCapacityMaxValue", 10)

    -- Citizen.InvokeNative(0x8538F1205D60ECA6, horseEntity, "HorseHandling", GetHashKey('HORSE_HANDLING_RACE'))
    -- Citizen.InvokeNative(0x8538F1205D60ECA6, horseEntity, "HorseType", GetHashKey('HORSE_CLASS_RACE'))
    -- Citizen.InvokeNative(0x8538F1205D60ECA6, horseEntity, "HorseBreed", GetHashKey(fufrp_1359(iVar1)));
    -- Citizen.InvokeNative(0x8538F1205D60ECA6, horseEntity, "HorseCoat", GetHashKey('COAT_CHOCR'))
    -- Citizen.InvokeNative(0x8538F1205D60ECA6, horseEntity, "HorseGender", GetHashKey('HORSE_GENDER_FEMALE'))
end

function DestroyHorse()
    if NativeGetPlayerHorse() ~= 0 then
        DeleteEntity(NativeGetPlayerHorse())
        NativeSetPlayerHorse(0)
    end
    isHorseActive = false
    isHorseActivationBlocked = false
    horseActivationSeconds = nil
end

function SetHorseComponentEnabled(hash)
    local model2 = GetHashKey(tonumber(hash))
    if not HasModelLoaded(model2) then
        Citizen.InvokeNative(0xFA28FE3A6246FC30, model2)
    end
    Citizen.InvokeNative(0xD3A7B003ED343FD9, horseEntity, tonumber(hash), true, true, true)
end

function drawBoundingBox()
    if playerHorse ~= 0 then
        local min, max = GetModelDimensions(GetEntityModel(playerHorse))

        local horseCoords = GetEntityCoords(playerHorse)

        local z = min.z

        -- front = vec3(front.xy, z)
        -- local back =
        local A = GetOffsetFromEntityInWorldCoords(playerHorse, vec3(min.x, max.y, z))
        local B = GetOffsetFromEntityInWorldCoords(playerHorse, vec3(max.x, max.y, z))
        local C = GetOffsetFromEntityInWorldCoords(playerHorse, min)
        local D = GetOffsetFromEntityInWorldCoords(playerHorse, vec3(max.x, min.y, z))

        local coords = horseCoords - vec3(0, 0, 1.0)

        -- DrawLine(coords, front, 0, 255, 0, 255)
        DrawLine(coords, A, 255, 255, 255, 255)
        DrawLine(coords, B, 255, 255, 255, 255)
        DrawLine(coords, C, 255, 255, 255, 255)
        DrawLine(coords, D, 255, 255, 255, 255)

        -- raycastDrinkable()
        raycastEatable()
    end
end

function raycastDrinkable()
    local boneIndex = GetEntityBoneIndexByName(playerHorse, "skel_head")
    local bonePosition = GetWorldPositionOfEntityBone(playerHorse, boneIndex)
    local groundCoords = vec3(bonePosition.xy, A.z)
    local waterPosition = vec3(table.unpack(exports["vp_horse"]:js_native(bonePosition.x, bonePosition.y, bonePosition.z, groundCoords.x, groundCoords.y, groundCoords.z)))
    if waterPosition.x ~= 127 and waterPosition.y ~= 0 and waterPosition.z ~= 0 then
        DrawLine(bonePosition, waterPosition, 0, 0, 255, 255)
    else
        DrawLine(bonePosition, groundCoords, 255, 0, 0, 255)
    end
    DrawLine(coords, bonePosition, 255, 255, 0, 255)
end

function raycastEatable()
    local min, max = GetModelDimensions(GetEntityModel(playerHorse))

    local horseCoords = GetEntityCoords(playerHorse)

    local z = min.z

    local A = GetOffsetFromEntityInWorldCoords(playerHorse, vec3(min.x, max.y, z))

    local boneIndex = GetEntityBoneIndexByName(playerHorse, "skel_head")
    local bonePosition = GetWorldPositionOfEntityBone(playerHorse, boneIndex)

    local groundCoords = vec3(bonePosition.xy, A.z)

    local shapeTestRay = StartShapeTestRay(bonePosition, groundCoords, 256, playerHorse, 0)

    local retVal, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(shapeTestRay)

    if hit ~= 0 then
        DrawLine(bonePosition, endCoords, 255, 255, 0, 255)
    end
end

-- function setHorseComponents(components)
--     horseComponents = components
--     for _, componentHash in pairs(horseComponents) do
--         Citizen.InvokeNative(0xD3A7B003ED343FD9, horseEntity, componentHash, true, true, true)
--     end
-- end

function WhistleHorse()
    if isHorseActive and not isHorseActivationBlocked then
        if GetScriptTaskStatus(playerHorse, 0x4924437D, 0) ~= 0 then
            TaskGoToEntity(playerHorse, PlayerPedId(), -1, 7.2, 2.0, 0, 0)
        else
            -- cAPI.Toast("error", "Seu cavalo já está vindo")
        end
    else
        if not isHorseActivationBlocked then
            -- InitiateHorse(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 1.0, 1.0, 0.0))
            InitiateHorse()
        else
            cAPI.Toast("error", "Seu cavalo está ferido, aguarde " .. horseActivationSeconds .. " segundos")
        end
    end
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            playerHorse = NativeGetPlayerHorse()

            if isHorseActive then
                if not isHorseActivationBlocked then
                    if IsPedInjured(playerHorse) then
                        cAPI.Toast("error", "Seu cavalo foi ferido, você não poderá chama-lo nos proximos 2 minutos")
                        isHorseActivationBlocked = true
                        horseActivationSeconds = 120
                    end

                    if PromptHasHoldModeCompleted(prompt_inventory) then
                        PromptSetEnabled(prompt_inventory, false)
                        Citizen.CreateThread(
                            function()
                                Citizen.Wait(250)
                                PromptSetEnabled(prompt_inventory, true)
                            end
                        )

                        TriggerServerEvent("VP:HORSE:OpenInventory")
                    end

                    -- Flee
                    if IsControlJustPressed(0, 0x4216AF06) then -- F
                        TaskAnimalFlee(playerHorse, PlayerPedId(), -1)
                        Citizen.CreateThread(
                            function()
                                Citizen.Wait(10000)
                                DestroyHorse()
                            end
                        )
                    end
                else
                    if not IsPedInjured(playerHorse) then
                        isHorseActivationBlocked = false
                        horseActivationSeconds = nil
                    end
                end
            end

            if IsControlJustPressed(0, 0xE7EB9185) or IsControlJustPressed(1, 0x24978A28) then -- H, HistleHorseBack - H, Histle
                if GetScriptTaskStatus(PlayerPedId(), 0x1DE2A7BD, 0) ~= 1 then
                    local mount = GetMount(PlayerPedId())

                    if CanHorseDrink() then
                        if mount == playerHorse then
                            TaskDismountAnimal(PlayerPedId(), 1, 0, 0, 0, 0)
                            Citizen.CreateThread(
                                function()
                                    while GetScriptTaskStatus(PlayerPedId(), 0x1DE2A7BD, 0) == 1 do
                                        Wait(100)
                                    end
                                    ActionDrink()
                                end
                            )
                        else
                            local horsePosition = GetEntityCoords(playerHorse)

                            if #(GetEntityCoords(PlayerPedId()) - horsePosition) <= 5.0 then
                                ActionEat()

                                local horserRider = Citizen.InvokeNative(0xB676EFDA03DADA52, playerHorse, 0, Citizen.ResultAsInteger())
                                if horserRider ~= 0 then
                                    TaskDismountAnimal(horserRider, 1, 0, 0, 0, 0)
                                    Citizen.CreateThread(
                                        function()
                                            while GetScriptTaskStatus(horserRider, 0x1DE2A7BD, 0) == 1 do
                                                Wait(100)
                                            end
                                            ActionDrink()
                                        end
                                    )
                                else
                                    ActionDrink()
                                end
                            end
                        end
                    elseif CanHorseEat() then
                        if mount == playerHorse then
                            ActionEat()
                        end
                    else
                        if IsControlJustPressed(1, 0x24978A28) then -- H, Histle
                            if mount == 0 or mount ~= playerHorse then
                                WhistleHorse()
                            end
                        end
                    end
                end
            end

            if IsControlJustPressed(0, 0x7D5B3717) then --and IsControlJustPressed(0, 0xE4D2CE1D) then
                if IsPedOnMount(PlayerPedId()) then
                    --    TaskHorseAction(GetMount(PlayerPedId()), 2, 0, 0) -- dropar
                    TaskHorseAction(GetMount(PlayerPedId()), 5, 0, 0) -- empinar
                --  TaskHorseAction(GetMount(PlayerPedId()), 3, 0, 0) -- freiar
                end
            end

            if IsControlJustPressed(0, 0xE16B9AAD) then
                if IsPedOnMount(PlayerPedId()) then
                    TaskHorseAction(GetMount(PlayerPedId()), 3, 0, 0)
                end
            end

            -- drawBoundingBox()
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            local active = false

            if playerHorse ~= 0 and not IsPedInjured(playerHorse) and DoesEntityExist(playerHorse) then -- and DoesEntityExist(playerHorse) then
                active = true
            end

            isHorseActive = active

            if not PromptIsValid(prompt_inventory) then
                prompt_inventory = nil
            end

            if isHorseActivationBlocked then
                horseActivationSeconds = horseActivationSeconds - 1
                if horseActivationSeconds <= 0 then
                    DestroyHorse()
                end
            end

            if isHorseInWrithe then
                if not IsPedInWrithe(playerHorse) then
                    isHorseInWrithe = false
                end
            else
                if IsPedInWrithe(playerHorse) then
                    cAPI.Toast("alert", "Seu cavalo foi ferido, reanime-o")
                    isHorseInWrithe = true
                else
                    if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(playerHorse)) > 500.0 then
                        DestroyHorse()
                    end
                end
            end
        end
    end
)

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if GetCurrentResourceName() == resourceName then
            DestroyHorse()
        end
    end
)
