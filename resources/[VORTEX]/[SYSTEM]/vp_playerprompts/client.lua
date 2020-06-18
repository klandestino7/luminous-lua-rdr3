local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

local targetedNonPlayerEntity

local targetedPlayerEntity
local targetedPlayerServerId
local targetedPlayerUserId

local options_isAnAdmin = false
local options_isATrooper = false
local options_isAMedic = false

Citizen.CreateThread(
    function()
        CreatePrompts()

        while true do
            Citizen.Wait(100)

            options_isAnAdmin = cAPI.hasGroupOrInheritance("admin")
            options_isATrooper = cAPI.hasGroupOrInheritance("trooper")
            options_isAMedic = cAPI.hasGroupOrInheritance("medic")

            local ped = PlayerPedId()

            local _nonPlayer

            local _targetedPlayerEntity
            local _targetedPlayerServerId
            local _targetedPlayerUserId

            local isTargetting, entity = GetPlayerTargetEntity(PlayerId())

            if isTargetting then
                if IsEntityAPed(entity) and IsPedHuman(entity) then
                    if IsPedAPlayer(entity) then
                        for _, pid in pairs(GetActivePlayers()) do
                            local pped = GetPlayerPed(pid)
                            if pped == entity then
                                _targetedPlayerEntity = entity
                                _targetedPlayerServerId = GetPlayerServerId(pid)
                                _targetedPlayerUserId = cAPI.GetUserIdFromServerId(_targetedPlayerServerId)
                                break
                            end
                        end
                    else
                        _nonPlayer = entity
                    end
                end
            else
                local pPosition = GetEntityCoords(ped)
                local cameraRotation = GetGameplayCamRot()
                local cameraCoord = GetGameplayCamCoord()
                local direction = RotationToDirection(cameraRotation)
                local aimingAtVector = vec3(cameraCoord.x + direction.x * 7.0, cameraCoord.y + direction.y * 7.0, cameraCoord.z + direction.z * 7.0)
                -- local rayHandle = StartShapeTestCapsule(pPosition, aimingAtVector, 20, 12, ped, 0)
                local rayHandle = StartShapeTestRay(cameraCoord, aimingAtVector, -1, ped, 0)
                local _, hit, endCoords, _, entityHit = GetShapeTestResult(rayHandle)
                if hit ~= 0 then
                    if IsEntityAPed(entityHit) and IsPedHuman(entityHit) and IsEntityDead(entityHit) then -- and IsPedAPlayer(entityHit) then
                        -- Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, GetEntityCoords(ped), endCoords, 0, 255, 20, 255)
                        _nonPlayer = entityHit
                    else
                        -- Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, GetEntityCoords(ped), aimingAtVector, 255, 0, 0, 170)
                    end
                else
                    -- Citizen.InvokeNative(GetHashKey("DRAW_LINE") & 0xFFFFFFFF, GetEntityCoords(ped), aimingAtVector, 255, 0, 0, 170)
                end
            end

            -- print(_nonPlayer, targetedNonPlayerEntity)

            if _nonPlayer ~= targetedNonPlayerEntity then
                targetedNonPlayerEntity = _nonPlayer
            end

            if _targetedPlayerUserId ~= targetedPlayerUserId then
                targetedPlayerUserId = _targetedPlayerUserId
            end

            if _targetedPlayerEntity ~= targetedPlayerEntity then
                targetedPlayerEntity = _targetedPlayerEntity
            end

            if _targetedPlayerServerId ~= targetedPlayerServerId then
                targetedPlayerServerId = _targetedPlayerServerId
            end
        end
    end
)

