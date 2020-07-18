local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")
API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local dropPopulation = {}
--[[
    {
        x,
        y,
        z
        itemId
        itemAmount
    }
]]
local dropPopulation_serveronly = {}
--[[
    {
        itemWeaponAmmoInClip
        itemWeaponAmmoInWeapon
        deletionTimestamp
    }
]]
RegisterNetEvent("VP:INVENTORY:PickedUpDroppedItem")
AddEventHandler(
    "VP:INVENTORY:PickedUpDroppedItem",
    function(index)
        local _source = source

        if not dropPopulation[index] then
            return
        end

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        if Character == nil then
            return
        end

        local Inventory = Character:getInventory()

        local d = dropPopulation[index]
        local d_serveronly = dropPopulation_serveronly[index]

        local itemId = d.itemId
        local itemAmount = d.itemAmount

        local itemWasAdded, slots = Inventory:addItem(itemId, itemAmount)
        if itemWasAdded then
            local itemData = API.getItemDataFromId(itemId)
            if itemData:getType() == "weapon" then
                local itemAmmoInClip = d_serveronly.itemWeaponAmmoInClip
                local itemAmmoInWeapon = d_serveronly.itemWeaponAmmoInWeapon

                local slotWeaponWasAddedTo

                for i = 1, 132 do
                    if slots[i] then
                        slotWeaponWasAddedTo = i
                        break
                    end
                end

                local Slot = Inventory:getSlots()[slotWeaponWasAddedTo]

                Slot:setAmmoInClip(itemAmmoInClip)
                Slot:setAmmoInWeapon(itemAmmoInWeapon)
            end

            dropPopulation[index] = nil
            dropPopulation_serveronly[index] = nil

            TriggerClientEvent("VP:INVENTORY:DROP:Delete", -1, index)

            if not User:hasInventoryOpen() then
                User:notify("item", itemId, itemAmount)
            end
        else
            User:notify("error", "Aforje sem espaço!")
        end
    end
)

RegisterNetEvent("VP:INVENTORY:OpenPersonal")
AddEventHandler(
    "VP:INVENTORY:OpenPersonal",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        -- local Character = User:getCharacter()
        User:viewInventory()
        -- local primaryInventory = User:getPrimaryInventoryViewing()
        -- local secondaryInventory = User:getSecondaryInventoryViewing()

        -- Primary = primaryInventory:getWeight()
        -- Capacity = primaryInventory:getCapacity()

        -- TriggerClientEvent('VP:INVENTORY:weight', _source, Primary, Capacity)
    end
)

RegisterNetEvent("VP:INVENTORY:Close")
AddEventHandler(
    "VP:INVENTORY:Close",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)

        if User == nil then
            return
        end

        User:closeInventory()
    end
)

RegisterNetEvent("VP:INVENTORY:Use")
AddEventHandler(
    "VP:INVENTORY:Use",
    function(slotId)
        local _source = source

        local User = API.getUserFromSource(_source)
        local Inventory = User:getPrimaryInventoryViewing()

        if Inventory == nil then
            return
        end

        local Slot = Inventory:getSlots()[slotId]

        if Slot == nil or Slot:getItemAmount() < 1 then
            return
        end

        local itemData = Slot:getItemData()

        if itemData:triggerUse(User) then
            Inventory:removeItem(slotId, Slot:getItemId(), 1)
        end
    end
)

RegisterNetEvent("VP:INVENTORY:Drop")
AddEventHandler(
    "VP:INVENTORY:Drop",
    function(slotId, x, y, z)
        local _source = source

        local User = API.getUserFromSource(_source)
        local Inventory = User:getPrimaryInventoryViewing()

        if Inventory == nil then
            return
        end

        local Slot = Inventory:getSlots()[slotId]

        if Slot == nil or Slot:getItemAmount() < 1 then
            return
        end

        local itemData = Slot:getItemData()

        local itemId = Slot:getItemId()
        local itemAmount = Slot:getItemAmount()

        local itemAmmoInClip = Slot:getAmmoInClip()
        local itemAmmoInWeapon = Slot:getAmmoInWeapon()

        if Inventory:removeItem(slotId, itemId, itemAmount) then
            local index = getfirsttablefreeindex(dropPopulation)

            local d = {
                x = x,
                y = y,
                z = z,
                itemId = itemId,
                itemAmount = itemAmount
            }

            local d_serveronly = {
                itemWeaponAmmoInClip = itemAmmoInClip or 0,
                itemWeaponAmmoInWeapon = itemAmmoInWeapon or 0,
                deletionTimestamp = os.time() + (60 * 10)
            }

            while dropPopulation[index] ~= nil do
                index = index + 1
            end

            dropPopulation[index] = d
            dropPopulation_serveronly[index] = d_serveronly

            TriggerClientEvent("VP:INVENTORY:DROP:Create", -1, index, x, y, z, itemId, itemAmount)

            if not User:hasInventoryOpen() then
                User:notify("item", itemId, -(itemAmount))
            end
        else
            User:notify("error", "x" .. itemAmount .. " " .. itemData:getName() .. " não encontrado no inventário")
        end
    end
)

