-- User Object
-- Inherits: ?
--

function API.User(source, id, ipAddress)
    local self = {}

    self.source = source
    self.id = id
    self.ipAddress = ipAddress or "0.0.0.0"
    self.posseId = nil

    -- @return The source or player server id
    self.getSource = function()
        return self.source
    end

    -- @return the user_id
    self.getId = function()
        return self.id
    end

    self.getIpAddress = function()
        return ipAddress
    end

    self.getIdentifiers = function()
        local num = GetNumPlayerIdentifiers(self.source)

        local identifiers = {}
        for i = 1, num do
            table.insert(identifiers, GetPlayerIdentifier(self.source, i))
        end

        return identifiers
    end

    -- getCharacters()
    -- @return Every character data owned by this user
    -- @format
    --          {
    --             charid (int)
    --             user_id (int)
    --             characterName (string)
    --             level (int)
    --             xp (int)
    --             groups (table)
    --             charTable (table)
    --             clothes (table)
    --             weapons (table)
    --          }
    self.getCharacters = function()
        local rows = API_Database.query("FCRP/GetCharacters", {user_id = self.id})
        if #rows > 0 then
            return rows
        end
    end

    -- createCharacter(param1)
    -- @param String name and lastname of the new character
    -- @return Character Object
    --
    -- @info Wont do any checks, just create a new Character and into the Database

    self.createCharacter = function(this, characterName, age)
        local Character = nil
        local rows = API_Database.query("FCRP/CreateCharacter", {user_id = self:getId(), charName = characterName, charAge = age})
        if #rows > 0 then
            local charId = rows[1].id

            Character = API.Character(charId, characterName, 1, 0, 0, age, API.Inventory("char:" .. charId, nil, nil))
            --    Character:createHorse("A_C_Donkey_01", "Burrinho")
            -- Character:setData(charId, "charTable", "hunger", 0)
            -- Character:setData(charId, "charTable", "thirst", 0)
            -- Character:setData(charId, "charTable", "banco", 0)

            API_Database.execute(
                "FCRP/Inventory",
                {
                    id = "char:" .. Character:getId(),
                    charid = Character:getId(),
                    capacity = 20,
                    slot = 0,
                    itemId = 0,
                    itemAmount = 0,
                    procType = "insert"
                }
            )
        end

        return Character
    end

    self.deleteCharacter = function(this, id)
        API_Database.execute("FCRP/DeleteCharacter", {charid = id})
    end

    self.setCharacter = function(this, id)
        local charRow = API_Database.query("FCRP/GetCharacter", {charid = id})
        if #charRow > 0 then
            API.chars[id] = self:getId()
            local inv_query = API_Database.query("SELECT:inv_select_slots_and_capacity", {inv_id = "char:" .. id})

            local Inventory = nil
            if #inv_query > 0 then
                local slots, _ = json.decode(inv_query[1].inv_slots)

                for k, v in pairs(slots) do
                    slots[k] = json.decode(v)
                end

                Inventory = API.Inventory("char:" .. id, tonumber(inv_query[1].inv_capacity), slots)
            end

            self.Character = API.Character(id, charRow[1].characterName, charRow[1].level, charRow[1].xp, tonumber(charRow[1].groups), charRow[1].age, Inventory)
            self.Character:setUserId(self:getId())
            self.Character:setSource(self:getSource())
            -- Enviar informaçoes da Hotbar
            -- print(#Inventory:getItems(), Inventory:getItems())
            -- if #Inventory:getItems() > 0 then
            --     local items = Inventory:getItems()
            --     local found = false
            --     for i = 129, 132 do
            --         if items[stringd] ~= nil then
            --             found = true
            --             parsedSlots[i] = {
            --                 items[i][1],
            --                 items[i][2]
            --             }
            --         end
            --     end
            --     if found == true then
            --         TriggerClientEvent("VP:INVENTORY:PrimarySyncSlots", self:getSource(), parsedSlots)
            --     end
            -- end

            -- local weapons = json.decode(charRow[1].weapons) or {}
            -- cAPI.replaceWeapons(self:getSource(), weapons)

            -- Vai retornar o cavalo atual do Character, caso não tenha, vai buscar pelo bancao de dados e carregar ele

            local Horse, horseComponents = self:getCharacter():getHorse()

            if Horse ~= nil then
                TriggerClientEvent("VP:HORSE:SetHorseInfo", self:getSource(), Horse:getModel(), Horse:getName(), horseComponents)
            else
                TriggerClientEvent("VP:HORSE:SetHorseInfo", self:getSource(), "A_C_Horse_MP_Mangy_Backup", "Pangaré", {0x106961A8, 0x508B80B9})
            end

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

            TriggerEvent("API:OnUserSelectCharacter", self, id)

            ---------------- AUTO ADMING GROUP TO USER WITH ID 1
            self.drawCharacter()
        end
    end

    -- getCharacter()
    --
    -- @return Character Object of the actual selected character

    self.getCharacter = function()
        return self.Character
    end
    self.saveCharacter = function()
        -- if self.Character ~= nil then
        --     self.Character:savePosition(Character:getLastPosition())
        -- end
    end

    self.drawCharacter = function()
        local Character = self:getCharacter()

        local character_model = Character:getModel()
        --   local character_skin = Character:getSkin()

        local character_clothing = Character:getClothes()
        local character_lastposition = Character:getLastPosition()

        local character_stats = Character:getCachedStats()

        if json.decode(character_clothing).Outfit ~= nil then
            cAPI.Initialize(self:getSource(), json.decode(character_model), tonumber(json.decode(character_clothing).Outfit), character_lastposition, character_stats)
        else
            cAPI.Initialize(self:getSource(), json.decode(character_model), character_clothing, character_lastposition, character_stats)
        end

        -- cAPI.CWanted(Character:getWanted())
    end

    self.disconnect = function(this, reason)
        DropPlayer(self:getSource(), reason)
    end

    self.viewInventory = function()
        if self.Character ~= nil then
            self:viewInventoryAsPrimary(self:getCharacter():getInventory())
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

    self.hasInventoryOpen = function()
        if self:getCharacter() == nil then
            return false
        else
            return self:getPrimaryInventoryViewing() == self:getCharacter():getInventory()
        end
    end

    self.setHorse = function(this, id)
        local Horse = self:getCharacter():setHorse(id)
        cAPI.SetHorseInfo(self:getSource(), Horse:getModel(), Horse:getName(), Horse:getComponents())
    end

    self.notify = function(this, type, text, quantity)
        -- cAPI.notify(self:getSource(), v)
        if type ~= nil and text == nil and quantity == nil then
            text = type
            type = "dev"
        end

        TriggerClientEvent("VP:TOAST:New", self:getSource(), type, text, quantity)
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
        TriggerClientEvent("VP:POSSE:SetPosse", self:getSource(), id)
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
