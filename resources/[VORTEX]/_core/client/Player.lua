function cAPI.Initialize(pedInfo, clothing, lastPosition)
    local decodedLastPosition = json.decode(lastPosition)
    if decodedLastPosition.x ~= nil then
        decodedLastPosition = {decodedLastPosition.x, decodedLastPosition.y, decodedLastPosition.z}
    end

    local pModel = pedInfo.model
    local pBodySize = pedInfo.bodySize
    local pSkin = json.decode(pedInfo.modSkin)
    local pFaceFeatures = json.decode(pedInfo.features)
    local pScale = pedInfo.pedSize
    local pClothing = json.decode(clothing)

    cAPI.SetPlayerPed(pModel)
    cAPI.replaceWeapons({})

    Citizen.CreateThread(
        function()
            cAPI.PlaySkyCameraAnimationAtCoords(decodedLastPosition)
        end
    )

    Citizen.CreateThread(
        function()
            Wait(6000)
            cAPI.SetPedBodyType(PlayerPedId(), pBodySize)

            cAPI.SetSkin(PlayerPedId(), pSkin)
            -- Wait(300
            cAPI.SetPedFaceFeature(PlayerPedId(), pFaceFeatures)
            -- Wait(30)
            cAPI.SetPedScale(PlayerPedId(), pScale)

            cAPI.SetPedClothing(PlayerPedId(), pClothing)
        end
    )

    TriggerEvent("ToogleBackCharacter")
    initializedPlayer = true
    Wait(1500)
    TriggerServerEvent("VP:RESPAWN:CheckDeath")
end

function cAPI.PlayerAsInitialized(bool)
    initializedPlayer = bool
end

function cAPI.Toast(type, text, quantity)
    if type ~= nil and text == nil and quantity == nil then
        text = type
        type = "dev"
    end

    TriggerEvent("VP:TOAST:New", type, text, quantity)
end

function cAPI.TeleportPlayerToWaypoint()
    if not IsWaypointActive() then
        return
    end

    local x, y, z = table.unpack(GetWaypointCoords())

    -- local ground
    -- local groundFound = false
    -- local groundCheckHeights = {
    -- 	0.0,
    -- 	50.0,
    -- 	100.0,
    -- 	150.0,
    -- 	200.0,
    -- 	250.0,
    -- 	300.0,
    -- 	350.0,
    -- 	400.0,
    -- 	450.0,
    -- 	500.0,
    -- 	550.0,
    -- 	600.0,
    -- 	650.0,
    -- 	700.0,
    -- 	750.0,
    -- 	800.0,
    -- 	850.0,
    -- 	900.0,
    -- 	950.0,
    -- 	1000.0,
    -- 	1050.0,
    -- 	1100.0
    -- }

    local ped = PlayerPedId()

    -- for i, height in ipairs(groundCheckHeights) do
    -- SetEntityCoordsNoOffset(ped, x, y, height, 0, 0, 1)

    RequestCollisionAtCoord(x, y, z)
    local retVal, groundZ, normal = GetGroundZAndNormalFor_3dCoord(x, y, z)

    if retVal == false then
        RequestCollisionAtCoord(x, y, z)
        local tries = 10
        while retVal == false and tries > 0 do
            Citizen.Wait(100)
            retVal, groundZ, normal = GetGroundZAndNormalFor_3dCoord(x, y, z)
            tries = tries - 1
        end

        z = (groundZ or 2000.0) + 1.0
    end
    -- end

    -- if not groundFound then
    -- 	z = 1200
    -- end

    SetEntityCoordsNoOffset(ped, x, y, z, 0, 0, 1)
end

-- ///////////// DEATH SYSTEM
local isPlayerDead = false

Citizen.CreateThread(
    function()
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
    end
)

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
    TriggerEvent("VP:onPlayerDeath", data)
    TriggerServerEvent("VP:RESPAWN:onPlayerDeath", data)
end

function PlayerKilled()
    local playerPed = PlayerPedId()
    local victimCoords = GetEntityCoords(PlayerPedId())

    local data = {
        killedByPlayer = false,
        deathCause = GetPedCauseOfDeath(playerPed)
    }

    TriggerEvent("VP:onPlayerDeath", data)
    TriggerServerEvent("VP:RESPAWN:onPlayerDeath", data)
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

function cAPI.SetPlayerPosition(x, y, z)
    SetEntityCoords(PlayerPedId(), x + 0.0001, y + 0.0001, z + 0.0001, 1, 0, 0, 1)
end

function cAPI.VaryPlayerHealth(value, secondsTillFillUp)
    Citizen.CreateThread(
        function()
            if secondsTillFillUp == nil then
                secondsTillFillUp = 1
            end

            local ped = PlayerPedId()

            if secondsTillFillUp == 1 then
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1.0, true)
            end

            valuePerTick = value / secondsTillFillUp
            while secondsTillFillUp > 0 do
                Citizen.InvokeNative(0xC6258F41D86676E0, ped, 0, GetAttributeCoreValue(ped, 0) + valuePerTick) -- SetAttributeCoreValue
                SetEntityHealth(ped, GetEntityHealth(ped) + valuePerTick)

                secondsTillFillUp = secondsTillFillUp - 1
                Citizen.Wait(1000)

                if secondsTillFillUp <= 0 then
                    Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 0.0, false)
                end
            end
        end
    )
end

function cAPI.VaryPlayerStamina(value, secondsTillFillUp)
    Citizen.CreateThread(
        function()
            if secondsTillFillUp == nil then
                secondsTillFillUp = 1
            end

            local ped = PlayerPedId()

            if secondsTillFillUp == 1 then
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1.0, true)
            end

            valuePerTick = value / secondsTillFillUp
            while secondsTillFillUp > 0 do
                Citizen.InvokeNative(0xC6258F41D86676E0, ped, 1, GetAttributeCoreValue(ped, 1) + valuePerTick) -- SetAttributeCoreValue
                Citizen.InvokeNative(0xC3D4B754C0E86B9E, ped, Citizen.InvokeNative(0x775A1CA7893AA8B5, ped) + valuePerTick)

                secondsTillFillUp = secondsTillFillUp - 1
                Citizen.Wait(1000)

                if secondsTillFillUp <= 0 then
                    Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 0.0, false)
                end
            end
        end
    )

    local ped = PlayerPedId()
    local n = math.floor(GetAttributeCoreValue(ped, 1) + variation)
end

function cAPI.VaryPlayerHorseHealth(value, secondsTillVary, goldenEffect)
    local playerHorse = Citizen.InvokeNative(0xB48050D326E9A2F3, PlayerId(), Citizen.ResultAsInteger())
    if playerHorse ~= nil and playerHorse ~= 0 then
        Citizen.CreateThread(
            function()
                if secondsTillVary ~= nil and secondsTillVary > 0 then
                    valuePerTick = value / secondsTillFillUp
                    while secondsTillFillUp > 0 do
                        Citizen.InvokeNative(0xC6258F41D86676E0, playerHorse, 0, GetAttributeCoreValue(playerHorse, 0) + valuePerTick)
                        -- SetAttributeCoreValue
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
                        Citizen.InvokeNative(0xC6258F41D86676E0, playerHorse, 1, GetAttributeCoreValue(playerHorse, 1) + valuePerTick)
                        -- SetAttributeCoreValue
                        Citizen.InvokeNative(0xC3D4B754C0E86B9E, playerHorse, valuePerTick)
                        -- _CHARGE_PED_STAMINA

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