RegisterNetEvent("VP:INVENTORY:SendItemIdAndAmountToPlayer")
AddEventHandler(
    "VP:INVENTORY:SendItemIdAndAmountToPlayer",
    function(itemId, itemAmount, playerTarget)
        local _source = source

        local UserTarget = API.getUserFromSource(playerTarget)

        if UserTarget == nil then
            return
        end

        local CharacterTarget = UserTarget:getCharacter()

        if CharacterTarget == nil then
            return
        end

        local InventoryTarget = CharacterTarget:getInventory()

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        if Character == nil then
            return
        end

        local Inventory = Character:getInventory()

        if Inventory:getItemAmount(itemId) < itemAmount then
            User:notify("error", "Você não tem items suficientes")
            return
        end

        if InventoryTarget:addItem(itemId, itemAmount) then
            Inventory:removeItem(-1, itemId, itemAmount)

            User:notify("item", itemId, -(itemAmount))

            if UserTarget:getPrimaryInventoryViewing() == nil then
                UserTarget:notify("item", itemId, itemAmount)
            end
        else
            User:notify("error", "Bolsa da pesssoa está sem espaço!")
        end
    end
)

RegisterNetEvent("VP:INVENTORY:moveSlotToPrimary")
AddEventHandler(
    "VP:INVENTORY:moveSlotToPrimary",
    function(slotId, itemAmount)
        local _source = source

        local User = API.getUserFromSource(_source)
        local primaryInventory = User:getPrimaryInventoryViewing()
        local secondaryInventory = User:getSecondaryInventoryViewing()

        if primaryInventory == nil or secondaryInventory == nil then
            User:closeInventory()
            return
        end

        slotId = tonumber(slotId)

        local Slot = secondaryInventory:getSlots()[slotId]

        if Slot == nil or Slot:getItemAmount() <= 0 then
            return
        end

        if itemAmount == -2 then
            itemAmount = Slot:getItemAmount()
        end

        if itemAmount == -1 then
            itemAmount = Slot:getItemAmount() / 2
        end

        if itemAmount <= 0 then
            itemAmount = 1
        end

        if (primaryInventory:getWeight() + (Slot:getItemData():getWeight() * itemAmount)) >= primaryInventory:getCapacity() then
            User:notify("error", "Baú cheio!")
            return
        end

        if primaryInventory:addItem(Slot:getItemId(), itemAmount) then
            secondaryInventory:removeItem(slotId, Slot:getItemId(), itemAmount)
        end
    end
)

RegisterNetEvent("VP:INVENTORY:moveSlotToSecondary")
AddEventHandler(
    "VP:INVENTORY:moveSlotToSecondary",
    function(slotId, itemAmount)
        local _source = source

        local User = API.getUserFromSource(_source)
        local primaryInventory = User:getPrimaryInventoryViewing()
        local secondaryInventory = User:getSecondaryInventoryViewing()

        if primaryInventory == nil or secondaryInventory == nil then
            User:closeInventory()
            return
        end

        slotId = tonumber(slotId)

        local Slot = primaryInventory:getSlots()[slotId]

        if Slot == nil or Slot:getItemAmount() <= 0 then
            return
        end

        if itemAmount == -2 then
            itemAmount = Slot:getItemAmount()
        end

        if itemAmount == -1 then
            itemAmount = Slot:getItemAmount() / 2
        end

        if itemAmount <= 0 then
            itemAmount = 1
        end

        if (secondaryInventory:getWeight() + (Slot:getItemData():getWeight() * itemAmount)) >= secondaryInventory:getCapacity() then
            User:notify("error", "Baú cheio!")
            return
        end

        if secondaryInventory:addItem(Slot:getItemId(), itemAmount) then
            primaryInventory:removeItem(slotId, Slot:getItemId(), itemAmount)
        end
    end
)

