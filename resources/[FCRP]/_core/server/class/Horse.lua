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

    self.setComponents = function(this, components)
        self.components = components
    end

    self.getComponents = function(this)
        return self.components
    end

    return self
end