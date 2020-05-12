function cAPI.Initialize(model, clothing, lastPosition)
    local decodedLastPosition = json.decode(lastPosition)
    if decodedLastPosition.x ~= nil then
        decodedLastPosition = {decodedLastPosition.x, decodedLastPosition.y, decodedLastPosition.z}
    end

    cAPI.SetModel(model.model)
    Wait(130)
    cAPI.SetBodyType(PlayerPedId(), model.bodySize)
    cAPI.SetSkin(PlayerPedId(), model.modSkin)
    Wait(300)
    cAPI.SetFaceFeature(PlayerPedId(), json.decode(model.features))
    Wait(30)
    cAPI.SetPedSize(PlayerPedId(), model.pedSize)

    cAPI.replaceWeapons({})
    cAPI.SetCloth(clothing)
    Citizen.CreateThread(
        function()
            cAPI.PlaySkyCameraAnimationAtCoords(decodedLastPosition)
        end
    )

    TriggerEvent("ToogleBackCharacter")
    initializedPlayer = true
    Wait(1500)
    TriggerServerEvent('VP:RESPAWN:CheckDeath')
end

function cAPI.setAsInitialized(bool)
    initializedPlayer = bool
end

function cAPI.notify(type, text, quantity)
    if type ~= nil and text == nil and quantity == nil then
        text = type
        type = "dev"
    end

    TriggerEvent("VP:TOAST:New", type, text, quantity)
end


-- ///////////// DEATH SYSTEM 

local isPlayerDead = false

Citizen.CreateThread(function()

    while true do
        Citizen.Wait(0)

        local player = PlayerId()

        if NetworkIsPlayerActive(player) then
            local playerPed = PlayerPedId()

            if IsPedFatallyInjured(playerPed) and not isPlayerDead then
                isPlayerDead = true
                --NetworkResurrectLocalPlayer(GetEntityCoords(playerPed), GetEntityHeading(playerPed, 2), true, false)
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

function PlayerKilledByPlayer(killerServerId, killerClientId, killerWeapon)
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
    print(json.encode(data))
    TriggerEvent('VP:onPlayerDeath', data)
    TriggerServerEvent('VP:RESPAWN:onPlayerDeath', data)
end

function PlayerKilled()
    local playerPed = PlayerPedId()
    local victimCoords = GetEntityCoords(PlayerPedId())
    local data = {
        killedByPlayer = false,
        deathCause     = GetPedCauseOfDeath(playerPed)
    }
    print(json.encode(data))
    TriggerEvent('VP:onPlayerDeath', data)
    TriggerServerEvent('VP:RESPAWN:onPlayerDeath', data)
end

function cAPI.isPlayerDead()
    return isPlayerDead
end