Citizen.CreateThread(
    function()
        -- local animDict = "script_re@mech_patdown"
        -- animDict = "mech_pickup@loot_body@face_down@loot@base"

        -- if not HasAnimDictLoaded(animDict) then
        --     RequestAnimDict(animDict)
        --     while not HasAnimDictLoaded(animDict) do
        --         Citizen.Wait(0)
        --     end
        -- end

        -- TaskPlayAnim(PlayerPedId(), animDict, "loot_loop_plyr", 4.0, -4.0, -1, 31, 0.0, false, 0, false, 0, false)
        -- TaskPlayAnim(entity, animDict, "search_chest_r", 4.0, -4.0, -1, 32, 0.0, false, 0, false, 0, false)

        while true do
            Citizen.Wait(0)

            DisableControlAction(0, 0xF8982F00, true)

            if targetedNonPlayerEntity ~= nil or targetedPlayerEntity ~= nil then
                local ped = PlayerPedId()

                local entity
                local isAPlayer = false
                local name = "Pessoa Desconhecida"

                -- isAPlayer = true

                if targetedNonPlayerEntity ~= nil then
                    entity = targetedNonPlayerEntity
                else
                    entity = targetedPlayerEntity
                    isAPlayer = true

                    -- name = "Pessoa "

                    if options_isAnAdmin or options_isATrooper or options_isAMedic then
                        name = name .. " " .. targetedPlayerUserId
                    end
                end

                local isANpc = not isAPlayer
                local isDead = IsEntityDead(entity)
                local isAlive = not isDead

                local distance = #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(entity))

                -- group, name, numpages, startpage(index 0),
                PromptSetActiveGroupThisFrame(fakeplayer_promptgroup, CreateVarString(10, "LITERAL_STRING", name), 6, 0, 0, 0)

                -- PUXAR A ARMA
                if IsControlJustPressed(0, 0x07CE1E61) then
                    local bestWeapon = GetBestPedWeapon(ped, 0, 0)
                    if bestWeapon ~= GetHashKey("WEAPON_UNARMED") then
                        ClearPedTasksImmediately(ped)
                        ClearPedSecondaryTask(ped)

                        SetCurrentPedWeapon(ped, bestWeapon, true)

                        DisableControlAction(0, 0x07CE1E61, true)
                    end
                end

                if isAPlayer then
                    PromptSetEnabled(prompt_patdown, false)

                    if isAlive then
                        if distance <= 1.5 then
                            if IsEntityPlayingAnim(entity, "script_proc@robberies@shop@rhodes@gunsmith@inside_upstairs", "handsup_register_owner", 3) then
                                PromptSetEnabled(prompt_patdown, true)
                            end

                            if not options_isATrooper then
                                PromptSetVisible(prompt_trooper_cuff, false)
                                PromptSetVisible(prompt_trooper_uncuff, false)
                            end

                            if options_isATrooper then
                                local entity_hasClearLOS = HasEntityClearLosToEntityInFront(entity, ped, 0)
                                local player_hasClearLOS = HasEntityClearLosToEntityInFront(ped, entity, 0)

                                if entity_hasClearLOS or not player_hasClearLOS then
                                    if not IsPedCuffed(entity) then
                                        PromptSetVisible(prompt_trooper_uncuff, false)

                                        PromptSetVisible(prompt_trooper_cuff, true)
                                        PromptSetEnabled(prompt_trooper_cuff, false)
                                    else
                                        PromptSetVisible(prompt_trooper_cuff, false)

                                        PromptSetVisible(prompt_trooper_uncuff, true)
                                        PromptSetEnabled(prompt_trooper_uncuff, false)
                                    end
                                end

                                if not entity_hasClearLOS and player_hasClearLOS then
                                    if not IsPedCuffed(entity) then
                                        PromptSetVisible(prompt_trooper_uncuff, false)

                                        PromptSetVisible(prompt_trooper_cuff, true)
                                        PromptSetEnabled(prompt_trooper_cuff, true)
                                    else
                                        PromptSetVisible(prompt_trooper_cuff, false)

                                        PromptSetVisible(prompt_trooper_uncuff, true)
                                        PromptSetEnabled(prompt_trooper_uncuff, true)
                                    end
                                end
                            end
                        end
                    end

                    if isDead then
                        PromptSetEnabled(prompt_patdown, true)

                        PromptSetVisible(prompt_trooper_cuff, false)
                        PromptSetVisible(prompt_trooper_uncuff, false)
                    end
                end

                if isANpc then
                    PromptSetVisible(prompt_patdown, false)

                    PromptSetVisible(prompt_trooper_cuff, false)
                    PromptSetVisible(prompt_trooper_uncuff, false)

                    if isDead then
                    end
                end

                if isAlive then
                    PromptSetVisible(prompt_admin_revive, false)

                    PromptSetVisible(prompt_dead_pickup, false)
                end

                if isDead then
                    PromptSetVisible(prompt_admin_revive, false)

                    PromptSetVisible(prompt_dead_pickup, false)

                    -- if options_isAnAdmin then
                    PromptSetVisible(prompt_admin_revive, true)
                    -- end

                    if distance <= 2.25 then
                        PromptSetVisible(prompt_dead_pickup, true)
                    end

                    if PromptIsJustPressed(prompt_patdown) then
                        TriggerServerEvent("VP:SHERIFF:TryToPatDown", targetedPlayerServerId)
                    end

                    if PromptHasHoldModeCompleted(prompt_dead_pickup) then
                        quickHoldModeToggle(prompt_dead_pickup)

                        TaskPickupCarriableEntity(ped, entity)
                    end

                    if PromptHasHoldModeCompleted(prompt_admin_revive) then
                        quickHoldModeToggle(prompt_admin_revive)

                        ResurrectPed(entity)
                        SetEntityHealth(entity, GetEntityMaxHealth(entity))
                    end

                    if PromptHasHoldModeCompleted(prompt_trooper_uncuff) then
                        quickHoldModeToggle(prompt_trooper_uncuff)

                        -- SetEnableHandcuffs(entity, false, false)

                        TriggerServerEvent("VP:SHERIFF:cuffing", targetedPlayerServerId)
                    end

                    if PromptHasHoldModeCompleted(prompt_trooper_cuff) then
                        quickHoldModeToggle(prompt_trooper_cuff)

                        -- SetEnableHandcuffs(entity, true, false)

                        TriggerServerEvent("VP:SHERIFF:unlocking", targetedPlayerServerId)
                    end
                end
            end
        end
    end
)

