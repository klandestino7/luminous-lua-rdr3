function API.Inventory(id, capacity, items)
    local self = {}

    self.id = id
    self.capacity = capacity or 20
    self.items = items or {}
    self.viewersSources = {}

    self.getId = function()
        return self.id
    end

    self.getItems = function()
        return self.items
    end

    self.getWeight = function()
        local weight = 0
        for id, amount in pairs(self.items) do
            local ItemData = API.getItemDataFromId(id)
            if ItemData ~= nil then
                local weight = weight + (ItemData:getWeight() * amount)
            end
        end

        return weight
    end

    self.setCapacity = function(this, v)
        self.capacity = v
    end

    self.getCapacity = function()
        return self.capacity
    end

    self.getCharId = function()
        -- Owner of the inventory
        if string.find(self:getId(), "char:") then
            local charid = string.sub(self:getId(), string.find(self:getId(), "char:") + 5)
            return tonumber(charid) or 0
        end
        return 0
    end

    self.addItem = function(this, id, amount)
        local ItemData = API.getItemDataFromId(id)
        if ItemData == nil then
            return false
        end

        local _temp = self.items[id] or 0
        _temp = _temp + amount

        self.items[id] = _temp

        if self:getId() ~= nil then
            API_Database.execute("FCRP/Inventory", {id = self:getId(), charid = self:getCharId(), capacity = 0, itemName = id, itemCount = _temp, typeInv = "update"})
        end

        for viewerSource, asPrimary in pairs(self.viewersSources) do
            -- Update
            local User = API.getUserFromSource(viewerSource)

            if asPrimary then
                TriggerClientEvent("FCRP:INVENTORY:PrimarySyncItemAmount", viewerSource, id, _temp, ItemData:getName())
                User:notify("Inventário Principal: + x" .. amount .. " " .. ItemData:getName())
            else
                TriggerClientEvent("FCRP:INVENTORY:SecondarySyncItemAmount", viewerSource, id, _temp, ItemData:getName())
                User:notify("Inventário Secundário: + x" .. amount .. " " .. ItemData:getName())
            end
        end

        return true
    end

    self.removeItem = function(this, id, amount)
        if self.items[id] then
            local _temp = self.items[id] or 0
            _temp = _temp - amount

            if _temp > 0 then
                self.items[id] = _temp
                if self:getId() ~= nil then
                    API_Database.execute("FCRP/Inventory", {id = self:getId(), charid = self:getCharId(), capacity = 0, itemName = id, itemCount = _temp, typeInv = "update"})
                end
            else
                self.items[id] = nil
                if self:getId() ~= nil then
                    API_Database.execute("FCRP/Inventory", {id = self:getId(), charid = self:getCharId(), capacity = 0, itemName = id, itemCount = 0, typeInv = "remove"})
                end
            end

            local ItemData = API.getItemDataFromId(id)
            for viewerSource, asPrimary in pairs(self.viewersSources) do
                -- Update
                local User = API.getUserFromSource(viewerSource)

                if asPrimary then
                    TriggerClientEvent("FCRP:INVENTORY:PrimarySyncItemAmount", viewerSource, id, _temp, ItemData:getName())
                    User:notify("Inventário Principal: - x" .. amount .. " " .. ItemData:getName())
                else
                    TriggerClientEvent("FCRP:INVENTORY:SecondarySyncItemAmount", viewerSource, id, _temp, ItemData:getName())
                    User:notify("Inventário Secundário: - x" .. amount .. " " .. ItemData:getName())
                end
            end

            return true
        end

        return false
    end

    self.getItemAmount = function(this, item_id)
        local amount = self.items[item_id] or 0
        return amount
    end

    self.hasItem = function(this, item_id)
        return self:getItemAmount(item_id) > 0
    end

    self.viewAsPrimary = function(this, viewerSource)
        self.viewersSources[viewerSource] = true

        local parsedItems = {}
        for id, amount in pairs(self.items) do
            local ItemData = API.getItemDataFromId(id)
            -- if ItemData ~= nil then
            table.insert(
                parsedItems,
                {
                    id = id,
                    amount = amount,
                    name = ItemData:getName(),
                    subtitle = ItemData:getSubTitle()
                    -- name = ItemData:getName()
                }
            )
            -- end
        end

        TriggerClientEvent("FCRP:INVENTORY:openAsPrimary", viewerSource, parsedItems)
    end

    self.viewAsSecondary = function(this, viewerSource)
        self.viewersSources[viewerSource] = false

        local parsedItems = {}
        -- Dont really need to parse them as the name of the items is being read from the ItemList config by the client
        for id, amount in pairs(self.items) do
            local ItemData = API.getItemDataFromId(id)
            -- if ItemData ~= nil then
            table.insert(
                parsedItems,
                {
                    id = id,
                    amount = amount,
                    name = ItemData:getName(),
                    subtitle = ItemData:getSubTitle()
                    -- name = ItemData:getName()
                }
            )
            -- end
        end

        TriggerClientEvent("FCRP:INVENTORY:openAsSecondary", viewerSource, parsedItems)
    end

    self.removeViewer = function(this, viewerSource)
        self.viewersSources[viewerSource] = nil
    end

    self.notify = function(this, v)
        for _, viewerSource in pairs(viewersSources) do
            local User = API.getUserFromSource(viewerSource)

            if User ~= nil then
                User:notify(v)
            end
        end
    end

    self.deleteInventory = function(self)
        API_Database.execute("FCRP/Inventory", {id = self:getId(), charid = self:getCharId(), capacity = 0, itemName = 0, itemCount = 0, typeInv = "deadPlayer"})
        self.items = nil
    end

    return self
end
