function API.Inventory(id, capacity, slots)
    local self = {}

    self.id = id
    self.capacity = capacity or 20
    self.viewersSources = {}
    self.save = true
    self.slots = {}

    if slots ~= nil then
        for slot, values in pairs(slots) do
            -- if type(values) == "table" then
            self.slots[tonumber(slot)] = API.Slot(self, tonumber(slot), values[1], tonumber(values[2]))
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

    -- self.moveSlot = function(this, slotId, slotIdTo, amount)
    --     local Slot = self:getSlots()[slotId]

    --     if Slot == nil then
    --         return false
    --     end

    --     if Slot:getItemAmount() < amount then
    --         return false
    --     end

    --     local first, last = getFirstLastSlots(Slot:getItemId())

    --     -- Slot youre trying to move the item
    --     -- does not support the item

    --     local itemType = Slot:getData():getType()

    --     if ItemType ~= "weapon" and ItemType ~= "ammo" then
    --         if (slotIdTo < first or slotIdTo > last) then
    --             return false
    --         end
    --     else
    --         if (slotIdTo < 129 or slotId > 132) then
    --             return false
    --         end
    --     end

    --     local SlotTo = self:getSlots()[slotIdTo]

    --     if SlotTo == nil then
    --         Slot:removeItemAmount(amount)
    --         local newSlot = self:setSlot(slotIdTo, Slot:getItemId(), amount)

    --         sync[slot] = Slot
    --         sync[slotIdTo] = newSlot
    --     else
    --         if Slot:getItemId() == SlotTo:getItemId() then
    --             local data = Slot:getData()

    --             local itemStackSize = data:getStackSize()

    --             if SlotTo:getItemAmount() < itemStackSize and (SlotTo:getItemAmount() + amount) <= itemStackSize then
    --                 Slot:removeItemAmount(amount)
    --                 SlotTo:addItemAmount(amount)

    --                 sync[slotId] = Slot
    --                 sync[slotId] = SlotTo
    --             end
    --         else
    --             local itemTypeTo = SlotTo:getData():getType()

    --             if itemType == "ammo" and itemTypeTo == "weapon" then
    --                 if getAmmoTypeFromWeaponType("weapon_" .. SlotTo:getItemId()) == Slot:getItemId() then
    --                     Slot:removeItemAmount(amount)
    --                     sync[slotId] = Slot
    --                 end
    --             else
    --                 local copySlot = deepcopy(SlotTo)

    --                 Slot:setSlotId(slotIdTo)
    --                 self:getSlots()[slotIdTo] = Slot

    --                 sync[slotId] = Slot

    --                 copySlot:setSlot(slotId)
    --                 self:getSlots()[slotId] = copySlot

    --                 sync[slotId] = copySlot
    --             end
    --         end
    --     end

    --     return syncToViewers(self.viewersSources, self:getSlots(), sync)
    -- end

    self.setSlot = function(this, slotId, itemId, itemAmount)
        -- Check if a item exists at this slot
        if self:getSlots()[slotId] ~= nil then
            self:getSlots()[slotId]:setItemAmount(0) -- Will delete itself from the slot list
        end

        local Slot = API.Slot(self, slotId, itemId, itemAmount)
        self:getSlots()[slotId] = Slot
        return Slot
    end

    self.addItem = function(this, itemId, itemAmount)
        -- print(itemId, itemAmount)
        -- local itemData = API.getItemDataFromId(itemId)

        -- if itemData == nil then
        --     print("itemdata is nil")
        --     return
        -- end

        -- print("bblee")
        -- local itemStackSize = itemData:getStackSize()

        -- local candidatesSlots = {}
        -- local amountLeftToAdd = itemAmount

        -- print("getting wqual slot")

        -- local equalSlots = getSlotsWithEqualItemId(self:getSlots(), itemId)
        -- for _, slotId in pairs(equalSlots) do
        --     local Slot = self:getSlots()[slotId]
        --     if Slot:getItemAmount() < itemStackSize then
        --         local a = itemStackSize - Slot:getItemAmount()

        --         if a > amountLeftToAdd then
        --             a = amountLeftToAdd
        --         end

        --         candidatesSlots[slotId] = a
        --         amountLeftToAdd = amountLeftToAdd - a

        --         if amountLeftToAdd <= 0 then
        --             break
        --         end
        --     end
        -- end

        -- print("getting freslots")

        -- local freeSlots = getFreeSlots(self:getSlots(), itemId)
        -- if amountLeftToAdd > 0 then
        --     local amountCanFitFreeSlots = #freeSlots * itemStackSize

        --     if amountCanFitFreeSlots > amountLeftToAdd then
        --         for _, slotId in pairs(freeSlots) do
        --             local a
        --             if amountLeftToAdd >= itemStackSize then
        --                 a = itemStackSize
        --             else
        --                 a = amountLeftToAdd
        --             end

        --             candidatesSlots[slotId] = a
        --             amountLeftToAdd = amountLeftToAdd - a

        --             if amountLeftToAdd <= 0 then
        --                 break
        --             end
        --         end
        --     end
        -- end

        -- print("about to sync")

        -- local sync = {}

        -- if amountLeftToAdd <= 0 then
        --     for slotId, amount in pairs(candidatesSlots) do
        --         self:setSlot(slotId, itemId, amount)

        --         table.insert(sync, slotId)
        --     end
        -- end

        -- print("syenc")

        self:getSlots()[17] = API.Slot(self, 17, itemId, itemAmount)

        return syncToViewers(self.viewersSources, self:getSlots(), {17})
    end

    -- self.removeItem = function(this, itemId, itemAmount)
    --     local itemData = API.getItemDataFromId(itemId)

    --     if itemData == nil then
    --         return
    --     end

    --     local equalSlots = getSlotsWithEqualItemId(self:getSlots(), itemId)

    --     local sync = {}

    --     local amountLeftToRemove = itemAmount
    --     for _, slotId in pairs(equalSlots) do
    --         local Slot = self:getSlots()[slotId]
    --         if itemId then
    --             local a = itemAmount
    --             if Slot:getItemAmount() >= itemAmount then
    --                 a = itemAmount
    --             else
    --                 a = Slot:getItemAmount()
    --             end

    --             Slot:removeItemAmount(a)
    --             amountLeftToRemove = amountLeftToRemove - a

    --             -- Or 0 because the slot might destroy itself when reaching 0
    --             table.insert(sync, slotId)

    --             if amountLeftToRemove <= 0 then
    --                 break
    --             end
    --         end
    --     end

    --     return syncToViewers(self.viewersSources, self:getSlots(), sync)
    -- end

    self.getItemAmount = function(this, itemId)
        local amount = 0

        for _, slotId in pairs(getSlotsWithEqualItemId(self:getSlots(), itemId)) do
            local _amount = self:getSlots()[slotId]:getItemAmount()
            amount = amount + _amount
        end

        return amount
    end

    -- self.saveWeaponSlotIntoDb = function(this, slot, ammoCount)
    --     if slot < 129 or slot > 132 then
    --         API.log("LUA INJECTION? Tentativa de duplicar item: " .. self:getId())
    --         return
    --     end

    --     local ItemSlot = self.slots[slot]

    --     if ItemSlot == nil then
    --         print("self.saveWeaponSlotIntoDb", "is nil")
    --         return
    --     end

    --     local ItemData = API.getItemDataFromId(ItemSlot:getItemId())

    --     if ItemData:getType() ~= "weapon" then
    --         API.log("LUA INJECTION? Tentativa de duplicar item: " .. self:getId())
    --         return
    --     end

    --     ItemSlot:setItemAmount(ammoCount)

    --     print("self.saveWeaponSlotIntoDb", slot, ammoCount)

    --     Citizen.CreateThread(
    --         function()
    --             API_Database.execute("FCRP/Inventory", {id = self:getId(), charid = self:getCharId(), capacity = 0, slot = slot, itemId = ItemSlot:getItemId(), itemAmount = ammoCount, procType = "update"})
    --         end
    --     )
    -- end

    self.viewAsPrimary = function(this, viewerSource)
        print('viewAsPrimary')
        self.viewersSources[viewerSource] = true

        print("about to view as primary")

        local _slots = {}

        for slotId, Slot in pairs(self:getSlots()) do
            _slots[slotId] = {
                Slot:getItemId(),
                Slot:getItemAmount()
            }
        end

        print("slots parsed")

        TriggerClientEvent("FCRP:INVENTORY:openAsPrimary", viewerSource, _slots)

        print("event sent")
    end

    self.viewAsSecondary = function(this, viewerSource)
        self.viewersSources[viewerSource] = false

        local _slots = {}

        for slotId, Slot in pairs(self:getSlots()) do
            _slots[slotId] = {
                Slot:getItemId(),
                Slot:getItemAmount()
            }
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

    self.saveable = function(self, bool)
        self.save = bool
    end

    return self
