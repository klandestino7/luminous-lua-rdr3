local Tunnel = module("_core", "libs/Tunnel")
local Proxy = module("_core", "libs/Proxy")

API = Proxy.getInterface("API")
cAPI = Tunnel.getInterface("API")

RegisterServerEvent('FRP:BANKING:withdraw')
AddEventHandler('FRP:BANKING:withdraw', function(amount)
    local _source = source
    local base = 0
    local _amount = tonumber(amount*100)

    local User = API.getUserFromSource(_source)      
    local Character = User:getCharacter()
    local Inventory = User:getCharacter():getInventory()
    local call = json.decode(Character:getData(Character:getId(), 'charTable', 'banco'))

	if amount ~= nil then
        if _amount == nil or _amount <= 0 or _amount > tonumber(call) then
            User:notify("Quantia inválida!")
            return
        else      
            Character:setData(Character:getId(), 'charTable', 'banco', tonumber(call-(amount*100)))
            Wait(100)
            Inventory:addItem('generic_money', amount*100)  
            Wait(100)
           -- TriggerClientEvent("redemrp_notification:start",_source, "Withdrawal made.." , 2, "success")
            Wait(1000)
            TriggerEvent('FRP:BANKING:balance',_source)
        end  
	end
end)


RegisterServerEvent('FRP:BANKING:deposit')
AddEventHandler('FRP:BANKING:deposit', function(amount)
    local _source = source
    local base = 0
    local _amount = tonumber(amount*100)
    local User = API.getUserFromSource(_source)      
    local Character = User:getCharacter()
    local Inventory = User:getCharacter():getInventory()
    local call = json.decode(Character:getData(Character:getId(), 'charTable', 'banco'))
	if amount ~= nil then
        if _amount == nil or _amount <= 0 or _amount > Inventory:getItemAmount("generic_money") then
            User:notify("Quantia inválida!")
            return
        else      
            Character:setData(Character:getId(), 'charTable', 'banco', tonumber(call+(amount*100)))
            Wait(100)
            Inventory:removeItem('generic_money', amount*100)  
            Wait(100)
           -- TriggerClientEvent("redemrp_notification:start",_source, "Withdrawal made.." , 2, "success")
            Wait(1000)
            TriggerEvent('FRP:BANKING:balance', _source)
        end  
	end
end)

RegisterServerEvent('FRP:BANKING:balance')
AddEventHandler('FRP:BANKING:balance', function(source)
    local _source = source
    local User = API.getUserFromSource(_source)      
    local Character = User:getCharacter()
    local call = json.decode(Character:getData(Character:getId(), 'charTable', 'banco'))  
    TriggerClientEvent('currentbalance1', _source, tonumber(call/100), Character:getName())  

end)

RegisterServerEvent('FRP:BANKING:balance2')
AddEventHandler('FRP:BANKING:balance2', function()
    local _source = source
    local User = API.getUserFromSource(_source)      
    local Character = User:getCharacter()
    local call = json.decode(Character:getData(Character:getId(), 'charTable', 'banco'))
    TriggerClientEvent('currentbalance1', _source, tonumber(call/100), Character:getName())			
end)


RegisterServerEvent('FRP:BANKING:sendmoney')
AddEventHandler('FRP:BANKING:sendmoney', function(source, amount)
TriggerEvent('redemrp:getPlayerFromId', source, function(user)
    local playermoney = user.getMoney()
   -- local removemoney = user.removeMoney(amount)
    if amount ~= nil then
        if playermoney >= amount then
           user.removeMoney(amount)
         --   TriggerClientEvent('FRP:BANKING:sendmoney' playersend, amount)            
        else
            TriggerClientEvent('fc_notify', 'Você não tem essa quantia', 5)
        end
    else
        TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEMA', 'ID ou Valor Inválido.' } })
    end
end)
end, false)


RegisterServerEvent('FRP:BANKING:recmoney')
AddEventHandler('FRP:BANKING:recmoney', function(source, amount, name)
    local _name = name
    local _amount = amount

    TriggerEvent('redemrp:getPlayerFromId', source, function(user)
        user.addMoney(_amount)          
        TriggerClientEvent('chatMessage', source, '^1SISTEMA', {255, 255, 255}, 'Você recebeu $'.. amount .. ' de ' .. _name .. '')
    end)
end)
