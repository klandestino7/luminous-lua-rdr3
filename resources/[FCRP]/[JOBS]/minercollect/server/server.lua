local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'libs/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

RegisterServerEvent('minercollect:checkitem')
AddEventHandler('minercollect:checkitem', function()
    local _source = source
    local User = API.getUserFromSource(_source)    
    local Inventory = User:getCharacter():getInventory()
    local item = Inventory:getItemAmount('generic_picareta')
    local ItemData = API.getItemDataFromId('generic_picareta')  

    if item < 1 then
        TriggerClientEvent('minercollect:nothaveitem', _source)
        User:notify('Voce nao possui uma ' .. ItemData:getName())
    end
    if item >= 1 then        
        TriggerClientEvent('fc_minercollet:anim', _source)
    end           

end)

RegisterServerEvent('minercollect:getitem')
AddEventHandler('minercollect:getitem', function()
    local _source = source
    local User = API.getUserFromSource(_source)    
    local Inventory = User:getCharacter():getInventory()
    
    local count = math.random(1, 9)

    print(count)

    if count <= 3 then
        User:notify('Voçe coletou [X'..count..'] de Carvão')
        Inventory:addItem('generic_carvaobruto', count)
    end
    
    if count == 4 or 5 or 6 then
        User:notify('Voçe coletou [X'..count..'] pedras')
        Inventory:addItem('generic_pedra', count)
    end
    if count >= 7 then
        User:notify('Voçe coletou [X'..count..'] de cobre')
        Inventory:addItem('generic_cobrebruto', count)
    end
end)

-- RegisterServerEvent('minercollect:processcheckitem')
-- AddEventHandler('minercollect:processcheckitem', function()
--     local _source = source
--     TriggerEvent('redemrp:getPlayerFromId', _source, function(user)      
--         inv.getCount(_source, 51, function(count)
--             if count == -1 then
--                 TriggerClientEvent("fc_notify:start", _source, 'Voce nao possui Minério de Cobre', 5)
--             end
--             if count >= 3 then
--                 TriggerClientEvent('fc_minercollet:processanim', _source)
--             elseif count < 3 then
--                 TriggerClientEvent("fc_notify:start", _source, 'Voce nao possui 3x Minério de Cobre', 5)
--             end
--         end)     
--     end)
-- end)

RegisterServerEvent('minercollect:processitem')
AddEventHandler('minercollect:processitem', function()
    local _source = source
    local count = math.random(1, 3)
    TriggerEvent('redemrp:getPlayerFromId', _source, function(user)
        inv.removeItem(_source, 51, 3)
        inv.addItem(_source, 55, count, false, false)
        TriggerClientEvent("fc_notify:start", _source, 'Voçe processou [X'..count..'] de cobre', 3)            
    end)
end)