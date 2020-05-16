local horseModel
local horseName
local horseComponents = {}

local isHorseActive = false
local isHorseActivationBlocked = false
local horseActivationSeconds
local isHorseInWrithe = false

local prompt_inventory

function cAPI.GetPlayerHorse()
    return Citizen.InvokeNative(0xB48050D326E9A2F3, PlayerId(), Citizen.ResultAsInteger())
end

function cAPI.SetPlayerHorseHealth(value)
    local playerHorse = cAPI.GetPlayerHorse()
    if IsPedInjured(playerHorse) or IsPedInWrithe(playerHorse) then
        -- ResurrectPed(playerHorse)
        local horseCoords = GetEntityCoords(playerHorse)
        DeleteEntity(playerHorse)
        cAPI.InitiateHorse(horseCoords)
    end
end

function cAPI.VaryPlayerHorseHealth(value, secondsTillFillUp)
    local playerHorse = cAPI.GetPlayerHorse()
    if playerHorse ~= nil and playerHorse ~= 0 then
        Citizen.CreateThread(
            function()
                if secondsTillFillUp == nil then
                    secondsTillFillUp = 1
                end

                valuePerTick = value / secondsTillFillUp
                while secondsTillFillUp > 0 do
                    Citizen.InvokeNative(0xC6258F41D86676E0, playerHorse, 0, GetAttributeCoreValue(playerHorse, 0) + valuePerTick) -- SetAttributeCoreValue
                    SetEntityHealth(playerHorse, GetEntityHealth(playerHorse) + valuePerTick)

                    secondsTillFillUp = secondsTillFillUp - 1
                    Citizen.Wait(1000)
                end
            end
        )
    end
end

function cAPI.VaryPlayerHorseStamina(value, secondsTillFillUp)
    local playerHorse = cAPI.GetPlayerHorse()
    if playerHorse ~= nil and playerHorse ~= 0 then
        Citizen.CreateThread(
            function()
                if secondsTillFillUp == nil then
                    secondsTillFillUp = 1
                end

                valuePerTick = value / secondsTillFillUp
                while secondsTillFillUp > 0 do
                    Citizen.InvokeNative(0xC6258F41D86676E0, playerHorse, 1, GetAttributeCoreValue(playerHorse, 1) + valuePerTick) -- SetAttributeCoreValue
                    Citizen.InvokeNative(0xC3D4B754C0E86B9E, playerHorse, valuePerTick) -- _CHARGE_PED_STAMINA

                    secondsTillFillUp = secondsTillFillUp - 1
                    Citizen.Wait(1000)
                end
            end
        )
    end
end

function cAPI.IsPlayerMountedOnOwnHorse()
    local mount = GetMount(PlayerPedId())

    if mount == cAPI.GetPlayerHorse() then
        return true
    end

    return false
end

function cAPI.SetHorseInfo(horse_model, horse_name, horse_components)
    horseModel = horse_model
    horseName = horse_name
    horseComponents = horse_components
end

-- function cAPI.spawnHorse()
function cAPI.InitiateHorse(atCoords)
    cAPI.DestroyHorse()

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
    SetModelAsNoLongerNeeded(modelHash)

    _SetPlayerHorse(entity)

    local playerHorse = cAPI.GetPlayerHorse()
    
    if horseModel == GetHashKey("A_C_Horse_Turkoman_Gold") then
        _SetPedComponentEnabled(playerHorse, 0x106961A8) --sela
        _SetPedComponentEnabled(playerHorse, 0x508B80B9) --blanket
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
            _SetPedComponentEnabled(playerHorse, tonumber(componentHash))
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

function cAPI.DestroyHorse()
    if cAPI.GetPlayerHorse() ~= 0 then
        DeleteEntity(cAPI.GetPlayerHorse())
        _SetPlayerHorse(0)
    end
    isHorseActive = false
    isHorseActivationBlocked = false
    horseActivationSeconds = nil
end

function cAPI.SetHorseComponentEnabled(hash)
    local model2 = GetHashKey(tonumber(hash))
    if not HasModelLoaded(model2) then
        Citizen.InvokeNative(0xFA28FE3A6246FC30, model2)
    end
    Citizen.InvokeNative(0xD3A7B003ED343FD9, horseEntity, tonumber(hash), true, true, true)
end

function cAPI.setHorseComponents(components)
    horseComponents = components
    for _, componentHash in pairs(horseComponents) do
        Citizen.InvokeNative(0xD3A7B003ED343FD9, horseEntity, componentHash, true, true, true)
    end
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if isHorseActive then
                local playerHorse = cAPI.GetPlayerHorse()

                if not isHorseActivationBlocked then
                    if IsPedInjured(playerHorse) then
                        cAPI.notify("error", "Seu cavalo foi ferido, você não poderá chama-lo nos proximos 2 minutos")
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

                    if IsControlJustPressed(0, 0x4216AF06) then -- Mandar cavalo Fugir
                        TaskAnimalFlee(playerHorse, PlayerPedId(), -1)
                    -- cAPI.notify("alert", "Seu cavalo foi embora")
                    -- Wait(20000)
                    -- cAPI.DestroyHorse()
                    end
                else
                    if not IsPedInjured(playerHorse) then
                        isHorseActivationBlocked = false
                        horseActivationSeconds = nil
                    end
                end
            end

            if IsControlJustPressed(1, 0x24978A28) then -- Segurar H
                if isHorseActive and not isHorseActivationBlocked then
                    local playerHorse = cAPI.GetPlayerHorse()
                    if GetScriptTaskStatus(playerHorse, 0x4924437D, 0) ~= 0 then
                        TaskGoToEntity(playerHorse, PlayerPedId(), -1, 7.2, 2.0, 0, 0)
                    -- else
                    --     cAPI.notify("error", "Seu cavalo já está vindo")
                    end
                else
                    if not isHorseActivationBlocked then
                        cAPI.InitiateHorse()
                    else
                        cAPI.notify("error", "Seu cavalo está ferido, aguarde " .. horseActivationSeconds .. " segundos")
                    end
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)
            local playerHorse = cAPI.GetPlayerHorse()

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
                    cAPI.DestroyHorse()
                end
            end

            if isHorseInWrithe then
                if not IsPedInWrithe(playerHorse) then
                    isHorseInWrithe = false
                end
            else
                if IsPedInWrithe(playerHorse) then
                    cAPI.notify("alert", "Seu cavalo foi ferido, reanime-o")
                    isHorseInWrithe = true
                else
                    if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(playerHorse)) > 500.0 then
                        cAPI.DestroyHorse()
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
            cAPI.DestroyHorse()
        end
    end
)

function _SetPlayerHorse(horseEntity)
    Citizen.InvokeNative(0xD2CB0FB0FDCB473D, PlayerId(), horseEntity)
end

function _SetPedComponentEnabled(ped, component)
    Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, component, true, true, true)
end
