Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)

            if IsControlJustPressed(0, 0xC1989F95) and not opened then
                TriggerServerEvent("FCRP:INVENTORY:OpenPersonal")
                opened = true
            end

            if IsControlJustPressed(0, 0x3076E97C) then -- NUMPAD 6
                SendNUIMessage(
                    {
                        type = "nextHotbarSlot"
                    }
                )
            end
        end
    end
)

local whereWeaponIsAtSlot = {}
local isReloadingOrShooting = false

-- Citizen.CreateThread(
--     function()
--         while true do
--             Citizen.Wait(0)
--             local ped = PlayerPedId()

--             -- 0x24B100C68C645951 IS_PED_RELOADING
--             local _, currentWeapon = Citizen.InvokeNative(0x3A87E44BB9A01D54, ped, 1, 1, 1)
--             if IsPedShooting(ped) or Citizen.InvokeNative(0x24B100C68C645951, ped) then
--                 -- local wasReloading = false
--                 while Citizen.InvokeNative(0x24B100C68C645951, ped) do
--                     -- wasReloading = true
--                     Citizen.Wait(0)
--                 end
--                 isReloadingOrShooting = true
--                 for weaponId, slotId in pairs(whereWeaponIsAtSlot) do
--                     local weaponHash = GetHashKey(weaponId)
--                     if currentWeapon == weaponHash then
--                         local _, inClip = GetAmmoInClip(ped, weaponHash)

--                         local inWeapon = GetAmmoInPedWeapon(ped, weaponHash)
--                         local ammoRemaining = math.floor(inWeapon - inClip)

--                         -- if not wasReloading then
--                         --     inClip = inClip - 1
--                         -- end

--                         -- print(weaponId .. " inClip: " .. inClip .. " Remaining: " .. ammoRemaining)

--                         TriggerServerEvent("VP:INVENTORY:SaveWeaponAmmoOnDB", slotId, inClip, ammoRemaining)

--                         local slots = {
--                             [slotId] = {weaponId:gsub("weapon_", ""), 1, inClip, ammoRemaining}
--                             -- [slotId] = {weaponId, 1, inClip, ammoRemaining}
--                         }

--                         SendNUIMessage(
--                             {
--                                 primarySlots = computeSlots(slots, true)
--                             }
--                         )
--                     end
--                 end
--             end
--         end
--     end
-- )

RegisterNetEvent("FCRP:INVENTORY:ToggleHotbar")
AddEventHandler(
    "FCRP:INVENTORY:ToggleHotbar",
    function(bool)
        SendNUIMessage(
            {
                type = "ToggleHotbar",
                val = bool
            }
        )
    end
)

RegisterNetEvent("FCRP:INVENTORY:closeInv")
AddEventHandler(
    "FCRP:INVENTORY:closeInv",
    function()
        closeInv()
    end
)

RegisterNetEvent("FCRP:INVENTORY:openAsPrimary")
AddEventHandler(
    "FCRP:INVENTORY:openAsPrimary",
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

RegisterNetEvent("FCRP:INVENTORY:openAsSecondary")
AddEventHandler(
    "FCRP:INVENTORY:openAsSecondary",
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

RegisterNetEvent("FCRP:INVENTORY:PrimarySyncSlots")
AddEventHandler(
    "FCRP:INVENTORY:PrimarySyncSlots",
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

RegisterNetEvent("FCRP:INVENTORY:SecondarySyncSlots")
AddEventHandler(
    "FCRP:INVENTORY:SecondarySyncSlots",
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
        TriggerServerEvent("FCRP:INVENTORY:Use", tonumber(cb.slotId))
    end
)

RegisterNUICallback(
    "drop",
    function(cb)
        TriggerServerEvent("FCRP:INVENTORY:Drop", tonumber(cb.slotId))
    end
)

RegisterNUICallback(
    "moveSlotToPrimary",
    function(cb)
        TriggerServerEvent("FCRP:INVENTORY:moveSlotToPrimary", cb.slotId, cb.itemAmount)
    end
)

RegisterNUICallback(
    "moveSlotToSecondary",
    function(cb)
        TriggerServerEvent("FCRP:INVENTORY:moveSlotToSecondary", cb.slotId, cb.itemAmount)
    end
)

RegisterNUICallback(
    "primarySwitchSlot",
    function(cb)
        TriggerServerEvent("FCRP:INVENTORY:PrimarySwitchSlot", cb.slotFrom, cb.slotTo, cb.itemAmount)
    end
)

RegisterNUICallback(
    "secondarySwitchSlot",
    function(cb)
        TriggerServerEvent("FCRP:INVENTORY:SecondarySwitchSlot", cb.slotFrom, cb.slotTo, cb.itemAmount)
    end
)

RegisterNUICallback(
    "interactWithHotbarSlot",
    function(cb)
        local itemId = cb.itemId or "unarmed"
        -- SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_" .. itemId), true)

        Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), GetHashKey("weapon_" .. itemId), 0, true, true)

        -- SetCurrentPedWeapon(PlayerPedId(), itemId, true)
        -- MakePedReload(ped)
        TaskReloadWeapon(ped, 0)
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
    TriggerServerEvent("FCRP:INVENTORY:Close")
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
                    if not shotOrReloaded then
                        local weaponId = 'weapon_' .. itemId
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

                            local _, inClip = GetAmmoInClip(ped, weaponHash)

                            local inWeapon = GetAmmoInPedWeapon(ped, weaponHash)
                            local ammoRemaining = math.floor(inWeapon - inClip)

                            TaskReloadWeapon(ped, 0)

                            whereWeaponIsAtSlot[weaponId] = slotId
                        else
                            if HasPedGotWeapon(ped, weaponHash, false) then
                                SetPedAmmo(ped, weaponHash, 0)
                                RemoveWeaponFromPed(ped, weaponHash)
                            end
                        end
                    else
                        -- A arma já estava equipada e só está atualizando o numero de munição
                    end
                end
            end
        end
    end

    return table
end

local promptUse
local promptDrop

Citizen.CreateThread(
    function()
        local prompt = PromptRegisterBegin()
        local promptGroup = GetRandomIntInRange(0, 0xffffff)
        PromptSetControlAction(prompt, 0x7F8D09B8)
        PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", "Usar Item"))
        PromptSetEnabled(prompt, 1)
        PromptSetVisible(prompt, 1)
        PromptSetHoldMode(prompt, 1)
        PromptSetGroup(prompt, promptGroup)
        PromptRegisterEnd(prompt)

        -- prompt2 = PromptRegisterBegin()
        -- local promptGroup = GetRandomIntInRange(0, 0xffffff)
        -- PromptSetControlAction(prompt2, 0x7F8D09B8)
        -- PromptSetText(prompt2, CreateVarString(10, 'LITERAL_STRING', 'Dropar Item'))
        -- PromptSetEnabled(prompt2, 1)
        -- PromptSetVisible(prompt2, 1)
        -- PromptSetHoldMode(prompt2, 1)
        -- PromptSetGroup(prompt2, promptGroup)
        -- PromptRegisterEnd(prompt2)
        while true do
            Citizen.Wait(0)
            if opened then
                PromptSetActiveGroupThisFrame(promptGroup, CreateVarString(10, "LITERAL_STRING", "Inventário"))
            end
        end
    end
)