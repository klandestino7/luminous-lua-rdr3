function API.Horse(id, model, name, Inventory)

    local self = {}

    self.id = id
    self.model = model
    self.name = name
    self.Inventory = Inventory or API.Inventory('horse:' .. self.id, nil, nil)

    self.getId = function()
        return self.id
    end

    self.getModel = function()
        return self.model
    end

    self.getName = function()
        return self.name
    end

    self.getInventory = function()
        return self.Inventory
    end
    
    self.getModif = function()       
        return self:getData(self.id, 'modificacao', nil)
    end

    self.setData = function(this, cid, targetName, key, value)
        API_Database.query('FCRP/SetHData', {target = targetName, key = key, value = value, id = cid})
    end

    self.getData = function(this, cid, targetName, key)
        if key == nil then
            key = 'all'
        end

        local rows = API_Database.query('FCRP/GetHData', {target = targetName, id = cid, key = key})

        print(cid, targetName, key)
        print(#rows)
        if #rows > 0 then
            return rows[1].Value
        else
            return ''
        end
    end

    -- self.setModif = function(this, id, value)
    --     API_Database.execute('FCRP/SetModifHorse', {modif = value, id = id})
    --     print(id, value)
    -- end    

    -- self.getModif = function(this, id, value)
    --     if key == nil then
    --         key = 'all'
    --     end
    --     local rows = API_Database.query('FCRP/GetModifHorse', {modif = value, id = id})
    --     if #rows > 0 then
    --         return rows
    --     else
    --         return '{}'
    --     end
    -- end

    self.remData = function(this, cid, targetName, key)
        local rows = API_Database.query('FCRP/RemCData', {target = targetName, key = key, charid = cid})
        if #rows > 0 then
            return true
        end
        return false
    end

    return self
end