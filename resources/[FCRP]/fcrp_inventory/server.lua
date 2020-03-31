local Tunnel = module("_core", "libs/Tunnel")
local Proxy = module("_core", "libs/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterNetEvent("FCRP:INVENTORY:open")
AddEventHandler(
    "FCRP:INVENTORY:open",
    function()
        local _source = source
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        User:viewInventory()
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

        local Character = User:getCharacter()
        User:closeInventory()
    end
)

RegisterNetEvent("FCRP:INVENTORY:useItem")
AddEventHandler(
    "FCRP:INVENTORY:useItem",
    function(itemId, amount)
        local _source = source

        local User = API.getUserFromSource(_source)
        local Inventory = User:getPrimaryInventoryViewing()

        if Inventory == nil then
            return
        end

        -- Might dupe?

        local ItemData = API.getItemDataFromId(itemId)
        if Inventory:getItemAmount(itemId) >= amount then
            if ItemData:use(User, amount) then
                Inventory:removeItem(itemId, amount)
                User:notify(ItemData:getName() .. " usado!")
            else
                User:notify(ItemData:getName() .. " não pode ser usado usado!")
            end
        else
            User:notify(ItemData:getName() .. " não encontrado no inventário")
        end
    end
)

RegisterNetEvent("FCRP:INVENTORY:dropItem")
AddEventHandler(
    "FCRP:INVENTORY:dropItem",
    function(itemId, amount)
        local _source = source

        local User = API.getUserFromSource(_source)
        local Inventory = User:getPrimaryInventoryViewing()

        if Inventory == nil then
            return
        end

        local Item = API.getItemDataFromId(itemId)

        if Inventory:removeItem(itemId, amount) then
            User:notify(ItemData:getName() .. " dropado!")
        else
            User:notify("x" .. amount .. " " .. ItemData:getName() .. " não encontrado no inventário")
        end
    end
)

RegisterNetEvent("FCRP:INVENTORY:sendItemToPrimary")
AddEventHandler(
    "FCRP:INVENTORY:sendItemToPrimary",
    function(id, amount)
        local _source = source

        local User = API.getUserFromSource(_source)
        local primaryInventory = User:getPrimaryInventoryViewing()
        local secondaryInventory = User:getSecondaryInventoryViewing()

        if primaryInventory == nil or secondaryInventory == nil then
            User:closeInventory()
            return
        end

        local ItemData = API.getItemDataFromId(id)

        if primaryInventory:getWeight() + (ItemData:getWeight() * amount) >= primaryInventory:getCapacity() then
            User:notify("Inventário cheio!")
            return
        end

        if secondaryInventory:removeItem(id, amount) then
            primaryInventory:addItem(id, amount)
        end
    end
)

RegisterNetEvent("FCRP:INVENTORY:sendItemToSecondary")
AddEventHandler(
    "FCRP:INVENTORY:sendItemToSecondary",
    function(id, amount)
        local _source = source

        local User = API.getUserFromSource(_source)
        local primaryInventory = User:getPrimaryInventoryViewing()
        local secondaryInventory = User:getSecondaryInventoryViewing()

        if primaryInventory == nil or secondaryInventory == nil then
            User:closeInventory()
            return
        end

        local ItemData = API.getItemDataFromId(id)

        if secondaryInventory:getWeight() + (ItemData:getWeight() * amount) >= secondaryInventory:getCapacity() then
            User:notify("Baú cheio!")
            return
        end

        if primaryInventory:removeItem(id, amount) then
            secondaryInventory:addItem(id, amount)
        end
    end
)
