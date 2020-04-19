local Tunnel = module("_core", "libs/Tunnel")
local Proxy = module("_core", "libs/Proxy")
API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterNetEvent("FCRP:INVENTORY:OpenPersonal")
AddEventHandler(
    "FCRP:INVENTORY:OpenPersonal",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        -- local Character = User:getCharacter()
        User:viewInventory()
        -- local primaryInventory = User:getPrimaryInventoryViewing()
        -- local secondaryInventory = User:getSecondaryInventoryViewing()

        -- Primary = primaryInventory:getWeight()
        -- Capacity = primaryInventory:getCapacity()

        -- TriggerClientEvent('FCRP:INVENTORY:weight', _source, Primary, Capacity)
    end
)

RegisterNetEvent("FCRP:INVENTORY:Close")
AddEventHandler(
    "FCRP:INVENTORY:Close",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)

        if User == nil then
            return
        end

        User:closeInventory()
    end
)

RegisterNetEvent("FCRP:INVENTORY:Use")
AddEventHandler(
    "FCRP:INVENTORY:Use",
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

RegisterNetEvent("FCRP:INVENTORY:dropItem")
AddEventHandler(
    "FCRP:INVENTORY:dropItem",
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

RegisterNetEvent("FCRP:INVENTORY:moveSlotToPrimary")
AddEventHandler(
    "FCRP:INVENTORY:moveSlotToPrimary",
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

RegisterNetEvent("FCRP:INVENTORY:moveSlotToSecondary")
AddEventHandler(
    "FCRP:INVENTORY:moveSlotToSecondary",
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

RegisterNetEvent("FCRP:INVENTORY:PrimarySwitchSlot")
AddEventHandler(
    "FCRP:INVENTORY:PrimarySwitchSlot",
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
