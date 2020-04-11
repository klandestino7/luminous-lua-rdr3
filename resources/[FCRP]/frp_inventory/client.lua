local whereWeaponIsAtSlot = {}
local lastWeaponAmmoCount = {}
local lastWeaponsShot = {}

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

local isReloadingOrShooting = false

-- Citizen.CreateThread(
--     function()
--         while true do
--             Citizen.Wait(0)
--             local ped = PlayerPedId()
--             if isReloadingOrShooting == false then
--                 if IsPedShooting(ped) or IsPedReloading(ped) then
--                     print("Reloading")

--                     while IsPedReloading(ped) do
--                         Citizen.Wait(0)
--                     end
--                     print("Ended reloading")
--                     isReloadingOrShooting = true
--                     for weaponId, slot in pairs(whereWeaponIsAtSlot) do
--                         local weaponHash = GetHashKey(weaponId)
--                         local _, currentWeapon = GetCurrentPedWeapon(ped, 1)
--                         if currentWeapon == weaponHash then
--                             local _, inClip = GetAmmoInClip(ped, weaponHash)
--                             local inWeapon = GetAmmoInPedWeapon(ped, weaponHash)

--                             TriggerServerEvent("VP:INVENTORY:SaveWeaponAmmoOnDB", slot, (inWeapon))

--                             print("Ammo:", "Clip:" .. inClip, "Usabled:" .. (inWeapon - inClip))

--                             local slots = {
--                                 [slot] = {weaponId:gsub("weapon_", ""), inClip, inWeapon}
--                             }

--                             SendNUIMessage(
--                                 {
--                                     primarySlots = computeSlots(slots, true)
--                                 }
--                             )
--                         -- end
--                         end
--                     end
--                 end
--             else
--                 if not IsPedReloading(ped) then
--                     isReloadingOrShooting = false
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

-- function interactWithHotbarSlot(data)
--     lastWeaponAmmoCount = {}

--     local ped = PlayerPedId()
--     RemoveAllPedWeapons(ped, true, true)

--     local itemId = data.itemId
--     local weaponClip = tonumber(data.weaponClip)
--     local weaponAmmo = tonumber(data.weaponAmmo)

--     if itemId ~= nil then
--         local weaponId = "weapon_" .. itemId

--         local hash = GetHashKey(weaponId)

--         Citizen.InvokeNative(0x5E3BDDBCB83F3D84, ped, hash, 0, true, true)
--         -- SetPedAmmo(ped, hash, 0)
--         -- SetAmmoInClip(ped, hash, 0)
--         SetPedAmmo(ped, hash, weaponAmmo)
--         SetAmmoInClip(ped, hash, weaponClip)
--     end
-- end

RegisterNUICallback(
    "interactWithHotbarSlot",
    function(cb)
        local itemId = cb.itemId or "unarmed"
        SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_" .. itemId), true)
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

function computeSlots(table, updatingAmmoCount)
    print('computeSlots')
    local ped = PlayerPedId()
    for slotId, values in pairs(table) do
        print(itemId, itemInfo)

        local itemId = values[1]
        local itemInfo = ItemList[itemId]

        if itemInfo ~= nil then
            local itemAmount = values[2]
            local itemName = itemInfo.name
            local itemDescription = itemInfo.description or "Descrição"
            local itemStack = itemInfo.stack or 64

            if itemInfo.type == "weapon" then
                if (slotId >= 129 and slotId <= 132) then
                    if updatingAmmoCount == nil or updatingAmmoCount == false then
                        -- A arma foi equipada agora

                        local weaponId = "weapon_" .. itemId
                        local weaponHash = GetHashKey(weaponId)

                        if HasPedGotWeapon(ped, hash, 0, 0) then
                            SetAmmoInClip(ped, weaponHash, 0)
                            SetPedAmmo(ped, weaponHash, itemAmount)
                        else
                            -- SetPedAmmo(ped, weaponHash, itemAmount)
                            for wId, slot in pairs(whereWeaponIsAtSlot) do
                                -- Verificar se alguma arma equipada
                                -- Está registrada no slot errado
                                -- e então remover ela
                                if slot == slotId and wId ~= weaponId then
                                    local foundHash = GetHashKey(wId)
                                    RemoveWeaponFromPed(ped, foundHash)
                                    whereWeaponIsAtSlot[wId] = nil
                                end
                            end

                            GiveWeaponToPed(ped, weaponHash, itemAmount, false, true)
                        end

                        if whereWeaponIsAtSlot[weaponId] == nil then
                            whereWeaponIsAtSlot[weaponId] = slotId
                        end
                    else
                        -- A arma já estava equipada e só está atualizando o numero de munição
                        local totalWeaponAmmo = values[3]

                        itemStack = totalWeaponAmmo - itemAmount
                    end
                end
            end

            values[3] = itemStack
            values[4] = itemName
            values[5] = itemDescription
        end
    end

    return table
end
