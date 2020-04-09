local isPlayerDead = false

Citizen.CreateThread(function()

    while true do
        Citizen.Wait(0)

        local player = PlayerId()

        if NetworkIsPlayerActive(player) then
            local playerPed = PlayerPedId()

            if IsPedFatallyInjured(playerPed) and not isPlayerDead then
                isPlayerDead = true

                NetworkResurrectLocalPlayer(GetEntityCoords(playerPed), GetEntityHeading(playerPed, 2), true, false)

                local killer, killerWeapon = NetworkGetEntityKillerOfPlayer(player)
                local killerServerId = NetworkGetPlayerIndexFromPed(killer)
        
                if killer ~= playerPed and killerServerId ~= nil and NetworkIsPlayerActive(killerServerId) then
                    PlayerKilledByPlayer(GetPlayerServerId(killerServerId), killerServerId, killerWeapon)
                else
                    PlayerKilled()
                end

            elseif not IsPedFatallyInjured(playerPed) then
                isPlayerDead = false
            end
        end
    end
end)

local function PlayerKilledByPlayer(killerServerId, killerClientId, killerWeapon)
    local victimCoords = GetEntityCoords(PlayerPedId())
    local killerCoords = GetEntityCoords(GetPlayerPed(killerClientId))
    local distance     = GetDistanceBetweenCoords(victimCoords, killerCoords, true)

    local data = {
        killedByPlayer = true,
        deathCause     = killerWeapon,
        distance       = tonumber(distance),

        killerServerId = killerServerId,
        killerClientId = killerClientId
    } 

    TriggerEvent('fcrp:onPlayerDeath', data)
    TriggerServerEvent('fcrp:onPlayerDeath', data)
end

local function PlayerKilled()
    local playerPed = PlayerPedId()
    local victimCoords = GetEntityCoords(PlayerPedId())
    local data = {
        killedByPlayer = false,
        deathCause     = GetPedCauseOfDeath(playerPed)
    }
    TriggerEvent('fcrp:onPlayerDeath', data)
    TriggerServerEvent('fcrp:onPlayerDeath', data)
end

function cAPI.isPlayerDead()
    return isPlayerDead
end