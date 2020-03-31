local Tunnel = module('_core', 'libs/Tunnel')
local Proxy = module('_core', 'libs/Proxy')
API = Proxy.getInterface('API')
cAPI = Tunnel.getInterface('API')

RegisterServerEvent('clothes:checkmoney')
AddEventHandler('clothes:checkmoney', function(price)
    local _source = source
    local User = API.getUserFromSource(_source)
    local Inventory = User:getCharacter():getInventory()

	if Inventory:getItemAmount('generic_money') < 2 then
        User:notify('Dinheiro insuficiente!')
        return
	end
	TriggerClientEvent('clothes:open', _source)	
end)



RegisterServerEvent('clothes:buy')
AddEventHandler('clothes:buy', function(price)
    local _source = source
    local User = API.getUserFromSource(_source)
    local Inventory = User:getCharacter():getInventory()

	if Inventory:getItemAmount('generic_money') < price then
        User:notify('Dinheiro insuficiente!')
        return
	end
	User:notify('Você pagou ~pa~' .. price ..'$')

	Inventory:removeItem('generic_money', price)

end)


