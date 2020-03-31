function API.Inventory(id, capacity, items)
    local self = {}

    self.id = id
    self.capacity = capacity or 20
    self.items = items or {}
    self.viewersSources = {}
    self.save = true

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

    self.addItem = function(this, id, amount, forced)
        local ItemData = API.getItemDataFromId(id)
        if ItemData == nil then
            return false
        end

        -- if forced == true or self:getWeight() + (ItemData:getWeight() * amount) <= self:getCapacity() then
        local _temp = self.items[id] or 0
        _temp = _temp + amount

        self.items[id] = _temp

        if self.save == true then
            dbAPI.execute("FCRP/Inventory", {id = self:getId(), charid = self:getCharId(), itemName = id, itemCount = _temp, typeInv = "update"})
        end

        for viewerSource, asPrimary in pairs(self.viewersSources) do
            -- Update
            local User = API.getUserFromSource(viewerSource)

            if asPrimary then
                TriggerClientEvent("FCRP:INVENTORY:PrimarySyncItemAmount", viewerSource, id, _temp)
                User:notify("Inventário Principal: + x" .. amount .. " " .. ItemData:getName())
            else
                TriggerClientEvent("FCRP:INVENTORY:SecondarySyncItemAmount", viewerSource, id, _temp)
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
                if self.save == true then
                    dbAPI.execute("FCRP/Inventory", {id = self:getId(), charid = self:getCharId(), itemName = id, itemCount = _temp, typeInv = "update"})
                end
            else
                self.items[id] = nil
                if self.save == true then
                    dbAPI.execute("FCRP/Inventory", {id = self:getId(), charid = self:getCharId(), itemName = id, itemCount = 0, typeInv = "remove"})
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

    self.getItemAmount = function(this, itemId)
        local amount = self.items[itemId] or 0
        return amount
    end

    self.viewAsPrimary = function(this, viewerSource)
        self.viewersSources[viewerSource] = true

        local items = {}
        for id, amount in pairs(self.items) do
            table.insert(
                items,
                {
                    id = id,
                    amount = amount
                }
            )
        end

        TriggerClientEvent("FCRP:INVENTORY:openAsPrimary", viewerSource, items)
    end

    self.viewAsSecondary = function(this, viewerSource)
        self.viewersSources[viewerSource] = false

        local items = {}
        for id, amount in pairs(self.items) do
            table.insert(
                items,
                {
                    id = id,
                    amount = amount
                }
            )
        end

        TriggerClientEvent("FCRP:INVENTORY:openAsSecondary", viewerSource, items)
    end

    self.removeViewer = function(this, User)
        if self.viewersSources[User:getSource()] ~= nil then
            if self.viewersSources[User:getSource()] == true then -- If viewing as primary
                User.primaryViewingInventory = nil
            else
                User.secondaryViewingInventory = nil
            end
        end

        self.viewersSources[User:getSource()] = nil
    end

    self.clear = function(self)
        self.items = {}

        if self.save == true then
            dbAPI.execute("FCRP/Inventory", {id = self:getId(), charid = self:getCharId(), itemName = 0, itemCount = 0, typeInv = "deadPlayer"})
        end
    end

    self.saveable = function(self, bool)
        self.save = bool
    end

    return self
end
