-- function API.ItemSlot(parentInventory, slot, Item)
-- function API.ItemSlot(Item)
function API.ItemSlot(slot, itemId, itemAmount)
    -- self.Item = Item

    -- self.getInventory = function()
    --     return self.parentInventory
    -- end

    -- self.setInventory = function(this, v)
    --     self.parentInventory = v
    -- end

    local self = {}

    self.slot = slot

    self.getSlot = function()
        return self.slot
    end

    self.setSlot = function(this, v)
        self.slot = v
    end

    -- self.getItem = function()
    --     return self.Item
    -- end

    -- self.setItem = function(this, v)
    --     self.Item = v
    -- end

    self.itemId = itemId
    self.itemAmount = itemAmount

    self.getItemId = function()
        return self.itemId
    end

    self.setItemId = function(this, v)
        self.itemId = v
    end

    self.getItemAmount = function()
        return self.itemAmount
    end

    self.setItemAmount = function(this, v)
        self.itemAmount = v
    end

    return self
end