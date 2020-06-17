local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")
API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local droppedItems = {}

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

        local itemId = Slot:getItemId()
        local itemAmount = Slot:getItemAmount()

        if Inventory:removeItem(slotId, itemId, itemAmount) then
            -- TriggerClientEvent("VP:INVENTORY:DROP:Create", itemId)
            if not User:hasInventoryOpen() then
                User:notify("item", itemId, -(itemAmount))
            end
        else
            User:notify("error", "x" .. itemAmount .. " " .. itemData:getName() .. " não encontrado no inventário")
        end
    end
)

RegisterNetEvent("VP:INVENTORY:SendToPlayer")
AddEventHandler(
    "VP:INVENTORY:SendToPlayer",
    function(slotId, playerTarget)
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

        local Slot = Inventory:getSlots()[tonumber(slotId)]

        if Slot == nil then
            -- User:notify("error", "Você não tem x" .. ItemData:getName())
            return
        end

        local itemAtSlot = Slot:getItemId()
        local amountAtSlot = Slot:getItemAmount()

        local ItemData = API.getItemDataFromId(itemAtSlot)
        -- if Inventory:getItemAmount(itemAtSlot) >= amountAtSlot then
        if InventoryTarget:addItem(itemAtSlot, amountAtSlot) then
            Inventory:removeItem(tonumber(slotId), itemAtSlot, amountAtSlot)

            local amountToDisplay = amountAtSlot
            local toastType = "item"

            if itemAtSlot == "gold" then
                toastType = "gold"
                amountToDisplay = amountToDisplay / 100
            elseif itemAtSlot == "money" then
                toastType = "dollar"
                amountToDisplay = amountToDisplay / 100
            end

            User:notify(toastType, ItemData:getName(), -(amountToDisplay))

            if UserTarget:getPrimaryInventoryViewing() == nil then
                UserTarget:notify(toastType, ItemData:getName(), amountToDisplay)
            end
        else
            User:notify("error", "Bolsa da pesssoa está sem espaço!")
        end
        -- -- else
        --     User:notify("error", "Você não tem x" .. ItemData:getName())
        -- end
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
        local _source = source

        local User = API.getUserFromSource(_source)
        local secondaryInventory = User:getSecondaryInventoryViewing()

        if secondaryInventory == nil then
            User:closeInventory()
            return
        end

        slotFrom = tonumber(slotFrom)
        slotTo = tonumber(slotTo)
        itemAmount = tonumber(itemAmount)

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
