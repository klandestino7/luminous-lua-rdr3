AddEventHandler(
    "VP:INVENTORY:UPDATE:AddItem",
    function(Inventory, itemId)

        if itemId == 'map' then
            local _source = source
            local User = API.getUserFromSource(_source)
            local user_inventory = User:getCharacter():getInventory()
            local map_amount = user_inventory:getItemAmount()        
         
            if Inventory:getId() == user_Inventory:getId() then
                if map_amount >= 1 then
                    TriggerClientEvent('VP:HUD:RevealMap', _source, true)
                end
            end

        end

end)

AddEventHandler(
    "VP:INVENTORY:UPDATE:RemoveItem",
    function(Inventory, itemId)

        if itemId == 'map' then
            local _source = source
            local User = API.getUserFromSource(_source)
            local user_inventory = User:getCharacter():getInventory()
            local map_amount = user_inventory:getItemAmount()        
         
            if user_inventory:getId() == user_Inventory:getId() then
                if map_amount < 1 then
                    TriggerClientEvent('VP:HUD:RevealMap', _source, false)
                end
            end
        end
end)


RegisterCommand("reveal", function(source, args)
    TriggerClientEvent('VP:HUD:RevealMap', source, args[1])
end)