end

function syncToViewers(viewers, slots, slotsToSync)
    print("about do sync2", #slotsToSync)

    local _slots = {}

    local moreThanOneToSync = false
    for _, slotId in pairs(slotsToSync) do
        print("reading slot " .. slotId, Slot)
        moreThanOneToSync = true
        local Slot = slots[slotId]
        _slots[slotId] = {
            Slot:getItemId(),
            Slot:getItemAmount()
        }
    end

    print("to vwer", moreThanOneToSync)

    if moreThanOneToSync then
        for viewerSource, asPrimary in pairs(viewers) do
            print("sendting to viwer " .. viewerSource, asPrimary)
            -- local User = API.getUserFromSource(viewerSource)

            if asPrimary then
                -- User:notify("Inventário Principal: + x" .. amount .. " " .. ItemData:getName())
                TriggerClientEvent("FCRP:INVENTORY:PrimarySyncSlots", viewerSource, _slots)
            else
                -- User:notify("Inventário Secundário: + x" .. amount .. " " .. ItemData:getName())
                TriggerClientEvent("FCRP:INVENTORY:SecondarySyncSlots", viewerSource, _slots)
            end
        end
    end

    return true
end

-- function getFreeSlots(slots, itemId)
--     local freeSlots = {}

--     local first, last = getFirstLastSlots(itemId)

--     for slotId = first, last do
--         if slots[slotId] == nil then
--             table.insert(freeSlots, slotId)
--         end
--     end

--     return freeSlots
-- end

-- function getSlotsWithEqualItemId(slots, itemId)
--     local equalSlots = {}

--     local first, last = getFirstLastSlots(itemId)

--     for slotId = first, last do
--         if slots[slotId] ~= nil and slots[slotId]:getItemId() == itemId then
--             table.insert(equalSlots, slotId)
--         end
--     end

--     return equalSlots
-- end

-- function deepcopy(orig)
--     local orig_type = type(orig)
--     local copy
--     if orig_type == "table" then
--         copy = {}
--         for orig_key, orig_value in next, orig, nil do
--             copy[deepcopy(orig_key)] = deepcopy(orig_value)
--         end
--         setmetatable(copy, deepcopy(getmetatable(orig)))
--     else -- number, string, boolean, etc
--         copy = orig
--     end
--     return copy
-- end

-- local a = {
--     -- ['Recents']  = {}
--     ["Food"] = {17, 32},
--     ["Tonics"] = {33, 48},
--     ["Ingredients"] = {49, 64},
--     ["Tools_Weapons"] = {65, 80},
--     ["Kit"] = {81, 96},
--     ["Valuables"] = {97, 112},
--     ["Documents"] = {113, 128},
--     ["Hotbar"] = {129, 132}
-- }

-- local b = {
--     -- ['Recents']  = {}
--     ["Food"] = {"edible", "beverage"},
--     ["Tonics"] = {"tonic", "boost"},
--     ["Ingredients"] = {"generic"},
--     ["Tools_Weapons"] = {"weapon", "ammo"},
--     ["Kit"] = {"kit"},
--     ["Valuables"] = {"valuable"},
--     ["Documents"] = {"document"}
--     -- ['Hotbar'] = {'weapon', 'ammo'},
-- }

-- function getFirstLastSlots(itemId)
--     local itemData = API.getItemDataFromId(itemId)
--     local itemType = itemData:getType()
--     local itemTabType

--     for tabType, v in pairs(b) do
--         for _, type in pairs(v) do
--             if itemType == type then
--                 itemTabType = tabType
--                 break
--             end
--         end
--     end

--     return table.unpack(a[itemTabType])
-- end
