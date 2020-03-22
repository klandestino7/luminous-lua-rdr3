-- local wasOpenedBefore = false

RegisterNetEvent('FCRP:CRAFTING:OpenMenu')
AddEventHandler(
    'FCRP:CRAFTING:OpenMenu',
    function(ownedParts)
        local craftingItems = CraftableItems
        local parsedItemNames = {}

        ----------------------------- DATA FORMAT
        -- ownedParts
        -- {
        --     id1 = amount,
        --     id2 = amount,
        -- }

        -- craftingItems
        -- {
        --     id1 = {
        --         canCraft = false
        --         craftingParts = {
        --             cId1 = amount
        --         }
        --     }
        --     id2 = {
        --         canCraft = true
        --         craftingParts = {
        --             cId1 = amount
        --             cId2 = amount
        --         }
        --     }
        -- }

        -- parsedItemNames
        -- {
        --     id1 = 'Maça'
        --     id2 = 'Vara de Pesca'
        -- }
        ----------------------------- DATA FORMAT

        -- if not wasOpenedBefore then
        for id, values in pairs(craftingItems) do
            parsedItemNames[id] = ItemList[id].name
            local canCraft = true
            for idCPart, amountNeeded in pairs(values.craftingParts) do              
                parsedItemNames[idCPart] = ItemList[idCPart].name
                if ownedParts[idCPart] == nil or ownedParts[idCPart] < amountNeeded then
                    canCraft = false
                end
            end
            craftingItems[id].canCraft = canCraft
        end
        SetNuiFocus(true, true)
        SendNUIMessage(
            {
                action = 'open',
                craftingItems = craftingItems,
                ownedParts = ownedParts,
                parsedItemNames = parsedItemNames
            }
        )
        -- wasOpenedBefore = true
        -- else
    end
)

RegisterNetEvent('FCRP:CRAFTING:SyncOnCraft')
AddEventHandler(
    'FCRP:CRAFTING:SyncOnCraft',
    function(updatedOwnedItems)
        local updatedCraftingStatus = {}

        for id, values in pairs(craftingItems) do
            local canCraft = true
            for idCPart, amountNeeded in pairs(values.craftingParts) do
                if updatedOwnedItems[idCPart] < amountNeeded then
                    canCraft = false
                    break
                end
            end
            updatedCraftingStatus[id] = canCraft
        end

        SendNUIMessage(
            {
                action = 'update',
                updatedOwnedItems = updatedOwnedItems,
                updatedCraftingStatus = updatedCraftingStatus
            }
        )
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(0)
            if IsControlJustPressed(0, 0x8CC9CD42) then
                TriggerServerEvent('FCRP:CRAFTING:Open')
              
            end
        end
    end
)

RegisterNUICallback(
    'craft',
    function(data)
        TriggerServerEvent('FCRP:CRAFTING:Craft', data.id)
    end
)

RegisterNUICallback(
    'close',
    function()
        SetNuiFocus(false, false)
    end
)

AddEventHandler(
    'onResourceStop',
    function(resourceName)
        if (GetCurrentResourceName() ~= resourceName) then
            return
        end
        SetNuiFocus(false, false)
        SendNUIMessage(
            {
                action = 'close'
            }
        )
    end
)
