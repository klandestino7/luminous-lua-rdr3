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

    self.createCharacter = function(this, characterName)
        local Character = nil
        local rows = API_Database.query("FCRP/CreateCharacter", {user_id = self:getId(), charName = characterName})
        if #rows > 0 then
            local charId = rows[1].id

            Character = API.Character(charId, characterName, 1, 0, {}, API.Inventory("char:" .. charId, nil, nil))
            --    Character:createHorse("A_C_Donkey_01", "Burrinho")
            Character:setData(charId, "charTable", "hunger", 0)
            Character:setData(charId, "charTable", "thirst", 0)
            Character:setData(charId, "charTable", "banco", 0)

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
            local rows2 = API_Database.query("FCRP/Inventory", {id = "char:" .. id, charid = id, capacity = 0, slot = 0, itemId = 0, itemAmount = 0, procType = "select"})
            local Inventory = nil
            if #rows2 > 0 then
                Inventory = API.Inventory("char:" .. id, parseInt(rows2[1].capacity), json.decode(rows2[1].items))
            end
            self.Character = API.Character(id, charRow[1].characterName, charRow[1].level, charRow[1].xp, json.decode(charRow[1].groups), Inventory)

            -- Enviar informaçoes da Hotbar
            if rows2[1] ~= nil then
                local parsedSlots = {}
                local decodedItems = json.decode(rows2[1].items)
                local found = false
                for i = 129, 132 do
                    local stringd = tostring(i)
                    if decodedItems[stringd] ~= nil then
                        found = true
                        parsedSlots[i] = {
                            decodedItems[stringd][1],
                            decodedItems[stringd][2]
                        }
                    end
                end
                if found == true then
                    TriggerClientEvent("FCRP:INVENTORY:PrimarySyncSlots", self:getSource(), parsedSlots)
                end
            end

            -- local weapons = json.decode(charRow[1].weapons) or {}
            -- cAPI.replaceWeapons(self:getSource(), weapons)

            -- Vai retornar o cavalo atual do Character, caso não tenha, vai buscar pelo bancao de dados e carregar ele

            local Horse, horseComponents = self:getCharacter():getHorse()

            if Horse ~= nil then
                cAPI.setHorse(self:getSource(), Horse:getModel(), Horse:getName(), horseComponents)
            else
                cAPI.setHorse(self:getSource(), "A_C_Horse_MP_Mangy_Backup", "Pangaré", {0x106961A8, 0x508B80B9})
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
        self.Character:savePosition(self:getSource())
    end

    self.drawCharacter = function()
        if cAPI.setModel(self:getSource(), json.decode(self.Character:getModel())) then
            Wait(200)
            if cAPI.startNeeds(self:getSource()) then
                Wait(100)
                if cAPI.setDados(self:getSource(), self.Character:getCharTable()) then
                    Wait(100)
                    cAPI.setClothes(self:getSource(), self.Character:getClothes())
                    Wait(100)
                    -- local lastPosition = self.Character:getLastPosition()
                    local lastPosition = json.encode({x = 33.080871582031, y = 32.801963806152, z = 101.56585693359})
                    cAPI.teleportSpawn(self:getSource(), lastPosition)
                    Wait(100)
                    cAPI.CWanted(Character:getWanted())

                -- print('aa')

                -- local source = self:getSource()
                -- local Character = self:getCharacter()

                -- print('d')
                -- local character_model = Character:getModel()
                -- print("a")
                -- -- local character_skin = Character:getSkin()
                -- local character_skin = {}
                -- print('b')
                -- local character_clothing = Character:getClothes()
                -- print('c')
                -- -- local character_lastposition = json.decode(Character:getData("charTable", "position")) or {0, 0, 0}
                -- local character_lastposition = json.encode({0, 0, 0})

                -- print(character_model, character_skin, character_clothing, character_lastposition)

                -- cAPI.Initialize(source, character_model, character_skin, character_clothing, character_lastposition)
                end
            end
        end
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

    self.setHorse = function(this, id)
        local Horse = self:getCharacter():setHorse(id)
        cAPI.setHorse(self:getSource(), Horse:getModel(), Horse:getName(), Horse:getComponents())
    end

    self.notify = function(this, v)
        cAPI.notify(self:getSource(), v)
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
