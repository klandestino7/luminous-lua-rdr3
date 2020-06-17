local Tunnel = module('_core', 'lib/Tunnel')
local Proxy = module('_core', 'lib/Proxy')

API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')


RegisterNetEvent('ROUBO:itemcheck')
AddEventHandler('ROUBO:itemcheck', function()    
    local _source = source

    local User = API.getUserFromSource(_source)

    local Character = User:getCharacter()
    local Inventory = Character:getInventory()
    local item = Inventory:getItemAmount("melee_knife") 
    
    if item > 0 then
        TriggerClientEvent("ROUBO:item_back", _source, true)
    else
        TriggerClientEvent('VP:NOTIFY:Simple', _source, "Você não pussi uma faca.", 10000)
    end
            
end)


RegisterNetEvent('ROUBO:sheriffs_call')
AddEventHandler('ROUBO:sheriffs_call', function(amount)    
    local _source = source

    local PoliceON = #API.getUsersByGroup("trooper") 
    local SheriffON = #API.getUsersByGroup("sheriff")


    if PoliceON+SheriffON < 2 then
        TriggerClientEvent('ROUBO:sheriffs_back', _source, 0)
        TriggerClientEvent('VP:NOTIFY:Simple', _source, "Esta loja não pode ser roubada, polica insuficiente.", 10000)
    else
        TriggerClientEvent('ROUBO:sheriffs_back', source, PoliceON) 
    end
end)


RegisterNetEvent('ROUBO:RegisterPay')
AddEventHandler('ROUBO:RegisterPay', function(amount)    
    local _source = source
    local User = API.getUserFromSource(_source)
    local Inventory = User:getCharacter():getInventory()
    local Reward = math.random(1500, 4900)

    Inventory:addItem('money', Reward)
end)