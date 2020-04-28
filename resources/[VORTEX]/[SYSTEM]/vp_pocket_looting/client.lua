local pocketing = {}

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(100)

            local itemSet = CreateItemset(true)
            FindAllAttachedCarriableEntities(PlayerPedId(), itemSet)
            local size = GetItemsetSize(itemSet)

            if size > 0 then
                for index = 0, size - 1 do
                    local entity = GetIndexedItemInItemset(index, itemSet)

                    -- POCKETABLE ITEM
                    if GetEntityType(entity) == 3 and GetCarriableCarryConfig(entity) == -411455723 then
                        if not pocketing[entity] then
                            pocketing[entity] = GetEntityModel(entity)
                        end
                    end
                end
            end

            if IsItemsetValid(itemSet) then
                DestroyItemset(itemSet)
            end

            for entity, model in pairs(pocketing) do
                if not DoesEntityExist(entity) then
                    TriggerServerEvent("VP:POCKET_LOOTING:Pocket", model)
                    pocketing[entity] = nil
                end
            end
        end
    end
)

function GetCarriableCarryConfig(carriable)
    return Citizen.InvokeNative(0x0FD25587BB306C86, carriable)
end

RegisterNetEvent("VP:POCKET_LOOTING:ItemDenied")
AddEventHandler(
    "VP:POCKET_LOOTING:ItemDenied",
    function(entityModel)
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped) + (GetEntityForwardVector(ped) * 0.5)

        local entity = CreateObject(entityModel, coords, false, true, false)
        Citizen.InvokeNative(0xF0B4F759F35CC7F5, entity, -411455723, 0, 0, 0)
        Citizen.InvokeNative(0x7DFB49BCDB73089A, entity, true)
        PlaceObjectOnGroundProperly(entity)
    end
)
