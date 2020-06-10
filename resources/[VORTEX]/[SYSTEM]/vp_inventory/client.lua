Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            if IsControlJustPressed(0, 0xC1989F95) and not opened then
                TriggerServerEvent("VP:INVENTORY:OpenPersonal")
                opened = true
            end

            if IsControlJustPressed(0, 0x3076E97C) then -- NUMPAD 6
                SendNUIMessage(
                    {
                        type = "nextHotbarSlot"
                    }
                )
                Wait(500)
            end
        end
    end
)

local sendingSlotId

local whereWeaponIsAtSlot = {}
local isReloadingOrShooting = false

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            local ped = PlayerPedId()

            -- 0x24B100C68C645951 IS_PED_RELOADING
            local _, currentWeapon = GetCurrentPedWeapon(ped, true, 0, true)
            if currentWeapon ~= GetHashKey("weapon_lasso") then
                if IsPedShooting(ped) or Citizen.InvokeNative(0x24B100C68C645951, ped) then
                    -- local wasReloading = false
                    while Citizen.InvokeNative(0x24B100C68C645951, ped) do
                        -- wasReloading = true
                        Citizen.Wait(0)
                    end
                    isReloadingOrShooting = true
                    for weaponId, slotId in pairs(whereWeaponIsAtSlot) do
                        local weaponHash = GetHashKey(weaponId)
                        if currentWeapon == weaponHash then
                            local _, inClip = GetAmmoInClip(ped, weaponHash)

                            local inWeapon = GetAmmoInPedWeapon(ped, weaponHash)
                            local ammoRemaining = math.floor(inWeapon - inClip)

                            -- if not wasReloading then
                            --     inClip = inClip - 1
                            -- end

                            -- print(weaponId .. " inClip: " .. inClip .. " Remaining: " .. ammoRemaining)

                            TriggerServerEvent("VP:INVENTORY:SaveWeaponAmmoOnDB", slotId, inClip, ammoRemaining)

                        -- local slots = {
                        --     [slotId] = {weaponId:gsub("weapon_", ""), 1, inClip, ammoRemaining}
                        -- [slotId] = {weaponId, 1, inClip, ammoRemaining}
                        -- }

                        -- SendNUIMessage(
                        --     {
                        --         primarySlots = computeSlots(slots, true)
                        --     }
                        -- )
                        end
                    end
                end
            end
        end
    end
)

local currentlyTryingToSendItem = false

function startLookingForAPlayerToSend(slotId)

    if currentlyTryingToSendItem then
        return
    end

    currentlyTryingToSendItem = true
    Citizen.CreateThread(
        function()
            local lastAimedPed
            local lastAimedPlayerIndex
            local lastAimedPlayerIndexName

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

            local prompt_group = GetRandomIntInRange(0, 0xffffff)

            local prompt_send = PromptRegisterBegin()
            PromptSetControlAction(prompt_send, 0x07CE1E61)
            PromptSetText(prompt_send, CreateVarString(10, "LITERAL_STRING", "Enviar"))
            PromptSetEnabled(prompt_send, true)
            PromptSetVisible(prompt_send, true)
            PromptSetHoldMode(prompt_send, true)
            PromptSetGroup(prompt_send, prompt_group)
            PromptRegisterEnd(prompt_send)

            local prompt_cancel = PromptRegisterBegin()
            PromptSetControlAction(prompt_cancel, 0xF84FA74F)
            PromptSetText(prompt_cancel, CreateVarString(10, "LITERAL_STRING", "Cancelar"))
            PromptSetEnabled(prompt_cancel, true)
            PromptSetVisible(prompt_cancel, true)
            PromptSetHoldMode(prompt_cancel, true)
            PromptSetGroup(prompt_cancel, prompt_group)
            PromptRegisterEnd(prompt_cancel)

            while true do
                Citizen.Wait(0)

                local closeToAPlayer= false
                local pPosition = GetEntityCoords(PlayerPedId())
                for _, index in pairs(GetActivePlayers()) do
                    local playerPed = GetPlayerPed(index)
                    if #(GetEntityCoords(playerPed) - pPosition) <= 10.0 then
                        closeToAPlayer = true
                        break
                    end
                end

                if closeToAPlayer == false then
                    PromptDelete(prompt_send)
                    PromptDelete(prompt_cancel)
                    break
                end

                local cameraRotation = GetGameplayCamRot()
                local cameraCoord = GetGameplayCamCoord()
                local direction = RotationToDirection(cameraRotation)
                local aimingAtVector = vec3(cameraCoord.x + direction.x * 5.0, cameraCoord.y + direction.y * 5.0, cameraCoord.z + direction.z * 5.0)

                local rayHandle = StartShapeTestRay(cameraCoord, aimingAtVector, 12, PlayerPedId(), 0)
                local _, hit, endCoords, _, entityHit = GetShapeTestResult(rayHandle)

                -- print(hit, endCoords, entityHit)

                if hit == 1 then
                    if (lastAimedPed == nil or lastAimedPed ~= entityHit) and IsPedAPlayer(lastAimedPed) then
                        lastAimedPed = entityHit

                        lastAimedPlayerIndex = NetworkGetPlayerIndexFromPed(lastAimedPed)
                        lastAimedPlayerIndexName = GetPlayerName(lastAimedPlayerIndex) or 'NPC'
                    else
                        if lastAimedPed ~= nil then
                            PromptSetActiveGroupThisFrame(prompt_group, CreateVarString(10, "LITERAL_STRING", lastAimedPlayerIndexName))

                            if PromptHasHoldModeCompleted(prompt_send) then
                                currentlyTryingToSendItem = false
                                PromptDelete(prompt_send)
                                PromptDelete(prompt_cancel)
                                TriggerServerEvent('VP:INVENTORY:SendToPlayer', slotId, GetPlayerServerId(lastAimedPlayerIndex))
                                break
                            end

                            if PromptHasHoldModeCompleted(prompt_cancel) then
                                currentlyTryingToSendItem = false
                                PromptDelete(prompt_send)
                                PromptDelete(prompt_cancel)
                                break
                            end
                        end
                    end
                end
            end
        end
    )