function RotationToDirection(rotation)
    local adjustedRotation = {
        x = (math.pi / 180) * rotation.x,
        y = (math.pi / 180) * rotation.y,
        z = (math.pi / 180) * rotation.z
    }
    local direction = {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        z = math.sin(adjustedRotation.x)
    }
    return direction
end

function CreatePrompts()
    fakeplayer_promptgroup = GetRandomIntInRange(0, 0xffffff)

    prompt_patdown = newPrompt(0x05CA7C52, "Revistar", false, 0)

    prompt_dead_pickup = newPrompt(0xEB2AC491, "Pegar", true, 0)

    prompt_admin_revive = newPrompt(0x7F8D09B8, "Reviver", true, 5)

    prompt_trooper_cuff = newPrompt(0xEB2AC491, "Algemar", true, 1)

    prompt_trooper_uncuff = newPrompt(0x7F8D09B8, "Desalgemar", true, 1)
end

function newPrompt(control, text, hold, page)
    local prompt = PromptRegisterBegin()
    PromptSetControlAction(prompt, control)
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", text))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)

    if not hold then
        PromptSetStandardMode(prompt, 0)
    else
        PromptSetHoldMode(prompt, true)
    end

    PromptSetGroup(prompt, fakeplayer_promptgroup, page)
    PromptRegisterEnd(prompt)
    return prompt
end

function quickHoldModeToggle(prompt)
    PromptSetHoldMode(prompt, false)
    PromptSetHoldMode(prompt, true)
end

AddEventHandler(
    "OnResourceStop",
    function(resourceName)
        if resourceName == GetCurrentResourceName() then
            PromptDelete(prompt_patdown)
            PromptDelete(prompt_dead_pickup)
            PromptDelete(prompt_admin_revive)
            PromptDelete(prompt_trooper_cuff)
            PromptDelete(prompt_trooper_uncuff)
        end
    end
)

-- PromptSetActiveGroupThisFrame(prompt_group, CreateVarString(10, "LITERAL_STRING", itemAmount .. " " .. itemName .. " | " .. itemWeight .. "kg"))
-- if PromptHasHoldModeCompleted(prompt) then
--     PromptSetEnabled(prompt, false)
--     Citizen.CreateThread(
--         function()
--             Citizen.Wait(1000)
--             PromptSetEnabled(prompt, true)
--         end
--     )

--     TriggerServerEvent("VP:INVENTORY:PickedUpDroppedItem", indexInPickupRange)
-- end

--[[
    MEDIC:
        VIVO
            CURAR
        MORTO
            REVIVER
    TROOPER:
        VIVO
            ALGERMAR
    USER:
        SHARED
            ASSALTAR
        VIVO
            COLOCAR SACO NA CABEÇA
    ADMIN:
        MORTO
            REVIVER
]]
