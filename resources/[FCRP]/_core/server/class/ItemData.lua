function API.ItemData(id, name, type, weight, description)
    local self = {}

    self.id = id
    self.name = name
    self.weight = weight
    self.type = type
    self.description = description or "DESCRIPTION"

    -- self.triggerOnUse

    self.getId = function()
        return self.id
    end

    self.getName = function(this)
        return self.name
    end

    -- self.getDescription = function(this)
    --     return self.description
    -- end

    self.getWeight = function()
        return self.weight
    end

    self.getStackSize = function()
        return 16
    end

    self.getType = function()
        return self.type
    end

    self.getSlotType = function()
        if self.type == "food" or self.type == "beverage" then
            return "Food"
        end

        if self.type == "tonics" or self.type == "boost" then
            return "Tonics"
        end

        if self.type == "weapon" or self.type == "ammo" then
            return "Tools_Weapons"
        end

        -- local slotTypes = {
        --     "Recents",
        --     "Food",
        --     "Tonics",
        --     "Ingredients",
        --     "Tools_Weapons",
        --     "Kit",
        --     "Valuables",
        --     "Documents"
        --     "Hotbar",
        -- }
        return "Food"
    end

    self.hasOnUseHandler = function()
        return self.triggerOnUse ~= nil
    end

    return self
end
