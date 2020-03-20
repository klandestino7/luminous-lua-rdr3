local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'libs/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

RegisterNetEvent('FCRP:CRAFTING:Open')
AddEventHandler(
    'FCRP:CRAFTING:Open',
    function()
        local _source = source

        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        TriggerClientEvent('FCRP:CRAFTING:OpenMenu', _source, Inventory:getItems())
    end
)

RegisterNetEvent('FCRP:CRAFTING:Craft')
AddEventHandler(
    'FCRP:CRAFTING:Craft',
    function(id)
        local _source = source

        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        local ItemData = API.getItemDataFromId(id)

        if Inventory:getWeight() + ItemData:getWeight() > Inventory:getCapacity() then
            User:notify('Inventário cheio!')
            return
        end

        local craftingParts = CraftableItems[id].craftingParts

        for cid, amount in pairs(craftingParts) do
            if Inventory:getItemAmount(cid) < amount then
                local cItemData = API.getItemDataFromId(cid)
                User:notify('Você não tem x' .. amount .. ' ' .. cItemData:getName() .. '.')
                return
            end
        end

        local ownedParts = {}
        for cid, amount in pairs(craftingParts) do
            Inventory:removeItem(cid, amount)
            ownedParts[cid] = Inventory:getItemAmount(cid) or 0
        end

        Inventory:addItem(id, 1)
        User:notify(ItemData:getName() .. ' criado!')

        TriggerClientEvent('FCRP:CRAFTING:SyncOnCraft', _source, ownedParts)
    end
)
