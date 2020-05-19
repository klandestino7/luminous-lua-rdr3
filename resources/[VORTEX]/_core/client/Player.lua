
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
    local distance = GetDistanceBetweenCoords(victimCoords, killerCoords, true)
    
    local data = {
        killedByPlayer = true,
        deathCause = killerWeapon,
        distance = tonumber(distance),
        
        killerServerId = killerServerId,
        killerClientId = killerClientId
    }
    TriggerEvent('VP:onPlayerDeath', data)
    TriggerServerEvent('VP:RESPAWN:onPlayerDeath', data)
end

function PlayerKilled()
    local playerPed = PlayerPedId()
    local victimCoords = GetEntityCoords(PlayerPedId())
    
    local data = {
        killedByPlayer = false,
        deathCause = GetPedCauseOfDeath(playerPed)
    }
    
    TriggerEvent('VP:onPlayerDeath', data)
    TriggerServerEvent('VP:RESPAWN:onPlayerDeath', data)
end

function cAPI.isPlayerDead()
    return isPlayerDead
end

function cAPI.IsPlayerMountedOnOwnHorse()
    local mount = GetMount(PlayerPedId())
    
    if mount ~= 0 and mount == Citizen.InvokeNative(0xB48050D326E9A2F3, PlayerId(), Citizen.ResultAsInteger()) then
        return true
    end
    
    return false
end

function cAPI.VaryPlayerHorseHealth(value, secondsTillVary, goldenEffect)
    local playerHorse = Citizen.InvokeNative(0xB48050D326E9A2F3, PlayerId(), Citizen.ResultAsInteger())
    if playerHorse ~= nil and playerHorse ~= 0 then
        Citizen.CreateThread(
            function()
                
                if secondsTillVary ~= nil and secondsTillVary > 0 then
                    valuePerTick = value / secondsTillFillUp
                    while secondsTillFillUp > 0 do
                        Citizen.InvokeNative(0xC6258F41D86676E0, playerHorse, 0, GetAttributeCoreValue(playerHorse, 0) + valuePerTick)-- SetAttributeCoreValue
                        SetEntityHealth(playerHorse, GetEntityHealth(playerHorse) + valuePerTick)
                        
                        secondsTillFillUp = secondsTillFillUp - 1
                        Citizen.Wait(1000)
                        
                        if secondsTillFillUp <= 0 then
                            Citizen.InvokeNative(0xF6A7C08DF2E28B28, playerHorse, 0, 0.0, false)
                        end
                    end
                else
                    Citizen.InvokeNative(0xF6A7C08DF2E28B28, playerHorse, 0, GetAttributeCoreValue(playerHorse, 0) + value, goldenEffect or false)
                    Citizen.InvokeNative(0xC3D4B754C0E86B9E, playerHorse, value)
                    Citizen.InvokeNative(0xF6A7C08DF2E28B28, playerHorse, 0, 0.0, false)
                end
            end
    )
    end
end

function cAPI.VaryPlayerHorseStamina(value, secondsTillVary, goldenEffect)
    local playerHorse = Citizen.InvokeNative(0xB48050D326E9A2F3, PlayerId(), Citizen.ResultAsInteger())
    if playerHorse ~= nil and playerHorse ~= 0 then
        Citizen.CreateThread(
            function()
                if secondsTillVary ~= nil and secondsTillVary > 0 then
                    valuePerTick = value / secondsTillFillUp
                    while secondsTillFillUp > 0 do
                        Citizen.InvokeNative(0xC6258F41D86676E0, playerHorse, 1, GetAttributeCoreValue(playerHorse, 1) + valuePerTick)-- SetAttributeCoreValue
                        Citizen.InvokeNative(0xC3D4B754C0E86B9E, playerHorse, valuePerTick)-- _CHARGE_PED_STAMINA
                        
                        secondsTillFillUp = secondsTillFillUp - 1
                        Citizen.Wait(1000)
                        
                        if secondsTillFillUp <= 0 then
                            Citizen.InvokeNative(0xF6A7C08DF2E28B28, playerHorse, 1, 0.0, false)
                        end
                    end
                else
                    Citizen.InvokeNative(0xF6A7C08DF2E28B28, playerHorse, 1, GetAttributeCoreValue(playerHorse, 1) + value, goldenEffect or false)
                    Citizen.InvokeNative(0xC3D4B754C0E86B9E, playerHorse, value)
                    Citizen.InvokeNative(0xF6A7C08DF2E28B28, playerHorse, 1, 0.0, false)
                end
            end
    )
    end
end
