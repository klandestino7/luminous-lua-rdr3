Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            DisableControlAction(0, 37, true) -- TAB

            if IsDisabledControlJustPressed(0, 37) and not opened then
                TriggerServerEvent("FCRP:INVENTORY:open")
                opened = true
            end

            if IsDisabledControlJustPressed(0, 38) then -- TAB
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

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            local ped = PlayerPedId()

            -- 0x24B100C68C645951 IS_PED_RELOADING
            local currentWeapon = GetSelectedPedWeapon(ped)
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

                        local slots = {
                            -- [slot] = {weaponId:gsub("weapon_", ""), inClip, inWeapon}
                            [slotId] = {weaponId, 1, inClip, ammoRemaining}
                        }

                        SendNUIMessage(
                            {
                                primarySlots = computeSlots(slots, true)
                            }
                        )
                    end
                end
            end
        end
    end
)

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
    function(slots)
        slots = computeSlots(slots)

        SetNuiFocus(true, true)
        SendNUIMessage(
            {
                type = "clearPrimary",
                primarySlots = slots
            }
        )
    end
)

RegisterNetEvent("FCRP:INVENTORY:openAsSecondary")
AddEventHandler(
    "FCRP:INVENTORY:openAsSecondary",
    function(slots)
        slots = computeSlots(slots)

        SetNuiFocus(true, true)
        SendNUIMessage(
            {
                type = "clearSecondary",
                secondarySlots = slots
            }
        )
    end
)

RegisterNetEvent("FCRP:INVENTORY:PrimarySyncSlots")
AddEventHandler(
    "FCRP:INVENTORY:PrimarySyncSlots",
    function(slots)
        slots = computeSlots(slots)

        SendNUIMessage(
            {
                primarySlots = slots
            }
        )
    end
)

RegisterNetEvent("FCRP:INVENTORY:SecondarySyncSlots")
AddEventHandler(
    "FCRP:INVENTORY:SecondarySyncSlots",
    function(slots)
        slots = computeSlots(slots)

        SendNUIMessage(
            {
                type = "secondarySyncSlots",
                slots = slots
            }
        )
    end
)

RegisterNUICallback(
    "useItem",
    function(data)
        TriggerServerEvent("FCRP:INVENTORY:useItem", data)
    end
)

RegisterNUICallback(
    "dropItem",
    function(data)
        TriggerServerEvent("FCRP:INVENTORY:dropItem", data)
    end
)

RegisterNUICallback(
    "sendItemToPrimary",
    function(cb)
        local id = cb.id
        local amount = cb.amount
        TriggerServerEvent("FCRP:INVENTORY:sendItemToPrimary", id, amount)
    end
)

RegisterNUICallback(
    "sendItemToSecondary",
    function(cb)
        local id = cb.id
        local amount = cb.amount
        TriggerServerEvent("FCRP:INVENTORY:sendItemToSecondary", id, amount)
    end
)

RegisterNUICallback(
    "primarySwitchItemSlot",
    function(cb)
        TriggerServerEvent("FCRP:INVENTORY:primarySwitchItemSlot", cb.slotFrom, cb.slotTo, cb.itemAmount)
    end
)

RegisterNUICallback(
    "interactWithHotbarSlot",
    function(cb)
        local itemId = cb.itemId or "weapon_unarmed"
        -- SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_" .. itemId), true)
        SetCurrentPedWeapon(PlayerPedId(), itemId, true)
        MakePedReload(ped)
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
            values.itemStackSize = itemInfo.stackSize or 16

            local itemType = itemInfo.type

            if itemInfo.type == "weapon" then
                -- ammoInClip = ammoInClip - 1
                values[3] = ammoInClip
                values[4] = ammoInWeapon

                if (slotId >= 129 and slotId <= 132) then
                    if not shotOrReloaded then

                        local weaponId = itemId
                        local weaponHash = GetHashKey(weaponId)

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

                            MakePedReload(ped)

                            whereWeaponIsAtSlot[weaponId] = slotId
                        else
                            if HasPedGotWeapon(ped, weaponHash, false) then
                                SetPedAmmo(ped, weaponHash, 0)
                                RemoveWeaponFromPed(ped, weaponHash)
                            end

                            whereWeaponIsAtSlot[weaponId] = nil
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
