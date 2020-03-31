local Tunnel = module("_core", "libs/Tunnel")
local Proxy = module("_core", "libs/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

local queue = {}

RegisterNetEvent("FCRP:CRAFTING:Open")
AddEventHandler(
    "FCRP:CRAFTING:Open",
    function()
        local _source = source

        local User = API.getUserFromSource(_source)
        local Inventory = User:getCharacter():getInventory()

        TriggerClientEvent("FCRP:CRAFTING:OpenMenu", _source, Inventory:getItems())
    end
)

RegisterNetEvent("FCRP:CRAFTING:Craft")
AddEventHandler(
    "FCRP:CRAFTING:Craft",
    function(id)
        local _source = source

        local User = API.getUserFromSource(_source)
        local Character = User:getCharacter()
        local Inventory = Character:getInventory()

        local ItemData = API.getItemDataFromId(id)

        if Inventory:getWeight() + ItemData:getWeight() > Inventory:getCapacity() then
            User:notify("Inventário cheio!")
            return
        end

        local craftingParts = CraftableItems[id][1]

        for cid, amount in pairs(craftingParts) do
            if Inventory:getItemAmount(cid) < amount then
                local cItemData = API.getItemDataFromId(cid)
                User:notify("Você não tem x" .. amount .. " " .. cItemData:getName() .. ".")
                return
            end
        end

        local ownedParts = {}
        for cid, amount in pairs(craftingParts) do
            Inventory:removeItem(cid, amount)
            ownedParts[cid] = Inventory:getItemAmount(cid) or 0
        end

        TriggerClientEvent("FCRP:CRAFTING:SyncOnCraft", _source, ownedParts)

        local itemCraftingTime = nil or 3

        local user_id = User:getId()
        if queue[user_id] then
            if queue[user_id][id] then
                queue[user_id][id] = queue[user_id][id] + 1
            else
                queue[user_id][id] = 1
            end
        else
            queue[user_id] = {}
            queue[user_id][id] = 1
        end

        TriggerClientEvent("FCRP:CRAFTING:UpCraftingCount", _source, id, itemCraftingTime)
    end
)

Citizen.CreateThread(
    function()
        local queue_seconds = {}
        while true do
            Citizen.Wait(1000)

            for user_id, queueItemList in pairs(queue) do
                for itemId, data in pairs(queueItemList) do
                    local ItemData = API.getItemDataFromId(itemId)
                    if queue_seconds[user_id] then
                        if queue_seconds[user_id][itemId] then
                            queue_seconds[user_id][itemId] = queue_seconds[user_id][itemId] - 1
                            if queue_seconds[user_id][itemId] <= 0 then
                                queue_seconds[user_id][itemId] = nil

                                if queue[user_id] ~= nil and queue[user_id][itemId] ~= nil then
                                    queue[user_id][itemId] = queue[user_id][itemId] - 1

                                    local User = API.getUserFromUserId(user_id)

                                    if queue[user_id][itemId] < 0 then
                                        queue[user_id][itemId] = nil
                                        if #queue[user_id] <= 0 then
                                            queue[user_id] = nil
                                        end
                                    else
                                        TriggerClientEvent("FCRP:CRAFTING:StartCraftingNext", User:getSource(), itemId, nil or 3)
                                    end

                                    -- giveITM
                                    -- startnewcraft
                                    local Character = User:getCharacter()
                                    local Inventory = Character:getInventory()
                                    Inventory:addItem(itemId, 1)
                                end
                            end
                        else
                            queue_seconds[user_id][itemId] = (nil or 3) - 1
                        end
                    else
                        queue_seconds[user_id] = {}
                        queue_seconds[user_id][itemId] =  (nil or 3) - 1
                    end
                end
            end
        end
    end
)


