function API.User(source, id, ipAddress)
    local self = {}

    self.source = source
    self.id = id
    self.ipAddress = ipAddress or "0.0.0.0"
    self.posseId = nil

    self.save = function()
    end

    self.getSource = function()
        return self.source
    end

    self.getId = function()
        return self.id
    end

    self.getIpAddress = function()
        return ipAddress
    end

    self.getCharacters = function()
        local rows = dbAPI.query("FCRP/GetCharacters", {user_id = self.id})
        if #rows > 0 then
            return rows
        end
    end

    self.createCharacter = function(this, characterName, age, saves, clothes)
        local Character = nil
        local rows = dbAPI.query("FCRP/CreateCharacter", {user_id = self:getId(), charName = characterName, charAge = age, charSkin = saves, clothes = clothes})
        if #rows > 0 then
            local charId = rows[1].id

            Character = API.Character(charId, characterName, age, 1, 0, {}, API.Inventory("char:" .. charId, nil, nil))
            local Inventory = Character:getInventory()

            Character:setData(charId, "charTable", "hunger", 0)
            Character:setData(charId, "charTable", "thirst", 0)
            Character:setData(charId, "charTable", "position", '{"z":13.81,"y":-2738.70,"x":-1038.16}')

            dbAPI.execute("FCRP/Inventory", {id = "char:" .. Character:getId(), charid = Character:getId(), itemName = 0, itemCount = 0, typeInv = "insert"})
        -- Character:savePosition(self:getSource())
        end

        return Character
    end

    self.deleteCharacter = function(this, id)
        dbAPI.execute("FCRP/DeleteCharacter", {charid = id})
    end

    self.setCharacter = function(this, id)
        local charRow = dbAPI.query("FCRP/GetCharacter", {charid = id})
        if #charRow > 0 then
            API.chars[id] = self:getId()
            local rows2 = dbAPI.query("FCRP/Inventory", {id = "char:" .. id, charid = id, itemName = 0, itemCount = 0, typeInv = "select"})
            local Inventory = nil

            if #rows2 > 0 then
                Inventory = API.Inventory("char:" .. id, parseInt(rows2[1].capacity), json.decode(rows2[1].items))
            end

            self.Character = API.Character(id, charRow[1].characterName, charRow[1].level, charRow[1].xp, json.decode(charRow[1].groups), Inventory)
            local weapons = json.decode(charRow[1].weapons) or {}
            cAPI.replaceWeapons(self:getSource(), weapons)
            local posse = API.getPosse(tonumber(json.decode(charRow[1].charTable).posse))
            if posse ~= nil then
                self.posseId = posse:getId()
            end
            ---------------- AUTO ADMING GROUP TO USER WITH ID 1
            if self:getId() == 1 then
                if not self.Character:hasGroup("admin") then
                    self.Character:addGroup("admin")
                end
            end
            ---------------- AUTO ADMING GROUP TO USER WITH ID 1
            self.drawCharacter()
        end
    end

    self.getCharacter = function()
        return self.Character
    end

    self.saveCharacter = function()
        self.Character:savePosition(self:getSource())
    end

    self.drawCharacter = function()
        local source = self:getSource()
        local Character = self:getCharacter()

        local character_model = Character:getModel()
        local character_skin = Character:getSkin()
        local character_clothing = Character:getClothes()
        local character_lastposition = json.decode(Character:getData("charTable", "position")) or {0, 0, 0}

        cPlayer.Initialize(source, character_model, character_skin, character_clothing, character_lastposition)

        -- cAPI.player_Initialize(source, character_model, character_skin, character_clothing, character_lastposition)
    end

    self.disconnect = function(this, reason)
        DropPlayer(self:getSource(), reason)
    end

    self.viewInventory = function()
        if self.Character ~= nil then
            self:viewInventoryAsPrimary(self.Character:getInventory())
        end
    end

    self.viewInventoryAsPrimary = function(this, Inventory)
        self.primaryViewingInventory = Inventory
        Inventory:viewAsPrimary(self:getSource())
    end

    self.viewInventoryAsSecondary = function(this, Inventory)
        self.secondaryViewingInventory = Inventory
        Inventory:viewAsSecondary(self:getSource())
    end

    self.closeInventory = function()
        -- TriggerClientEvent('fcrp_inventory:closeInv', self:getSource())

        if self.primaryViewingInventory ~= nil then
            self.primaryViewingInventory:removeViewer(self)
        end

        if self.secondaryViewingInventory ~= nil then
            self.secondaryViewingInventory:removeViewer(self)
        end
    end

    self.getPrimaryInventoryViewing = function()
        return self.primaryViewingInventory
    end

    self.getSecondaryInventoryViewing = function()
        return self.secondaryViewingInventory
    end

    self.notify = function(this, v)
        print("User " .. self:getId() .. ": " .. v)
        -- cAPI.notify(self:getSource(), v)
    end

    self.getWeapons = function()
        return cAPI.getWeapons(self:getSource())
    end

    self.giveWeapon = function(this, weapon, ammo)
        self:giveWeapons({[weapon] = ammo})
    end

    self.giveWeapons = function(this, array)
        cAPI.giveWeapons(self:getSource(), array, false)
        self.Character:setWeapons(cAPI.getWeapons(self:getSource()))
    end

    self.removeWeapon = function(this, weapon)
        self:removeWeapons({weapon})
    end

    self.removeWeapons = function(this, array)
        local weapons = cAPI.getWeapons(self:getSource())
        for _, weapon in pairs(array) do
            weapons[weapon] = nil
        end
        cAPI.replaceWeapons(self:getSource(), weapons)
        self.Character:setWeapons(cAPI.getWeapons(self:getSource()))
    end

    self.replaceWeapons = function(this, array)
        cAPI.replaceWeapons(self:getSource(), array)
        self.Character:setWeapons(cAPI.getWeapons(self:getSource()))
    end

    self.setPosse = function(this, id)
        self.posseId = id

        TriggerClientEvent("FCRP:POSSE:SetPosse", self:getSource(), id)

        if id ~= nil then
            self:getCharacter():setData(self:getCharacter():getId(), "charTable", "posse", id)
        else
            self:getCharacter():remData(self:getCharacter():getId(), "charTable", "posse")
        end
    end

    self.getPosseId = function()
        return self.posseId
    end

    self.isInAPosse = function()
        return self.posseId ~= nil
    end

    return self
end
