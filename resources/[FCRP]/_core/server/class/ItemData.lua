function API.ItemData(id, type, name, stackSize, description)
    local self = {}

    self.id = id
    self.name = name
    self.type = type
    self.description = description 
    self.stackSize = stackSize
    -- self.worldModel = 'default_prop'

    self.getId = function()
        return self.id
    end

    self.getName = function(this)
        return self.name or 'nome'
    end

    self.getDescription = function()
        return self.description or 'descricao'
    end

    self.getStackSize = function()
        return self.stackSize or 16
    end

    self.getType = function()
        return self.type or 'weapon'
    end

    self.onUse = function(this, v)
        self.use = v
    end

    self.use = function(this, User)
        return false
    end

    return self
end