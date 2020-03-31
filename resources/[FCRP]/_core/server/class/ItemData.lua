function API.ItemData(id, name, weight, description)
    local self = {}

    self.id = id
    self.name = name
    self.weight = weight
    self.description = description
    -- self.worldModel = 'default_prop'

    self.getId = function()
        return self.id
    end

    self.getName = function(this)
        return self.name or ''
    end

    self.getWeight = function()
        return self.weight or 0.0
    end

    self.getDescription = function()
        return self.description or ''
    end

    self.onUse = function(this, v)
        self.use = v
    end

    self.use = function(this, User)
        return false
    end

    return self
end