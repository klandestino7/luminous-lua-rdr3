AddEventHandler(
    "VP:EVENTS:PedFinishedGatheringEntity",
    function(ped, entity, bool_unk)
        if IsEntityAPed(entity) then
            local isHuman = IsPedHuman(entity)

            if ped == PlayerPedId() then
                TriggerServerEvent("VP:GATHERING:Gathered", GetEntityModel(entity), isHuman, GetAnimalCarcassQuality(pedGathered))
            end
        end
    end
)

function GetAnimalCarcassQuality(entity)
    local ret = Citizen.InvokeNative(0x88EFFED5FE8B0B4A, entity)
    return ret ~= false and ret or 0
end
