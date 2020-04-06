local whereWeaponIsAtSlot = {}
local lastWeaponAmmoCount = {}
local lastWeaponsShot = {}

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if IsControlJustPressed(0, 0xC1989F95) and not opened then
                TriggerServerEvent("FCRP:INVENTORY:open")
                opened = true
            end

            -- DisableControlAction(0, 0xB238FE0B, true) -- ToggleHolster
            -- -- DisableControlAction(0, 0x6070D032, true) -- QuickEquipItem
            -- DisableControlAction(0, 0xAC4BD4F1, true) -- OpenWheelMenu
            -- DisableControlAction(0, 0x85D24405, true) -- CreatorMenuToggle

            -- if IsDisabledControlJustPressed(0, 0xB238FE0B) then -- ToggleHolster
            --     print('ToggleHolster')
            --     -- SendNUIMessage(
            --     --     {
            --     --         type = "nextHotbarSlot"
            --     --     }
            --     -- )
            -- end

            -- if IsDisabledControlJustPressed(0, 0x6070D032) then -- QuickEquipItem
            --     print('QuickEquipItem')
            --     -- SendNUIMessage(
            --     --     {
            --     --         type = "nextHotbarSlot"
            --     --     }
            --     -- )
            -- end

            if IsControlJustPressed(0, 0x3076E97C) then -- F
                -- if IsDisabledControlJustPressed(0, 0x85D24405) then -- ToggleHolster TAB
                SendNUIMessage(
                    {
                        type = "nextHotbarSlot"
                    }
                )
            end

            -- for i, weaponId in pairs(lastWeaponsShot) do
            --     local weaponHash = GetHashKey(weaponId)
            --     local _, inClip = GetAmmoInClip(ped, weaponHash)
            --     local inWeapon = GetAmmoInPedWeapon(ped, weaponHash)
            --     if lastWeaponAmmoCount[weaponId] == nil or lastWeaponAmmoCount[weaponId] ~= (inClip + inWeapon) then
            --         print("ammo changed")
            --         lastWeaponAmmoCount[weaponId] = nil
            --         lastWeaponsShot[i] = nil

            --         local slot = whereWeaponIsAtSlot[weaponId]

            --         if slot ~= nil then
            --             local slots = {
            --                 [slot] = {weaponId:gsub("weapon_", ""), inClip, inWeapon}
            --             }

            --             SendNUIMessage(
            --                 {
            --                     primarySlots = computeSlots(slots)
            --                 }
            --             )
            --         end

            --         break
            --     end
            -- end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(5)
            local ped = PlayerPedId()
            for weaponId, slot in pairs(whereWeaponIsAtSlot) do
                local weaponHash = GetHashKey(weaponId)
                local _, currentWeapon = GetCurrentPedWeapon(ped, 1)
                if currentWeapon == weaponHash then
                    local _, inClip = GetAmmoInClip(ped, weaponHash)
                    local inWeapon = GetAmmoInPedWeapon(ped, weaponHash)
                    if lastWeaponAmmoCount[weaponId] == nil or lastWeaponAmmoCount[weaponId] ~= (inWeapon + inClip) then
                        local dontSave = false
                        if lastWeaponAmmoCount[weaponId] ~= nil then
                            if  lastWeaponAmmoCount[weaponId] == (inWeapon + inClip) then
                                dontSave = true
                            end
                        end

                        if dontSave == false then
                            lastWeaponAmmoCount[weaponId] = (inWeapon + inClip)

                            print("dontSave", lastWeaponAmmoCount[weaponId], (inWeapon + inClip))

                            TriggerServerEvent("VP:INVENTORY:SaveWeaponAmmoOnDB", slot, (inWeapon + inClip))

                            local slots = {
                                [slot] = {weaponId:gsub("weapon_", ""), inClip, inWeapon}
                            }

                            SendNUIMessage(
                                {
                                    primarySlots = computeSlots(slots)
                                }
                            )
                        end
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
        lastWeaponAmmoCount = {}

        local ped = PlayerPedId()
        RemoveAllPedWeapons(ped, true, true)

        local itemId = cb.itemId
        local weaponClip = tonumber(cb.weaponClip)
        local weaponAmmo = tonumber(cb.weaponAmmo)

        if itemId ~= nil then
            local weaponId = "weapon_" .. itemId

            local hash = GetHashKey(weaponId)

            Citizen.InvokeNative(0x5E3BDDBCB83F3D84, ped, hash, 0, true, true)
            -- SetPedAmmo(ped, hash, 0)
            -- SetAmmoInClip(ped, hash, 0)
            SetPedAmmo(ped, hash, weaponAmmo)
            SetAmmoInClip(ped, hash, weaponClip)
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
    TriggerServerEvent("FCRP:INVENTORY:Close")
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

function computeSlots(table)
    local ped = PlayerPedId()
    for _, values in pairs(table) do
        -- 1 = id
        -- 2 = amount
        -- 3 stackSize
        -- 4 name
        -- 5 description

        values[4] = ItemList[values[1]].name
        values[5] = ItemList[values[1]].description or "Descrição"
        if ItemList[values[1]].type ~= "weapon" then
            values[3] = ItemList[values[1]].stack or 1
        else
            values[3] = values[2]
            values[2] = 0

            if _ >= 129 and _ <= 132 then
                whereWeaponIsAtSlot["weapon_" .. values[1]] = _
            end
        end
    end

    return table
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(100)
        end
    end
)
