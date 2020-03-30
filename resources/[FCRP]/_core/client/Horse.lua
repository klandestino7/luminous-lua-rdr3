local horseModel
local horseEntity
local horseName
local horsePrompt

function cAPI.setHorse(model, name)
    horseModel = model
    horseName = name
end

function cAPI.clearHorse()
    if horseEntity ~= nil then
        SetVehicleHasBeenOwnedByPlayer(horseEntity, false)
    end
    horseModel = nil
    horseEntity = nil
    horseName = nil
    horsePrompt = nil
end

function cAPI.getHorseEnt()
    return horseEntity
end

function cAPI.spawnHorse()
    local ped = PlayerPedId()
    local pCoords = GetEntityCoords(ped)
    print('spawn')
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
    -- SetRandomOutfitVariation(horseEntity, true)
    Citizen.InvokeNative(0x283978A15512B2FE, horseEntity, true)
   -- Citizen.InvokeNative(0x283978A15512B2FE, horseEntity, true)
    Citizen.InvokeNative(0x58A850EAEE20FAA3, horseEntity)
    Citizen.InvokeNative(0x23f74c2fda6e7c61, -1230993421, horseEntity)
    SetVehicleHasBeenOwnedByPlayer(horseEntity, true)
    SetPedNameDebug(horseEntity, horseModel)
    SetPedPromptName(horseEntity, horseName)
    
   -- Citizen.InvokeNative(0xD3A7B003ED343FD9, horseEntity, 0xFD4E14C5, true, true, true) --saddle
    --Citizen.InvokeNative(0xD3A7B003ED343FD9, horseEntity, 0x508B80B9, true, true, true) --blanket
    -- Citizen.InvokeNative(0xD3A7B003ED343FD9, horseEntity, 0x16923E26, true, true, true) --mane
    -- Citizen.InvokeNative(0xD3A7B003ED343FD9, horseEntity, 0xF867D611, true, true, true) --tail
 --   Citizen.InvokeNative(0xD3A7B003ED343FD9, horseEntity, 0xF0C30271, true, true, true) --bag
   --- Citizen.InvokeNative(0xD3A7B003ED343FD9, horseEntity, 0x12F0DF9F, true, true, true) --bedroll
  --  Citizen.InvokeNative(0xD3A7B003ED343FD9, horseEntity, 0x67AF7302, true, true, true) --stirups

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

--     Citizen.InvokeNative(0x8538F1205D60ECA6, horseEntity, "HorseHandling", GetHashKey('HORSE_HANDLING_RACE'))
-- 	Citizen.InvokeNative(0x8538F1205D60ECA6, horseEntity, "HorseType", GetHashKey('HORSE_CLASS_RACE'))
-- --	Citizen.InvokeNative(0x8538F1205D60ECA6, horseEntity, "HorseBreed", GetHashKey(fufrp_1359(iVar1)));
-- 	Citizen.InvokeNative(0x8538F1205D60ECA6, horseEntity, "HorseCoat", GetHashKey('COAT_CHOCR'))
-- 	Citizen.InvokeNative(0x8538F1205D60ECA6, horseEntity, "HorseGender", GetHashKey('HORSE_GENDER_FEMALE'))

    SetModelAsNoLongerNeeded(horseEntity)
end


function cAPI.stablecloth(hash)
    local model2 = GetHashKey(tonumber(hash))
    if not HasModelLoaded(model2) then
        Citizen.InvokeNative(0xFA28FE3A6246FC30, model2)
    end
    Citizen.InvokeNative(0xD3A7B003ED343FD9 , horseEntity,  tonumber(hash), true, true, true)
end

function cAPI.setHorseClothes(hash)
--	local Clothe = json.decode(hash)
    if hash ~= "{}" then
        print('TEM MODIF')
       -- for k, v in pairs(Clothe) do		
            local modelHash = tonumber(v)
            cAPI.LoadModel(modelHash)
            Citizen.InvokeNative(0xD3A7B003ED343FD9, horseEntity, modelHash, true, true, true)        
      --  end	
    else
        print('NÃO TEM MODIF')
		if GetEntityModel(horseEntity) == GetHashKey(k) then
            local modelHash = tonumber(v)
            cAPI.LoadModel(modelHash)
            Citizen.InvokeNative(0xD3A7B003ED343FD9, horseEntity, 0xFD4E14C5, true, true, true) --saddle
            Citizen.InvokeNative(0xD3A7B003ED343FD9, horseEntity, 0x508B80B9, true, true, true) --blanket
		end
    end
	return true
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
                                TriggerServerEvent('FCRP:HORSE:openChest')
                            end
                        end
                        if IsControlJustPressed(2, 0x24978A28) then
                            TaskGoToEntity(horseEntity, ped, -1, 7.2, 2.0, 0, 0)
                        end
                    else
                        horseEntity = nil
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
    'onResourceStop',
    function(resourceName)
        if GetCurrentResourceName() ~= resourceName then
            return
        end

        if horsePrompt ~= nil then
        end
    end
)
