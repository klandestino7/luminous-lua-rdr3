local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")
API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

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

RegisterNetEvent("VP:INVENTORY:dropItem")
AddEventHandler(
    "VP:INVENTORY:dropItem",
    function(slotId)
        local _source = source

        local User = API.getUserFromSource(_source)
        local Inventory = User:getPrimaryInventoryViewing()

        if Inventory == nil then
            return
        end

        local ItemData = API.getItemDataFromId(data.id)

        if Inventory:removeItem(slotId, data.id, data.amount) then
            User:notify(ItemData:getName() .. " dropado!")
        else
            User:notify("x" .. data.amount .. " " .. ItemData:getName() .. " não encontrado no inventário")
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
            User:notify("Baú cheio!")
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
            User:notify("Baú cheio!")
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

        if primaryInventory:getSlots()[slotFrom] == nil then
            return
        end

        if itemAmount == -2 then
            itemAmount = primaryInventory:getSlots()[slotFrom]:getItemAmount()
        end

        if itemAmount == -1 then
            itemAmount = primaryInventory:getSlots()[slotFrom]:getItemAmount() / 2
        end

        if itemAmount <= 0 then
            itemAmount = 1
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

RegisterCommand(
    "garmas",
    function(source, args)
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        local armas = cAPI.replaceWeapons(_source, {})
        local Inventory = Character:getInventory()
        -- local ammo = cAPI.getAmmo(_source)

        -- for w, v in pairs(armas) do
        --     Inventory:addItem(w, 1)
        -- end

        -- for a, v in pairs(ammo) do
        --     Inventory:addItem(w, v)
        -- end

        TriggerClientEvent("frp_inventory:removeWeapons", _source)
    end
)
