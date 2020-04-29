function API.Chest(id)
    -- function API.Chest(id, owner_char_id, position, type, capacity, group)
    local self = {}
    self.id = id

    self.cache = function()
        API.cacheChest(self)
    end

    self.getId = function()
        return self.id
    end

    self.getOwnerCharId = function()
        return self.owner_char_id
    end

    self.getPosition = function()
        return self.position
    end

    self.getType = function()
        return self.type
    end

    self.getCapacity = function()
        return self.capacity
    end

    -- O items do baú são globais, são sempre os mesmos independente de quem abra
    self.isGlobal = function()
        return self.type == 0
    end

    -- O baú pode ser aberto por qualquer um, mas os items sao diferentes para cada player
    self.isPublic = function()
        return self.type == 1
    end

    -- O baú é aberto só pelo dono do baú, os items são sempre os mesmos
    self.isPrivate = function()
        return self.type == 2
    end

    self.getInventory = function(this, User)
        local Character = User:getCharacter()
        local charId = Character:getId()

        print(self.id)

        if self:isGlobal() then
            if self.groups then
                local hasAnyGroup = false
                for _, v in pairs(self.groups) do
                    if Character:hasGroupOrInheritance(v) then
                        hasAnyGroup = true
                        break
                    end
                end

                if hasAnyGroup == false then
                    return
                end
            end

            local higherThanOne = false
            if self.inventories ~= nil then
                for k, v in pairs(self.inventories) do
                    if v ~= nil then
                        higherThanOne = true
                        break
                    end
                end
            end

            if self.inventories == nil or higherThanOne == false then
                local query = API_Database.query("SELECT:inv_select_slots_and_capacity", {inv_id = "chest:" .. self.id})

                local Inventory

                if #query > 0 then
                    local slots, _ = json.decode(query[1].inv_slots)

                    for k, v in pairs(slots) do
                        slots[k] = json.decode(v)
                    end

                    Inventory = API.Inventory("chest:" .. self.id, tonumber(query[1].inv_capacity), slots)
                else
                    API_Database.execute(
                        "FCRP/Inventory",
                        {
                            id = "chest:" .. self.id,
                            charid = 0,
                            capacity = self.capacity,
                            slot = 0,
                            itemId = 0,
                            itemAmount = 0,
                            procType = "insert"
                        }
                    )

                    Inventory = API.Inventory("chest:" .. self.id, self.capacity, {})
                end

                if self.inventories == nil then
                    self.inventories = {}
                end

                self.inventories[0] = Inventory
            end

            return self.inventories[0]
        end

        if self:isPublic() or (self:isPrivate() and charId == self:getOwnerCharId()) then
            local targetId = self:getOwnerCharId()

            if self:isPublic() then
                targetId = charId
            end

            if self.inventories == nil or self.inventories[targetId] == nil then
                local query = API_Database.query("SELECT:inv_select_slots_and_capacity", {inv_id = "chest:char" .. targetId})

                local Inventory

                if #query >= 0 then
                    local slots, _ = json.decode(query[1].inv_slots)

                    for k, v in pairs(slots) do
                        slots[k] = json.decode(v)
                    end

                    Inventory = API.Inventory("chest:char:" .. targetId, tonumber(query[1].inv_capacity), slots)
                else
                    API_Database.execute(
                        "FCRP/Inventory",
                        {
                            id = "chest:char:" .. targetId,
                            charid = targetId,
                            capacity = self.capacity,
                            slot = 0,
                            itemId = 0,
                            itemAmount = 0,
                            procType = "insert"
                        }
                    )

                    Inventory = API.Inventory("chest:char" .. targetId, self.capacity, {})
                end

                if self.inventories == nil then
                    self.inventories = {}
                end

                self.inventories[targetId] = Inventory
            end

            return self.inventories[targetId]
        end
    end

    return self
end
