function cAPI.Initialize(pedInfo, clothing, lastPosition, stats)
    local decodedLastPosition = json.decode(lastPosition)
    if decodedLastPosition.x ~= nil then
        decodedLastPosition = {decodedLastPosition.x, decodedLastPosition.y, decodedLastPosition.z}
    end

    local pModel = pedInfo.model
    local pBodySize = pedInfo.bodySize
    local pSkin = json.decode(pedInfo.modSkin)
    local pFaceFeatures = json.decode(pedInfo.features)
    local pScale = pedInfo.pedSize
    local pClothing

    if type(clothing) ~= "string" then
        if clothing <= 100 then
            pClothing = clothing
        end
    else
        pClothing = json.decode(clothing)
        print(pClothing)
    end

    local pStats = stats

    Citizen.CreateThread(
        function()
            cAPI.PlaySkyCameraAnimationAtCoords(decodedLastPosition)
            cAPI.PlayerAsInitialized(true)
        end
    )

    cAPI.replaceWeapons({})
    cAPI.SetPlayerPed(pModel)
    cAPI.SetPedBodyType(PlayerPedId(), pBodySize)
    cAPI.SetSkin(PlayerPedId(), pSkin)
    cAPI.SetPedFaceFeature(PlayerPedId(), pFaceFeatures)
    cAPI.SetPedScale(PlayerPedId(), pScale)
    cAPI.SetPedClothing(PlayerPedId(), pClothing)

    -- local pHealth = 250
    -- local pStamina = 34.0
    -- local pHealthCore = 100
    -- local pStaminaCore = 100
    -- if #pStats > 0 then
    pHealth = pStats[1] or 250
    pStamina = pStats[2] or 34.0
    pHealthCore = pStats[3] or 100
    pStaminaCore = pStats[3] or 100
    -- end

    cAPI.VaryPlayerHealth(pHealth)
    cAPI.VaryPlayerStamina(pStamina)
    cAPI.VaryPlayerCore(0, pHealthCore)
    cAPI.VaryPlayerCore(1, pStaminaCore)

    TriggerServerEvent("VP:RESPAWN:CheckDeath")
    TriggerServerEvent("API:pre_OnUserCharacterInitialization")
end

function cAPI.PlayerAsInitialized(bool)
    initializedPlayer = bool
end

function cAPI.IsPlayerInitialized()
    return initializedPlayer
end

function cAPI.notify(type, text, quantity)
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
    -- TriggerServerEvent("VP:RESPAWN:onPlayerDeath", data)
end

function PlayerKilled()
    local playerPed = PlayerPedId()
    local victimCoords = GetEntityCoords(PlayerPedId())

    local data = {
        killedByPlayer = false,
        deathCause = GetPedCauseOfDeath(playerPed)
    }

    TriggerEvent("VP:onPlayerDeath", data)
    -- TriggerServerEvent("VP:RESPAWN:onPlayerDeath", data)
end

function cAPI.isPlayerDead()
    return isPlayerDead
end

function cAPI.IsPlayerMountedOnOwnHorse()
    local mount = GetMount(PlayerPedId())

    if mount ~= 0 and mount == cAPI.GetPlayerHorse() then
        return true
    end

    return false
end

function cAPI.SetPlayerPosition(x, y, z)
    SetEntityCoords(PlayerPedId(), x + 0.0001, y + 0.0001, z + 0.0001, 1, 0, 0, 1)
end

function cAPI.VaryPlayerHealth(variation, variationTime)
    cAPI.VaryPedHealth(PlayerPedId(), variation, variationTime)
end

function cAPI.VaryPlayerStamina(variation, variationTime)
    cAPI.VaryPedStamina(PlayerPedId(), variation, variationTime)
end

function cAPI.VaryPlayerCore(core, variation, variationTime, goldenEffect)
    cAPI.VaryPedCore(PlayerPedId(), core, variation, variationTime, goldenEffect)
end

function cAPI.VaryHorseHealth(variation, variationTime)
    if cAPI.IsPlayerHorseActive() then
        cAPI.VaryPedHealth(cAPI.GetPlayerHorse(), variation, variationTime)
    end
end

function cAPI.VaryHorseStamina(variation, variationTime)
    if cAPI.IsPlayerHorseActive() then
        cAPI.VaryPedHealth(cAPI.GetPlayerHorse(), variation, variationTime)
    end
end

function cAPI.VaryHorseCore(core, variation, variationTime, goldenEffect)
    if cAPI.IsPlayerHorseActive() then
        cAPI.VaryPedCore(cAPI.GetPlayerHorse(), core, variation, variationTime, goldenEffect)
    end
