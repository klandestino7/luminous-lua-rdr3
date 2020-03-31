RegisterNetEvent("CK:ADMIN:ChangeModel")
AddEventHandler(
    "CK:ADMIN:ChangeModel",
    function(pedModel)
        local hash = GetHashKey(pedModel)

        if not IsModelValid(hash) then
            return
        end

        if not HasModelLoaded(hash) then
            RequestModel(hash)
            while not HasModelLoaded(hash) do
                Citizen.wait(10)
            end
        end

        SetPlayerModel(PlayerId(), hash)
    end
)

RegisterNetEvent("deletarveiculo")
AddEventHandler(
    "deletarveiculo",
    function()
        TriggerServerEvent("trydeleteveh", VehToNet(vehicle))
    end
)
