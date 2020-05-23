local Tunnel = module("_core", "lib/Tunnel")
local Proxy = module("_core", "lib/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterNetEvent("VP:CRAFTING:Open")
AddEventHandler(
    "VP:CRAFTING:Open",
    function()
        local _source = source

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        if Character == nil then
            return
        end

        local Inventory = Character:getInventory()

        local ownedItems = Inventory:getItemsAndAmount()

        -- local parsedItems = {}

        -- for _, v in pairs(slots) do
        --     parsedItems[v[1]] = v[2]
        -- end

        TriggerClientEvent("VP:CRAFTING:OpenMenu", _source, ownedItems)
    end
)

RegisterNetEvent("VP:CRAFTING:Craft")
AddEventHandler(
    "VP:CRAFTING:Craft",
    function(id)
        local _source = source

        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        local ItemData = API.getItemDataFromId(id)

        if Inventory:getWeight() + ItemData:getWeight() > Inventory:getCapacity() then
            User:notify("error", "Bolsa sem espaço")
            return
        end

        local craftingParts = Config[id]

        for cid, amount in pairs(craftingParts) do
            if Inventory:getItemAmount(cid) < amount then
                local cItemData = API.getItemDataFromId(cid)
                User:notify("error", "Você não tem x" .. amount .. " " .. cItemData:getName() .. ".")
                return
            end
        end

        local ownedParts = {}
        for cid, amount in pairs(craftingParts) do
            Inventory:removeItem(cid, amount)
            ownedParts[cid] = Inventory:getItemAmount(cid) or 0
        end

        Inventory:addItem(id, 1)
        User:notify("item", ItemData:getName(), 1)

        TriggerClientEvent("VP:CRAFTING:SyncOnCraft", _source, ownedParts)
    end
)
