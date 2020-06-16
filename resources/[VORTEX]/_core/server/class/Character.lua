function API.Character(id, charName, level, xp, role, charAge, inventory)
    local self = {}

    self.id = id
    self.charName = charName
    self.level = level or 1
    self.xp = xp or 0
    self.charAge = charAge
    self.Inventory = inventory or API.Inventory("char:" .. self.id, nil, nil)
    self.Horse = nil

    self.role = role or 0

    -- self.user_id
    -- self.source

    self.setUserId = function(this, v)
        self.user_id = v
    end

    self.setSource = function(this, v)
        self.source = v
    end

    self.getUserId = function()
        return self.user_id
    end

    self.getSource = function()
        return self.source
    end

    self.getInventory = function()
        return self.Inventory
    end

    self.hasGroup = function(this, group)
        local bit = config_file_GROUPS[group:lower()]

        if bit ~= nil then
            return (self.role & bit) ~= 0
        end

        return false
    end

    self.addGroup = function(this, group)
        if not self:hasGroup(group) then
            local bit = config_file_GROUPS[group:lower()]

            if bit ~= nil then
                self.role = self.role + bit

                TriggerClientEvent("VP:EVENTS:CharacterJoinedGroup", self:getSource(), group)

                API_Database.execute("UPDATE:character_data_role", {charid = self:getId(), role = self.role})
            end
        end
    end

    self.removeGroup = function(this, group)
        if self:hasGroup(group) then
            local bit = config_file_GROUPS[group:lower()]

            if bit ~= nil then
                self.role = self.role - bit

                TriggerClientEvent("VP:EVENTS:CharacterLeftGroup", self:getSource(), group)

                API_Database.execute("UPDATE:character_data_role", {charid = self:getId(), role = self.role})
            end
        end
    end

    self.hasGroupOrInheritance = function(this, group)
        if self:hasGroup(group) then
            return true
        else
            local lastParent = group
            -- print('Trying inheritance for group ' .. group)

            -- local nth = 1
            while lastParent ~= nil do
                local inheritance = config_file_INHERITANCE[lastParent]
                lastParent = inheritance
                -- print(nth .. '* inheritance' .. inheritance)

                if lastParent ~= nil and self:hasGroup(lastParent) then
                    return true
                end
            end
        end

        return false
    end

    self.getId = function()
        return self.id
    end

    self.getName = function()
        return self.charName
    end

    self.getLevel = function()
        return self.level
    end

    self.getExp = function()
        return self.xp or 0
    end

    self.varyExp = function(this, variation)
        self.xp = self:getExp() + variation

        -- for level, info in pairs(LevelSystem) do
        --     local savedLevel = level + 1
        --     if self.xp < LevelSystem[level].xp then
        --         self.level = level - 1
        --     else
        --     end


        --     Citizen.CreateThread(
        --         function()
        --             API_Database.execute("FCRP/UpdateLevel", {charid = self:getId(), level = self:getLevel()})
        --         end
        --     )
        --     break
        -- end

        TriggerClientEvent("VP:TOAST:New", self:getSource(), "xp", variation)

        API_Database.execute("FCRP/UpdateXP", {charid = self:getId(), xp = self:getExp()})
    end

    self.getModel = function()
        return self:getData(self.id, "SkinMdf", nil)
    end

    self.getCharTable = function()
        return self:getData(self.id, "charTable", nil)
    end

    self.getClothes = function()
        return self:getData(self.id, "clothes", nil)
    end

    --[[
        Targets:
            charTable, groups, clothes
        Keys From charTable:
            hunger, thirst, health
        Keys From Groups:
            admin, user, vip1, vip2
        Keys From Clothes:
            chapeu, camisa, colete, casaco, calca, mascara, botas, luvas, saia, coldre 
        How Works:
            Character.getData(CHARID, TARGETS, KEY)
            Character.setData(CHARID, TARGETS, KEY, VALUE)
            Character.remData(CHARID, TARGETS, KEY)
        
        on put key = nil is all JSON {} 
    ]]
    self.setData = function(this, cid, targetName, key, value)
        API_Database.query("FCRP/SetCData", {target = targetName, key = key, value = value, charid = cid})
    end

    self.setSkinData = function(this, cid, value)
        API_Database.execute("FCRP/SetSkinData", {value = value, charid = cid})
        --      API_Database.query("FCRP/SetSkinData", {key = key, value = value, charid = cid})
    end

    self.getData = function(this, cid, targetName, key)
        if key == nil then
            key = "all"
        end
        local rows = API_Database.query("FCRP/GetCData", {target = targetName, charid = cid, key = key})
        if #rows > 0 then
            return rows[1].Value
        else
            return ""
        end
    end

    self.remData = function(this, cid, targetName, key)
        local rows = API_Database.query("FCRP/RemCData", {target = targetName, key = key, charid = cid})
        if #rows > 0 then
            return true
        end
        return false
    end

    self.setJail = function(this, cid, value)
        API_Database.execute("FCRP/SetCJail", {jail_time = value, charid = cid})
    end

    self.updJail = function(this, cid, value)
        API_Database.execute("FCRP/UpdCJail", {jail_time = value, charid = cid})
    end

    self.getJail = function(this, cid)
        if key == nil then
            key = "all"
        end
        local rows = API_Database.query("FCRP/GetCJail", {charid = cid})
        if #rows > 0 then
            return rows
        else
            return ""
        end
    end

    self.remJail = function(this, cid)
        local rows = API_Database.query("FCRP/RemCJail", {charid = cid})
        if #rows > 0 then
            return true
        end
        return false
    end

    self.setWanted = function(this, cid, value)
        API_Database.execute("FCRP/SetCWanted", {wanted = value, charid = cid})
    end

    self.getWanted = function(this, cid)
        local rows = API_Database.query("FCRP/GetCWanted", {user_id = cid})
        if rows ~= "{}" then
            return rows[1]
        else
            return nil
        end
    end

    self.updWanted = function(this, cid, value)
        API_Database.execute("FCRP/GetCWanted", {reward = value, charid = cid})
    end

    self.createHorse = function(this, model, name)
        local rows = API_Database.query("FCRP/CreateHorse", {charid = self:getId(), model = model, name = name})
        if #rows > 0 then
            local id = rows[1].id
            self.Horse = API.Horse(id, model, name, API.Inventory("horse" .. id, nil, nil))
            local Inventory = self.Horse:getInventory()

            API_Database.execute("FCRP/Inventory", {id = "horse:" .. id, charid = self:getId(), slot = 0, itemId = 0, itemAmount = 0, procType = "insert"})
        end

        return self.Horse
    end

    self.setHorse = function(this, id)
        local horseRows = API_Database.query("FCRP/GetHorse", {id = id})
        if #horseRows > 0 then
            -- local invRows = API_Database.query("FCRP/Inventory", {id = "horse:" .. id, charid = 0, slot = 0, itemId = 0, itemAmount = 0, procType = "select"})
            local inv_query = API_Database.query("SELECT:inv_select_slots_and_capacity", {inv_id = "horse" .. id})
            local Inventory = nil
            if #inv_query > 0 then
                local slots, _ = json.decode(inv_query[1].inv_slots)
                Inventory = API.Inventory("horse:" .. id, tonumber(inv_query[1].inv_capacity), slots)
            end
            self.Horse = API.Horse(id, horseRows[1]["model"], horseRows[1]["name"], Inventory)
            self:getHorse():setComponents(json.decode(horseRows[1]["components"]))
            return self.Horse
        end
    end

    self.removeHorse = function(this, id)
        if self.Horse ~= nil then
            if self.Horse:getId() == id then
                self.Horse = nil
            end
        end
    end

    self.getHorses = function()
        local rows = API_Database.query("FCRP/GetHorses", {charid = self.id})
        if #rows > 0 then
            return rows
        else
            return ""
        end
    end

    self.getHorse = function()
        if self.Horse == nil then
            local charHorsesRows = self:getHorses()
            if #charHorsesRows > 0 then
                -- local invRows = API_Database.query("FCRP/Inventory", {id = "horse:" .. horses[1].id, charid = 0, itemName = 0, itemCount = 0, typeInv = "select"})
                local Inventory = nil
                -- if #invRows > 0 then
                --     -- Por algum motivo o decode tá retornando 2 valores?
                --     local items, _ = json.decode(invRows[1].items)
                --     Inventory = API.Inventory("horse:" .. charHorsesRows[1].id, tonumber(invRows[1].capacity), items)
                -- end

                self.Horse = API.Horse(tonumber(charHorsesRows[1]["id"]), charHorsesRows[1]["model"], charHorsesRows[1]["name"], Inventory)

                return self.Horse, json.decode(charHorsesRows[1]["components"]) or {}
            else
                return
            end
        else
            return self.Horse, nil
        end
    end

    self.setDeath = function(this, value)
        API_Database.execute("FCRP/SetPlayerDeath", {charid = self:getId(), is_dead = value})
    end

    self.getDeath = function(this)
        local row = API_Database.query("FCRP/GetPlayerDeath", {charid = self:getId()})
        return table.unpack(row).is_dead
    end

    -- self.savePosition = function(this, x, y, z)
    --     local encoded = json.encode({x, y, z})
    --     self:setData(self:getId(), "charTable", "position", encoded)
    -- end

    self.getLastPosition = function(this)
        local lastPositionFromDb = self:getData(self.id, "charTable", "position")
        return lastPositionFromDb ~= nil and json.decode(lastPositionFromDb) or {-329.9, 775.11, 121.74}
    end

    self.getCachedStats = function()
        local c = self:getData(self.id, "charTable", "stats")
        return c ~= nil and json.decode(c) or {}
    end

    self.cacheStats = function(this, position, health, stamina, healthCore, staminaCore)
        local encodedStats = json.encode({health, stamina, healthCore, staminaCore})
        local encodedPosition = json.encode(position)
        self:setData(self:getId(), "charTable", "stats", encodedStats)
        self:setData(self:getId(), "charTable", "position", encodedPosition)
    end

    return self
end
