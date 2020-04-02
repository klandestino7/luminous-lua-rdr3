function API.Inventory(id, capacity, items)
    local self = {}

    self.id = id
    self.capacity = capacity or 20
    self.items = items or {}
    self.viewersSources = {}

    self.slots = {}

    if items ~= nil then
        for slot, values in pairs(items) do
            self.slots[tonumber(slot)] = API.ItemSlot(tonumber(slot), values[1], tonumber(values[2]))
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
        for id, amount in pairs(self.items) do
            local ItemData = API.getItemDataFromId(id)
            if ItemData ~= nil then
                weight = weight + (ItemData:getWeight() * amount)
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

    self.getItemSlotAt = function(this, slotId)
        return self.slots[slotId]
    end

    self.getFirstItemSlotWithId = function(this, itemId)
        return self:getListItemSlotsWithId(itemId, 1)[1] or nil
    end

    self.getListItemSlotsWithId = function(this, itemId, listSize)
        local list = {}

        for _, ItemSlot in pairs(self.slots) do
            if ItemSlot:getItemId() == itemId then
                table.insert(list, ItemSlot)

                if listSize ~= nil then
                    if #list >= listSize then
                        break
                    end
                end
            end
        end

        return list
    end

    self.getFreeSlotOfType = function(this, slotType)
        local slotIndex = slotTypeToSlotIndex(slotType)

        return self:getFreeSlotOfTypeIndex(index)
    end

    self.getListFreeSlotsOfType = function(this, slotType)
        local slotIndex = slotTypeToSlotIndex(slotType)

        return self:getListFreeSlotsOfTypeIndex(slotIndex)
    end

    self.getFreeSlotOfTypeIndex = function(this, slotTypeIndex)
        return self:getListFreeSlotsOfTypeIndex(slotTypeIndex)[1] or -1
    end

    self.getListFreeSlotsOfTypeIndex = function(this, slotTypeIndex)
        local slot_start = (16 * (slotTypeIndex + 1)) - (16 - 1)
        local slot_end = (16 * (slotTypeIndex + 1))

        local freeSlots = {}

        for i = slot_start, slot_end do
            if self.slots[i] == nil then
                table.insert(freeSlots, i)
            end
        end

        return freeSlots
    end

    self.canFit = function(this, itemId, itemAmount)
        return #self:getFittableSlots(itemId, itemAmount) > 0
    end

    self.getFittableSlots = function(this, itemId, itemAmount)
        local ItemData = API.getItemDataFromId(itemId)

        local stackSize = ItemData.getStackSize()
        local slotType = ItemData.getSlotType()

        local fittableSlots = {}

        local amountLeft = itemAmount

        local listFreeSlotsOfType = self:getListFreeSlotsOfType(slotType)
        local listItemSlotWithId = self:getListItemSlotsWithId(itemId)

        for _, ItemSlot in pairs(listItemSlotWithId) do
            local slot_itemAmount = ItemSlot:getItemAmount()
            if slot_itemAmount < stackSize then
                local maxFittable = (stackSize - slot_itemAmount)

                if maxFittable > 0 then
                    local toFit = 0
                    if amountLeft > maxFittable then
                        toFit = maxFittable
                    else
                        toFit = amountLeft
                        amountLeft = 0
                    end

                    fittableSlots[ItemSlot:getSlot()] = toFit

                    if amountLeft <= 0 then
                        break
                    end
                end
            end
        end

        if amountLeft > 0 then
            if #listFreeSlotsOfType > 0 then
                for _, slot in pairs(listFreeSlotsOfType) do
                    if amountLeft > 0 then
                        local amountFittable = stackSize

                        if amountFittable > amountLeft then
                            amountFittable = amountLeft
                            amountLeft = 0
                        else
                            amountLeft = amountLeft - amountFittable
                        end

                        fittableSlots[slot] = amountFittable
                    end
                end
            end

            if amountLeft > 0 then
                fittableSlots = {}
            end
        end

        return fittableSlots
    end

    self.addItem = function(this, slot, itemId, itemAmount)
        local syncSlotQueue = {}
        local switchSlotQueue = {}

        if slot == -1 then
            local fittableSlots = self:getFittableSlots(itemId, itemAmount)

            for slot, fittableAmount in pairs(fittableSlots) do
                if self.slots[slot] == nil then
                    self.slots[slot] = API.ItemSlot(slot, itemId, fittableAmount)
                else
                    local ItemSlot = self.slots[slot]
                    ItemSlot:setItemAmount(ItemSlot:getItemAmount() + fittableAmount)
                end

                syncSlotQueue[slot] = self.slots[slot]

                Citizen.CreateThread(
                    function()
                        API_Database.execute("FCRP/Inventory", {id = self:getId(), charid = self:getCharId(), capacity = 0, slot = slot, itemId = itemId, itemAmount = self.slots[slot]:getItemAmount(), procType = "update"})
                    end
                )

                -- Update recent items tab
                -- for i = 16, 1, -1 do
                --     if self.slots[i] ~= nil then
                --         if i == 16 then
                --             self.slots[16] = nil
                --         else
                --             self.slots[i + 1] = self.slots[i]
                --             self.slots[i] = nil
                --         end
                --     end
                --     syncSlotQueue[slot] = self.slots[i]
                -- end
                -- self.slots[1] = self.slots[slot]
                -- syncSlotQueue[1] = self.slots[slot]

            end
        else
            if self.slots[slot] == nil then
                self.slots[slot] = API.ItemSlot(slot, itemId, itemAmount)
                syncSlotQueue[slot] = self.slots[slot]
                Citizen.CreateThread(
                    function()
                        API_Database.execute("FCRP/Inventory", {id = self:getId(), charid = self:getCharId(), capacity = 0, slot = slot, itemId = itemId, itemAmount = self.slots[slot]:getItemAmount(), procType = "update"})
                    end
                )
            else
                local ItemSlot = self.slots[slot]
                if ItemSlot:getItemId() == itemId then
                    ItemSlot:setItemAmount(ItemSlot:getItemAmount() + itemAmount)
                    syncSlotQueue[slot] = self.slots[slot]
                    Citizen.CreateThread(
                        function()
                            API_Database.execute("FCRP/Inventory", {id = self:getId(), charid = self:getCharId(), capacity = 0, slot = slot, itemId = itemId, itemAmount = self.slots[slot]:getItemAmount(), procType = "update"})
                        end
                    )
                end
            end
        end

        local parsedSlots = parseSlots(syncSlotQueue)
        for viewerSource, asPrimary in pairs(self.viewersSources) do
            -- local User = API.getUserFromSource(viewerSource)

            if asPrimary then
                -- User:notify("Inventário Principal: + x" .. amount .. " " .. ItemData:getName())
                TriggerClientEvent("FCRP:INVENTORY:PrimarySyncSlots", viewerSource, parsedSlots)
            else
                -- User:notify("Inventário Secundário: + x" .. amount .. " " .. ItemData:getName())
                TriggerClientEvent("FCRP:INVENTORY:SecondarySyncSlots", viewerSource, parsedSlots)
            end
        end
    end

    self.removeItem = function(this, slot, itemId, itemAmount)
        local syncSlotQueue = {}

        if slot == -1 then
            for _, slot in pairs(self:getListItemSlotsWithId(itemId)) do
                local ItemSlot = self.slots[slot]
                local _amount = ItemSlot:getItemAmount()
                _amount = _amount - itemAmount

                ItemSlot:setItemAmount(_amount)
                syncSlotQueue[slot] = ItemSlot

                if _amount <= 0 then
                    self.slots[slot] = nil
                end
            end
        else
            if self.slots[slot] ~= nil then
                local ItemSlot = self.slots[slot]
                local _amount = ItemSlot:getItemAmount()

                if itemAmount == nil then
                    itemAmount = _amount
                end

                _amount = _amount - itemAmount

                ItemSlot:setItemAmount(_amount)

                syncSlotQueue[slot] = ItemSlot

                if _amount > 0 then
                    Citizen.CreateThread(
                        function()
                            API_Database.execute("FCRP/Inventory", {id = self:getId(), charid = self:getCharId(), capacity = 0, slot = slot, itemId = ItemSlot:getItemId(), itemAmount = _amount, procType = "update"})
                        end
                    )
                else
                    self.slots[slot] = nil

                    Citizen.CreateThread(
                        function()
                            API_Database.execute("FCRP/Inventory", {id = self:getId(), charid = self:getCharId(), capacity = 0, slot = slot, itemId = 0, itemAmount = 0, procType = "remove"})
                        end
                    )
                end
            end
        end

        local parsedSlots = parseSlots(syncSlotQueue)
        for viewerSource, asPrimary in pairs(self.viewersSources) do
            -- local User = API.getUserFromSource(viewerSource)

            if asPrimary then
                -- User:notify("Inventário Principal: + x" .. amount .. " " .. ItemData:getName())
                TriggerClientEvent("FCRP:INVENTORY:PrimarySyncSlots", viewerSource, parsedSlots)
            else
                -- User:notify("Inventário Secundário: + x" .. amount .. " " .. ItemData:getName())
                TriggerClientEvent("FCRP:INVENTORY:SecondarySyncSlots", viewerSource, parsedSlots)
            end
        end
    end

    self.moveToSlot = function(this, slotFrom, slotTo, amount)
        local slotA = self.slots[slotFrom]
        local slotB = self.slots[slotTo]

        if amount == -2 then -- NULL key
            amount = slotA:getItemAmount()
        end

        if amount == -1 then -- SHIFT key
            amount = math.floor(slotA:getItemAmount() / 2)
        end

        if slotB == nil then
            self:addItem(slotTo, slotA:getItemId(), amount)
            self:removeItem(slotFrom, slotA:getItemId(), amount)
            return true
        end

        -- local itemD_A = ItemData.getItemDataFromId(slotA:getItemId())
        -- local itemD_B = ItemData.getItemDataFromId(slotB:getItemId())

        if slotA:getItemId() == slotB:getItemId() then
            local itemId = slotA:getItemId()
            local itemD = API.getItemDataFromId(slotA:getItemId())

            if slotB:getItemAmount() == itemD:getStackSize() then
                return false
            end

            if (amount + slotB:getItemAmount() <= itemD:getStackSize()) then
                self:addItem(slotTo, itemId, amount)
                self:removeItem(slotFrom, itemId, amount)
                return true
            else
                local diff = itemD:getStackSize() - slotB:getItemAmount()

                if diff > 0 then
                    self:addItem(slotTo, itemId, diff)
                    self:removeItem(slotFrom, itemId, diff)
                    return true
                end
            end
        else
            local amountA = slotA:getItemAmount()
            local amountB = slotB:getItemAmount()

            self:removeItem(slotFrom, slotA:getItemId(), slotA:getItemAmount())
            self:removeItem(slotTo, slotB:getItemId(), slotB:getItemAmount())

            self:addItem(slotTo, slotA:getItemId(), amountA)
            self:addItem(slotFrom, slotB:getItemId(), amountB)
            return true
        end

        return false
    end

    self.getItemAmount = function(this, itemId)
        local amount = 0

        for _, slot in pairs(self:getListItemSlotsWithId(itemId)) do
            local _amount = self.slots[slot]:getItemAmount()
            amount = amount + _amount
        end

        return amount
    end

    self.hasItem = function(this, item_id)
        return self:getItemAmount(item_id) > 0
    end

    self.viewAsPrimary = function(this, viewerSource)
        self.viewersSources[viewerSource] = true

        local parsedSlots = parseSlots(self.slots)

        TriggerClientEvent("FCRP:INVENTORY:openAsPrimary", viewerSource, parsedSlots)
    end

    self.viewAsSecondary = function(this, viewerSource)
        self.viewersSources[viewerSource] = false

        local parsedSlots = parseSlots(self.slots)

        TriggerClientEvent("FCRP:INVENTORY:openAsSecondary", viewerSource, parsedSlots)
    end

    self.removeViewer = function(this, viewerSource)
        self.viewersSources[viewerSource] = nil
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

