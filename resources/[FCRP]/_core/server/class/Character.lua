function API.Character(id, charName, level, xp, groups, inventory)
    local self = {}

    self.id = id
    self.charName = charName
    self.level = level or 1
    self.xp = xp or 0
    self.groups = groups or {}
    self.Inventory = inventory or API.Inventory("char:" .. self.id, nil, nil)

    self.getInventory = function()
        return self.Inventory
    end

    self.addGroup = function(this, group)
        
        local groupType = Config_Permissions[group].type
        if groupType ~= nil then
            for tempGroup, _ in pairs(self.groups) do
                local tempGroupType = Config_Permissions[group].type
                if tempGroupType == groupType then
                    self.removeGroup(tempGroup)
                    break
                end
            end
        end

        self:setData(self.id, "groups", group, true)
        self.groups[group] = true
    end

    self.removeGroup = function(this, group)
        self:remData(self.id, "groups", group)
        self.groups[group] = nil
    end

    self.hasGroup = function(this, group)
        return self.groups[group] ~= nil
    end

    self.hasGroupOrInheritance = function(this, group)
        if self.groups[group] then
            return true
        else
            for tempGroup, _ in pairs(self.groups) do
                if Config_Permissions[tempGroup] then
                    local foundInheritanceGroup = Config_Permissions[tempGroup].inheritance
                    if foundInheritanceGroup == group then
                        return true
                    else
                        while true do
                            Citizen.Wait(0)
                            foundInheritanceGroup = Config_Permissions[foundInheritanceGroup].inheritance
                            if foundInheritanceGroup == nil then
                                return false
                            else
                                if foundInheritanceGroup == group then
                                    return true
                                end
                            end
                        end
                    end
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

    self.getXp = function()
        return self.xp
    end

    self.updateLevel = function()
        for level, info in pairs(LevelSystem) do
            local savedLevel = level + 1
            if self.xp < LevelSystem[level].xp then
                self.level = level - 1
                dbAPI.execute("FCRP/UpdateLevel", {charid = self:getId(), level = self.level})
                break
            end
        end
    end

    self.addXp = function(this, v)
        self.xp = self.xp + v
        self.updateLevel()
        local xp = dbAPI.query("FCRP/UpdateXP", {charid = self:getId(), xp = self.xp})
    end

    self.removeXp = function(this, v)
        self.xp = self.xp - v
        self.updateLevel()
        local xp = dbAPI.query("FCRP/UpdateXP", {charid = self:getId(), xp = self.xp})
    end

    self.setWeapons = function(this, weapons)
        dbAPI.execute("FCRP/SetCWeaponData", {charid = self:getId(), weapons = json.encode(weapons)})
    end

    self.getModel = function()
        return self:getData("skin", "model")
    end

    self.getSkin = function()
        return self:getData("skin", nil)
    end

    self.getClothes = function()
        return self:getData("clothes", nil)
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
    self.setData = function(this, targetName, key, value)
        dbAPI.query("FCRP/SetCData", {target = targetName, key = key, value = value, charid = self:getId()})
    end

    self.getData = function(this, targetName, key)
        if key == nil then
            key = "all"
        end
        local rows = dbAPI.query("FCRP/GetCData", {target = targetName, charid = self:getId(), key = key})
        if #rows > 0 then
            return rows[1].Value
        else
            return ""
        end
    end

    self.remData = function(this, targetName, key)
        local rows = dbAPI.query("FCRP/RemCData", {target = targetName, key = key, charid = self:getId()})
        if #rows > 0 then
            return true
        end
        return false
    end

    self.createHorse = function(this, model, name)
        local rows = dbAPI.query("FCRP/CreateHorse", {charid = self:getId(), model = model, name = name})
        if #rows > 0 then
            local id = rows[1].id
            self.Horse = API.Horse(id, model, name, API.Inventory("horse" .. id, nil, nil))
            local Inventory = self.Horse:getInventory()

            dbAPI.execute("FCRP/Inventory", {id = "horse:" .. id, charid = self:getId(), itemName = 0, itemCount = 0, typeInv = "insert"})
        end

        return self.Horse
    end

    self.setHorse = function(this, id)
        local rows = dbAPI.query("FCRP/GetHorse", {id = id})
        if #rows > 0 then
            local invRows = dbAPI.query("FCRP/Inventory", {id = "horse:" .. id, charid = 0, itemName = 0, itemCount = 0, typeInv = "select"})
            local Inventory = nil
            if #invRows > 0 then
                local items, _ = json.decode(invRows[1].items)
                Inventory = API.Inventory("horse:" .. id, tonumber(invRows[1].capacity), items)
            end
            self.Horse = API.Horse(id, rows[1].model, rows[1].name, Inventory)
            return self:getHorse()
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
        local rows = dbAPI.query("FCRP/GetHorses", {charid = self.id})
        if #rows > 0 then
            return rows
        end
    end

    self.getHorse = function()
        if self.Horse == nil then
            local horses = self:getHorses()

            if horses ~= nil then
                local invRows = dbAPI.query("FCRP/Inventory", {id = "horse:" .. horses[1].id, charid = 0, itemName = 0, itemCount = 0, typeInv = "select"})
                local Inventory = nil
                if #invRows > 0 then
                    -- Por algum motivo o decode tá retornando 2 valores?
                    local items, _ = json.decode(invRows[1].items)
                    Inventory = API.Inventory("horse:" .. horses[1].id, tonumber(invRows[1].capacity), items)
                end

                self.Horse = API.Horse(tonumber(horses[1].id), horses[1].model, horses[1].name, Inventory)

                return self.Horse
            else
                return self:createHorse("A_C_Donkey_01", "Burrinho")
            end
        else
            return self.Horse
        end
    end

    self.savePosition = function(this, source)
        local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(source)))
        local encoded = {
            ["x"] = tonumber(math.floor(x * 100) / 100),
            ["y"] = tonumber(math.floor(y * 100) / 100),
            ["z"] = tonumber(math.floor(z * 100) / 100)
        }
        self:setData(self:getId(), "charTable", "position", json.encode(encoded))
    end

    self.addGroup = function(this, group)
        self:setData(self.id, "groups", group, true)
        self.groups[group] = true
    end

    self.saveClothes = function()
        --[[ for k,v in pairs(cAPI.getClothes()) do
            self:setData(self.id, 'clothes', k, v)
        end ]]
    end

    self.saveProfiles = function()
        --[[ for k,v in pairs(cAPI.getProfiles()) do
            self:setData(self.id, 'charTable', k, v)
        end ]]
    end

    return self
end
