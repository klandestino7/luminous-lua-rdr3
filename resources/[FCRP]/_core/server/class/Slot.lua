function API.Slot(Inventory, slotId, itemId, itemAmount)
    local self = {}

    self.Inventory = Inventory
    self.slotId = slotId
    self.itemId = itemId
    self.itemAmount = itemAmount
    self.itemData = API.getItemDataFromId(itemId)

    self.getSlotId = function()
        return self.slotId
    end

    self.getItemId = function()
        return self.itemId
    end

    self.getItemAmount = function()
        return self.itemAmount
    end

    self.getItemData = function()
        return self.itemData
    end

    self.setItemAmount = function(this, v)
        if v <= 0 then
            self:destroy()
        else
            self.itemAmount = v
        end
    end

    self.addItemAmount = function(this, v)
        self:setItemAmount(self:getItemAmount() + v)
    end

    self.removeItemAmount = function(this, v)
        self:setItemAmount(self:getItemAmount() - v)
    end

    self.destroy = function()
        self.Inventory:getSlots()[self:getSlotId()] = nil
        self = nil
        return self
    end

    return self
end
