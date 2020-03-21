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

    self.setData = function(this, cid, targetName, key, value)
        print(targetName, key, value, cid)
        API_Database.query('FCRP/SetCData', {target = targetName, key = key, value = value, charid = cid})
    end    

    self.getData = function(this, cid, targetName, key)
        if key == nil then
            key = 'all'
        end
        local rows = API_Database.query('FCRP/GetCData', {target = targetName, charid = cid, key = key})
        if #rows > 0 then
            return rows[1].Value
        else
            return ''
        end
    end

    self.remData = function(this, cid, targetName, key)
        local rows = API_Database.query('FCRP/RemCData', {target = targetName, key = key, charid = cid})
        if #rows > 0 then
            return true
        end
        return false
    end

    return self
end