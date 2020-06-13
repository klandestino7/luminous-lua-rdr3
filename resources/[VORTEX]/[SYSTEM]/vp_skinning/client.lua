AddEventHandler(
    "VP:EVENTS:PedFinishedGatheringPed",
    function(ped, pedGathered, bool_unk)
        local isHuman = IsPedHuman(pedGathered)

        if ped == PlayerPedId() then
            TriggerServerEvent("VP:SKINNING:Skinned", GetEntityModel(pedGathered), isHuman)
        end
    end
)
