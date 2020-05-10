local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

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
        User:notify('Você nao possui uma ' .. ItemData:getName())
    end
    if item >= 1 then        
        TriggerClientEvent('minercollect:anim', _source)
    end
end)

RegisterServerEvent('minercollect:getitem')
AddEventHandler('minercollect:getitem', function()
    local _source = source
    local User = API.getUserFromSource(_source)    
    local Inventory = User:getCharacter():getInventory()    
    local sort = math.random(1, 9)
    local amount = math.random(1, 4)
    if sort <= 3 then
        User:notify('Você coletou [X'..amount..'] pedras')
        Inventory:addItem('generic_pedra', amount)
        return
    end    
    if sort == 4 or sort ==  5 or sort == 6 then
        User:notify('Você coletou [X'..amount..'] de Carvão')
        Inventory:addItem('generic_carvaobruto', amount)
        return
    end
    if sort == 7 or sort == 8 then
        User:notify('Você coletou [X'..amount..'] de cobre')
        Inventory:addItem('generic_cobrebruto', amount)
        return
    end

    if sort == 9 then
        User:notify('Você coletou [X'..amount..'] de OURO Bruto')
        Inventory:addItem('generic_ourobruto', amount)
        return
    end
end)

RegisterServerEvent('minercollect:checkprocess')
AddEventHandler('minercollect:checkprocess', function()
    local _source = source
    local User = API.getUserFromSource(_source)    
    local Inventory = User:getCharacter():getInventory()

    local pedra = Inventory:getItemAmount('generic_pedra')
    local pedraData = API.getItemDataFromId('generic_pedra')  
    if pedra >= 1 then
        TriggerEvent('minercollect:checknum', _source, 1)
        User:notify('Você está processando ' .. pedraData:getName())
        return
    end
    local carvao = Inventory:getItemAmount('generic_carvaobruto')
    local carvaoData = API.getItemDataFromId('generic_carvaobruto')
    if carvao >= 1 then   
        TriggerEvent('minercollect:checknum', _source, 2)
        User:notify('Você está processando ' .. carvaoData:getName())
        return
    end
    local cobre = Inventory:getItemAmount('generic_cobrebruto')
    local cobreData = API.getItemDataFromId('generic_cobrebruto')
    if cobre >= 1 then
        TriggerEvent('minercollect:checknum', _source, 3)
        User:notify('Você está processando ' .. cobreData:getName())
        return
    end
    local ouro = Inventory:getItemAmount('generic_ourobruto')
    local ouroData = API.getItemDataFromId('generic_ourobruto')
    if ouro >= 3 then
        TriggerEvent('minercollect:checknum', _source, 4)
        User:notify('Você está processando ' .. cobreData:getName())
        return
    -- else
    --     User:notify('Precisa de 3 ouro Bruto para minerar')
    --     return
    end
   -- TriggerClientEvent('minercollect:nothaveitem', _source)
    User:notify('Você não possuí item para minerar')  
end)

RegisterServerEvent('minercollect:checknum')
AddEventHandler('minercollect:checknum', function(source, num)
    local _source = source
    local User = API.getUserFromSource(_source)        
    local Character = User:getCharacter()
    if num == 0 or num == nil then        
        User:notify('Erro no processamento')
        return
    end
    if num >= 4 or num == 0 then
        if Character:hasGroup("ourives") then  

        else
            User:notify('Você não pode processar esse minério')
        return
        end
    end
    TriggerClientEvent('minercollect:processanim', _source, num)
end)

RegisterServerEvent('minercollect:processitem')
AddEventHandler('minercollect:processitem', function(num)
    local _source = source
    local User = API.getUserFromSource(_source)    
    local Inventory = User:getCharacter():getInventory()
    local Character = User:getCharacter()    
    local count = math.random(1, 5)

    if num == 1 then
        Inventory:removeItem(-1, 'generic_pedra', 1)        
        User:notify('Você processou [X'..count..'] pedras')
        Wait(1000)
        Inventory:addItem('generic_pedralavada', count)
        User:notify('Você recebeu [X'..count..'] de Pedra Lavada')
        return
    end
    if num == 2 then
        Inventory:removeItem(-1, 'generic_carvaobruto', 1)      
        User:notify('Você processou [X1] de Carvão')
        Wait(1000)
        Inventory:addItem('generic_carvaorefi', count)
        User:notify('Você recebeu [X'..count..'] de Carvão Refinado')
        return
    end    
    if num == 3 then
        Inventory:removeItem(-1, 'generic_cobrebruto', 1)      
        User:notify('Você processou [X'..count..'] de cobre')
        Wait(1000)
        Inventory:addItem('generic_provision_disco_ammolite', count)
        User:notify('Você recebeu [X'..count..'] de Barra de Cobre')
        return
    end   
    if num == 4 then
        Inventory:removeItem(-1, 'generic_ourobruto', 3)
        User:notify('Você processou [X'..count..'] ouro')
        Wait(1000)
        print(count*10)
        Inventory:addItem('generic_gold', count*10)
        User:notify('Você recebeu [X'..count..'] de Ouro')
        return
    end 
end)