end

RegisterNetEvent("VP:INVENTORY:ToggleHotbar")
AddEventHandler(
    "VP:INVENTORY:ToggleHotbar",
    function(bool)
        SendNUIMessage(
            {
                type = "ToggleHotbar",
                val = bool
            }
        )
    end
)

RegisterNetEvent("VP:INVENTORY:closeInv")
AddEventHandler(
    "VP:INVENTORY:closeInv",
    function()
        closeInv()
    end
)

RegisterNetEvent("VP:INVENTORY:openAsPrimary")
AddEventHandler(
    "VP:INVENTORY:openAsPrimary",
    function(slots, inventoryWeight, inventoryMaxWeight)
        slots = computeSlots(slots)

        SetNuiFocus(true, true)
        SendNUIMessage(
            {
                type = "clearPrimary",
                primarySlots = slots,
                primaryWeight = inventoryWeight,
                primaryMaxWeight = inventoryMaxWeight
            }
        )
    end
)

RegisterNetEvent("VP:INVENTORY:openAsSecondary")
AddEventHandler(
    "VP:INVENTORY:openAsSecondary",
    function(slots, inventoryWeight, inventoryMaxWeight)
        slots = computeSlots(slots)

        SetNuiFocus(true, true)
        SendNUIMessage(
            {
                type = "clearSecondary",
                secondarySlots = slots,
                secondaryWeight = inventoryWeight,
                secondaryMaxWeight = inventoryMaxWeight
            }
        )
    end
)

RegisterNetEvent("VP:INVENTORY:PrimarySyncSlots")
AddEventHandler(
    "VP:INVENTORY:PrimarySyncSlots",
    function(slots, inventoryWeight)
        slots = computeSlots(slots)

        SendNUIMessage(
            {
                primarySlots = slots,
                primaryWeight = inventoryWeight
            }
        )
    end
)

RegisterNetEvent("VP:INVENTORY:SecondarySyncSlots")
AddEventHandler(
    "VP:INVENTORY:SecondarySyncSlots",
    function(slots, inventoryWeight)
        slots = computeSlots(slots)

        SendNUIMessage(
            {
                secondarySlots = slots,
                secondaryWeight = inventoryWeight
            }
        )
    end
)

RegisterNUICallback(
    "use",
    function(cb)
        TriggerServerEvent("VP:INVENTORY:Use", tonumber(cb.slotId))
    end
)

RegisterNUICallback(
    "drop",
    function(cb)
        -- TriggerServerEvent("VP:INVENTORY:Drop", tonumber(cb.slotId))
    end
)

RegisterNUICallback(
    "startsendingslot",
    function(cb)
        startLookingForAPlayerToSend(cb.slotId)
    end
)

RegisterNUICallback(
    "moveSlotToPrimary",
    function(cb)
        TriggerServerEvent("VP:INVENTORY:moveSlotToPrimary", cb.slotId, cb.itemAmount)
    end
)

RegisterNUICallback(
    "moveSlotToSecondary",
    function(cb)
        TriggerServerEvent("VP:INVENTORY:moveSlotToSecondary", cb.slotId, cb.itemAmount)
    end
)

RegisterNUICallback(
    "primarySwitchSlot",
    function(cb)
        TriggerServerEvent("VP:INVENTORY:PrimarySwitchSlot", cb.slotFrom, cb.slotTo, cb.itemAmount)
    end
)

