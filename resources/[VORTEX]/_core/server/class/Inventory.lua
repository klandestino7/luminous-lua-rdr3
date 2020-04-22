function API.Inventory(id, capacity, slots)
    local self = {}

    self.id = id
    self.capacity = capacity or 20
    self.viewersSources = {}

    self.slots = {}

    if slots ~= nil then
        for slotId, values in pairs(slots) do
            local tableSize = table.getn(values)

            slotId = tonumber(slot)
            local itemId = values[1]
            local itemAmount = tonumber(values[2])
            local ammoInClip = tonumber(values[3])
            local ammoInWeapon = tonumber(values[4])

            self.slots[slotId] = API.Slot(slotId, itemId, itemAmount, ammoInClip, ammoInWeapon)
        end
    end

    self.getId = function()
        return self.id
    end

    self.getItems = function()
        return self.items
    end

    self.getWeight = function()
        local weight = 0
        for slotId, Slot in pairs(self.slots) do
            if slotId < 129 or slotId > 132 then
                local itemData = Slot:getItemData()
                weight = weight + (itemData:getWeight() * Slot:getItemAmount())
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

    self.getItemAmount = function(this, itemId)
        local amount = 0

        for _, slotId in pairs(getSlotsWithEqualItemId(self.slots, itemId)) do
            local _amount = self.slots[slotId]:getItemAmount()
            amount = amount + _amount
        end

        return amount
    end

    self.hasItem = function(this, item_id)
        return self:getItemAmount(item_id) > 0
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
            if (slotIdTo >= 129 and slotIdTo <= 132) then --or (slotIdTo < first or slotIdTo > last) then
                return false
            end
        end

        -- if itemType == "weapon" or itemType == "ammo" then
        --     if (slotIdTo < 129 or slotIdTo > 132) then --and (slotIdTo < first or slotIdTo > last) then
        --         if self:addItem(Slot:getItemId(), amount) then
        --             Slot:removeItemAmount(amount)
        --             sync[slotId] = Slot:getSyncData()
        --         else
        --             return false
        --         end
        --     end
        -- end

        local sync = {}

        local SlotTo = self.slots[slotIdTo]

        if SlotTo == nil then
            if (slotIdTo >= 129 and slotIdTo <= 132) then
                if itemType == "weapon" then
                    if not canFitHotbarSlot(slotIdTo, Slot:getItemId()) then
                        return false
                    end
                end
            else
                if slotIdTo < first or slotIdTo > last then
                    slotIdTo = getFreeSlots(self:getSlots(), Slot:getItemId())[1]
                end
            end

            if slotIdTo ~= nil then
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
            end
        else
            if Slot:getItemId() == SlotTo:getItemId() then
                local data = Slot:getItemData()

                local itemStackSize = data:getStackSize()

                if itemStackSize == -1 or (SlotTo:getItemAmount() + amount) <= itemStackSize then
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
                    if getAmmoTypeFromWeaponType("weapon_" .. SlotTo:getItemId()) == Slot:getItemId() then
                        Slot:removeItemAmount(amount)
                        SlotTo:setAmmoInWeapon(SlotTo:getAmmoInWeapon() + amount)

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

        syncToViewers(self.viewersSources, sync, self:getWeight())
    end

    self.setSlot = function(this, slotId, itemId, itemAmount, sync)
        -- Check if a item exists at this slot

        itemAmount = math.floor(math.abs(itemAmount))

        if self.slots[slotId] ~= nil then
            self.slots[slotId]:setItemAmount(0) -- Will delete itself from the slot list
        end

        local Slot = API.Slot(slotId, itemId, itemAmount, nil, nil)
        self.slots[slotId] = Slot

        if sync then
            syncToViewers(self.viewersSources, {[slotId] = Slot:getSyncData()}, self:getWeight())
        end

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
            if itemStackSize ~= -1 then
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
            else
                candidatesSlots[slotId] = amountLeftToAdd
                amountLeftToAdd = 0
                break
            end
        end

        local freeSlots = getFreeSlots(self.slots, itemId)
        if amountLeftToAdd > 0 then
            if itemStackSize ~= -1 then
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
            else
                if freeSlots[1] ~= nil then
                    candidatesSlots[freeSlots[1]] = amountLeftToAdd
                    amountLeftToAdd = 0
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

        syncToViewers(self.viewersSources, sync, self:getWeight())

        if amountLeftToAdd <= 0 then
            return true
        else
            return false
        end
    end

    self.removeItem = function(this, slotId, itemId, itemAmount)
        itemAmount = math.floor(math.abs(itemAmount))

        local itemData = API.getItemDataFromId(itemId)

        if itemData == nil then
            return
        end

        local sync = {}

        if slotId == nil or slotId == -1 then
            local equalSlots = getSlotsWithEqualItemId(self.slots, itemId)
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
        else
            local Slot = self.slots[slotId]

            if Slot == nil then
                return false
            end

            if Slot:getItemAmount() < itemAmount then
                return false
            end

            Slot:removeItemAmount(itemAmount)

            sync[slotId] = Slot:getSyncData()

            if Slot:getItemAmount() <= 0 then
                self.slots[slotId] = nil
            end
        end

        return syncToViewers(self.viewersSources, sync, self:getWeight())
    end

    self.getItemAmount = function(this, itemId)
        local amount = 0

        for _, slotId in pairs(getSlotsWithEqualItemId(self.slots, itemId)) do
            local _amount = self.slots[slotId]:getItemAmount()
            amount = amount + _amount
        end

        return amount
    end

    self.saveWeaponSlotIntoDb = function(this, _source, slotId, ammoInClip, ammoInWeapon)
        if slotId < 129 or slotId > 132 then
            -- API.log("LUA INJECTION? Tentativa de duplicar item: " .. self:getId())
            return
        end

        local Slot = self.slots[slotId]

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

        if (itemData:isThrowable() or itemData:isMelee()) and ammoInWeapon <= 0 then
            Slot:setItemAmount(0)
        end

        local sync = {
            [slotId] = Slot:getSyncData()
        }

        if Slot:getItemAmount() <= 0 then
            self.slots[slotId] = nil
        end

        syncToViewers({[_source] = true}, sync, self:getWeight())

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
        --   syncToViewers(self.viewersSources, sync, self:getWeight())
    end

    self.viewAsPrimary = function(this, viewerSource)
        self.viewersSources[viewerSource] = true

        local _slots = {}

        for slotId, Slot in pairs(self.slots) do
            _slots[slotId] = Slot:getSyncData()
        end

        TriggerClientEvent("VP:INVENTORY:openAsPrimary", viewerSource, _slots, self:getWeight(), self:getCapacity())
    end

    self.viewAsSecondary = function(this, viewerSource)
        self.viewersSources[viewerSource] = false

        local _slots = {}

        for slotId, Slot in pairs(self.slots) do
            _slots[slotId] = Slot:getSyncData()
        end

        TriggerClientEvent("VP:INVENTORY:openAsSecondary", viewerSource, _slots, self:getWeight(), self:getCapacity())
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

    self.notify = function(this, v)
        for _, viewerSource in pairs(viewersSources) do
            local User = API.getUserFromSource(viewerSource)

            if User ~= nil then
                User:notify(v)
            end
        end
    end

    self.deleteInventory = function(self)
        API_Database.execute("FCRP/Inventory", {id = self:getId(), charid = self:getCharId(), capacity = 0, slot = 0, itemId = 0, itemAmount = 0, procType = "clear"})
        self.items = nil
    end

    return self
