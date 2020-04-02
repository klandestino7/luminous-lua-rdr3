local horseModel
local horseEntity
local horseName
local horsePrompt
local horseComponents = {}

cAPI.Horse = {}
local Horse = cAPI.Horse

function Horse.Text(text)
    print(text)
end

function cAPI.setHorse(model, name, components)
    horseModel = model
    horseName = name
    horseComponents = components

end

function cAPI.clearHorse()
    if horseEntity ~= nil then
        SetVehicleHasBeenOwnedByPlayer(horseEntity, false)
    end
    horseModel = nil
    horseEntity = nil
    horseName = nil
    horsePrompt = nil
    horseComponents = {}
end

function cAPI.getHorseEnt()
    return horseEntity
end

function cAPI.spawnHorse()
    local ped = PlayerPedId()
    local pCoords = GetEntityCoords(ped)
    local modelHash = GetHashKey(horseModel)
    if not HasModelLoaded(modelHash) then
        RequestModel(modelHash)
        while not HasModelLoaded(modelHash) do
            Citizen.Wait(10)
        end
    end

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

    horseEntity = CreatePed(modelHash, nodePosition, GetEntityHeading(ped), 1, 0)

    if modelHash == 'A_C_Horse_MP_Mangy_Backup' then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, horseEntity, 0x106961A8, true, true, true) --sela
        Citizen.InvokeNative(0xD3A7B003ED343FD9, horseEntity, 0x508B80B9, true, true, true) --blanket
    end

    -- SetRandomOutfitVariation(horseEntity, true)
    -- ^^
    Citizen.InvokeNative(0x283978A15512B2FE, horseEntity, true)

    -- Citizen.InvokeNative(0x58A850EAEE20FAA3, horseEntity) -- PlaceObjectOnGroundProperly

    -- BlipAddForEntity(-1230993421, horseEntity)
    -- ^^
    Citizen.InvokeNative(0x23F74C2FDA6E7C61, -1230993421, horseEntity)

    SetVehicleHasBeenOwnedByPlayer(horseEntity, true)
    SetPedNameDebug(horseEntity, horseModel)
    SetPedPromptName(horseEntity, horseName)


    if horseComponents ~= nil then
        print(#horseComponents)        
        for _, componentHash in pairs(horseComponents) do
            Citizen.InvokeNative(0xD3A7B003ED343FD9, horseEntity, tonumber(componentHash), true, true, true)
        end
    end
    
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

    SetModelAsNoLongerNeeded(horseEntity)
end

function cAPI.stablecloth(hash)
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
            if horseEntity ~= nil then
                if DoesEntityExist(horseEntity) then
                    local ped = PlayerPedId()
                    local pCoords = GetEntityCoords(ped)

                    local dist = #(pCoords - GetEntityCoords(horseEntity))
                    if dist <= 100 then
                        if IsControlJustPressed(0, 0xC1989F95) then -- I
                            if dist <= 1.5 then
                                TriggerServerEvent("FCRP:HORSE:openChest")
                            end
                        end
                        if IsControlJustPressed(2, 0x24978A28) then
                            TaskGoToEntity(horseEntity, ped, -1, 7.2, 2.0, 0, 0)
                        end
                    else
                        horseEntity = nil
                    end

                    if IsControlJustPressed(0, 0x4216AF06) then -- Mandar cavalo Fugir
                        if horseEntity ~= nil then
                            TaskAnimalFlee(horseEntity, PlayerPedId() , -1)
                            Wait(20000)
                            cAPI.fleeHorse()
                        end       
                    end

                else
                    horseEntity = nil
                end
            else
                if IsControlJustPressed(1, 0x24978A28) then -- Segurar H
                    if horseModel and horseName then
                        if horseEntity == nil then
                            cAPI.spawnHorse()
                            TaskGoToEntity(horseEntity, PlayerPedId(), -1, 7.2, 2.0, 0, 0)
                        else
                            TaskGoToEntity(horseEntity, PlayerPedId(), -1, 7.2, 2.0, 0, 0)
                        end
                    else
                        -- print('Cavalo invalido! Relogue')
                    end
                end   
            end
        end
    end
)

function cAPI.fleeHorse()
    DeletePed(horseEntity)
end

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if GetCurrentResourceName() ~= resourceName then
            return
        end

        if horsePrompt ~= nil then
        end
    end
)