RegisterNUICallback(
    "secondarySwitchSlot",
    function(cb)
        TriggerServerEvent("VP:INVENTORY:SecondarySwitchSlot", cb.slotFrom, cb.slotTo, cb.itemAmount)
    end
)

RegisterNUICallback(
    "interactWithHotbarSlot",
    function(cb)
        local itemId = cb.itemId or "unarmed"
        local weaponId = "weapon_" .. itemId
        local weaponHash = GetHashKey(weaponId)

        local ped = PlayerPedId()

        local _, currentWeapon = GetCurrentPedWeapon(ped, true, 0, true)
        if currentWeapon ~= weaponHash then
            Citizen.InvokeNative(0x5E3BDDBCB83F3D84, ped, weaponHash, 0, true, true)
            TaskReloadWeapon(ped, 0)
        end
    end
)

RegisterNUICallback(
    "NUIFocusOff",
    function()
        closeInv()
    end
)

AddEventHandler(
    "onResourceStart",
    function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then
            return
        end
        closeInv()
    end
)

function closeInv()
    SetNuiFocus(false, false)
    SendNUIMessage(
        {
            action = "hide"
        }
    )
    opened = false
    TriggerServerEvent("VP:INVENTORY:Close")
end

function computeSlots(table, shotOrReloaded)
    local ped = PlayerPedId()
    for slotId, values in pairs(table) do
        local itemInfo = ItemList[values[1]]

        if itemInfo ~= nil then
            local itemId = values[1]
            local itemAmount = values[2]

            local ammoInClip = values[3]
            local ammoInWeapon = values[4]

            values.itemName = itemInfo.name
            values.itemDescription = itemInfo.description or "Descrição"
            values.itemStackSize = itemInfo.stackSize or 1

            local itemType = itemInfo.type

            if itemInfo.type == "weapon" then
                -- ammoInClip = ammoInClip - 1
                values[3] = ammoInClip
                values[4] = ammoInWeapon

                if (slotId >= 129 and slotId <= 132) then
                    -- if not shotOrReloaded then
                    local weaponId = "weapon_" .. itemId
                    local weaponHash = GetHashKey(weaponId)

                    whereWeaponIsAtSlot[weaponId] = nil

                    if itemAmount > 0 then
                        for wId, slot in pairs(whereWeaponIsAtSlot) do
                            if slot == slotId and weaponId ~= wId then
                                local foundHash = GetHashKey(wId)
                                SetPedAmmo(ped, foundHash, 0)
                                RemoveWeaponFromPed(ped, foundHash)
                                whereWeaponIsAtSlot[wId] = nil
                            end
                        end

                        if not HasPedGotWeapon(ped, weaponHash, false) then
                            GiveWeaponToPed(ped, weaponHash, ammoInWeapon, false, false)
                        end

                        SetPedAmmo(ped, weaponHash, ammoInWeapon)
                        SetAmmoInClip(ped, weaponHash, ammoInClip)

                        whereWeaponIsAtSlot[weaponId] = slotId
                    else
                        if HasPedGotWeapon(ped, weaponHash, false) then
                            SetPedAmmo(ped, weaponHash, 0)
                            RemoveWeaponFromPed(ped, weaponHash)
                        end
                    end
                -- end
                end
            end
        end
    end

    return table
end

-- local promptUse
-- local promptDrop

-- Citizen.CreateThread(
--     function()
--         local prompt = PromptRegisterBegin()
--         local promptGroup = GetRandomIntInRange(0, 0xffffff)
--         PromptSetControlAction(prompt, 0x7F8D09B8)
--         PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "Usar Item"))
--         PromptSetEnabled(prompt, 1)
--         PromptSetVisible(prompt, 1)
--         PromptSetHoldMode(prompt, 1)
--         PromptSetGroup(prompt, promptGroup)
--         PromptRegisterEnd(prompt)

--         -- prompt2 = PromptRegisterBegin()
--         -- local promptGroup = GetRandomIntInRange(0, 0xffffff)
--         -- PromptSetControlAction(prompt2, 0x7F8D09B8)
--         -- PromptSetText(prompt2, CreateVarString(10, 'LITERAL_STRING', 'Dropar Item'))
--         -- PromptSetEnabled(prompt2, 1)
--         -- PromptSetVisible(prompt2, 1)
--         -- PromptSetHoldMode(prompt2, 1)
--         -- PromptSetGroup(prompt2, promptGroup)
--         -- PromptRegisterEnd(prompt2)
--         while true do
--             Citizen.Wait(0)
--             if opened then
--                 PromptSetActiveGroupThisFrame(promptGroup, CreateVarString(10, "LITERAL_STRING", "Inventário"))
--             end
--         end
--     end
-- )
