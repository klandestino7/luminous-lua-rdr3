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
        return triggerUse(User, self)
    end

    self.isMelee = function()
        return isMelee(self:getId())
    end

    self.isThrowable = function()
        return isThrowable(self:getId())
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

    if itemType == "tonic" or itemType == "boost" then
        if itemId:find("tonic") then
            cAPI.TaskInteraction(source, "drink_tonic")
            User:closeInventory()

            if itemId:find("health") then
                cAPI.VaryPlayerHealth(source, 25, 60)
            elseif itemId:find("stamina") then
                cAPI.VaryPlayerStamina(source, 25, 60)
            end
            return true
        end

        if itemId:find("boost") then
            if itemId:find("horse") then
                if cAPI.IsPlayerMountedOnOwnHorse(source) then
                    cAPI.TaskAnimalInteraction(source, "injection")
                    User:closeInventory()


                    if itemId:find("health") then
                        cAPI.VaryHorseHealth(source, 25)
                    elseif itemId:find("stamina") then
                        cAPI.VaryHorseStamina(source, 25)
                    end
                    return true
                else
                    return false
                end
            else
                cAPI.TaskInteraction(source, "injection")
                User:closeInventory()

                if itemId:find("health") then
                    cAPI.VaryPlayerHealth(User:getSource(), 25)
                    cAPI.VaryPlayerCore(User:getSource(), 0, 25, 0, true)
                elseif itemId:find("stamina") then
                    cAPI.VaryPlayerStamina(User:getSource(), 25)
                    cAPI.VaryPlayerCore(User:getSource(), 1, 25, 0, true)
                end
                return true
            end
        end

        return false
    end

    if itemId == "chest_small" then
        local var = itemData.varOnUse

        TriggerEvent("VP:CHESTS:StartPlayerPlacement", source, var)

        return true
    end

    if itemId:find("_seed") then
        TriggerClientEvent("VP:FARM:StartPlacingSeed", source, itemId:sub(0, itemId:find("_") - 1))
        User:closeInventory()
        return false
    end

    if itemId == "pigeonpost" then
        TriggerClientEvent("VP:PIGEONPOST:Init", source)
    end

    return false
end

local melee = {
    "lasso",
    "melee_lantern_electric",
    "melee_torch",
    "melee_broken_sword",
    "fishingrod",
    "melee_knife_john",
    "melee_knife",
    "melee_knife_bear",
    "melee_cleaver",
    "melee_ancient_hatchet",
    "melee_knife_jawbone",
    "melee_knife_hunter",
    "melee_knife_miner",
    "melee_machete"
}

local throwable = {
    "thrown_ancient_tomahawk",
    "thrown_dynamite",
    "thrown_molotov",
    "thrown_throwing_knives",
    "thrown_throwing_knives_improved",
    "melee_hatchet",
    "melee_hatchet_viking",
    "melee_hatchet_hewing",
    "melee_hatchet_double_bit",
    "melee_hatchet_double_bit_rusted",
    "melee_hatchet_hunter",
    "melee_hatchet_hunter_rusted"
}

function isMelee(itemId)
    -- itemId = 'weapon_' .. itemId

    for _, col in pairs(melee) do
        if itemId == col then
            return true
        end
    end

    return false
end

function isThrowable(itemId)
    -- itemId = 'weapon_' .. itemId

    for _, col in pairs(throwable) do
        if itemId == col then
            return true
        end
    end

    return false
end
