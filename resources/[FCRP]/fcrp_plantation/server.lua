local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'libs/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')
dbAPI = Proxy.getInterface("API_DB")

local tempPCapacity = {}

RegisterNetEvent('FCRP:CHESTS:AskForSync')
RegisterNetEvent('FCRP:CHESTS:StartPlayerPlacement')
RegisterNetEvent('FCRP:CHESTS:EndPlayerPlacement')
RegisterNetEvent('FCRP:CHESTS:Open')

AddEventHandler(
    'FCRP:CHESTS:AskForSync',
    function()
        local _source = source
        API.syncChestsWithPlayer(_source)
    end
)

AddEventHandler(
    'FCRP:CHESTS:StartPlayerPlacement',
    function(source, capacity)
        local _source = source
        tempPCapacity[_source] = capacity
        TriggerClientEvent('FCRP:CHESTS:StartPlayerPlacement', _source, capacity)
    end
)

AddEventHandler(
    'FCRP:CHESTS:EndPlayerPlacement',
    function(capacity, x, y, z, h)
        local _source = source

        if tempPCapacity[_source] == nil then
            return
        end

        capacity = tempPCapacity[_source]

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        local Inventory = Character:getInventory()

        local item_id = getItemIdFromCapacity(capacity)
        local ItemData = API.getItemDataFromId(item_id)

        if x == nil and y == nil and z == nil and h == nil then
            Inventory:addItem(item_id, 1)
        end

        if Inventory:getItemAmount(item_id) < 1 then
            User:notify('Você não tem 1x ' .. ItemData:getName() .. 'no inventário')
            return
        end

        Inventory:removeItem(item_id, 1)

        tempPCapacity[_source] = nil

        local charid = Character:getId()
        local position = {x, y, z, h}
        local rowsWithId = dbAPI.query('FCRP/CreateChest', {charid = charid, position = json.encode(position), type = 1, capacity = capacity})
        if #rowsWithId > 0 then
            local chestId = rowsWithId[1].id
            local Chest = API.Chest(chestId, charid, position, 1, capacity, nil)
            API.cacheChest(Chest)
        end
    end
)

AddEventHandler(
    'FCRP:CHESTS:Open',
    function(chestId)
        local _source = source

        local Chest = API.getChestFromChestId(chestId)
        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()

        local User = API.getUserFromSource(_source)
        local primaryInventory = User:getPrimaryInventoryViewing()
        local secondaryInventory = User:getSecondaryInventoryViewing()


        local chestInventory = Chest:getInventory(Character:getId())

        if chestInventory == nil then
            User:notify('Você não pode abrir este baú')
            return
        end

        User:viewInventoryAsSecondary(chestInventory)

    end
)

AddEventHandler(
    'playerDropped',
    function(reason)
        local _source = source
        tempPCapacity[_source] = nil
        -- local User = API.getUserFromSource(_source)
    end
)

AddEventHandler(
    'playerConnecting',
    function(name, setReason)
        local _source = source
        TriggerClientEvent('FCRP:CHESTS:SyncMultipleChests', _source, tempChests)
    end
)

AddEventHandler(
    'FCRP:playerSpawned',
    function(source, user_id, isFirstSpawn)
        if isFirstSpawn then
            API.syncChestsWithPlayer(source)
        end
    end
)

function getItemIdFromCapacity(capacity)
    if capacity == 25 then
        return 'chest_small'
    end

    if capacity == 50 then
        return 'chest_medium'
    end

    if capacity == 100 then
        return 'chest_large'
    end

    return nil
end
