local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

cAPI = Proxy.getInterface("API")
API = Tunnel.getInterface("API")

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            if IsControlJustPressed(0, 0xC1989F95) and not opened then
                TriggerServerEvent("VP:INVENTORY:OpenPersonal")
                opened = true
            end

            --[[
            if IsControlJustPressed(0, 0x3076E97C) then -- NUMPAD 6
                SendNUIMessage(
                    {
                        type = "nextHotbarSlot"
                    }
                )
                Wait(500)
            end 
            --]]
        end
    end
)

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

                            TriggerServerEvent("VP:INVENTORY:SaveWeaponAmmoOnDB", slotId, inClip, ammoRemaining)
                        end
                    end
                end
            end
        end
    end
)

local currentlyTryingToSendItem = false
local prompt_senditem

function startLookingForAPlayerToSend(slotId)
    if currentlyTryingToSendItem then
        return
    end

    closeInv()

    currentlyTryingToSendItem = true

    local lastTargetPlayerServerId = nil

    prompt_senditem = PromptRegisterBegin()
    PromptSetControlAction(prompt_senditem, 0x07CE1E61)
    PromptSetText(prompt_senditem, CreateVarString(10, "LITERAL_STRING", "Enviar"))
    PromptSetEnabled(prompt_senditem, true)
    PromptSetVisible(prompt_senditem, false)
    PromptSetHoldMode(prompt_senditem, true)
    PromptRegisterEnd(prompt_senditem)

    Citizen.CreateThread(
        function()
            local timeRemaining = 10
            while currentlyTryingToSendItem do
                local y, entity = GetPlayerTargetEntity(PlayerId())

                lastTargetPlayerServerId = nil

                if y then
                    for _, pid in pairs(GetActivePlayers()) do
                        if NetworkIsPlayerActive(pid) then
                            local pped = GetPlayerPed(pid)
                            if entity == pped then
                                local serverId = GetPlayerServerId(pid)
                                if lastTargetPlayerServerId ~= serverId then
                                    lastTargetPlayerServerId = serverId
                                    PromptSetVisible(prompt_senditem, true)
                                    PromptSetGroup(prompt_senditem, PromptGetGroupIdForTargetEntity(entity))

                                    local pPosition = GetEntityCoords(PlayerPedId())
                                    local tPosition = GetEntityCoords(entity)

                                    local dist = #(pPosition - tPosition)

                                    if dist <= 1.5 then
                                        PromptSetEnabled(prompt_senditem, true)
                                    else
                                        PromptSetEnabled(prompt_senditem, false)
                                    end

                                    break
                                end
                            end
                        end
                    end
                end

                if lastTargetPlayerServerId == nil then
                    PromptSetVisible(prompt_senditem, false)
                end

                Citizen.Wait(250)

                timeRemaining = timeRemaining - 0.25

                if timeRemaining <= 0 then
                    currentlyTryingToSendItem = false
                end
            end
        end
    )

    Citizen.CreateThread(
        function()
            while currentlyTryingToSendItem do
                Citizen.Wait(0)
                if lastTargetPlayerServerId ~= nil then
                    if PromptHasHoldModeCompleted(prompt_senditem) then
                        PromptDelete(prompt_senditem)
                        prompt_senditem = nil

                        currentlyTryingToSendItem = false
                        TriggerServerEvent("VP:INVENTORY:SendToPlayer", slotId, lastTargetPlayerServerId)
                    end
                end
            end

            PromptDelete(prompt_senditem)
            prompt_senditem = nil
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
        slots = computeSlots(slots, true)

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
        slots = computeSlots(slots, false)

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
        slots = computeSlots(slots, true)

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
        slots = computeSlots(slots, false)

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

-- RegisterNUICallback(
--     "interactWithHotbarSlot",
--     function(cb)
--         local itemId = cb.itemId or "unarmed"
--         local weaponId = "weapon_" .. itemId
--         local weaponHash = GetHashKey(weaponId)

--         local ped = PlayerPedId()

--         local _, currentWeapon = GetCurrentPedWeapon(ped, true, 0, true)
--         if currentWeapon ~= weaponHash then
--             Citizen.InvokeNative(0x5E3BDDBCB83F3D84, ped, weaponHash, 0, true, true)
--             TaskReloadWeapon(ped, 0)
--         end
--     end
-- )

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

AddEventHandler(
    "onResourceStop",
    function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then
            return
        end
        if prompt_senditem ~= nil then
            PromptDelete(prompt_senditem)
        end
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

function computeSlots(table, asPrimary)
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

            if itemInfo.type == "weapon" and asPrimary then
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
                            -- GiveWeaponToPed(ped, weaponHash, ammoInWeapon, false, false)
                            -- cAPI.giveWeapon(weaponId, ammoInWeapon, false)
                            Citizen.InvokeNative(0x5E3BDDBCB83F3D84, ped, weaponHash, ammoInWeapon, true, true)
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
