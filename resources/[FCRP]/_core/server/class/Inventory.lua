function API.Inventory(id, capacity, slots)
    local self = {}

    self.id = id
    self.capacity = capacity or 20
    self.viewersSources = {}
    self.save = true
    self.slots = {}

    if slots ~= nil then
        for slotId, values in pairs(slots) do
            -- if type(values) == "table" then
            local tableSize = table.getn(values)

            slotId = tonumber(slot)
            local itemId = values[1]
            local itemAmount = tonumber(values[2])
            local ammoInClip = tonumber(values[3])
            local ammoInWeapon = tonumber(values[4])

            self.slots[slotId] = API.Slot(slotId, itemId, itemAmount, ammoInClip, ammoInWeapon)
            -- else
            --     recents[slot] = values
            -- end
        end

    -- for k, v in pairs(recents) do
    --     self.slots[k] = self.slots[v]
    -- end
    end

    self.getId = function()
        return self.id
    end

    self.getWeight = function()
        local weight = 0
        for id, amount in pairs(self.slots) do
            local ItemData = API.getItemDataFromId(id)
            if ItemData ~= nil then
                local weight = weight + (ItemData:getWeight() * amount)
            end
        end

        return weight
    end

    self.setCapacity = function(this, v)
        self.capacity = v
    end

    self.getCapacity = function()
        return self.capacity
    end

    self.getCharId = function()
        -- Owner of the inventory
        if string.find(self:getId(), "char:") then
            local charid = string.sub(self:getId(), string.find(self:getId(), "char:") + 5)
            return tonumber(charid) or 0
        end
        return 0
    end

    self.getSlots = function()
        return self.slots
    end

    self.moveSlot = function(this, slotId, slotIdTo, amount)
        amount = math.floor(math.abs(amount))

        local Slot = self.slots[slotId]

        if Slot == nil then
            return false
        end

        if Slot:getItemAmount() < amount or Slot:getItemAmount() <= 0 then
            return false
        end

        local first, last = getFirstLastSlots(Slot:getItemId())


        -- Slot youre trying to move the item
        -- does not support the item

        local itemType = Slot:getItemData():getType()

        if itemType ~= "weapon" and itemType ~= "ammo" then
            if (slotIdTo >= 129 and slotIdTo <= 132) or (slotIdTo < first or slotIdTo > last) then
                return false
            end
        end

        if itemType == "weapon" or itemType == "ammo" then
            if (slotIdTo < 129 or slotIdTo > 132) and (slotIdTo < first or slotIdTo > last) then
                return false
            end
        end

        local sync = {}

        local SlotTo = self.slots[slotIdTo]

        if SlotTo == nil then

            if (slotIdTo >= 129 and slotIdTo <= 132) and itemType ~= 'weapon' then
                return false
            end

            Slot:removeItemAmount(amount)

            self:setSlot(slotIdTo, Slot:getItemId(), amount)
            local newSlot = self.slots[slotIdTo]
            newSlot:setAmmoInClip(Slot:getAmmoInClip())
            newSlot:setAmmoInWeapon(Slot:getAmmoInWeapon())

            sync[slotId] = Slot:getSyncData()
            sync[slotIdTo] = newSlot:getSyncData()

            if Slot:getItemAmount() <= 0 then
                self.slots[slotId] = nil
            end
        else
            if Slot:getItemId() == SlotTo:getItemId() then
                local data = Slot:getItemData()

                local itemStackSize = data:getStackSize()

                if SlotTo:getItemAmount() < itemStackSize and (SlotTo:getItemAmount() + amount) <= itemStackSize then
                    Slot:removeItemAmount(amount)
                    SlotTo:addItemAmount(amount)

                    sync[slotId] = Slot:getSyncData()
                    sync[slotIdTo] = SlotTo:getSyncData()

                    if Slot:getItemAmount() <= 0 then
                        self.slots[slotId] = nil
                    end
                end
            else
                local itemTypeTo = SlotTo:getItemData():getType()

                if itemType == "ammo" and itemTypeTo == "weapon" then
                    -- if getAmmoTypeFromWeaponType("weapon_" .. SlotTo:getItemId()) == Slot:getItemId() then
                    if Slot:getItemId():gsub("ammo", "weapon") == SlotTo:getItemId() then
                        Slot:removeItemAmount(amount)
                        SlotTo:setAmmoInWeapon(SlotTo:getAmmoInWeapon() + (amount + 1))

                        if Slot:getItemAmount() <= 0 then
                            self.slots[slotId] = nil
                        end

                        sync[slotId] = Slot:getSyncData()
                        sync[slotIdTo] = SlotTo:getSyncData()
                    end
                else
                    local copySlot = deepcopy(SlotTo)

                    self.slots[slotIdTo] = Slot

                    self.slots[slotId] = copySlot

                    sync[slotId] = copySlot:getSyncData()
                    sync[slotIdTo] = Slot:getSyncData()
                end
            end
        end

        syncToViewers(self.viewersSources, sync)
    end

    self.setSlot = function(this, slotId, itemId, itemAmount)
        -- Check if a item exists at this slot

        itemAmount = math.floor(math.abs(itemAmount))

        if self.slots[slotId] ~= nil then
            self.slots[slotId]:setItemAmount(0) -- Will delete itself from the slot list
        end

        local Slot = API.Slot(slotId, itemId, itemAmount, nil, nil)
        self.slots[slotId] = Slot
        return Slot
    end

    self.addItem = function(this, itemId, itemAmount)
        itemAmount = math.floor(math.abs(itemAmount))

        local itemData = API.getItemDataFromId(itemId)

        if itemData == nil then
            return
        end

        local itemStackSize = itemData:getStackSize()

        local candidatesSlots = {}
        local amountLeftToAdd = itemAmount

        local equalSlots = getSlotsWithEqualItemId(self.slots, itemId)
        for _, slotId in pairs(equalSlots) do
            local Slot = self.slots[slotId]
            if Slot:getItemAmount() < itemStackSize then
                local a = itemStackSize - Slot:getItemAmount()

                if a > amountLeftToAdd then
                    a = amountLeftToAdd
                end

                candidatesSlots[slotId] = a
                amountLeftToAdd = amountLeftToAdd - a

                if amountLeftToAdd <= 0 then
                    break
                end
            end
        end

        local freeSlots = getFreeSlots(self.slots, itemId)
        if amountLeftToAdd > 0 then
            local amountCanFitFreeSlots = #freeSlots * itemStackSize

            if amountCanFitFreeSlots >= amountLeftToAdd then
                for _, slotId in pairs(freeSlots) do
                    local a
                    if amountLeftToAdd >= itemStackSize then
                        a = itemStackSize
                    else
                        a = amountLeftToAdd
                    end

                    candidatesSlots[slotId] = a
                    amountLeftToAdd = amountLeftToAdd - a

                    if amountLeftToAdd <= 0 then
                        break
                    end
                end
            end
        end

        local sync = {}

        if amountLeftToAdd <= 0 then
            for slotId, amount in pairs(candidatesSlots) do
                local Slot 
                if self.slots[slotId] == nil then
                    Slot = self:setSlot(slotId, itemId, amount)
                else
                    Slot = self.slots[slotId]
                    if Slot:getItemId() == itemId then
                        Slot:addItemAmount(amount)
                    end
                end

                sync[slotId] = Slot:getSyncData()
            end
        end

        -- Will sync twice
        self:addRecent(itemId, itemAmount)

        syncToViewers(self.viewersSources, sync)
    end

    self.removeItem = function(this, itemId, itemAmount)
        itemAmount = math.floor(math.abs(itemAmount))

        local itemData = API.getItemDataFromId(itemId)

        if itemData == nil then
            return
        end

        local equalSlots = getSlotsWithEqualItemId(self.slots, itemId)

        local sync = {}

        local amountLeftToRemove = itemAmount
        for _, slotId in pairs(equalSlots) do
            local Slot = self.slots[slotId]
            if itemId then
                local a = itemAmount
                if Slot:getItemAmount() >= itemAmount then
                    a = itemAmount
                else
                    a = Slot:getItemAmount()
                end

                Slot:removeItemAmount(a)

                sync[slotId] = Slot:getSyncData()

                if Slot:getItemAmount() <= 0 then
                    self.slots[slotId] = nil
                end

                amountLeftToRemove = amountLeftToRemove - a

                -- Or 0 because the slot might destroy itself when reaching 0

                if amountLeftToRemove <= 0 then
                    break
                end
            end
        end

        return syncToViewers(self.viewersSources, sync)
    end

    self.getItemAmount = function(this, itemId)
        local amount = 0

        for _, slotId in pairs(getSlotsWithEqualItemId(self.slots, itemId)) do
            local _amount = self.slots[slotId]:getItemAmount()
            amount = amount + _amount
        end

        return amount
    end

    self.saveWeaponSlotIntoDb = function(this, slot, ammoInClip, ammoInWeapon)
        if slot < 129 or slot > 132 then
            -- API.log("LUA INJECTION? Tentativa de duplicar item: " .. self:getId())
            return
        end

        local Slot = self.slots[slot]

        if Slot == nil then
            return
        end

        local itemData = Slot:getItemData()

        if itemData:getType() ~= "weapon" then
            -- API.log("LUA INJECTION? Tentativa de duplicar item: " .. self:getId())
            return
        end

        Slot:setAmmoInClip(ammoInClip)
        Slot:setAmmoInWeapon(ammoInWeapon)

        -- Citizen.CreateThread(
        --     function()
        --         dbAPI.execute("FCRP/Inventory", {id = self:getId(), charid = self:getCharId(), capacity = 0, slot = slot, itemId = Slot:getItemId(), itemAmount = ammoCount, procType = "update"})
        --     end
        -- )
    end

    self.addRecent = function(this, itemId, itemAmount)
        -- local sync = {}
        -- for slotId = 16, 1, -1 do
        --     if slotId == 16 then
        --         self.slots[slotId] = nil
        --     else
        --         local Slot = self.slots[slotId]
        --         if Slot ~= nil then
        --             self.slots[slotId + 1] = Slot
        --             sync[slotId + 1] = Slot:getSyncData()
        --         end
        --     end
        -- end
        -- local Slot = self:setSlot(1, itemId, itemAmount)
        -- sync[1] = Slot:getSyncData()
        -- syncToViewers(self.viewersSources, sync)
    end

    self.viewAsPrimary = function(this, viewerSource)
        self.viewersSources[viewerSource] = true

        local _slots = {}

        for slotId, Slot in pairs(self.slots) do
            _slots[slotId] = Slot:getSyncData()
        end

        TriggerClientEvent("FCRP:INVENTORY:openAsPrimary", viewerSource, _slots)
    end

    self.viewAsSecondary = function(this, viewerSource)
        self.viewersSources[viewerSource] = false

        local _slots = {}

        for slotId, Slot in pairs(self.slots) do
            _slots[slotId] = Slot:getSyncData()
        end

        TriggerClientEvent("FCRP:INVENTORY:openAsSecondary", viewerSource, _slots)
    end

    self.removeViewer = function(this, User)
        if self.viewersSources[User:getSource()] ~= nil then
            if self.viewersSources[User:getSource()] == true then -- If viewing as primary
                User.primaryViewingInventory = nil
            else
                User.secondaryViewingInventory = nil
            end
        end

        self.viewersSources[User:getSource()] = nil
    end

    self.clear = function(self)
        self.slots = {}

        if self.save == true then
            dbAPI.execute("FCRP/Inventory", {id = self:getId(), charid = self:getCharId(), itemName = 0, itemCount = 0, typeInv = "deadPlayer"})
        end
    end

    self.saveable = function(this, bool)
        self.save = bool
    end

    return self