RegisterNetEvent("VP:INVENTORY:PrimarySwitchSlot")
AddEventHandler(
    "VP:INVENTORY:PrimarySwitchSlot",
    function(slotFrom, slotTo, itemAmount)
        local _source = source

        local User = API.getUserFromSource(_source)
        local primaryInventory = User:getPrimaryInventoryViewing()

        if primaryInventory == nil then
            User:closeInventory()
            return
        end

        slotFrom = tonumber(slotFrom)
        slotTo = tonumber(slotTo)
        itemAmount = tonumber(itemAmount)

        local Slot = primaryInventory:getSlots()[slotFrom]

        if Slot == nil then
            return
        end

        local itemIdAtSlot = Slot:getItemId()

        if itemAmount == -2 then
            itemAmount = primaryInventory:getSlots()[slotFrom]:getItemAmount()
        elseif itemAmount == -1 then
            itemAmount = primaryInventory:getSlots()[slotFrom]:getItemAmount() / 2
        elseif itemAmount <= 0 then
            itemAmount = 1
        else
            if itemIdAtSlot == "money" or itemIdAtSlot == "gold" then
                itemAmount = itemAmount * 100
            end
        end

        itemAmount = math.floor(itemAmount)
        primaryInventory:moveSlot(slotFrom, slotTo, itemAmount)
    end
)

RegisterNetEvent("VP:INVENTORY:SecondarySwitchSlot")
AddEventHandler(
    "VP:INVENTORY:SecondarySwitchSlot",
    function(slotFrom, slotTo, itemAmount)

        slotFrom = tonumber(slotFrom)
        slotTo = tonumber(slotTo)
        itemAmount = tonumber(itemAmount)

        if slotTo >= 129 and slotTo <= 132 then
            return
        end

        local _source = source

        local User = API.getUserFromSource(_source)
        local secondaryInventory = User:getSecondaryInventoryViewing()

        if secondaryInventory == nil then
            User:closeInventory()
            return
        end

        if secondaryInventory:getSlots()[slotFrom] == nil then
            return
        end

        if itemAmount == -2 then
            itemAmount = secondaryInventory:getSlots()[slotFrom]:getItemAmount()
        end

        if itemAmount == -1 then
            itemAmount = secondaryInventory:getSlots()[slotFrom]:getItemAmount() / 2
        end

        if itemAmount <= 0 then
            itemAmount = 1
        end

        itemAmount = math.floor(itemAmount)
        secondaryInventory:moveSlot(slotFrom, slotTo, itemAmount)
    end
)

RegisterNetEvent("VP:INVENTORY:SaveWeaponAmmoOnDB")
AddEventHandler(
    "VP:INVENTORY:SaveWeaponAmmoOnDB",
    function(slot, ammoInClip, ammoInWeapon)
        local _source = source

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        local primaryInventory = Character:getInventory()

        if primaryInventory ~= nil then
            primaryInventory:saveWeaponSlotIntoDb(_source, slot, ammoInClip, ammoInWeapon)
        end
    end
)

-- RegisterCommand(
--     "garmas",
--     function(source, args)
--         local _source = source
--         local User = API.getUserFromSource(_source)
--         local Character = User:getCharacter()

--         local armas = cAPI.replaceWeapons(_source, {})
--         local Inventory = Character:getInventory()
--         -- local ammo = cAPI.getAmmo(_source)

--         -- for w, v in pairs(armas) do
--         --     Inventory:addItem(w, 1)
--         -- end

--         -- for a, v in pairs(ammo) do
--         --     Inventory:addItem(w, v)
--         -- end

--         TriggerClientEvent("frp_inventory:removeWeapons", _source)
--     end
-- )

function getfirsttablefreeindex(table)
    for i = 1, 99999 do
        if table[i] == nil then
            return i
        end
    end
    return 1
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)

            local time = os.time()

            for index, d in pairs(dropPopulation_serveronly) do
                local deletionTimestamp = d.deletionTimestamp

                if time >= deletionTimestamp then
                    dropPopulation[index] = nil
                    dropPopulation_serveronly[index] = nil
                    TriggerClientEvent("VP:INVENTORY:DROP:Delete", index)
                end
            end
        end
    end
)
