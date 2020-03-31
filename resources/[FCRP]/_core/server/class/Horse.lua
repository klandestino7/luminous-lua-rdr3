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
    
    -- self.getModif = function()       
    --     return self:getData(self.id, 'modificacao', nil)
    -- end

    self.setComponents = function(this, components)
        local encodedComponents = json.encode(components)
        API_Database.query('UpdateHorseComponents', {id = self:getId(), components = encodedComponents})
    end

    self.getComponents = function()
        local horseComponentsRows = API_Database.query('SelectHorseComponents', {id = self:getId()})
        
        

        return #horseComponentsRows > 0 and json.decode(horseComponentsRows[1].components) or {}
    end

    return self
end