local Proxy = module("_core", "libs/Proxy")
-- cAPI = Proxy.getInterface("API")
cPlayer = Proxy.getInterface('API:cPlayer')
cWrapper = Proxy.getInterface('API:cWrapper')

-- local Tunnel = module("_core", "libs/Tunnel")
-- API = Tunnel.getInterface("API")


Citizen.CreateThread(
    function()
        -- cPlayer:yell()
        while true do
            Citizen.Wait(3)

            local ped = PlayerPedId()

            verifyTryingToHandcuff(ped)
        end
    end
)

function verifyTryingToHandcuff(ped)
    if IsControlJustPressed(0, 47) then -- G_key
        local closestPlayers = cWrapper:GetClosestPlayers(1.5, 1)
        if #closestPlayers > 0 then
            local closestPlayerServerId = GetPlayerServerId(closestPlayers[1])
            TriggerServerEvent("VP:POLICE:TryToHandcuff", closestPlayerServerId)
        end
    end
end