end

local playerHorse = 0
local isHorseActivationBlocked = false
local horseActivationSeconds
local isHorseInWrithe = false

function cAPI.SetPlayerHorse(horse)
    playerHorse = horse
end

function cAPI.GetPlayerHorse()
    return playerHorse
end

function cAPI.IsPlayerHorseActive()
    return playerHorse ~= 0
end

function cAPI.IsPlayerHorseActivationBlocked()
    return isHorseActivationBlocked
end

function cAPI.DestroyPlayerHorse()
    if cAPI.GetPlayerHorse() ~= 0 then
        DeleteEntity(cAPI.GetPlayerHorse())
        cAPI.SetPlayerHorse(0)
    end
    isHorseActivationBlocked = false
    horseActivationSeconds = nil
end

Citizen.CreateThread(
    function()
        -- print(GetHashKey("BASE"))
        -- print(GetHashKey("CUSTOM"))
        -- print(GetHashKey("COMPONENT"))

        while true do
            Citizen.Wait(0)

            if cAPI.IsPlayerHorseActive() then
                if not isHorseActivationBlocked then
                    if IsPedInjured(playerHorse) then
                        cAPI.notify("error", "Seu cavalo foi ferido, você não poderá chama-lo nos proximos 2 minutos")
                        isHorseActivationBlocked = true
                        horseActivationSeconds = 120
                    end

                    if PromptHasHoldModeCompleted(prompt_inventory) then
                        PromptSetEnabled(prompt_inventory, false)
                        Citizen.CreateThread(
                            function()
                                Citizen.Wait(250)
                                PromptSetEnabled(prompt_inventory, true)
                            end
                        )

                        TriggerServerEvent("VP:HORSE:OpenInventory")
                    end

                    -- Flee
                    if IsControlJustPressed(0, 0x4216AF06) then -- F
                        TaskAnimalFlee(playerHorse, PlayerPedId(), -1)
                        Citizen.CreateThread(
                            function()
                                Citizen.Wait(10000)
                                cAPI.DestroyPlayerHorse()
                            end
                        )
                    end
                else
                    if not IsPedInjured(playerHorse) then
                        isHorseActivationBlocked = false
                        horseActivationSeconds = nil
                    end
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            if playerHorse ~= 0 and not DoesEntityExist(playerHorse) then -- and DoesEntityExist(playerHorse) then
                cAPI.DestroyPlayerHorse()
            end

            if isHorseActivationBlocked then
                horseActivationSeconds = horseActivationSeconds - 1
                if horseActivationSeconds <= 0 then
                    cAPI.DestroyPlayerHorse()
                end
            end

            if isHorseInWrithe then
                if not IsPedInWrithe(playerHorse) then
                    isHorseInWrithe = false
                end
            else
                if IsPedInWrithe(playerHorse) then
                    cAPI.notify("alert", "Seu cavalo foi ferido, reanime-o")
                    isHorseInWrithe = true
                else
                    if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(playerHorse)) > 500.0 then
                        cAPI.DestroyPlayerHorse()
                    end
                end
            end
        end
    end
)

local role = 0

RegisterNetEvent("VP:EVENTS:CharacterSetRole")
AddEventHandler(
    "VP:EVENTS:CharacterSetRole",
    function(_role)
        role = _role
    end
)

RegisterNetEvent("VP:EVENTS:CharacterJoinedGroup")
AddEventHandler(
    "VP:EVENTS:CharacterJoinedGroup",
    function(group)
        if not cAPI.hasGroup(group) then
            local bit = config_file_GROUPS[group:lower()]

            if bit ~= nil then
                role = role | bit
            end
        end
    end
)

RegisterNetEvent("VP:EVENTS:CharacterLeftGroup")
AddEventHandler(
    "VP:EVENTS:CharacterLeftGroup",
    function(group)
        if cAPI.hasGroup(group) then
            local bit = config_file_GROUPS[group:lower()]

            if bit ~= nil then
                role = role & (~bit)
            end
        end
    end
)

function cAPI.hasGroup(group)
    local bit = config_file_GROUPS[group:lower()]

    if bit ~= nil then
        return (role & bit) ~= 0
    end

    return false
end

function cAPI.hasGroupOrInheritance(group)
    if cAPI.hasGroup(group) then
        return true
    else
        for superGroup, childrenGroup in pairs(config_file_INHERITANCE) do
            if childrenGroup == group then
                if self:hasGroup(superGroup) then
                    return true
                end
            end
        end
    end

    return false
end
