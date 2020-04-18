function API.ItemData(id, name, description, type, stackSize, weight)
    local self = {}

    self.id = id
    self.name = name
    self.description = description
    self.type = type
    self.stackSize = stackSize
    self.weight = weight

    self.getId = function()
        return self.id
    end

    self.getName = function(this)
        return self.name or "nome"
    end

    self.getDescription = function()
        return self.description or "descricao"
    end

    self.getType = function()
        return self.type or "generic"
    end

    self.getStackSize = function()
        return self.stackSize or 1
    end

    self.getWeight = function()
        return self.weight or 1
    end

    self.triggerUse = function(this, User)
        return triggerUse(User, self.id, self.type)
    end

    return self
end

-- self.getSlotType = function()
--     if self.type == "food" or self.type == "beverage" then
--         return "Food"
--     end

--     if self.type == "tonics" or self.type == "boost" then
--         return "Tonics"
--     end

--     if self.type == "weapon" or self.type == "ammo" then
--         return "Tools_Weapons"
--     end

--     -- local slotTypes = {
--     --     "Recents",
--     --     "Food",
--     --     "Tonics",
--     --     "Ingredients",
--     --     "Tools_Weapons",
--     --     "Kit",
--     --     "Valuables",
--     --     "Documents"
--     --     "Hotbar",
--     -- }
--     return "Food"

function triggerUse(User, itemData)
    local source = User:getSource()

    local itemId = itemData:getId()
    local itemType = itemData:getType()

    if itemType == "food" then
        local var = itemData.varOnUse

        API.varyHunger(source, var)

        return true
    end

    if itemType == "beverage" then
        local var = itemData.varOnUse

        API.varyThirst(source, var)

        return true
    end

    if itemType == "tonic" then
        local var = values.varOnUse

        if itemId == "tonic_medicine" or itemId == "tonic" or itemId == "tonic_potent_medicine" then
            cAPI.varyHealth(User:getSource(), var)
        end

        if itemId == "special_tonic" or itemId == "tonic_special_medicine" or itemId == "tonic_special_horse_stimulant_crafted" then
            cAPI.varyStamina(User:getSource(), var)
            cAPI.varyEye(User:getSource(), var)
        end

        return true
    end

    if itemId == "chest_small" then
        local var = values.varOnUse

        TriggerEvent("FCRP:CHESTS:StartPlayerPlacement", source, var)
    end

    return false
end