end

function getAmmoTypeFromWeaponType(weapon)
    weapon = weapon:upper()

    local ammo = nil

    if weapon == "WEAPON_MOONSHINEJUG" then
        ammo = "AMMO_MOONSHINEJUG"
    end

    if weapon == "WEAPON_FISHINGROD" then
        ammo = "AMMO_FISHINGROD"
    end

    if weapon == "WEAPON_THROWN_THROWING_KNIVES" then
        ammo = "AMMO_THROWING_KNIVES"
    end

    if weapon == "WEAPON_THROWN_TOMAHAWK" then
        ammo = "AMMO_TOMAHAWK"
    end

    if weapon == "WEAPON_THROWN_TOMAHAWK_ANCIENT" then
        ammo = "AMMO_TOMAHAWK_ANCIENT"
    end

    if weapon == "WEAPON_MOONSHINEJUG" then
        ammo = "AMMO_MOONSHINEJUG"
    end

    if weapon:find("_PISTOL_") then
        ammo = "AMMO_PISTOL"
    end

    if weapon:find("_REPEATER_") or weapon:find("WEAPON_RIFLE_VARMINT") then
        ammo = "AMMO_REPEATER"
    end

    if weapon:find("_REVOLVER_") then
        ammo = "AMMO_REVOLVER"
    end

    if weapon:find("_RIFLE_") then
        ammo = "AMMO_RIFLE"
    end

    if weapon:find("_SHOTGUN_") then
        ammo = "AMMO_SHOTGUN"
    end

    if weapon:find("WEAPON_BOW") then
        ammo = "AMMO_ARROW"
    end

    if weapon:find("WEAPON_THROWN_DYNAMITE") then
        ammo = "AMMO_DYNAMITE"
    end

    if weapon:find("WEAPON_THROWN_MOLOTOV") then
        ammo = "AMMO_MOLOTOV"
    end

    return ammo:lower()
end

function syncToViewers(viewers, slotsToSync, inventoryWeight)
    for viewerSource, asPrimary in pairs(viewers) do
        -- local User = API.getUserFromSource(viewerSource)

        if asPrimary then
            -- User:notify("Inventário Principal: + x" .. amount .. " " .. ItemData:getName())
            TriggerClientEvent("VP:INVENTORY:PrimarySyncSlots", viewerSource, slotsToSync, inventoryWeight)
        else
            -- User:notify("Inventário Secundário: + x" .. amount .. " " .. ItemData:getName())
            TriggerClientEvent("VP:INVENTORY:SecondarySyncSlots", viewerSource, slotsToSync, inventoryWeight)
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
    ["Ingredients"] = {"generic", "consumable", "planting"},
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

function canFitHotbarSlot(slotId, itemId)
    local itemData = API.getItemDataFromId(itemId)

    if slotId == 129 or slotId == 130 then
        if not itemData:isMelee(itemId) and not itemData:isThrowable(itemId) then
            return true
        else
            return false
        end
    end

    if slotId == 131 then
        return itemData:isMelee(itemId)
    end

    if slotId == 132 then
        return itemData:isThrowable(itemId)
    end
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
