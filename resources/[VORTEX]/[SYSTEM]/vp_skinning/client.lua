AddEventHandler(
    "VP:EVENTS:PedFinishedGatheringPed",
    function(ped, pedGathered, bool_unk)
        local isHuman = IsPedHuman(pedGathered)

        if ped == PlayerPedId() then
            TriggerServerEvent("VP:SKINNING:Skinned", GetEntityModel(pedGathered), isHuman, GetAnimalCarcassQuality(pedGathered))
        end
    end
)

function GetAnimalCarcassQuality(entity)
    local ret = Citizen.InvokeNative(0x88EFFED5FE8B0B4A, entity)
    return ret ~= false and ret or 0
end