function slotTypeToSlotIndex(slotType)
    local slotTypes = {
        -- "Recents",
        -- 1 2 3 4
        -- 4 5 6 7
        -- 9 10 11 12
        -- 13 14 15 16
        "Food",
        -- 17 18 19 20
        -- 21 21 23 24
        -- 25 26 27 28
        -- 29 30 31 32
        "Tonics",
        -- 33 34 35 36
        -- 37 38 39 40
        -- 41 42 43 44
        -- 45 46 47 48
        "Ingredients",
        -- 49 50 51 52
        -- 53 54 55 56
        -- 57 58 59 60
        -- 61 62 63 64
        "Tools_Weapons",
        -- 65 66 67 68
        -- 69 70 71 72
        -- 73 74 75 76
        -- 77 78 79 80
        "Kit",
        -- 81 82 83 84
        -- 85 86 87 88
        -- 89 90 91 92
        -- 93 94 95 96
        "Valuables",
        -- 97 98 99 100
        -- 101 102 103 104
        -- 105 106 107 108
        -- 109 110 110 112
        "Documents"
        -- 113 114 115 116
        -- 117 118 119 120
        -- 121 122 123 124
        -- 125 126 127 128
        --
        -- "Hotbar"
        -- 129 130 131 132
    }

    for slotIndex, _slotType in pairs(slotTypes) do
        if slotType == _slotType then
            return slotIndex
        end
    end

    return nil
end

function parseSlots(slots)
    local parsedSlots = {}
    for slot, ItemSlot in pairs(slots) do
        parsedSlots[slot] = {
            ItemSlot:getItemId(),
            ItemSlot:getItemAmount()
        }
    end
    return parsedSlots
end