end

function syncToViewers(viewers, slotsToSync)
    for viewerSource, asPrimary in pairs(viewers) do
        -- local User = API.getUserFromSource(viewerSource)

        if asPrimary then
            -- User:notify("Inventário Principal: + x" .. amount .. " " .. ItemData:getName())
            TriggerClientEvent("FCRP:INVENTORY:PrimarySyncSlots", viewerSource, slotsToSync)
        else
            -- User:notify("Inventário Secundário: + x" .. amount .. " " .. ItemData:getName())
            TriggerClientEvent("FCRP:INVENTORY:SecondarySyncSlots", viewerSource, slotsToSync)
        end
    end
end

function getFreeSlots(slots, itemId)
    local freeSlots = {}

    local first, last = getFirstLastSlots(itemId)

    for slotId = first, last do
        if slots[slotId] == nil then
            table.insert(freeSlots, slotId)
        end
    end

    return freeSlots
end

function getSlotsWithEqualItemId(slots, itemId)
    local equalSlots = {}

    local first, last = getFirstLastSlots(itemId)

    for slotId = first, last do
        if slots[slotId] ~= nil and slots[slotId]:getItemId() == itemId then
            table.insert(equalSlots, slotId)
        end
    end

    return equalSlots
end

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == "table" then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end

    return copy
end

local a = {
    -- ['Recents']  = {}
    ["Food"] = {17, 32},
    ["Tonics"] = {33, 48},
    ["Ingredients"] = {49, 64},
    ["Tools_Weapons"] = {65, 80},
    ["Kit"] = {81, 96},
    ["Valuables"] = {97, 112},
    ["Documents"] = {113, 128},
    ["Hotbar"] = {129, 132}
}

local b = {
    -- ['Recents']  = {}
    ["Food"] = {"edible", "beverage"},
    ["Tonics"] = {"tonic", "boost"},
    ["Ingredients"] = {"generic"},
    ["Tools_Weapons"] = {"weapon", "ammo"},
    ["Kit"] = {"kit"},
    ["Valuables"] = {"valuable"},
    ["Documents"] = {"document"}
    -- ['Hotbar'] = {'weapon', 'ammo'},
}

function getFirstLastSlots(itemId)
    local itemData = API.getItemDataFromId(itemId)
    local itemType = itemData:getType()
    local itemTabType

    for tabType, v in pairs(b) do
        for _, type in pairs(v) do
            if itemType == type then
                itemTabType = tabType
                break
            end
        end
    end

    return table.unpack(a[itemTabType])
end
