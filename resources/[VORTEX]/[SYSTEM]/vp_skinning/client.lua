AddEventHandler(
    "VP:EVENTS:PedFinishedGatheringPed",
    function(ped, pedGathered, bool_unk)
        print('PedFinishedGatheringPed triggered')
        local isHuman = IsPedHuman(pedGathered)

        if ped == PlayerPedId() and not isHuman then
            TriggerServerEvent("VP:SKINNING:Skinned", GetEntityModel(pedGathered))
        end
    end
)
